Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F8DC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E422177E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RW35XySV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbfEXC7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 22:59:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43966 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387485AbfEXC7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 22:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3ReDohYM/VMtr1ygEVpafs5ADrPqoTmnqqTt7tUizZ4=; b=RW35XySVF4hvxpb9dr376bXusL
        ySj1jxNLHAaTvwzjVtxXr0qSApXWjsWEJ1y3IkQnpe4Bfywf2OUiaOeges9y3rTbFn2b2Pnjdc9Q3
        XEtQoGyF5638qdkRRJ+rDkap42NykEh7AAb6ucWC25g/SMr7SKseUJclLffDq30q/kn5HKkrt3QpS
        9jCPfOKqopqcP9TaBKm00uJMD02uJCVUS4GV6wzo8hPvVyW1TLxxLYYcuBJAbxbHLlDd5DRzCX/OU
        jnDF4AGT0mexUPyIqFhrm0q88oBoYE79ol6XZwN5osX8okOL8cw53pwT7kiKF0YVPC9u2JlCaQGWP
        Yl66VaBg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hU0QV-0002dg-L1; Fri, 24 May 2019 02:59:23 +0000
Subject: Re: [alsa-devel] [PATCH] ASoc: fix
 sound/soc/intel/skylake/slk-ssp-clk.c build error on IA64
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        kbuild test robot <lkp@intel.com>
References: <9019c87f-cf1a-b59f-d87e-8169b247cf88@infradead.org>
 <6b89e370-90e3-6962-c71a-80919b7c6154@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4cedd724-7c2e-10c2-a328-61f7af3ab9ed@infradead.org>
Date:   Thu, 23 May 2019 19:59:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6b89e370-90e3-6962-c71a-80919b7c6154@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/19 4:28 AM, Pierre-Louis Bossart wrote:
> 
> 
> On 5/22/19 10:58 PM, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> skl-ssp-clk.c does not build on IA64 because the driver
>> uses the common clock interface, so make the driver depend
>> on COMMON_CLK.
>>
>> Fixes this build error:
>> ../sound/soc/intel/skylake/skl-ssp-clk.c:26:16: error: field 'hw' has incomplete type
>>    struct clk_hw hw;
>>                  ^~
>>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>> Cc: Jie Yang <yang.jie@linux.intel.com>
>> Cc: alsa-devel@alsa-project.org
>> ---
>>   sound/soc/intel/Kconfig        |    3 ++-
>>   sound/soc/intel/boards/Kconfig |    2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> --- lnx-52-rc1.orig/sound/soc/intel/Kconfig
>> +++ lnx-52-rc1/sound/soc/intel/Kconfig
>> @@ -104,7 +104,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>>   config SND_SOC_INTEL_SKYLAKE
>>       tristate "All Skylake/SST Platforms"
>>       depends on PCI && ACPI
>> -    select SND_SOC_INTEL_SKL
>> +    select SND_SOC_INTEL_SKL if COMMON_CLK
> 
> Is this really necessary? The COMMON_CLK is only needed for the SND_SOC_INTEL_SKYLAKE_SSP_CLK option, isn't it?

It prevents this Kconfig warning:

WARNING: unmet direct dependencies detected for SND_SOC_INTEL_SKL
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_SST_TOPLEVEL [=y] && PCI [=y] && ACPI [=y] && COMMON_CLK [=n]
  Selected by [y]:
  - SND_SOC_INTEL_SKYLAKE [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_SST_TOPLEVEL [=y] && PCI [=y] && ACPI [=y]


>>       select SND_SOC_INTEL_APL
>>       select SND_SOC_INTEL_KBL
>>       select SND_SOC_INTEL_GLK
>> @@ -120,6 +120,7 @@ config SND_SOC_INTEL_SKYLAKE
>>   config SND_SOC_INTEL_SKL
>>       tristate "Skylake Platforms"
>>       depends on PCI && ACPI
>> +    depends on COMMON_CLK
>>       select SND_SOC_INTEL_SKYLAKE_FAMILY
>>       help
>>         If you have a Intel Skylake platform with the DSP enabled
>> --- lnx-52-rc1.orig/sound/soc/intel/boards/Kconfig
>> +++ lnx-52-rc1/sound/soc/intel/boards/Kconfig
>> @@ -286,7 +286,7 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927
>>       select SND_SOC_MAX98927
>>       select SND_SOC_DMIC
>>       select SND_SOC_HDAC_HDMI
>> -    select SND_SOC_INTEL_SKYLAKE_SSP_CLK
>> +    select SND_SOC_INTEL_SKYLAKE_SSP_CLK if COMMON_CLK
> 
> and here I would make it a depend. I guess your solution solves the compilation but doesn't fully represent the fact that this machine driver is not functional without COMMON_CLK+SKYLAKE_SSP_CLK.

Not functional on ia64 anyway.  :)

> 
>>       help
>>         This adds support for ASoC Onboard Codec I2S machine driver. This will
>>         create an alsa sound card for RT5663 + MAX98927.


Thanks.
-- 
~Randy
