Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521F1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 01:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7A220659
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 01:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfJ1Bx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 21:53:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:27887 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbfJ1BxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 21:53:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 18:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,238,1569308400"; 
   d="scan'208";a="224494974"
Received: from rmullina-mobl.amr.corp.intel.com (HELO [10.255.229.12]) ([10.255.229.12])
  by fmsmga004.fm.intel.com with ESMTP; 27 Oct 2019 18:53:23 -0700
Subject: Re: [PATCH -next] ASoC: SOF: select SND_INTEL_DSP_CONFIG in
 SND_SOC_SOF_PCI
To:     Mao Wenan <maowenan@huawei.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.de,
        daniel.baluta@nxp.com, rdunlap@infradead.org,
        ranjani.sridharan@linux.intel.com, arnd@arndb.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20191028014511.73472-1-maowenan@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <68a432df-81d4-dc54-b836-f58981d78491@linux.intel.com>
Date:   Sun, 27 Oct 2019 20:53:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191028014511.73472-1-maowenan@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/19 8:45 PM, Mao Wenan wrote:
> When SND_SOC_SOF_PCI=y, and SND_INTEL_DSP_CONFIG=m, below
> errors can be seen:
> sound/soc/sof/sof-pci-dev.o: In function `sof_pci_probe':
> sof-pci-dev.c:(.text+0xb9): undefined reference to
> `snd_intel_dsp_driver_probe'
> 
> After commit 82d9d54a6c0e ("ALSA: hda: add Intel DSP
> configuration / probe code"), sof_pci_probe() will call
> snd_intel_dsp_driver_probe(), so it should select
> SND_INTEL_DSP_CONFIG in Kconfig SND_SOC_SOF_PCI.
> 
> Fixes: 82d9d54a6c0e ("ALSA: hda: add Intel DSP configuration / probe code")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>   sound/soc/sof/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
> index 56a3ab6..a9b2be2 100644
> --- a/sound/soc/sof/Kconfig
> +++ b/sound/soc/sof/Kconfig
> @@ -16,6 +16,7 @@ config SND_SOC_SOF_PCI
>   	select SND_SOC_ACPI if ACPI
>   	select SND_SOC_SOF_OPTIONS
>   	select SND_SOC_SOF_INTEL_PCI if SND_SOC_SOF_INTEL_TOPLEVEL
> +	select SND_INTEL_DSP_CONFIG

The problem may be real but the fix should be in 
sound/sof/sof/intel/Kconfig, e.g. something like:

config SND_SOC_SOF_HDA_COMMON
	tristate
	select SND_SOC_SOF_INTEL_COMMON
+	select SND_INTEL_DSP_CONFIG
	select SND_SOC_SOF_HDA_LINK_BASELINE


I have another patch coming to replace the Intel stuff on the line above.

>   	help
>   	  This adds support for PCI enumeration. This option is
>   	  required to enable Intel Skylake+ devices
> 
