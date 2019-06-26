Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A10BC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C0D2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfFZJpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:45:44 -0400
Received: from foss.arm.com ([217.140.110.172]:57510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfFZJpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:45:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6D372B;
        Wed, 26 Jun 2019 02:45:43 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B57BF3F718;
        Wed, 26 Jun 2019 02:45:42 -0700 (PDT)
Subject: Re: "arm64: vdso: Substitute gettimeofday() with C implementation"
 breaks clang build
To:     Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1561464964.5154.63.camel@lca.pw>
 <e86774e4-7470-5cb2-fc3e-b7c1f529d253@arm.com>
 <1561467369.5154.67.camel@lca.pw>
 <00a78980-6b9c-5d5b-ed01-b28bb34be022@arm.com>
 <1561470705.5154.68.camel@lca.pw>
 <5113362e-1256-6712-6ce8-9599b1806cf1@arm.com>
 <1561472887.5154.72.camel@lca.pw>
 <668bbe72-b32b-8cee-ccad-d1f6110c6728@arm.com>
 <CAKwvOdmCFjunXRbninTdqoDGPNJ6b7npgXLAPYGqFZas5ofNjw@mail.gmail.com>
 <193c179e-16ca-4b4e-2584-75e8f6c1819f@arm.com>
 <20190626093836.y2lofo54rhxw3xsm@willie-the-truck>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <897bf622-0f89-14f2-d278-b22f640b78f4@arm.com>
Date:   Wed, 26 Jun 2019 10:45:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626093836.y2lofo54rhxw3xsm@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/06/2019 10:38, Will Deacon wrote:
> On Tue, Jun 25, 2019 at 06:00:27PM +0100, Vincenzo Frascino wrote:
>> On 25/06/2019 17:26, Nick Desaulniers wrote:
>>> On Tue, Jun 25, 2019 at 7:54 AM Vincenzo Frascino
>>> <vincenzo.frascino@arm.com> wrote:
>>>>> but clang 7.0 is still use in many distros by default, so maybe this commit can
>>>>> be fixed by adding a conditional check to use "small" if clang version < 8.0.
>>>>>
>>>>
>>>> Could you please verify that the patch below works for you?
>>>
>>> Should it be checking against CONFIG_CLANG_VERSION, or better yet be
>>> using cc-option macro?
>>>
>>
>> This is what I did in my proposed patch, but I was surprised that clang-7
>> generates relocations that clang-8 does not.
>>
>>   LD      arch/arm64/kernel/vdso/vdso.so.dbg
>>   VDSOCHK arch/arm64/kernel/vdso/vdso.so.dbg
>> 00000000000009d0 R_AARCH64_JUMP_SLOT  _mcount
> 
> Hmm. It would be nice to understand where the reference to _mcount is coming
> from, since that sounds like ftrace is getting involved where it shouldn't
> be.
> 

That's very true, it was a mistake in the Makefile change that I provided with
the original iteration of this patch, that had as a side effect of having ftrace
involved (_mcount is defined in entry-ftrace.c).

I was overriding:

CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os

with:

CFLAGS_REMOVE_vgettimeofday.o = -mcmodel=tiny (selected if clang is < 8)

that's why I said that I missed a "+" in my previous patch.

Having:

CFLAGS_REMOVE_vgettimeofday.o += -mcmodel=tiny

restores the wanted behavior.

Sorry for not being clear in my explanation.

> Will
> 

-- 
Regards,
Vincenzo
