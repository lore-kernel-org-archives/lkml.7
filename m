Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28E1C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A5720652
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mvO/ZCjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404704AbfFKIN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:13:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51604 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404418AbfFKIN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mkcpo7en8M+8P4XggtFvfO/k9/j7EcHlCovsQ/YQuOc=; b=mvO/ZCjoReANn7ODvkHLtCsKI
        8ovgq1OSkphYUE1i6E4TrW5V4Zm7l2ZNIBcXMTy3rPKGYhidwVZcI1Y9EoIbu/6EhEIx8PlYywK72
        kUmK5i2AK7J/k8js35P1wkeMWFWaUVi0JYyaZIZyVWRKFo4DUB2Da/hf2ZGpjGSnD6VHVhkfly9XQ
        TrLOAiWNWbM/mjoV+vFAXmlRROP9miblQWLdSCXUhs08dLsqVG3V6sAy6ni8S944RnxYWe7a6uW+D
        3IAughuaujqh6fWnopuBHkLIB+heDAKWy0mpip64qBuB6Au5bHBqW3iqduIyk8OjaWdvyjgUedaXv
        /PsJYN7JA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1habtY-0003N7-L8; Tue, 11 Jun 2019 08:12:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C766A202173E0; Tue, 11 Jun 2019 10:12:37 +0200 (CEST)
Date:   Tue, 11 Jun 2019 10:12:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 03/15] x86/kprobes: Fix frame pointer annotations
Message-ID: <20190611081237.GO3436@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131944.711054227@infradead.org>
 <20190607220210.328ed88f2f7598e757c3564f@kernel.org>
 <20190607133602.os7st57epo3otbc4@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607133602.os7st57epo3otbc4@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 09:36:02AM -0400, Josh Poimboeuf wrote:
> On Fri, Jun 07, 2019 at 10:02:10PM +0900, Masami Hiramatsu wrote:
> > On Wed, 05 Jun 2019 15:07:56 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > The kprobe trampolines have a FRAME_POINTER annotation that makes no
> > > sense. It marks the frame in the middle of pt_regs, at the place of
> > > saving BP.
> > 
> > commit ee213fc72fd67 introduced this code, and this is for unwinder which
> > uses frame pointer. I think current code stores the address of previous
> > (original context's) frame pointer into %rbp. So with that, if unwinder
> > tries to decode frame pointer, it can get the original %rbp value,
> > instead of &pt_regs from current %rbp.

The way I read that code is that we'll put the value of SP into BP at
the point where we've done 'PUSH BP', which is right in the middle of
that PUSH sequence. So while it works for a FP based unwinder, it
doesn't 'properly' identify the current frame.

> > > Change it to mark the pt_regs frame as per the ENCODE_FRAME_POINTER
> > > from the respective entry_*.S.
> > > 
> > 
> > With this change, I think stack unwinder can not get the original %rbp
> > value. Peter, could you check the above commit?
> 
> The unwinder knows how to decode the encoded frame pointer.  So it can
> find regs by decoding the new rbp value, and it also knows that regs->bp
> is the original rbp value.

Right, as Josh says the unwinder has a special case for this and it
knows these 'odd' BP values (either MSB or LSB set) indicate a pt_regs
set.
