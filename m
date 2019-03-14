Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E079C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712F820854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfCNNBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:01:07 -0400
Received: from ozlabs.org ([203.11.71.1]:43027 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfCNNBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:01:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Kpjp5fV9z9s55;
        Fri, 15 Mar 2019 00:01:02 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, jaydee@email.cz,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH] powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038
In-Reply-To: <CAK8P3a0A9dbneHo7_CrgiPS8ROaV1bWrYWJUh5Zo2FfEuABfhw@mail.gmail.com>
References: <20190313131438.8212-1-mpe@ellerman.id.au> <CAK8P3a0A9dbneHo7_CrgiPS8ROaV1bWrYWJUh5Zo2FfEuABfhw@mail.gmail.com>
Date:   Fri, 15 Mar 2019 00:00:59 +1100
Message-ID: <871s398vas.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:
> On Wed, Mar 13, 2019 at 2:14 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> That causes CLOCK_MONOTONIC to jump ahead by ~4 billion seconds which
>> it is not meant to do. Worse, if the time is then set back before the
>> Y2038 boundary CLOCK_MONOTONIC will jump backward.
>>
>> We can fix it simply by storing the full 64-bit offset in the
>> vdso_data, and using that in the VDSO assembly code. We also shuffle
>> some of the fields in vdso_data to avoid creating a hole.
>
> I see nothing wrong with your patch,

Thanks.

> but I would point out that there is a patch series [1] from Vincenzo
> Frascino to unify the vdso implementation across architectures that I
> hope can make it into linux-5.2, and that will resolve this issue, as
> well as allow 32-bit architectures to provide a working interface with
> 64-bit time_t.

Yeah I did see that series. I will try and keep an eye on it, though I'm
not sure I'll have time to convert powerpc to use it for 5.2.

I'm also not sure how easy it's going to be to convert to the C
versions, because our syscall ABI is not a simple function call (result
code is returned in CR0.SO).

cheers
