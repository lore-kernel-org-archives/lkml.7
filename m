Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6AAC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE17621738
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfDBGCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:02:53 -0400
Received: from ozlabs.org ([203.11.71.1]:58861 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbfDBGCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:02:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44YJXQ3TgGz9sTS;
        Tue,  2 Apr 2019 17:02:46 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Carlos O'Donell <codonell@redhat.com>,
        Paul Burton <paul.burton@mips.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
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
In-Reply-To: <1965431879.7576.1553529272844.JavaMail.zimbra@efficios.com>
References: <20190212194253.1951-1-mathieu.desnoyers@efficios.com> <20190212194253.1951-2-mathieu.desnoyers@efficios.com> <5166fbe9-cfe0-8554-abc7-4fc844cf2765@redhat.com> <1965431879.7576.1553529272844.JavaMail.zimbra@efficios.com>
Date:   Tue, 02 Apr 2019 17:02:40 +1100
Message-ID: <87lg0tosfz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> Hi Carlos,
>
> ----- On Mar 22, 2019, at 4:09 PM, Carlos O'Donell codonell@redhat.com wrote:
...
>
> [...]
>>> +++ b/sysdeps/unix/sysv/linux/powerpc/bits/rseq.h
> [...]
>>> +/* Signature required before each abort handler code.  */
>>> +#define RSEQ_SIG 0x53053053
>> 
>> Why isn't this an opcode specific to power?
>
> On powerpc 32/64, the abort is placed in a __rseq_failure executable section:
>
> #define RSEQ_ASM_DEFINE_ABORT(label, abort_label)                               \
>                 ".pushsection __rseq_failure, \"ax\"\n\t"                       \
>                 ".long " __rseq_str(RSEQ_SIG) "\n\t"                            \
>                 __rseq_str(label) ":\n\t"                                       \
>                 "b %l[" __rseq_str(abort_label) "]\n\t"                         \
>                 ".popsection\n\t"
>
> That section only contains snippets of those trampolines. Arguably, it would be
> good if disassemblers could find valid instructions there. Boqun Feng could perhaps
> shed some light on this signature choice ? Now would be a good time to decide
> once and for all whether a valid instruction would be a better choice.

I'm a bit vague on what we're trying to do here.

But it seems like you want some sort of "eye catcher" prior to the branch?

That value is a valid instruction on current CPUs (rlwimi.
r5,r24,6,1,9), and even if it wasn't it could become one in future.

If you change it to 0x8053530 that is both a valid instruction and is a
nop (conditional trap immediate but with no conditions set).

cheers
