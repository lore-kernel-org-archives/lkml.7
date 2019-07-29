Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C021AC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04B92182B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387608AbfG2LIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:08:53 -0400
Received: from foss.arm.com ([217.140.110.172]:42096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387457AbfG2LIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:08:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C35428;
        Mon, 29 Jul 2019 04:08:52 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F6E83F694;
        Mon, 29 Jul 2019 04:08:51 -0700 (PDT)
Subject: Re: build error
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <CAGnkfhySwXY7YwuQezyx6cEpemZW4Hox1_4fQJm3-5hvM3G6gw@mail.gmail.com>
 <20190729095047.k45isr7etq3xkyvr@willie-the-truck>
 <1cfad84e-5a98-99bd-07c2-9db0cf37292b@arm.com>
 <CAGnkfhxXHPfMZVMy4Wjmy39E3Oh2U8FjVU8p8PprCnj5QFLMEg@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <cc6f9c8f-a4a1-7c71-1f89-72e1e8dd0cc8@arm.com>
Date:   Mon, 29 Jul 2019 12:08:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGnkfhxXHPfMZVMy4Wjmy39E3Oh2U8FjVU8p8PprCnj5QFLMEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matteo,

On 29/07/2019 11:25, Matteo Croce wrote:
> On Mon, Jul 29, 2019 at 12:16 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> Hi Matteo and Will,
>>
>>
>> If I try to build a fresh kernel on my machine with the standard "make mrproper
>> && make defconfig && make" I do not see the reported issue (Please see below
>> scissors).
>>
>> At this point would be interesting to know more about how Matteo is building the
>> kernel, and try to reproduce the issue here.
>>
>> @Matteo, could you please provide the full .config and the steps you used to
>> generate it? Is it an 'oldconfig'?
>>
> 
> Hi,
> 
> yes, this is an oldconfig from a vanilla 5.2, I attach it
> (the non gzipped config was dropped by the ML filter)
> 
> 

I tried your config file and seems working correctly:

# cp ~/config ../linux-out/.config
# make oldconfig
# make

arch/arm64/Makefile:56: CROSS_COMPILE_COMPAT not defined or empty, the compat
vDSO will not be built

---

Could you please send to me the config file that does not contain:
CONFIG_CROSS_COMPILE_COMPAT_VDSO=""

The original one I mean, on which you did not run make oldconfig.
My suspect at this point is that the string passed to
CONFIG_CROSS_COMPILE_COMPAT_VDSO is not completely empty.

In fact if I do CONFIG_CROSS_COMPILE_COMPAT_VDSO=" " (single space),
I do have a failure similar to the one you reported.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Regards,
Vincenzo
