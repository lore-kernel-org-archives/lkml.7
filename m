Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA73BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F5D222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395282AbfJYOFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:05:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:56879 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394652AbfJYOFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:05:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 07:05:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="223930772"
Received: from bnail-mobl.amr.corp.intel.com (HELO [10.252.140.167]) ([10.252.140.167])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2019 07:05:13 -0700
Subject: Re: [alsa-devel] [PATCH] ASoC: eve: implement set_bias_level function
 for rt5514
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>,
        Richard Fontana <rfontana@redhat.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Naveen M <naveen.m@intel.com>, linux-kernel@vger.kernel.org
References: <1571994691-20199-1-git-send-email-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3ce80285-ddb5-653d-cf60-febc9fd0bdee@linux.intel.com>
Date:   Fri, 25 Oct 2019 09:05:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571994691-20199-1-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/19 4:11 AM, Brent Lu wrote:
> The first DMIC capture always fail (zero sequence data from PCM port)
> after using DSP hotwording function (i.e. Google assistant).

Can you clarify where the DSP hotwording is done? Intel DSP or rt5514?

Turning on the MCLK with the BIAS info might force the Intel DSP to 
remain on, which would impact power consumption if it was supposed to 
remain off.

> This rt5514 codec requires to control mclk directly in the set_bias_level
> function. Implement this function in machine driver to control the
> ssp1_mclk clock explicitly could fix this issue.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>   .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 50 ++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> index dc09a85..b546de8 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> @@ -653,6 +653,55 @@ static struct snd_soc_dai_link kabylake_dais[] = {
>   	},
>   };
>   
> +static int kabylake_set_bias_level(struct snd_soc_card *card,
> +	struct snd_soc_dapm_context *dapm, enum snd_soc_bias_level level)
> +{
> +	struct snd_soc_component *component = dapm->component;
> +	struct kbl_codec_private *priv = snd_soc_card_get_drvdata(card);
> +	int ret = 0;
> +
> +	if (!component || strcmp(component->name, RT5514_DEV_NAME))
> +		return 0;
> +
> +	if (IS_ERR(priv->mclk))
> +		return 0;
> +
> +	/*
> +	 * It's required to control mclk directly in the set_bias_level
> +	 * function for rt5514 codec or the recording function could
> +	 * break.
> +	 */
> +	switch (level) {
> +	case SND_SOC_BIAS_PREPARE:
> +		if (dapm->bias_level == SND_SOC_BIAS_ON) {
> +			dev_dbg(card->dev, "Disable mclk");
> +			clk_disable_unprepare(priv->mclk);
> +		} else {
> +			dev_dbg(card->dev, "Enable mclk");
> +			ret = clk_set_rate(priv->mclk, 24000000);
> +			if (ret) {
> +				dev_err(card->dev, "Can't set rate for mclk, err: %d\n",
> +					ret);
> +				return ret;
> +			}
> +
> +			ret = clk_prepare_enable(priv->mclk);
> +			if (ret) {
> +				dev_err(card->dev, "Can't enable mclk, err: %d\n",
> +					ret);
> +
> +				/* mclk is already enabled in FW */
> +				ret = 0;
> +			}
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>   static int kabylake_card_late_probe(struct snd_soc_card *card)
>   {
>   	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(card);
> @@ -692,6 +741,7 @@ static struct snd_soc_card kabylake_audio_card = {
>   	.owner = THIS_MODULE,
>   	.dai_link = kabylake_dais,
>   	.num_links = ARRAY_SIZE(kabylake_dais),
> +	.set_bias_level = kabylake_set_bias_level,
>   	.controls = kabylake_controls,
>   	.num_controls = ARRAY_SIZE(kabylake_controls),
>   	.dapm_widgets = kabylake_widgets,
> 
