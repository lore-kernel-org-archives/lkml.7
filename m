Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505E0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B246206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfDBHIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:08:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDBHIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:08:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10F79309267E;
        Tue,  2 Apr 2019 07:08:15 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-38.ams2.redhat.com [10.36.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B02211001DDA;
        Tue,  2 Apr 2019 07:08:06 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Carlos O'Donell <codonell@redhat.com>,
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
Date:   Tue, 02 Apr 2019 09:08:04 +0200
In-Reply-To: <87lg0tosfz.fsf@concordia.ellerman.id.au> (Michael Ellerman's
        message of "Tue, 02 Apr 2019 17:02:40 +1100")
Message-ID: <87pnq4zxyj.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 02 Apr 2019 07:08:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Ellerman:

> I'm a bit vague on what we're trying to do here.
>
> But it seems like you want some sort of "eye catcher" prior to the branch?
>
> That value is a valid instruction on current CPUs (rlwimi.
> r5,r24,6,1,9), and even if it wasn't it could become one in future.
>
> If you change it to 0x8053530 that is both a valid instruction and is a
> nop (conditional trap immediate but with no conditions set).

I think we need something that is very unlikely to appear in the
instruction stream.  It's just a marker.  The instruction will never be
executed, and it does not have to be a trap, either (I believe that a
standard trap instruction would be a bad choice).

Thanks,
Florian
