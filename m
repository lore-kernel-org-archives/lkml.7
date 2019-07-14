Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61772C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFB8205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfGNRRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 13:17:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:27362 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbfGNRRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 13:17:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2019 10:17:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,491,1557212400"; 
   d="scan'208";a="172027150"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.252.4.28]) ([10.252.4.28])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2019 10:17:45 -0700
Subject: Re: [PATCH v3 6/6] ASoC: sgtl5000: Improve VAG power and mute control
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <20190712145550.27500-1-oleksandr.suvorov@toradex.com>
 <20190712145550.27500-7-oleksandr.suvorov@toradex.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <e9f0f7c7-4c11-36ad-679c-503f6160b83f@intel.com>
Date:   Sun, 14 Jul 2019 19:17:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712145550.27500-7-oleksandr.suvorov@toradex.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-12 16:56, Oleksandr Suvorov wrote:
>   
> +enum {
> +	HP_POWER_EVENT,
> +	DAC_POWER_EVENT,
> +	ADC_POWER_EVENT
> +};
> +
> +struct sgtl5000_mute_state {
> +	u16 hp_event;
> +	u16 dac_event;
> +	u16 adc_event;
> +};
> +
>   /* sgtl5000 private structure in codec */
>   struct sgtl5000_priv {
>   	int sysclk;	/* sysclk rate */
> @@ -137,8 +156,109 @@ struct sgtl5000_priv {
>   	u8 micbias_voltage;
>   	u8 lrclk_strength;
>   	u8 sclk_strength;
> +	struct sgtl5000_mute_state mute_state;

Why not array instead?
u16 mute_state[ADC_POWER_EVENT+1];
-or-
u16 mute_state[LAST_POWER_EVENT+1]; (if you choose to add explicit LAST 
enum constant).

Enables simplification, see below.

> @@ -170,40 +290,79 @@ static int mic_bias_event(struct snd_soc_dapm_widget *w,
>   	return 0;
>   }
>   
> -/*
> - * As manual described, ADC/DAC only works when VAG powerup,
> - * So enabled VAG before ADC/DAC up.
> - * In power down case, we need wait 400ms when vag fully ramped down.
> - */
> -static int power_vag_event(struct snd_soc_dapm_widget *w,
> -	struct snd_kcontrol *kcontrol, int event)
> +static void vag_and_mute_control(struct snd_soc_component *component,
> +				 int event, int event_source,
> +				 u16 mute_mask, u16 *mute_reg)
>   {
> -	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> -	const u32 mask = SGTL5000_DAC_POWERUP | SGTL5000_ADC_POWERUP;
> -
>   	switch (event) {
> -	case SND_SOC_DAPM_POST_PMU:
> -		snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_POWER,
> -			SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
> -		msleep(400);
> +	case SND_SOC_DAPM_PRE_PMU:
> +		*mute_reg = mute_output(component, mute_mask);
> +		break;
> +	case SND_SOC_DAPM_POST_PMU:
> +		vag_power_on(component, event_source);
> +		restore_output(component, mute_mask, *mute_reg);
>   		break;
> -
>   	case SND_SOC_DAPM_PRE_PMD:
> -		/*
> -		 * Don't clear VAG_POWERUP, when both DAC and ADC are
> -		 * operational to prevent inadvertently starving the
> -		 * other one of them.
> -		 */
> -		if ((snd_soc_component_read32(component, SGTL5000_CHIP_ANA_POWER) &
> -				mask) != mask) {
> -			snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_POWER,
> -				SGTL5000_VAG_POWERUP, 0);
> -			msleep(400);
> -		}
> +		*mute_reg = mute_output(component, mute_mask);
> +		vag_power_off(component, event_source);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		restore_output(component, mute_mask, *mute_reg);
>   		break;
>   	default:
>   		break;
>   	}
> +}
> +
> +/*
> + * Mute Headphone when power it up/down.
> + * Control VAG power on HP power path.
> + */
> +static int headphone_pga_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component =
> +		snd_soc_dapm_to_component(w->dapm);
> +	struct sgtl5000_priv *sgtl5000 =
> +		snd_soc_component_get_drvdata(component);
> +
> +	vag_and_mute_control(component, event, HP_POWER_EVENT,
> +			     SGTL5000_HP_MUTE,
> +			     &sgtl5000->mute_state.hp_event);
> +
> +	return 0;
> +}
> +
> +/* As manual describes, ADC/DAC powering up/down requires
> + * to mute outputs to avoid pops.
> + * Control VAG power on ADC/DAC power path.
> + */
> +static int adc_updown_depop(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component =
> +		snd_soc_dapm_to_component(w->dapm);
> +	struct sgtl5000_priv *sgtl5000 =
> +		snd_soc_component_get_drvdata(component);
> +
> +	vag_and_mute_control(component, event, ADC_POWER_EVENT,
> +			     SGTL5000_OUTPUTS_MUTE,
> +			     &sgtl5000->mute_state.adc_event);
> +
> +	return 0;
> +}
> +
> +static int dac_updown_depop(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component =
> +		snd_soc_dapm_to_component(w->dapm);
> +	struct sgtl5000_priv *sgtl5000 =
> +		snd_soc_component_get_drvdata(component);
> +
> +	vag_and_mute_control(component, event, DAC_POWER_EVENT,
> +			     SGTL5000_OUTPUTS_MUTE,
> +			     &sgtl5000->mute_state.dac_event);
>   
>   	return 0;
>   }

With array approach you can simplify these 3 callbacks:
- remove local declaration of sgtl5000
- remove the need for "u16 *mute_reg" param for vag_and_mute_control
(you always provide the xxx_event field of mute_state corresponding to 
given XXX_POWER_EVENT anyway)

The sgtl5000 local ptr would be declared within common handler, which 
vag_and_mute_control clearly is. Said handler declaration could be 
updated to again require widget rather than component.

Cherry on top: relocation of "return 0;" directly to 
vag_and_mute_control. Leaving it void (as it is), however, might also be 
appropriate (explicit).

Czarek
