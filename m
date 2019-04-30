Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF7EC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7E120652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfD3Pj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:39:28 -0400
Received: from foss.arm.com ([217.140.101.70]:49334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfD3Pj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:39:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4DA4374;
        Tue, 30 Apr 2019 08:39:27 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E89353F719;
        Tue, 30 Apr 2019 08:39:25 -0700 (PDT)
Subject: Re: [PATCH 7/7] clocksource/arm_arch_timer: Use
 arch_timer_read_counter to access stable counters
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20190408154907.223536-1-marc.zyngier@arm.com>
 <20190408154907.223536-8-marc.zyngier@arm.com>
 <2a60a031-1eab-2d5e-89ff-b5d516545eeb@linaro.org>
 <bbe9b8c1-132f-bbfa-e3d0-ad10c4165ad7@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <cef220b8-f46d-0653-8249-a9d48b2efc48@arm.com>
Date:   Tue, 30 Apr 2019 16:39:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bbe9b8c1-132f-bbfa-e3d0-ad10c4165ad7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/04/2019 16:27, Marc Zyngier wrote:
[...]
>>> @@ -372,6 +392,7 @@ static u32 notrace sun50i_a64_read_cntv_tval_el0(void)
>>>  DEFINE_PER_CPU(const struct arch_timer_erratum_workaround *, timer_unstable_counter_workaround);
>>>  EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
>>>  
>>> +static atomic_t timer_unstable_counter_workaround_in_use = ATOMIC_INIT(0);
>>
>> Wouldn't make sense to READ_ONCE / WRITE_ONCE instead of using an atomic?
> 
> I don't think *_ONCE says anything about the atomicity of the access. It
> only instruct the compiler that this should only be accessed once, and
> not reloaded/rewritten.

FWIW 7bd3e239d6c6 ("locking: Remove atomicy checks from {READ,WRITE}_ONCE")
points this out.

[...]
