Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D904C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3129F20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fF8aA2CD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfDIFOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:14:00 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57570 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfDIFN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 01:13:59 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x395DdsD006999;
        Tue, 9 Apr 2019 00:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554786819;
        bh=taidpLPVIoVKv0fJWsJQ2zlzEyHbE+MdwQ7pOv0WmVg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fF8aA2CDF/91s6HfltjeKUlhmS4mF8sxKh0qPEug91TFVJn8g46FufL+Ke7cOmTqt
         BF7uWP4idpltrWpQzyFUlHa/4B0kOB9Lyg6mkyXH5mbkNTkk4CmyxnefffQ4K8J7LW
         zLtxoLo2VN5NjnWzyCQNHnIAqlAi2EYDn5Bq9QO0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x395DdbN077713
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Apr 2019 00:13:39 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 9 Apr
 2019 00:13:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 9 Apr 2019 00:13:38 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x395DZ1A037276;
        Tue, 9 Apr 2019 00:13:36 -0500
Subject: Re: [PATCH 3/3] ARM: omap2: move platform-specific asm-offset.h to
 arch/arm/mach-omap2
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tony Lindgren <tony@atomide.com>, arm-soc <arm@kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
CC:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>
References: <20190408075427.6052-1-yamada.masahiro@socionext.com>
 <20190408075427.6052-3-yamada.masahiro@socionext.com>
 <20190408161802.GI49658@atomide.com>
 <6308904e-443a-46ff-9633-2ccb3b03bef9@ti.com>
 <CAK7LNASYqkhW_W6K5Y9NvmqnZ2aSCbGZNw0ZFrBB3Dd2FRN8yg@mail.gmail.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <39d9cc92-ef2f-993c-3abd-99b134e1c22e@ti.com>
Date:   Tue, 9 Apr 2019 10:44:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNASYqkhW_W6K5Y9NvmqnZ2aSCbGZNw0ZFrBB3Dd2FRN8yg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/04/19 10:37 AM, Masahiro Yamada wrote:
> On Tue, Apr 9, 2019 at 2:00 PM Keerthy <j-keerthy@ti.com> wrote:
>>
>>
>>
>> On 08/04/19 9:48 PM, Tony Lindgren wrote:
>>> Hi,
>>>
>>> * Masahiro Yamada <yamada.masahiro@socionext.com> [190408 07:56]:
>>>> <generated/ti-pm-asm-offsets.h> is only generated and included
>>>> by arch/arm/mach-omap2/, so it does not need to reside in the
>>>> globally visible include/generated/.
>>>>
>>>> I moved and renamed it to arch/arm/mach-omap2/pm-asm-offsets.h
>>>> since the prefix 'omap2-' is just redundant in mach-omap2/.
>>>>
>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> ---
>>>>
>>>> Can this be applied to ARM-SOC tree in a series?
>>>> (with Ack from the platform sub-maintainer.)
>>>>
>>>> ti-pm-asm-offsets.h does not need to reside in include/generated/,
>>>> but you may ask "Why must it get out of include/generated/?"
>>>>
>>>> My main motivation is to avoid a race condition in the currently
>>>> proposed patch:
>>>>
>>>> https://lore.kernel.org/patchwork/patch/1052763/
>>>>
>>>> This patch tries to embed some build artifacts into the kernel.
>>>>
>>>> If arch/arm/mach-omap2/ and kernel/ are built at the same time,
>>>> it may embed a truncated file.
>>>
>>> Looks like a nice improvment to me, adding Keerthy and Dave to Cc.
>>>
>>> Keerthy and Dave, can you please test this series with am3 and am4
>>> PM code?
>>
>> Tested for Deep Sleep0 on AM33xx Beaglebone-black.
>> Tested for Deep Sleep0 on AM437x-gp-evm.
>>
>> Applied this on top of Tony's for-next with the gpio patch
>> required for RTC+DDR mode on am437x-gp-evm.
> 
> Was it applied to TI tree?
> 
> If so ...
> 
> Arnd, Olof,
> Please just ignore this patch
> since it looks it was already applied to TI tree.

Masahiro Yamada,

No i manually applied this on top.

Regards,
Keerthy

