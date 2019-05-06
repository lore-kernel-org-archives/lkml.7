Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811F6C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB6E205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfEFPY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:24:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:30792 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbfEFPYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:24:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 08:24:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="344011094"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 06 May 2019 08:24:48 -0700
Received: from slaugust-mobl.amr.corp.intel.com (unknown [10.254.21.102])
        by linux.intel.com (Postfix) with ESMTP id 935FC58010A;
        Mon,  6 May 2019 08:24:48 -0700 (PDT)
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5651.c: remove string buffers
 'byt_rt5651_cpu_dai_name' and 'byt_rt5651_cpu_dai_name'
To:     Nariman <narimantos@gmail.com>, linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        Jordy Ubink <jordyubink@hotmail.nl>
References: <20190504151652.5213-1-user@elitebook-localhost>
 <20190504151652.5213-4-user@elitebook-localhost>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ea3ac342-c3a2-6054-77f7-0f13d0e9d593@linux.intel.com>
Date:   Mon, 6 May 2019 10:24:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504151652.5213-4-user@elitebook-localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/19 10:16 AM, Nariman wrote:
> From: Jordy Ubink <jordyubink@hotmail.nl>
> 
> The snprintf calls filling byt_rt5651_cpu_dai_name / byt_rt5651_cpu_dai_name always fill them with the same string (ssp0-port" resp "rt5651-aif2"). So instead of keeping these buffers around and making the cpu_dai_name / codec_dai_name point to this, simply update the foo_dai_name pointers to directly point to a string constant containing the desired string.
> 
> Signed-off-by: Jordy Ubink <jordyubink@hotmail.nl>
> ---
>   sound/soc/intel/boards/bytcr_rt5651.c | 24 ++++--------------------
>   1 file changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
> index e528995668b7..2e1bf43820d8 100644
> --- a/sound/soc/intel/boards/bytcr_rt5651.c
> +++ b/sound/soc/intel/boards/bytcr_rt5651.c
> @@ -730,8 +730,6 @@ static struct snd_soc_dai_link byt_rt5651_dais[] = {
>   
>   /* SoC card */
>   static char byt_rt5651_codec_name[SND_ACPI_I2C_ID_LEN];
> -static char byt_rt5651_codec_aif_name[12]; /*  = "rt5651-aif[1|2]" */
> -static char byt_rt5651_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
>   static char byt_rt5651_long_name[50]; /* = "bytcr-rt5651-*-spk-*-mic[-swapped-hp]" */
>   
>   static int byt_rt5651_suspend(struct snd_soc_card *card)
> @@ -1009,26 +1007,12 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
>   	log_quirks(&pdev->dev);
>   
>   	if ((byt_rt5651_quirk & BYT_RT5651_SSP2_AIF2) ||
> -	    (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2)) {
> -		/* fixup codec aif name */
> -		snprintf(byt_rt5651_codec_aif_name,
> -			sizeof(byt_rt5651_codec_aif_name),
> -			"%s", "rt5651-aif2");
> -
> -		byt_rt5651_dais[dai_index].codec_dai_name =
> -			byt_rt5651_codec_aif_name;
> -	}
> +	    (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2))
> +		byt_rt5651_dais[dai_index].codec_dai_name = "rt5651-aif2";
>   
>   	if ((byt_rt5651_quirk & BYT_RT5651_SSP0_AIF1) ||
> -	    (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2)) {
> -		/* fixup cpu dai name name */
> -		snprintf(byt_rt5651_cpu_dai_name,
> -			sizeof(byt_rt5651_cpu_dai_name),
> -			"%s", "ssp0-port");
> -
> -		byt_rt5651_dais[dai_index].cpu_dai_name =
> -			byt_rt5651_cpu_dai_name;
> -	}
> +	    (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2))
> +		byt_rt5651_dais[dai_index].cpu_dai_name = "ssp0-port";

same issues with Signed-off-by and missing quirks.

>   
>   	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN) {
>   		priv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
> 

