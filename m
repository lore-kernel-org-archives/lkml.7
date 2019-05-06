Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610D0C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3AB205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfEFPYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:24:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:63190 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfEFPYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:24:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 08:24:06 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 06 May 2019 08:24:06 -0700
Received: from slaugust-mobl.amr.corp.intel.com (unknown [10.254.21.102])
        by linux.intel.com (Postfix) with ESMTP id 6B840580238;
        Mon,  6 May 2019 08:24:05 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: cht_bsw_rt5645.c: Remove buffer
 and snprintf calls
To:     Nariman <narimantos@gmail.com>, linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, tiwai@suse.com,
        yang.jie@linux.intel.com, liam.r.girdwood@linux.intel.com,
        hdegoede@redhat.com, broonie@kernel.org,
        Damian van Soelen <dj.vsoelen@gmail.com>
References: <20190504151652.5213-1-user@elitebook-localhost>
 <20190504151652.5213-2-user@elitebook-localhost>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <92f39b95-aabe-0a92-714e-15d2ea123f49@linux.intel.com>
Date:   Mon, 6 May 2019 10:24:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504151652.5213-2-user@elitebook-localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/19 10:16 AM, Nariman wrote:
> From: Damian van Soelen <dj.vsoelen@gmail.com>
> 
> The snprintf calls filling cht_rt5645_cpu_dai_name / cht_rt5645_codec_aif_name
> always fill them with the same string ("ssp0-port" resp "rt5645-aif2") so
> instead of keeping these buffers around and making the cpu_dai_name /
> codec_aif_name point to this, simply update the foo_dai_name and foo_aif_name pointers to
> directly point to a string constant containing the desired string.
> 
> Signed-off-by: Damian van Soelen <dj.vsoelen@gmail.com>

Need Nariman's Signoff-of-by tag here.

> ---
>   sound/soc/intel/boards/cht_bsw_rt5645.c | 26 ++++---------------------
>   1 file changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
> index cbc2d458483f..b15459e56665 100644
> --- a/sound/soc/intel/boards/cht_bsw_rt5645.c
> +++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
> @@ -506,8 +506,6 @@ static struct cht_acpi_card snd_soc_cards[] = {
>   };
>   
>   static char cht_rt5645_codec_name[SND_ACPI_I2C_ID_LEN];
> -static char cht_rt5645_codec_aif_name[12]; /*  = "rt5645-aif[1|2]" */
> -static char cht_rt5645_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
>   
>   static bool is_valleyview(void)
>   {
> @@ -641,28 +639,12 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
>   	log_quirks(&pdev->dev);
>   
>   	if ((cht_rt5645_quirk & CHT_RT5645_SSP2_AIF2) ||
> -		(cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2)) {
> -
> -		/* fixup codec aif name */
> -		snprintf(cht_rt5645_codec_aif_name,
> -			sizeof(cht_rt5645_codec_aif_name),
> -			"%s", "rt5645-aif2");
> -
> -		cht_dailink[dai_index].codec_dai_name =
> -			cht_rt5645_codec_aif_name;
> -	}
> +		(cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2))
> +			cht_dailink[dai_index].codec_dai_name = "rt5645-aif2";

same, not equivalent. SSP2_AIF2 is not handled.

>   
>   	if ((cht_rt5645_quirk & CHT_RT5645_SSP0_AIF1) ||
> -		(cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2)) {
> -
> -		/* fixup cpu dai name name */
> -		snprintf(cht_rt5645_cpu_dai_name,
> -			sizeof(cht_rt5645_cpu_dai_name),
> -			"%s", "ssp0-port");
> -
> -		cht_dailink[dai_index].cpu_dai_name =
> -			cht_rt5645_cpu_dai_name;
> -	}
> +		(cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2))
> +			cht_dailink[dai_index].cpu_dai_name = "ssp0-port";

and same here, SSP0_AIF1 will no longer work.

>   
>   	/* override plaform name, if required */
>   	platform_name = mach->mach_params.platform;
> 

