Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F0DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA642054F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AAAzyGVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfDWL7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:59:53 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34555 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDWL7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:59:52 -0400
Received: by mail-vs1-f65.google.com with SMTP id t78so8092769vsc.1;
        Tue, 23 Apr 2019 04:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xZDf+Aq9qm4iQPqRo7F3/Bdsw94R7s4kG6bB6BPk5w=;
        b=AAAzyGVJc6M2BpZ3PWidLlBDlAo1ghs+XJ3M8cI76Ktmi4LBW3wEjIZyHKDucwNjAu
         YMXzW2dih0S34aZzYQtiJb/YAlnL2f+dks2n818Z4lO0tqA+G0ksN8HIRPs3h3v0tKu0
         dBChMiFBoef+Wo/zPBedMisJM5i55wjOysQIuXBdi9BUdm7BlRNlABZ7SZ71r+L0cqoS
         0UYPiwrfpKznailkuaN9bhjcZpXFGfc84ebUbd/gi1b+C7cIKAfEtm3ZIgBss2ks0/v9
         efDujWgoCyEt8cP/CCfNECalOAxZ46uQ0F361ZXXWDgHkYsVsb6Y7JJnLP0J2hML4ASJ
         7Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xZDf+Aq9qm4iQPqRo7F3/Bdsw94R7s4kG6bB6BPk5w=;
        b=T3xwrwK5s0SNC9dpFmWdZqQc19vsLpDYz91qApPjrkZ7Rrjy63CXfKQjXM9QrYoPE/
         MdpqnYkY4LnNl8qpRm6noq4iU4Rvw1F9u04ZYOKbVav9+IxsgtYvca+SgpUK0uMgJFL2
         jyaqH9pw8nkdcfldqFzqAiVxdxI7QNjYBnMvAZHbEs79t/ckbUiJduHxAybyhLM0/HbS
         0HUenN6gDdP58uFCRt2jDeF/ZYmWxZ863EgY5sTCs9QFi6e9LwyNufHveWxYR3qWzs+/
         4yJXvF+5yRwb1brLqsvqulrlIfc/Urj8NCRZErQFFEhaahvPvc6NXQpom7MTenmQL+4Z
         8RWQ==
X-Gm-Message-State: APjAAAXyX46j9G7iKbAdsMgEO/Y89TgYyOq/D3s+WT8Eu1Uj5VD6qgPm
        ikQrSqTVWj1QPHJNk/UMOF5oCzuhfEaXYU7Uj+c=
X-Google-Smtp-Source: APXvYqyQZDJzMpt6eC0//frtR6D/O60R4tvzZomjDI1TZZ321D0ZcYNm/bhVdeq58awKlnE9ME/qT6rjYPGdzoUOmXM=
X-Received: by 2002:a67:8c47:: with SMTP id o68mr3862742vsd.170.1556020791535;
 Tue, 23 Apr 2019 04:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190416173216.9028-1-mathieu.desnoyers@efficios.com>
 <1770787324.668.1555530989646.JavaMail.zimbra@efficios.com>
 <1066731871.915.1555593471194.JavaMail.zimbra@efficios.com>
 <6cbfea7b-9d83-74a5-9cd2-af56a5d68818@arm.com> <1055153722.1072.1555602067220.JavaMail.zimbra@efficios.com>
 <79996d13-2ba2-ed7d-b202-e7d38f1fd870@arm.com> <604915684.1299.1555607449814.JavaMail.zimbra@efficios.com>
 <846db7ef-f75e-53b8-3c4c-461ec730a17e@arm.com> <1531569198.1389.1555611422188.JavaMail.zimbra@efficios.com>
 <a1bd2595-b7ae-b06b-9c71-802901ed8587@arm.com>
In-Reply-To: <a1bd2595-b7ae-b06b-9c71-802901ed8587@arm.com>
From:   Ramana Radhakrishnan <ramana.gcc@googlemail.com>
Date:   Tue, 23 Apr 2019 12:59:38 +0100
Message-ID: <CAJA7tRZDKHxLDzuggSmNngfxSTD31EX3mv6YQpcnNXrOtF=9qQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and
 thread creation (v8)
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        nd <nd@arm.com>, Joseph Myers <joseph@codesourcery.com>,
        Will Deacon <Will.Deacon@arm.com>, carlos <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 12:16 PM Szabolcs Nagy <Szabolcs.Nagy@arm.com> wrote:
>
> On 18/04/2019 19:17, Mathieu Desnoyers wrote:
> > ----- On Apr 18, 2019, at 1:37 PM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:
> >> you have to add a documentation comment somewhere
> >> explaining if RSEQ_SIG is the value that's passed to
> >> the kernel and then aarch64 asm code has to use
> >>
> >> .inst endianfixup(RSEQ_SIG) // or
> >> .word RSEQ_SIG
> >
> > Using ".word" won't allow objdump to show the instruction it
> > maps to. It will consider it as data. So .inst is preferred here.
>
> is there some specific reason you prefer .inst?

I believe the reasoning here is that in the disassembly you want to
see an instruction pattern for an architecture rather than a magic bit
pattern that appears to be an "inline" literal pool entry.  I would
support the .inst variant so that the disassembler shows the
instruction for what it is when debugging. If control reaches the
marker instruction, something's gone wrong and thus from a user
friendliness perspective I would prefer to see an instruction that
clearly indicates that it's undefined .inst directive so that someone
disassembling this in an assembly view in GDB sees the right thing
(TM) instead of having to reach for the manual and disassembling this
by hand.

>
> disassembling a canary value as data (that is
> never executed, but loaded and compared by the
> kernel as data) sounds more semantically correct
> to me than showing it as an instruction.
>



Ramana


> i guess having it as an instruction can avoid
> issues if some tools dislike .word in .text,
> but otherwise .word seems better.
