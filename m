Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72021C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1892133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbfEWLUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:20:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:32257 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbfEWLUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:20:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 04:20:06 -0700
X-ExtLoop1: 1
Received: from jlrosema-mobl.amr.corp.intel.com (HELO [10.252.131.22]) ([10.252.131.22])
  by orsmga002.jf.intel.com with ESMTP; 23 May 2019 04:20:05 -0700
Subject: Re: [PATCH] ASoC: sound/soc/intel/boards: limit some drivers to X86
 since headers are only in arch/x86/
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
References: <46dc0767-bb21-2b98-90f2-34dd4bcad7c0@infradead.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bdad5973-93e2-ea2b-85e9-c68635b6a5ba@linux.intel.com>
Date:   Thu, 23 May 2019 06:20:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <46dc0767-bb21-2b98-90f2-34dd4bcad7c0@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/19 10:58 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Several drivers in sound/soc/intel/boards/ #include header files
> that only exist in arch/x86/include/asm.  This causes build errors,
> so make these drivers depend on X86.
> 
> Fixes these build errors (on ia64):
> 
> ../sound/soc/intel/boards/bxt_da7219_max98357a.c:19:10: fatal error: asm/cpu_device_id.h: No such file or directory
>   #include <asm/cpu_device_id.h>
> ../sound/soc/intel/boards/bytcr_rt5640.c:31:10: fatal error: asm/cpu_device_id.h: No such file or directory
>   #include <asm/cpu_device_id.h>
> ../sound/soc/intel/boards/bytcr_rt5651.c:33:10: fatal error: asm/cpu_device_id.h: No such file or directory
>   #include <asm/cpu_device_id.h>
> ../sound/soc/intel/boards/cht_bsw_rt5645.c:29:10: fatal error: asm/cpu_device_id.h: No such file or directory
>   #include <asm/cpu_device_id.h>
> ../sound/soc/intel/boards/bytcht_es8316.c:33:10: fatal error: asm/cpu_device_id.h: No such file or directory
>   #include <asm/cpu_device_id.h>
> ../sound/soc/intel/boards/bytcht_da7213.c:26:10: fatal error: asm/platform_sst_audio.h: No such file or directory
>   #include <asm/platform_sst_audio.h>
> 
> And more drivers determined by:
>> grep "include.*asm.cpu_device_id.h" *.c
> bxt_da7219_max98357a.c:#include <asm/cpu_device_id.h>
> bytcht_es8316.c:#include <asm/cpu_device_id.h>
> bytcr_rt5640.c:#include <asm/cpu_device_id.h>
> bytcr_rt5651.c:#include <asm/cpu_device_id.h>
> cht_bsw_rt5645.c:#include <asm/cpu_device_id.h>
> sof_rt5682.c:#include <asm/cpu_device_id.h>
>    and
>> grep "include.*asm.platform_sst_audio.h" *.c
> bytcht_da7213.c:#include <asm/platform_sst_audio.h>
> bytcht_es8316.c:#include <asm/platform_sst_audio.h>
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Cc: Jie Yang <yang.jie@linux.intel.com>
> Cc: alsa-devel@alsa-project.org
> ---
>   sound/soc/intel/boards/Kconfig |    6 ++++++
>   1 file changed, 6 insertions(+)
> 
> --- lnx-52-rc1.orig/sound/soc/intel/boards/Kconfig
> +++ lnx-52-rc1/sound/soc/intel/boards/Kconfig
> @@ -87,6 +87,7 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
>   	tristate "Baytrail and Baytrail-CR with RT5640 codec"
>   	depends on I2C && ACPI
>   	depends on X86_INTEL_LPSS || COMPILE_TEST
> +	depends on X86

How does this improve the results?

config X86_INTEL_LPSS
	bool "Intel Low Power Subsystem Support"
	depends on X86 && ACPI && PCI

So the X86 dependency is already there. Does this happen with 
COMPILE_TEST set? If yes, maybe that's the part that needs to be 
changed? The addition of COMPILE_TEST here is quite recent and might 
need to be reverted.
