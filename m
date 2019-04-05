Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6939C10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867B3217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbfDEJQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:16:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729728AbfDEJQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:16:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36E1B87648;
        Fri,  5 Apr 2019 09:16:25 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-233.ams2.redhat.com [10.36.116.233])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDB44261C6;
        Fri,  5 Apr 2019 09:16:15 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Carlos O'Donell <codonell@redhat.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paul Burton <paul.burton@mips.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, carlos <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup and thread creation (v7)
References: <20190212194253.1951-1-mathieu.desnoyers@efficios.com>
        <20190212194253.1951-2-mathieu.desnoyers@efficios.com>
        <5166fbe9-cfe0-8554-abc7-4fc844cf2765@redhat.com>
        <1965431879.7576.1553529272844.JavaMail.zimbra@efficios.com>
        <87lg0tosfz.fsf@concordia.ellerman.id.au>
        <87pnq4zxyj.fsf@oldenburg2.str.redhat.com>
        <ce6f9db3-bf85-7aec-4bae-998e6fd629e1@redhat.com>
Date:   Fri, 05 Apr 2019 11:16:08 +0200
In-Reply-To: <ce6f9db3-bf85-7aec-4bae-998e6fd629e1@redhat.com> (Carlos
        O'Donell's message of "Thu, 4 Apr 2019 16:32:53 -0400")
Message-ID: <87y34o4xt3.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 05 Apr 2019 09:16:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Carlos O'Donell:

> On 4/2/19 3:08 AM, Florian Weimer wrote:
>> * Michael Ellerman:
>>
>>> I'm a bit vague on what we're trying to do here.
>>>
>>> But it seems like you want some sort of "eye catcher" prior to the branch?
>>>
>>> That value is a valid instruction on current CPUs (rlwimi.
>>> r5,r24,6,1,9), and even if it wasn't it could become one in future.
>>>
>>> If you change it to 0x8053530 that is both a valid instruction and is a
>>> nop (conditional trap immediate but with no conditions set).
>>
>> I think we need something that is very unlikely to appear in the
>> instruction stream.  It's just a marker.  The instruction will never be
>> executed, and it does not have to be a trap, either (I believe that a
>> standard trap instruction would be a bad choice).
>
> I assume you want to avoid a standard trap instruction because it would
> be common, and so not meet the intent of the RSEQ_SIG choice as being something
> that is *uncommon* right?

Ideally, RSEQ_SIG would be something that does not show up in the
instruction stream at all, so that it is a reliable marker for the start
of an rseq handler.  I assume the intent here is that the kernel
provides some validation on the program counter it reads from the rseq
area, so that we do not end up with some easily-abused gadget in every
process image.

> It is valuable that it be a trap, particularly for constant pools because
> it means that a jump into the constant pool will trap.

Sorry, I don't understand why this matters in this context.  Would you
please elaborate?

Thanks,
Florian
