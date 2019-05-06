Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF33DC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9EC20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfEFTnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 15:43:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:49663 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfEFTnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 15:43:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 12:43:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,439,1549958400"; 
   d="scan'208";a="168555081"
Received: from lrafterx-mobl.amr.corp.intel.com (HELO [10.251.10.252]) ([10.251.10.252])
  by fmsmga004.fm.intel.com with ESMTP; 06 May 2019 12:43:08 -0700
Subject: Re: [alsa-devel] [PATCH] ASoC: sound/soc/sof/: fix kconfig dependency
 warning
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <418abbd5-f01c-19ef-c9f2-7de5662f10a2@infradead.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <653fcfc0-8285-acbb-8eac-39d0e6f8176e@linux.intel.com>
Date:   Mon, 6 May 2019 14:43:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <418abbd5-f01c-19ef-c9f2-7de5662f10a2@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/19 2:01 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kconfig warning for unmet dependency for IOSF_MBI when
> PCI is not set/enabled.  Fixes this warning:
> 
> WARNING: unmet direct dependencies detected for IOSF_MBI
>    Depends on [n]: PCI [=n]
>    Selected by [y]:
>    - SND_SOC_SOF_ACPI [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_SOF_TOPLEVEL [=y] && (ACPI [=y] || COMPILE_TEST [=n]) && X86 [=y]
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

I completely forgot to mirror the change in sound/soc/intel/Kconfig for 
IOSF support (ASoC: Intel: atom: Make PCI dependency explicit) for the 
same issue that ACPI no longer depends on PCI, thanks Randy for spotting 
this.

> ---
>   sound/soc/sof/Kconfig |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20190506.orig/sound/soc/sof/Kconfig
> +++ linux-next-20190506/sound/soc/sof/Kconfig
> @@ -28,7 +28,7 @@ config SND_SOC_SOF_ACPI
>   	select SND_SOC_ACPI if ACPI
>   	select SND_SOC_SOF_OPTIONS
>   	select SND_SOC_SOF_INTEL_ACPI if SND_SOC_SOF_INTEL_TOPLEVEL
> -	select IOSF_MBI if X86
> +	select IOSF_MBI if X86 && PCI
>   	help
>   	  This adds support for ACPI enumeration. This option is required
>   	  to enable Intel Haswell/Broadwell/Baytrail/Cherrytrail devices
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
