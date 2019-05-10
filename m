Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C058C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8E6205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfEJNhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 09:37:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:39945 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbfEJNhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 09:37:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 06:37:20 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 10 May 2019 06:37:19 -0700
Received: from khbyers-mobl2.amr.corp.intel.com (unknown [10.251.29.37])
        by linux.intel.com (Postfix) with ESMTP id 700A5580482;
        Fri, 10 May 2019 06:37:18 -0700 (PDT)
Subject: Re: [PATCH V2] ASoC: SOF: Fix build error with
 CONFIG_SND_SOC_SOF_NOCODEC=m
To:     YueHaibing <yuehaibing@huawei.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20190510023657.8960-1-yuehaibing@huawei.com>
 <20190510132940.28184-1-yuehaibing@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9284cd65-98e3-5f7e-1427-8245dd84edcd@linux.intel.com>
Date:   Fri, 10 May 2019 08:36:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510132940.28184-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/19 8:29 AM, YueHaibing wrote:
> Fix gcc build error while CONFIG_SND_SOC_SOF_NOCODEC=m
> 
> sound/soc/sof/core.o: In function `snd_sof_device_probe':
> core.c:(.text+0x4af): undefined reference to `sof_nocodec_setup'
> 
> Change IS_ENABLED to IS_REACHABLE to fix this.

this just hides the issue instead of fixing it.
please send the config+sha1 so that we can check.

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Takashi Iwai <tiwai@suse.de>
> Fixes: c16211d6226d ("ASoC: SOF: Add Sound Open Firmware driver core")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> V2: use IS_REACHABLE
> ---
>   sound/soc/sof/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
> index 32105e0..38e22f4 100644
> --- a/sound/soc/sof/core.c
> +++ b/sound/soc/sof/core.c
> @@ -259,7 +259,7 @@ int snd_sof_create_page_table(struct snd_sof_dev *sdev,
>   static int sof_machine_check(struct snd_sof_dev *sdev)
>   {
>   	struct snd_sof_pdata *plat_data = sdev->pdata;
> -#if IS_ENABLED(CONFIG_SND_SOC_SOF_NOCODEC)
> +#if IS_REACHABLE(CONFIG_SND_SOC_SOF_NOCODEC)
>   	struct snd_soc_acpi_mach *machine;
>   	int ret;
>   #endif
> @@ -267,7 +267,7 @@ static int sof_machine_check(struct snd_sof_dev *sdev)
>   	if (plat_data->machine)
>   		return 0;
>   
> -#if !IS_ENABLED(CONFIG_SND_SOC_SOF_NOCODEC)
> +#if !IS_REACHABLE(CONFIG_SND_SOC_SOF_NOCODEC)
>   	dev_err(sdev->dev, "error: no matching ASoC machine driver found - aborting probe\n");
>   	return -ENODEV;
>   #else
> 

