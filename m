Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD60C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 02:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5962521D56
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 02:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgACCX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 21:23:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:52631 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgACCX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 21:23:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 18:23:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,389,1571727600"; 
   d="scan'208";a="231982388"
Received: from lavazque-mobl.amr.corp.intel.com (HELO [10.255.86.75]) ([10.255.86.75])
  by orsmga002.jf.intel.com with ESMTP; 02 Jan 2020 18:23:56 -0800
Subject: Re: [PATCH v3] ASoC: Intel: sof_rt5682: Ignore the speaker amp when
 there isn't one.
To:     Sam McNally <sammc@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sathya Prakash M R <sathya.prakash.m.r@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Takashi Iwai <tiwai@suse.com>,
        Xun Zhang <xun2.zhang@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
References: <20200103124921.v3.1.Ib87c4a7fbb3fc818ea12198e291b87dc2d5bc8c2@changeid>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c7471ed8-a9ac-b261-b4b7-97198c92475e@linux.intel.com>
Date:   Thu, 2 Jan 2020 20:23:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103124921.v3.1.Ib87c4a7fbb3fc818ea12198e291b87dc2d5bc8c2@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/2/20 7:50 PM, Sam McNally wrote:
> Some members of the Google_Hatch family include a rt5682 jack codec, but
> no speaker amplifier. This uses the same driver (sof_rt5682) as a
> combination of rt5682 jack codec and max98357a speaker amplifier. Within
> the sof_rt5682 driver, these cases are not currently distinguishable,
> relying on a DMI quirk to decide the configuration. This causes an
> incorrect configuration when only the rt5682 is present on a
> Google_Hatch device.
> 
> For CML, the jack codec is used as the primary key when matching,
> with a possible speaker amplifier described in quirk_data. The two cases
> of interest are the second and third 10EC5682 entries in
> snd_soc_acpi_intel_cml_machines[]. The second entry matches the
> combination of rt5682 and max98357a, resulting in the quirk_data field
> in the snd_soc_acpi_mach being non-null, pointing at
> max98357a_spk_codecs, the snd_soc_acpi_codecs for the matched speaker
> amplifier. The third entry matches just the rt5682, resulting in a null
> quirk_data.
> 
> The sof_rt5682 driver's DMI data matching identifies that a speaker
> amplifier is present for all Google_Hatch family devices. Detect cases
> where there is no speaker amplifier by checking for a null quirk_data in
> the snd_soc_acpi_mach and remove the speaker amplifier bit in that case.
> 
> Signed-off-by: Sam McNally <sammc@chromium.org>

thanks, this is a great explanation

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> ---
> 
> Changes in v3:
> - Rewrote commit message to refer to correct
>    snd_soc_acpi_intel_cml_machines[] entries and better describe the
>    change
> 
> Changes in v2:
> - Added details about the relevant ACPI matches to the description
> 
>   sound/soc/intel/boards/sof_rt5682.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index ad8a2b4bc709..8a13231dee15 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -603,6 +603,14 @@ static int sof_audio_probe(struct platform_device *pdev)
>   
>   	dmi_check_system(sof_rt5682_quirk_table);
>   
> +	mach = (&pdev->dev)->platform_data;
> +
> +	/* A speaker amp might not be present when the quirk claims one is.
> +	 * Detect this via whether the machine driver match includes quirk_data.
> +	 */
> +	if ((sof_rt5682_quirk & SOF_SPEAKER_AMP_PRESENT) && !mach->quirk_data)
> +		sof_rt5682_quirk &= ~SOF_SPEAKER_AMP_PRESENT;
> +
>   	if (soc_intel_is_byt() || soc_intel_is_cht()) {
>   		is_legacy_cpu = 1;
>   		dmic_be_num = 0;
> @@ -663,7 +671,6 @@ static int sof_audio_probe(struct platform_device *pdev)
>   	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
>   
>   	sof_audio_card_rt5682.dev = &pdev->dev;
> -	mach = (&pdev->dev)->platform_data;
>   
>   	/* set platform name for each dailink */
>   	ret = snd_soc_fixup_dai_links_platform_name(&sof_audio_card_rt5682,
> 
