Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD77C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12AB2173B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WpEuz0f2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404688AbfFKIRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:17:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404401AbfFKIRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ud411InFe8GoOew3/skHmwEYBmhHWja4h4GlbxBRd9I=; b=WpEuz0f2bMQMpMS+SEsJoXQ0a
        clPKhCoLgxEn3zA+5EICQ7tkNJxjlskObNKJzKhSooTVjtW++jQr13J9cnEE8Kewof8/YRDYYFiaK
        2VMxA6jXB6SQjukBtOBmnCSEk5BbkosCYTUe7GApgABK7mfNPTyoi8TDsWfBpIzpP5spitDAnXFqJ
        OJjFrbh+1mOEuzOHiTemufpqLhbQMrUQ/9pBtxC2LM0knnGwb2FS60JeAS/8RsjzwFu9JvfS/VJTh
        o9OCx+PnGVpfpP2BIxz2a+1f8NAAb+Q0bMNB14tRackxSOLhHN4SOwEOhg1Sx/xqj81sotWLmm16w
        ITWNCyIHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haby5-00077F-3q; Tue, 11 Jun 2019 08:17:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8077D202173E1; Tue, 11 Jun 2019 10:17:19 +0200 (CEST)
Date:   Tue, 11 Jun 2019 10:17:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 07/15] x86: Add int3_emulate_call() selftest
Message-ID: <20190611081719.GQ3436@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131944.946978563@infradead.org>
 <20190610165258.t7rcvggdjihtdrfz@treble>
 <CALCETrVRuMP4vF+dN-tK_cw=guv6J5EqgD1H-PxMow+d=1DT4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVRuMP4vF+dN-tK_cw=guv6J5EqgD1H-PxMow+d=1DT4g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 09:57:58AM -0700, Andy Lutomirski wrote:
> On Mon, Jun 10, 2019 at 9:53 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Wed, Jun 05, 2019 at 03:08:00PM +0200, Peter Zijlstra wrote:
> > > Given that the entry_*.S changes for this functionality are somewhat
> > > tricky, make sure the paths are tested every boot, instead of on the
> > > rare occasion when we trip an INT3 while rewriting text.
> > >
> > > Requested-by: Andy Lutomirski <luto@kernel.org>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
> >
> 
> Looks good to me, too,

I'll translate that into an Acked-by from you, if you don't mind :-)

> except that I seriously hate die notifiers that
> return NOTIFY_STOP, and I eventually want to remove support for them.
> This can wait, though.

Yes, I share your hatred for notifiers in general. But since they are
still here and I do think it is a waste to have an unconditional
function call in do_int3() just for this, I figured I'd use them.
