Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE82FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6642168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403786AbfEXNDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:03:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:17708 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391555AbfEXNDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:03:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 06:03:10 -0700
X-ExtLoop1: 1
Received: from mgastonx-mobl.amr.corp.intel.com (HELO [10.251.128.35]) ([10.251.128.35])
  by orsmga003.jf.intel.com with ESMTP; 24 May 2019 06:03:09 -0700
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
 <6b89e370-90e3-6962-c71a-80919b7c6154@linux.intel.com>
 <4cedd724-7c2e-10c2-a328-61f7af3ab9ed@infradead.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7d685525-b0fe-429b-f0ea-f363069cf667@linux.intel.com>
Date:   Fri, 24 May 2019 08:03:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4cedd724-7c2e-10c2-a328-61f7af3ab9ed@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/19 9:59 PM, Randy Dunlap wrote:
> On 5/23/19 4:28 AM, Pierre-Louis Bossart wrote:
>>
>>
>> On 5/22/19 10:58 PM, Randy Dunlap wrote:
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> skl-ssp-clk.c does not build on IA64 because the driver
>>> uses the common clock interface, so make the driver depend
>>> on COMMON_CLK.
>>>
>>> Fixes this build error:
>>> ../sound/soc/intel/skylake/skl-ssp-clk.c:26:16: error: field 'hw' has incomplete type
>>>     struct clk_hw hw;
>>>                   ^~
>>>
>>> Reported-by: kbuild test robot <lkp@intel.com>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Mark Brown <broonie@kernel.org>
>>> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>>> Cc: Jie Yang <yang.jie@linux.intel.com>
>>> Cc: alsa-devel@alsa-project.org
>>> ---
>>>    sound/soc/intel/Kconfig        |    3 ++-
>>>    sound/soc/intel/boards/Kconfig |    2 +-
>>>    2 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> --- lnx-52-rc1.orig/sound/soc/intel/Kconfig
>>> +++ lnx-52-rc1/sound/soc/intel/Kconfig
>>> @@ -104,7 +104,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>>>    config SND_SOC_INTEL_SKYLAKE
>>>        tristate "All Skylake/SST Platforms"
>>>        depends on PCI && ACPI
>>> -    select SND_SOC_INTEL_SKL
>>> +    select SND_SOC_INTEL_SKL if COMMON_CLK
>>
>> Is this really necessary? The COMMON_CLK is only needed for the SND_SOC_INTEL_SKYLAKE_SSP_CLK option, isn't it?
> 
> It prevents this Kconfig warning:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_INTEL_SKL
>    Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_SST_TOPLEVEL [=y] && PCI [=y] && ACPI [=y] && COMMON_CLK [=n]
>    Selected by [y]:
>    - SND_SOC_INTEL_SKYLAKE [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_SST_TOPLEVEL [=y] && PCI [=y] && ACPI [=y]

Humm, ok. Can you share the config? I'd like to look into this. There 
may be a need for this COMMON_CLK, but applying it here would not be 
fully correct: you can unselect SND_SOC_INTEL_SKYLAKE and only select 
SND_SOC_INTEL_SKL and still have the same problem.

> 
>>>        select SND_SOC_INTEL_APL
>>>        select SND_SOC_INTEL_KBL
>>>        select SND_SOC_INTEL_GLK
>>> @@ -120,6 +120,7 @@ config SND_SOC_INTEL_SKYLAKE
>>>    config SND_SOC_INTEL_SKL
>>>        tristate "Skylake Platforms"
>>>        depends on PCI && ACPI
>>> +    depends on COMMON_CLK
>>>        select SND_SOC_INTEL_SKYLAKE_FAMILY
>>>        help
>>>          If you have a Intel Skylake platform with the DSP enabled
>>> --- lnx-52-rc1.orig/sound/soc/intel/boards/Kconfig
>>> +++ lnx-52-rc1/sound/soc/intel/boards/Kconfig
>>> @@ -286,7 +286,7 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927
>>>        select SND_SOC_MAX98927
>>>        select SND_SOC_DMIC
>>>        select SND_SOC_HDAC_HDMI
>>> -    select SND_SOC_INTEL_SKYLAKE_SSP_CLK
>>> +    select SND_SOC_INTEL_SKYLAKE_SSP_CLK if COMMON_CLK
>>
>> and here I would make it a depend. I guess your solution solves the compilation but doesn't fully represent the fact that this machine driver is not functional without COMMON_CLK+SKYLAKE_SSP_CLK.
> 
> Not functional on ia64 anyway.  :)

Yeah, I am fine with this.
