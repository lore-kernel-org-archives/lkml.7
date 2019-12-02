Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB66FC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A606020865
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfLBRka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:40:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:30015 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbfLBRk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:40:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 09:40:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="208164902"
Received: from svedurlx-mobl.amr.corp.intel.com (HELO [10.251.129.241]) ([10.251.129.241])
  by fmsmga008.fm.intel.com with ESMTP; 02 Dec 2019 09:40:25 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: Intel: Fix build error
To:     YueHaibing <yuehaibing@huawei.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.de,
        daniel.baluta@nxp.com, arnd@arndb.de, tglx@linutronix.de,
        rdunlap@infradead.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20191127141649.5524-1-yuehaibing@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <31733dff-0811-b2a4-6201-277d7c5ff619@linux.intel.com>
Date:   Mon, 2 Dec 2019 11:27:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191127141649.5524-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/19 8:16 AM, YueHaibing wrote:
> If SND_INTEL_DSP_CONFIG is m and SND_SOC_SOF_PCI is y,
> building fails:
> 
> sound/soc/sof/sof-pci-dev.o: In function `sof_pci_probe':
> sof-pci-dev.c:(.text+0xb4): undefined reference to `snd_intel_dsp_driver_probe'
> 
> Select SND_INTEL_DSP_CONFIG to fix this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 82d9d54a6c0e ("ALSA: hda: add Intel DSP configuration / probe code")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   sound/soc/sof/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
> index 71a0fc0..e0b04b5 100644
> --- a/sound/soc/sof/Kconfig
> +++ b/sound/soc/sof/Kconfig
> @@ -14,6 +14,7 @@ config SND_SOC_SOF_PCI
>   	depends on PCI
>   	select SND_SOC_SOF
>   	select SND_SOC_ACPI if ACPI
> +	select SND_INTEL_DSP_CONFIG

Thanks for the report. This looks like a valid issue but I don't think 
the fix is in the right place, we moved all Intel-specific stuff to 
sound/soc/sof/Intel.

In addition I don't get how this can happen in the first place, we have
this statement

config SND_SOC_SOF_INTEL_PCI
	def_tristate SND_SOC_SOF_PCI

Can you share the config that's broken? Thanks!
