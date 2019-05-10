Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B03C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1369E208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfEJMxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 08:53:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46254 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbfEJMx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 08:53:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56026374;
        Fri, 10 May 2019 05:53:29 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C545B3F6C4;
        Fri, 10 May 2019 05:53:27 -0700 (PDT)
Subject: Re: [PATCH V2] ARM: mach-shmobile: Don't init CNTVOFF if PSCI is
 available
To:     Oleksandr <olekstysh@gmail.com>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     horms@verge.net.au, magnus.damm@gmail.com, linux@armlinux.org.uk,
        biju.das@bp.renesas.com,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <1556882268-27451-1-git-send-email-olekstysh@gmail.com>
 <b52a7c3f-6e10-b45e-4cb9-859ac4b468a8@arm.com>
 <6495fca7-bdfa-9020-4eff-b2d04c19827a@gmail.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <e496aece-b092-7845-9295-25b764721724@arm.com>
Date:   Fri, 10 May 2019 13:53:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6495fca7-bdfa-9020-4eff-b2d04c19827a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2019 13:27, Oleksandr wrote:
> 
> On 06.05.19 18:37, Julien Grall wrote:
>> Hi Oleksandr,
> 
> Hi Julien
> 
> 
>>> ---
>>>   arch/arm/mach-shmobile/setup-rcar-gen2.c | 13 ++++++++++++-
>>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c 
>>> b/arch/arm/mach-shmobile/setup-rcar-gen2.c
>>> index eea60b2..bc8537b 100644
>>> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
>>> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
>>> @@ -17,7 +17,9 @@
>>>   #include <linux/of.h>
>>>   #include <linux/of_fdt.h>
>>>   #include <linux/of_platform.h>
>>> +#include <xen/xen.h>
>>>   #include <asm/mach/arch.h>
>>> +#include <asm/psci.h>
>>>   #include <asm/secure_cntvoff.h>
>>>   #include "common.h"
>>>   #include "rcar-gen2.h"
>>> @@ -63,7 +65,16 @@ void __init rcar_gen2_timer_init(void)
>>>       void __iomem *base;
>>>       u32 freq;
>>>   -    secure_cntvoff_init();
>>> +    /*
>>> +     * If PSCI is available then most likely we are running on PSCI-enabled
>>> +     * U-Boot which, we assume, has already taken care of resetting CNTVOFF
>>> +     * before switching to non-secure mode and we don't need to.
>>> +     * Another check is to be sure that we are not running on top of Xen
>>> +     * hypervisor, as CNTVOFF is controlled by hypervisor itself and
>>> +     * shouldn't be touched by Dom0 in such case.
>>
>> If you are running on top of Xen, then PSCI will be available. So is there any 
>> real value to check the presence of Xen as well?
> 
> I think, no. If the PSCI is a must to run Xen, then it is certainly an excessive 
> check. I will drop it in V3.

Xen does not offer another interface for SMP bring-up.

Cheers,

-- 
Julien Grall