> 
> Thanks.
> Masahiro Yamada
> 
> 
> 
> 
>> Tested-by: Keerthy <j-keerthy@ti.com>
>>
>>>
>>> Regards,
>>>
>>> Tony
>>>
>>>>    arch/arm/mach-omap2/.gitignore  | 1 +
>>>>    arch/arm/mach-omap2/Makefile    | 5 +++--
>>>>    arch/arm/mach-omap2/sleep33xx.S | 2 +-
>>>>    arch/arm/mach-omap2/sleep43xx.S | 2 +-
>>>>    4 files changed, 6 insertions(+), 4 deletions(-)
>>>>    create mode 100644 arch/arm/mach-omap2/.gitignore
>>>>
>>>> diff --git a/arch/arm/mach-omap2/.gitignore b/arch/arm/mach-omap2/.gitignore
>>>> new file mode 100644
>>>> index 000000000000..79a8d6ea7152
>>>> --- /dev/null
>>>> +++ b/arch/arm/mach-omap2/.gitignore
>>>> @@ -0,0 +1 @@
>>>> +pm-asm-offsets.h
>>>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>>>> index 85d1b13c9215..26baeb6477af 100644
>>>> --- a/arch/arm/mach-omap2/Makefile
>>>> +++ b/arch/arm/mach-omap2/Makefile
>>>> @@ -236,9 +236,10 @@ obj-y                                   += omap_phy_internal.o
>>>>
>>>>    obj-$(CONFIG_MACH_OMAP2_TUSB6010)  += usb-tusb6010.o
>>>>
>>>> -include/generated/ti-pm-asm-offsets.h: arch/arm/mach-omap2/pm-asm-offsets.s FORCE
>>>> +$(obj)/pm-asm-offsets.h: $(obj)/pm-asm-offsets.s FORCE
>>>>       $(call filechk,offsets,__TI_PM_ASM_OFFSETS_H__)
>>>>
>>>> -$(obj)/sleep33xx.o $(obj)/sleep43xx.o: include/generated/ti-pm-asm-offsets.h
>>>> +$(obj)/sleep33xx.o $(obj)/sleep43xx.o: $(obj)/pm-asm-offsets.h
>>>>
>>>>    targets += pm-asm-offsets.s
>>>> +clean-files += pm-asm-offsets.h
>>>> diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
>>>> index 47a816468cdb..a003769121aa 100644
>>>> --- a/arch/arm/mach-omap2/sleep33xx.S
>>>> +++ b/arch/arm/mach-omap2/sleep33xx.S
>>>> @@ -6,7 +6,6 @@
>>>>     * Dave Gerlach, Vaibhav Bedia
>>>>     */
>>>>
>>>> -#include <generated/ti-pm-asm-offsets.h>
>>>>    #include <linux/linkage.h>
>>>>    #include <linux/platform_data/pm33xx.h>
>>>>    #include <linux/ti-emif-sram.h>
>>>> @@ -15,6 +14,7 @@
>>>>
>>>>    #include "iomap.h"
>>>>    #include "cm33xx.h"
>>>> +#include "pm-asm-offsets.h"
>>>>
>>>>    #define AM33XX_CM_CLKCTRL_MODULESTATE_DISABLED                     0x00030000
>>>>    #define AM33XX_CM_CLKCTRL_MODULEMODE_DISABLE                       0x0003
>>>> diff --git a/arch/arm/mach-omap2/sleep43xx.S b/arch/arm/mach-omap2/sleep43xx.S
>>>> index 5b9343b58fc7..aa288f361c5e 100644
>>>> --- a/arch/arm/mach-omap2/sleep43xx.S
>>>> +++ b/arch/arm/mach-omap2/sleep43xx.S
>>>> @@ -6,7 +6,6 @@
>>>>     * Dave Gerlach, Vaibhav Bedia
>>>>     */
>>>>
>>>> -#include <generated/ti-pm-asm-offsets.h>
>>>>    #include <linux/linkage.h>
>>>>    #include <linux/ti-emif-sram.h>
>>>>    #include <linux/platform_data/pm33xx.h>
>>>> @@ -19,6 +18,7 @@
>>>>    #include "iomap.h"
>>>>    #include "omap-secure.h"
>>>>    #include "omap44xx.h"
>>>> +#include "pm-asm-offsets.h"
>>>>    #include "prm33xx.h"
>>>>    #include "prcm43xx.h"
>>>>
>>>> --
>>>> 2.17.1
>>>>
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
> 
