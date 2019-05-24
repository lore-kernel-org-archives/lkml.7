Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58CAC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B682620868
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403793AbfEXNHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:07:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:7522 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391357AbfEXNHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:07:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 06:07:30 -0700
X-ExtLoop1: 1
Received: from mgastonx-mobl.amr.corp.intel.com (HELO [10.251.128.35]) ([10.251.128.35])
  by orsmga003.jf.intel.com with ESMTP; 24 May 2019 06:07:28 -0700
Subject: Re: [PATCH v2] ASoC: drop COMPILE_TEST for sound/soc/intel/boards/
 that use X86_INTEL_LPSS
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
References: <03640e4f-1f8e-9090-c03b-364918e633d3@infradead.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c05d5438-d369-e69d-e314-a0b104a3c71e@linux.intel.com>
Date:   Fri, 24 May 2019 08:07:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <03640e4f-1f8e-9090-c03b-364918e633d3@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/19 10:45 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> This is a partial revert of 164a263bf8d0, which causes build errors
> on non-X86 platforms (specifically seen on IA64) when COMPILE_TEST
> is set/enabled.
> 
> Fixes these build errors (on ia64):
> i../sound/soc/intel/boards/bxt_da7219_max98357a.c:19:10: fatal error: asm/cpu_device_id.h: No such file or directory
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

Randy, your v2 removes COMPILE_TEST for all boards even the ones that 
compiled fine?

Also maybe the 'right' way to fix this is to have a helper that compiles 
out on non X86 platforms (or use an existing one?). IIRC the dependency 
on asm/cpu_device_id is just to find out if the device is baytrail or 
cherrytrail.

