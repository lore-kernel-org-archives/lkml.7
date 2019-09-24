Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F404C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9072146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504851AbfIXMKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:10:15 -0400
Received: from foss.arm.com ([217.140.110.172]:58516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440945AbfIXMKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:10:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19593142F;
        Tue, 24 Sep 2019 05:10:14 -0700 (PDT)
Received: from [192.168.1.25] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 111B93F67D;
        Tue, 24 Sep 2019 05:10:10 -0700 (PDT)
Subject: Re: Problems with arm64 compat vdso
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <7f05a25a-36c7-929c-484d-bc964587917c@arm.com>
 <CAKv+Gu9EvwM22HaFJvX55HQhptcNUoQZCxq3nxyzquUjcq6DUg@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <991e5bf9-6e15-1ca1-d593-8abe553ebe7c@arm.com>
Date:   Tue, 24 Sep 2019 13:11:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9EvwM22HaFJvX55HQhptcNUoQZCxq3nxyzquUjcq6DUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On 9/23/19 5:41 PM, Ard Biesheuvel wrote:
> On Fri, 20 Sep 2019 at 18:33, Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> Hi Will,
>>
>> thank you for reporting this.
>>
>> On 20/09/2019 15:27, Will Deacon wrote:
>>> Hi Vincenzo,
>>>
>>> I've been running into a few issues with the COMPAT vDSO. Please could
>>> you have a look?
>>>
>>
>> I will be at Linux Recipes next week. I will look at this with priority when I
>> come back.
>>
> 
> Hi all,
> 
> I noticed another issue: I build out of tree, and the VDSO gets
> rebuilt every time I build the kernel, even if I haven't made any
> changes to the source tree at all.
> 
> Could you please look into that as well? (once you get around to it)
> 

I am happy to have a look at this once back from Kernel Recipes next week.
In the meantime may I ask for some more details?

Could be useful to have a set of commands and a log that shows the problem, in
this way I will be sure to be looking at the same issue.

> Thanks,
> Ard.
> 
> 
>>> If I do the following:
>>>
>>> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
>>> [...]
>>> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig
>>> [set CONFIG_CROSS_COMPILE_COMPAT_VDSO="arm-linux-gnueabihf-"]
>>> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
>>>
>>> Then I see the following warning:
>>>
>>> arch/arm64/Makefile:62: CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built
>>>
>>> even though the compat vDSO *has* been built:
>>>
>>> $ file arch/arm64/kernel/vdso32/vdso.so
>>> arch/arm64/kernel/vdso32/vdso.so: ELF 32-bit LSB pie executable, ARM, EABI5 version 1 (SYSV), dynamically linked, BuildID[sha1]=c67f6c786f2d2d6f86c71f708595594aa25247f6, stripped
>>>
>>> However, I also get some warnings because arm64 headers are being included
>>> in the compat vDSO build:
>>>
>>> In file included from ./arch/arm64/include/asm/thread_info.h:17:0,
>>>                  from ./include/linux/thread_info.h:38,
>>>                  from ./arch/arm64/include/asm/preempt.h:5,
>>>                  from ./include/linux/preempt.h:78,
>>>                  from ./include/linux/spinlock.h:51,
>>>                  from ./include/linux/seqlock.h:36,
>>>                  from ./include/linux/time.h:6,
>>>                  from /usr/local/google/home/willdeacon/work/linux/lib/vdso/gettimeofday.c:7,
>>>                  from <command-line>:0:
>>> ./arch/arm64/include/asm/memory.h: In function ‘__tag_set’:
>>> ./arch/arm64/include/asm/memory.h:233:15: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>>>   u64 __addr = (u64)addr & ~__tag_shifted(0xff);
>>>                ^
>>> In file included from ./arch/arm64/include/asm/pgtable-hwdef.h:8:0,
>>>                  from ./arch/arm64/include/asm/processor.h:34,
>>>                  from ./arch/arm64/include/asm/elf.h:118,
>>>                  from ./include/linux/elf.h:5,
>>>                  from ./include/linux/elfnote.h:62,
>>>                  from arch/arm64/kernel/vdso32/note.c:11:
>>> ./arch/arm64/include/asm/memory.h: In function ‘__tag_set’:
>>> ./arch/arm64/include/asm/memory.h:233:15: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>>>   u64 __addr = (u64)addr & ~__tag_shifted(0xff);
>>>                ^
>>> Worse, if your compat binutils isn't up-to-date, you'll actually run into
>>> a build failure:
>>>
>>> /tmp/ccFCrjUg.s:80: Error: invalid barrier type -- `dmb ishld'
>>> /tmp/ccFCrjUg.s:124: Error: invalid barrier type -- `dmb ishld'
>>>
>>> There also appears to be a problem getting the toolchain prefix from Kconfig.
>>> If, for example, I do:
>>>
>>> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
>>> [...]
>>> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig
>>> [set CONFIG_CROSS_COMPILE_COMPAT_VDSO="vincenzo"]
>>> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
>>> arch/arm64/Makefile:64: *** vincenzogcc not found, check CROSS_COMPILE_COMPAT.  Stop.
>>> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig
>>> [set CONFIG_CROSS_COMPILE_COMPAT_VDSO="arm-linux-gnueabihf-"]
>>> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
>>> arch/arm64/Makefile:64: *** vincenzogcc not found, check CROSS_COMPILE_COMPAT.  Stop.
>>> $ grep CONFIG_CROSS_COMPILE_COMPAT_VDSO .config
>>> CONFIG_CROSS_COMPILE_COMPAT_VDSO="arm-linux-gnueabihf-"
>>>
>>> which is irritating, because it seems to force a 'mrproper' if you don't
>>> get the prefix right first time.
>>>
>>> Cheers,
>>>
>>> Will
>>>
>>
>> --
>> Regards,
>> Vincenzo

-- 
Regards,
Vincenzo
