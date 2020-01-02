Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24C5C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC4F21582
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgABVSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:18:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:28012 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgABVSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:18:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 13:18:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,388,1571727600"; 
   d="scan'208";a="224819855"
Received: from ybabin-mobl1.amr.corp.intel.com (HELO [10.252.139.105]) ([10.252.139.105])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2020 13:18:31 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: sof_rt5682: Ignore the speaker
 amp when there isn't one.
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
        Jairaj Arava <jairaj.arava@intel.com>,
        Xun Zhang <xun2.zhang@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
References: <20200102112558.1.Ib87c4a7fbb3fc818ea12198e291b87dc2d5bc8c2@changeid>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a7ab606a-1e35-29aa-ea60-7c31374eb7b4@linux.intel.com>
Date:   Thu, 2 Jan 2020 12:48:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102112558.1.Ib87c4a7fbb3fc818ea12198e291b87dc2d5bc8c2@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/1/20 6:28 PM, Sam McNally wrote:
> Some members of the Google_Hatch family include a rt5682, but not a
> speaker amp. When a speaker amp is also present, it matches MX98357A
> as well, resulting in the quirk_data field in the snd_soc_acpi_mach
> being non-null. When only the rt5682 is present, quirk_data is left
> null.

Sorry, I don't get this last sentence.

There is a single entry for 10EC5682 in sound-acpi-intel-glk-match.c and 
quirk_data is assigned - thus can never be NULL.

I wonder if your Chrome kernel has an extra entry in 
snd_soc_acpi_intel_glk_machines[] ? What I am missing?

> 
> The sof_rt5682 driver's DMI data matching identifies that a speaker amp
> is present for all Google_Hatch family devices. Detect cases where there
> is no speaker amp by checking for a null quirk_data in the
> snd_soc_acpi_mach and remove the speaker amp bit in that case.
> 
> Signed-off-by: Sam McNally <sammc@chromium.org>
> ---
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
