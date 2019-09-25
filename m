Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70601C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452BB20673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731869AbfIYXd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 19:33:29 -0400
Received: from foss.arm.com ([217.140.110.172]:34348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731743AbfIYXd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 19:33:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 338911000;
        Wed, 25 Sep 2019 16:33:27 -0700 (PDT)
Received: from [172.23.27.158] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 792373F67D;
        Wed, 25 Sep 2019 16:33:25 -0700 (PDT)
Subject: Re: [PATCH] arm64: Allow disabling of the compat vDSO
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190925130926.50674-1-catalin.marinas@arm.com>
 <CAKwvOdn2Sf7aAt0zqUUqGY6nXg-C3be7An9amy4tfiNr_8ERJw@mail.gmail.com>
 <20190925170838.GK7042@arrakis.emea.arm.com>
 <CAKwvOd=GcF0Tv2-h0LNMvCzx+tm5skKW1J7P=NTf8xYbmPiOPw@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <868f7611-4f66-7273-a7fd-65a8a6d9216d@arm.com>
Date:   Thu, 26 Sep 2019 00:35:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=GcF0Tv2-h0LNMvCzx+tm5skKW1J7P=NTf8xYbmPiOPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/19 6:31 PM, Nick Desaulniers wrote:
> On Wed, Sep 25, 2019 at 10:08 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
>>
>> This is just a temporary hiding of the issue, not a complete fix.
> 
> Yep.
> 
>> Vincenzo will do the fix later on.
> 
> Appreciated, I'm happy to help discuss, review, and test.
> 
>>>> - check whether COMPATCC is clang or not rather than CC_IS_CLANG, which
>>>>   only checks the native compiler
>>>
>>> When cross compiling, IIUC CC_IS_CLANG is referring to CC which is the
>>> cross compiler, which is different than HOSTCC which is the host
>>> compiler.  HOSTCC is used mostly for things in scripts/ while CC is
>>> used to compile a majority of the kernel in a cross compile.
>>
>> We need the third compiler here for the compat vDSO (at least with gcc),
>> COMPATCC. I'm tempted to just drop the CONFIG_CROSS_COMPILE_COMPAT_VDSO
>> altogether and only rely on a COMPATCC. This way we can add
>> COMPATCC_IS_CLANG etc. in the Kconfig checks directly.
> 
> Oh, man, yeah 3 compilers in that case:
> 1. HOSTCC
> 2. CC
> 3. COMPATCC
>

The easier way I found to encapsulate the three compilers is using
CONFIG_CROSS_COMPILE_COMPAT_VDSO, hence I would prefer to not drop it.

In the case of gcc:
-------------------

CROSS_COMPILE_COMPAT ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%"=%)

$(CROSS_COMPILE_COMPAT)gcc ...

In the case of clang:
---------------------

CLANG_TRIPLE ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%-"=%)

clang --target=$(notdir $CLANG_TRIPLE)

This will prevent the vdso32 library generation to depend from a fixed
configuration that might change in future.

Based on this work we will be able to add COMPAT_CC_IS_CLANG, COMPAT_CC_IS_GCC
and COMPAT_CC_GCC_VERSION, COMPAT_CC_CLANG_VERSION which will help us in a more
fine grain control of the compiler versions.

The clang support will be added shortly after the header problems have been
addressed, because without that and the possibility to have 32bit headers in
arm64 would result in a broken target.

>>
>> If clang can build both 32 and 64-bit with the same binary (just
>> different options), we could maybe have COMPATCC default to CC and add a
>> check on whether COMPATCC generates 32-bit binaries.
> 
> Cross compilation work differently between GCC and Clang from a
> developers perspective. In GCC, at ./configure time you select which
> architecture you'd like to cross compile for, and you get one binary
> that targets one architecture.  You get a nice compiler that can do
> mostly static dispatch at the cost of needing multiple binaries in
> admittedly rare scenarios like the one we have here.  Clang defaults
> to all backends enabled when invoking cmake (though there are options
> to enable certain backends; Sony for instance enables only x86_64 for
> their PS4 SDK (and thus I break their build frequently with my arm64
> unit tests)).
> 
> Clang can do all of the above with one binary.  The codebase makes
> heavy use of OOP+virtual dispatch to run ISA specific and general code
> transformations (virtual dispatch is slower than static dispatch, but
> relative to what the compiler is actually doing, I suspect the effects
> are minimal. Folks are also heavily invested in researching
> "devirtualization").  With one clang binary, I can do:
> 
> # implicitly uses the host's ISA, for me that's x86_64-linux-gnu
> $ clang foo.c
> $ clang -target aarch64-linux-gnu foo.c
> $ clang -target arm-linux-gnueabi foo.c
> 
> Admittedly, it's not as simple for the kernel's case; the top level
> Makefile sets some flags to support invoking Clang from a non-standard
> location, and telling it where to find binutils because we can't
> assemble the kernel with LLVM's substitute for GAS).
> 

Thank you for the explanation, if I understand it correctly the strategy
proposed above should cover all the cased proposed. Please, let me know if i
need to tweak something.

The plan is to use binutils to build the vdso libraries with both the compilers.

-- 
Regards,
Vincenzo