> 
> Fixes: 164a263bf8d0 ("ASoC: Intel: Make boards more available for compile test")
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Cc: Jie Yang <yang.jie@linux.intel.com>
> Cc: alsa-devel@alsa-project.org
> ---
>   sound/soc/intel/boards/Kconfig |   30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
> 
> --- lnx-52-rc1.orig/sound/soc/intel/boards/Kconfig
> +++ lnx-52-rc1/sound/soc/intel/boards/Kconfig
> @@ -18,7 +18,7 @@ config SND_SOC_INTEL_HASWELL_MACH
>   	tristate "Haswell Lynxpoint"
>   	depends on I2C
>   	depends on I2C_DESIGNWARE_PLATFORM || COMPILE_TEST
> -	depends on X86_INTEL_LPSS || COMPILE_TEST
> +	depends on X86_INTEL_LPSS
>   	select SND_SOC_RT5640
>   	help
>   	  This adds support for the Lynxpoint Audio DSP on Intel(R) Haswell
> @@ -35,7 +35,7 @@ config SND_SOC_INTEL_BDW_RT5677_MACH
>   	depends on I2C
>   	depends on I2C_DESIGNWARE_PLATFORM || COMPILE_TEST
>   	depends on GPIOLIB || COMPILE_TEST
> -	depends on X86_INTEL_LPSS || COMPILE_TEST
> +	depends on X86_INTEL_LPSS
>   	select SND_SOC_RT5677
>   	help
>   	  This adds support for Intel Broadwell platform based boards with
> @@ -47,7 +47,7 @@ config SND_SOC_INTEL_BROADWELL_MACH
>   	tristate "Broadwell Wildcatpoint"
>   	depends on I2C
>   	depends on I2C_DESIGNWARE_PLATFORM || COMPILE_TEST
> -	depends on X86_INTEL_LPSS || COMPILE_TEST
> +	depends on X86_INTEL_LPSS
>   	select SND_SOC_RT286
>   	help
>   	  This adds support for the Wilcatpoint Audio DSP on Intel(R) Broadwell
> @@ -61,7 +61,7 @@ if SND_SOC_INTEL_BAYTRAIL
>   config SND_SOC_INTEL_BYT_MAX98090_MACH
>   	tristate "Baytrail with MAX98090 codec"
>   	depends on I2C
> -	depends on X86_INTEL_LPSS || COMPILE_TEST
> +	depends on X86_INTEL_LPSS
>   	select SND_SOC_MAX98090
>   	help
>   	  This adds audio driver for Intel Baytrail platform based boards
> @@ -72,7 +72,7 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
>   config SND_SOC_INTEL_BYT_RT5640_MACH
>   	tristate "Baytrail with RT5640 codec"
>   	depends on I2C
> -	depends on X86_INTEL_LPSS || COMPILE_TEST
> +	depends on X86_INTEL_LPSS
>   	select SND_SOC_RT5640
>   	help
>   	  This adds audio driver for Intel Baytrail platform based boards
> @@ -86,7 +86,7 @@ if SND_SST_ATOM_HIFI2_PLATFORM || SND_SO
>   config SND_SOC_INTEL_BYTCR_RT5640_MACH
>   	tristate "Baytrail and Baytrail-CR with RT5640 codec"
>   	depends on I2C && ACPI
> -	depends on X86_INTEL_LPSS || COMPILE_TEST
> +	depends on X86_INTEL_LPSS
>   	select SND_SOC_ACPI
>   	select SND_SOC_RT5640
>   	help
> @@ -98,7 +98,7 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
>   config SND_SOC_INTEL_BYTCR_RT5651_MACH
>   	tristate "Baytrail and Baytrail-CR with RT5651 codec"
>   	depends on I2C && ACPI
> -	depends on X86_INTEL_LPSS || COMPILE_TEST
> +	depends on X86_INTEL_LPSS
>   	select SND_SOC_ACPI
>   	select SND_SOC_RT5651
>   	help
> @@ -110,7 +110,7 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
>   config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
>   	tristate "Cherrytrail & Braswell with RT5672 codec"
>   	depends on I2C && ACPI
> -	depends on X86_INTEL_LPSS || COMPILE_TEST
> +	depends on X86_INTEL_LPSS
>   	select SND_SOC_ACPI
>   	select SND_SOC_RT5670
>           help
> @@ -122,7 +122,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
>   config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
>   	tristate "Cherrytrail & Braswell with RT5645/5650 codec"
>   	depends on I2C && ACPI
> -	depends on X86_INTEL_LPSS || COMPILE_TEST
> +	depends on X86_INTEL_LPSS
>   	select SND_SOC_ACPI
>   	select SND_SOC_RT5645
>   	help
> @@ -134,7 +134,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
>   config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
>   	tristate "Cherrytrail & Braswell with MAX98090 & TI codec"
>   	depends on I2C && ACPI
> -	depends on X86_INTEL_LPSS || COMPILE_TEST
> +	depends on X86_INTEL_LPSS
>   	select SND_SOC_MAX98090
>   	select SND_SOC_TS3A227E
>   	help
> @@ -146,7 +146,7 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI
>   config SND_SOC_INTEL_CHT_BSW_NAU8824_MACH
>   	tristate "Cherrytrail & Braswell with NAU88L24 codec"
>   	depends on I2C && ACPI
> -	depends on X86_INTEL_LPSS || COMPILE_TEST
> +	depends on X86_INTEL_LPSS
>   	select SND_SOC_ACPI
>   	select SND_SOC_NAU8824
>   	help
> @@ -158,7 +158,7 @@ config SND_SOC_INTEL_CHT_BSW_NAU8824_MAC
>   config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
>   	tristate "Baytrail & Cherrytrail with DA7212/7213 codec"
>   	depends on I2C && ACPI
> -	depends on X86_INTEL_LPSS || COMPILE_TEST
> +	depends on X86_INTEL_LPSS
>   	select SND_SOC_ACPI
>   	select SND_SOC_DA7213
>   	help
> @@ -170,7 +170,7 @@ config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
>   config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
>   	tristate "Baytrail & Cherrytrail with ES8316 codec"
>   	depends on I2C && ACPI
> -	depends on X86_INTEL_LPSS || COMPILE_TEST
> +	depends on X86_INTEL_LPSS
>   	select SND_SOC_ACPI
>   	select SND_SOC_ES8316
>   	help
> @@ -186,7 +186,7 @@ if SND_SST_ATOM_HIFI2_PLATFORM
>   config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
>   	tristate "Baytrail & Cherrytrail platform with no codec (MinnowBoard MAX, Up)"
>   	depends on I2C && ACPI
> -	depends on X86_INTEL_LPSS || COMPILE_TEST
> +	depends on X86_INTEL_LPSS
>   	help
>   	  This adds support for ASoC machine driver for the MinnowBoard Max or
>   	  Up boards and provides access to I2S signals on the Low-Speed
> @@ -248,7 +248,7 @@ if SND_SOC_INTEL_APL
>   config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
>   	tristate "Broxton with DA7219 and MAX98357A in I2S Mode"
>   	depends on I2C && ACPI
> -	depends on MFD_INTEL_LPSS || COMPILE_TEST
> +	depends on MFD_INTEL_LPSS
>   	select SND_SOC_DA7219
>   	select SND_SOC_MAX98357A
>   	select SND_SOC_DMIC
> 
