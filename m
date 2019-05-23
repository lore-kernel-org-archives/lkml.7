Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFDAC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2373B217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfEWL22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:28:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:22976 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730534AbfEWL21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:28:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 04:28:27 -0700
X-ExtLoop1: 1
Received: from jlrosema-mobl.amr.corp.intel.com (HELO [10.252.131.22]) ([10.252.131.22])
  by orsmga002.jf.intel.com with ESMTP; 23 May 2019 04:28:26 -0700
Subject: Re: [alsa-devel] [PATCH] ASoc: fix
 sound/soc/intel/skylake/slk-ssp-clk.c build error on IA64
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        kbuild test robot <lkp@intel.com>
References: <9019c87f-cf1a-b59f-d87e-8169b247cf88@infradead.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6b89e370-90e3-6962-c71a-80919b7c6154@linux.intel.com>
Date:   Thu, 23 May 2019 06:28:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9019c87f-cf1a-b59f-d87e-8169b247cf88@infradead.org>
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
> skl-ssp-clk.c does not build on IA64 because the driver
> uses the common clock interface, so make the driver depend
> on COMMON_CLK.
> 
> Fixes this build error:
> ../sound/soc/intel/skylake/skl-ssp-clk.c:26:16: error: field 'hw' has incomplete type
>    struct clk_hw hw;
>                  ^~
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Cc: Jie Yang <yang.jie@linux.intel.com>
> Cc: alsa-devel@alsa-project.org
> ---
>   sound/soc/intel/Kconfig        |    3 ++-
>   sound/soc/intel/boards/Kconfig |    2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> --- lnx-52-rc1.orig/sound/soc/intel/Kconfig
> +++ lnx-52-rc1/sound/soc/intel/Kconfig
> @@ -104,7 +104,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>   config SND_SOC_INTEL_SKYLAKE
>   	tristate "All Skylake/SST Platforms"
>   	depends on PCI && ACPI
> -	select SND_SOC_INTEL_SKL
> +	select SND_SOC_INTEL_SKL if COMMON_CLK

Is this really necessary? The COMMON_CLK is only needed for the 
SND_SOC_INTEL_SKYLAKE_SSP_CLK option, isn't it?

>   	select SND_SOC_INTEL_APL
>   	select SND_SOC_INTEL_KBL
>   	select SND_SOC_INTEL_GLK
> @@ -120,6 +120,7 @@ config SND_SOC_INTEL_SKYLAKE
>   config SND_SOC_INTEL_SKL
>   	tristate "Skylake Platforms"
>   	depends on PCI && ACPI
> +	depends on COMMON_CLK
>   	select SND_SOC_INTEL_SKYLAKE_FAMILY
>   	help
>   	  If you have a Intel Skylake platform with the DSP enabled
> --- lnx-52-rc1.orig/sound/soc/intel/boards/Kconfig
> +++ lnx-52-rc1/sound/soc/intel/boards/Kconfig
> @@ -286,7 +286,7 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927
>   	select SND_SOC_MAX98927
>   	select SND_SOC_DMIC
>   	select SND_SOC_HDAC_HDMI
> -	select SND_SOC_INTEL_SKYLAKE_SSP_CLK
> +	select SND_SOC_INTEL_SKYLAKE_SSP_CLK if COMMON_CLK

and here I would make it a depend. I guess your solution solves the 
compilation but doesn't fully represent the fact that this machine 
driver is not functional without COMMON_CLK+SKYLAKE_SSP_CLK.


>   	help
>   	  This adds support for ASoC Onboard Codec I2S machine driver. This will
>   	  create an alsa sound card for RT5663 + MAX98927.
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
