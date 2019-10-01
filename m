Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96B6C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977002054F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389165AbfJAOjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:39:44 -0400
Received: from foss.arm.com ([217.140.110.172]:51216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388932AbfJAOjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:39:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFB4F1000;
        Tue,  1 Oct 2019 07:39:42 -0700 (PDT)
Received: from [10.37.8.149] (unknown [10.37.8.149])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C8253F71A;
        Tue,  1 Oct 2019 07:39:41 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] arm64: vdso32: Fix compilation warning
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        catalin.marinas@arm.com, tglx@linutronix.de
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926214342.34608-1-vincenzo.frascino@arm.com>
 <20190926214342.34608-4-vincenzo.frascino@arm.com>
 <20191001132108.jx2x7quyk2p2vyfw@willie-the-truck>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <adc03e22-6317-a6c1-2d3c-e1fddcd97edd@arm.com>
Date:   Tue, 1 Oct 2019 15:41:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001132108.jx2x7quyk2p2vyfw@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/19 2:21 PM, Will Deacon wrote:
> On Thu, Sep 26, 2019 at 10:43:40PM +0100, Vincenzo Frascino wrote:
>> As reported by Will Deacon the following compilation warning appears
>> during the compilation of the vdso32:
>>
>> In file included from ./arch/arm64/include/asm/thread_info.h:17:0,
>>                  from ./include/linux/thread_info.h:38,
>>                  from ./arch/arm64/include/asm/preempt.h:5,
>>                  from ./include/linux/preempt.h:78,
>>                  from ./include/linux/spinlock.h:51,
>>                  from ./include/linux/seqlock.h:36,
>>                  from ./include/linux/time.h:6,
>>                  from .../work/linux/lib/vdso/gettimeofday.c:7,
>>                  from <command-line>:0:
>> ./arch/arm64/include/asm/memory.h: In function ‘__tag_set’:
>> ./arch/arm64/include/asm/memory.h:233:15: warning: cast from pointer to
>> integer of different size [-Wpointer-to-int-cast]
>>   u64 __addr = (u64)addr & ~__tag_shifted(0xff);
>>                ^
>> In file included from ./arch/arm64/include/asm/pgtable-hwdef.h:8:0,
>>                  from ./arch/arm64/include/asm/processor.h:34,
>>                  from ./arch/arm64/include/asm/elf.h:118,
>>                  from ./include/linux/elf.h:5,
>>                  from ./include/linux/elfnote.h:62,
>>                  from arch/arm64/kernel/vdso32/note.c:11:
>> ./arch/arm64/include/asm/memory.h: In function ‘__tag_set’:
>> ./arch/arm64/include/asm/memory.h:233:15: warning: cast from pointer to
>> integer of different size [-Wpointer-to-int-cast]
>>   u64 __addr = (u64)addr & ~__tag_shifted(0xff);
>>                ^
>>
>> This happens because few 64 bit compilation headers are included during
>> the generation of vdso32.
>>
>> Fix the issue redefining the __tag_set function.
>>
>> Note: This fix is meant to be temporary, a more comprehensive solution
>> based on the refactoring of the generic headers will be provided with a
>> future patch set. At that point it will be possible to revert this patch.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  arch/arm64/include/asm/memory.h | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index b61b50bf68b1..c61b2eb50a3b 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -228,11 +228,14 @@ static inline unsigned long kaslr_offset(void)
>>  #define __tag_get(addr)		0
>>  #endif /* CONFIG_KASAN_SW_TAGS */
>>  
>> +#ifdef __aarch64__
>> +/* Do not attempt to compile this code with compat vdso */
>>  static inline const void *__tag_set(const void *addr, u8 tag)
>>  {
>>  	u64 __addr = (u64)addr & ~__tag_shifted(0xff);
>>  	return (const void *)(__addr | __tag_shifted(tag));
>>  }
>> +#endif
> 
> Sorry, but I'm not taking this.
> 
> I know you're trying to fix the issues I reported as quickly as you can (and
> thank you for that), but I'm sure that you agree this needs more thought to
> develop a proper solution to what is a much bigger issue than can be solved
> by sprinkling #ifdefs. I can live with the warning on the basis that a
> proper fix is in the pipeline, but in the meantime it can serve as a
> reminder that we're not done here.
>

This was my original preference as well, if we silence the warnings we tend to
forget about them. Since you reported the issue as urgent, I reacted with
something that fixes it temporarily, but I have not objections if you want to
wait for a more comprehensive solution.

> Will
> 

-- 
Regards,
Vincenzo
