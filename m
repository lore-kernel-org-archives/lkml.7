Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B136DC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9251720883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbfFYRdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:33:19 -0400
Received: from foss.arm.com ([217.140.110.172]:46208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbfFYRdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:33:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00E94360;
        Tue, 25 Jun 2019 10:33:18 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F042D3F718;
        Tue, 25 Jun 2019 10:33:16 -0700 (PDT)
Subject: Re: "arm64: vdso: Substitute gettimeofday() with C implementation"
 breaks clang build
To:     Qian Cai <cai@lca.pw>, Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
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
 <1561483888.5154.78.camel@lca.pw>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <b25d3952-abe5-def5-fe42-0300f0b4c73c@arm.com>
Date:   Tue, 25 Jun 2019 18:33:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561483888.5154.78.camel@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On 25/06/2019 18:31, Qian Cai wrote:
> On Tue, 2019-06-25 at 18:00 +0100, Vincenzo Frascino wrote:
>> Hi Nick,
>>
>> On 25/06/2019 17:26, Nick Desaulniers wrote:
>>> On Tue, Jun 25, 2019 at 7:54 AM Vincenzo Frascino
>>> <vincenzo.frascino@arm.com> wrote:
>>>>
>>>> Hi Qian,
>>>>
>>>> ...
>>>>
>>>>>
>>>>> but clang 7.0 is still use in many distros by default, so maybe this
>>>>> commit can
>>>>> be fixed by adding a conditional check to use "small" if clang version <
>>>>> 8.0.
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
>>   LD      arch/arm64/kernel/vdso/vdso.so.dbg
>>   VDSOCHK arch/arm64/kernel/vdso/vdso.so.dbg
>> 00000000000009d0 R_AARCH64_JUMP_SLOT  _mcount
>>
>> arch/arm64/kernel/vdso/vdso.so.dbg: dynamic relocations are not supported
>> make[1]: *** [arch/arm64/kernel/vdso/Makefile:59:
>> arch/arm64/kernel/vdso/vdso.so.dbg] Error 1
>> make: *** [arch/arm64/Makefile:180: vdso_prepare] Error 2
>>
>> This is the the result of the macro I introduced in lib/vdso/Makefile.
>>
>> And I just found out why. I forgot to add a "+" in the patch provided :)
>>
>> @Qian: Could you please retry with the one provided below?
>>
> 
> It works fine.
> 

Thanks for the confirmation, I will push the patch in a short while.

-- 
Regards,
Vincenzo
