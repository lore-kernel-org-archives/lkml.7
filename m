Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8388AC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54ACE2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bRH4o9/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfDZMa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:30:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33148 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZMa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SY3OmMcmE6RsLtnPRQw6TPwMMsYZdkv6QteKnLQJd5w=; b=bRH4o9/Oi8qVjVbCcaZY40XtXC
        bNM6mos7i1fnURib3xf05NVW9StXGrC9QxrJAmKIORd4cfEHpVtJPxXYWUYFfq+qcnzaI6QoK9RK6
        +Wh9xHuZIQeZfKkgsioIJ9TtpZil+Iknh2S+1bFF3mqBFwMmxg9v/cm4DYSYf8IciOUxunS85o5ZL
        whZGJAZ/t2UeIaAUTsz67260Hfv9i2/06Qe/Xkr0ykKPeP2eYHg8YwzeDMj5CjarVQ58fyIHZl8/r
        h7pROZZy2CHvPBlSTLIc3oHd+56eqKt0AxG+xR6H5lHa2doN+C48K029JlNdkICTi477E9ZPgUpXp
        YbjFaP5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJzJ0-0008Qs-GZ; Fri, 26 Apr 2019 11:46:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF76329D173A6; Fri, 26 Apr 2019 13:46:10 +0200 (CEST)
Date:   Fri, 26 Apr 2019 13:46:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2] x86/mm/tlb: Remove flush_tlb_info from the stack
Message-ID: <20190426114610.GC12232@hirez.programming.kicks-ass.net>
References: <20190425180828.24959-1-namit@vmware.com>
 <20190425192930.GA91578@gmail.com>
 <82E44F4A-E52D-4666-95B5-C6248A14A442@vmware.com>
 <20190425194837.GB58719@gmail.com>
 <FA82D7BD-5657-4681-B76E-3452A71171B6@vmware.com>
 <20190426075349.GA4038@hirez.programming.kicks-ass.net>
 <14D4B64B-3684-4090-9881-C4A605CF5A19@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14D4B64B-3684-4090-9881-C4A605CF5A19@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 08:37:37AM +0000, Nadav Amit wrote:

> Interesting! (and thanks for the reference). Well, I said it would be quite
> surprising, and I see you wrote the same thing in the patch ;-)
> 
> But correct me if I’m wrong - it does sound as if you “screw” all the uses
> of atomic_inc() and atomic_dec() (~4000 instances) for the fewer uses of
> smp_mb__after_atomic() and smp_mb__before_atomic() (~400 instances).
> 
> Do you intend to at least introduce a variant of atomic_inc() without a
> memory barrier?

Based on defconfig build changes that that patch caused, no.

  https://lkml.kernel.org/r/20190423121715.GQ4038@hirez.programming.kicks-ass.net

Also note that except x86 and MIPS, the others: ia64, sparc, s390 and
xtensa already have this exact behaviour. Also note, as the patch notes,
that on 86 only atomic_{inc,dec,add,sub}() have this,
atomic_{and,or,xor}() already have the memory clobber.

Also, that would complicate the API too much, people are already getting
it wrong _a_lot_.

  https://lkml.kernel.org/r/20190423123209.GR4038@hirez.programming.kicks-ass.net
