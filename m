Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01160C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F9820863
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388467AbfB1SAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:00:21 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52228 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbfB1SAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:00:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66748EBD;
        Thu, 28 Feb 2019 10:00:18 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB47A3F720;
        Thu, 28 Feb 2019 10:00:16 -0800 (PST)
Subject: Re: [PATCH] lib/raid6: use vdupq_n_u8 to avoid endianness warnings
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20190226040345.202047-1-ndesaulniers@google.com>
 <CAKv+Gu-5DvWZL6ogLVNDEvgKe6TENX+5sF1U7QxiyYC8Wx0nXw@mail.gmail.com>
 <CAKwvOdmzb1WF6NU5LYWGXK_O2cbqwMjbWGAa5xk5x+EMz7A1yw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b3bf85a9-85de-3800-787e-2b00d3edd939@arm.com>
Date:   Thu, 28 Feb 2019 18:00:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmzb1WF6NU5LYWGXK_O2cbqwMjbWGAa5xk5x+EMz7A1yw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2019 20:44, Nick Desaulniers wrote:
> On Mon, Feb 25, 2019 at 11:19 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>>
>> On Tue, 26 Feb 2019 at 05:03, <ndesaulniers@google.com> wrote:
>>>
>>> Clang warns: vector initializers are not compatible with NEON intrinsics
>>> in big endian mode [-Wnonportable-vector-initialization]
>>>
>>> While this is usually the case, it's not an issue for this case since
>>> we're initializing the uint8x16_t (16x uint8_t's) with the same value.
>>>
>>> Instead, use vdupq_n_u8 which both compilers lower into a single movi
>>> instruction: https://godbolt.org/z/vBrgzt
>>>
>>> This avoids the static storage for a constant value.
>>>
>>> Link: https://github.com/ClangBuiltLinux/linux/issues/214
>>> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
>>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>>
>> Much better, thanks,
>>
>> Did you double check that the intrinsic exists on 32-bit ARM as well?
>> I assume it does, but please make sure if you haven't yet.
> 
> Thanks for the review!
> Looking through Clang's generated arm_neon.h, vdupq_n_u8 seems to have
> 2 definitions predicated on __LITTLE_ENDIAN__ (not __arch64__ or
> __ARM_ARCH >= 8 like some of the other types and functions).
> 
> So NEON got some additions in v8?  Is there a doc that lists them?
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0491g/BABDBBJB.html
> is where I found vdupq_n_u8, but it doesn't seem to mention
> compatibility (so I assume it's been around since the introduction of
> NEON?).

FWIW the most recent 'proper' spec document I know of is this one:

http://infocenter.arm.com/help/topic/com.arm.doc.ihi0073b/index.html


Apparently we have a more interactive playground on the new site, too:

https://developer.arm.com/technologies/neon/intrinsics


Robin.
