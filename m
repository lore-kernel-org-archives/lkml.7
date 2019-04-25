Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029BFC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF722236C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gfGWPw49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfDYM0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:26:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbfDYM0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pPtMBVUTCJglIJ029BF5lLSw6NXULkk4/tedW3lLCSY=; b=gfGWPw49Z+/4b1/zSJch/d0rs5
        hWocoQ6J7Gl1yKSQiue1HfFwPKOcc6q2KU57TJeO9et8XZJfPhgr+b6YTIsLekS6yCZ7mznqMyOL3
        bwUkSLbueJpTuoaZExDjv/IkF4aRWGLRsDrMynrgN1qtWt+Etu5xDE6t1fmq5n96AyNsHUZKkndDi
        U1R/heyu+LjTGcOqRdXdh2uGeu7axwC+I97PRZ2UPMnUt6wdhRx7zPILEFbkWvXlR3WS/eeDap5cM
        8g/ZdeQg6YDfRExEo1PtRa61Q/RVV6zti1ZKBv7M10OD846wj7bHfSAzIJxKU5ivfnKbqDZdXM/+x
        PPtGTnlg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJdS9-0008Ny-DW; Thu, 25 Apr 2019 12:26:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCB7229C22B18; Thu, 25 Apr 2019 14:26:11 +0200 (CEST)
Date:   Thu, 25 Apr 2019 14:26:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     huangpei@loongson.cn
Cc:     Paul Burton <paul.burton@mips.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: Re: Re: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb()
 wreckage
Message-ID: <20190425122611.GT4038@hirez.programming.kicks-ass.net>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.636767843@infradead.org>
 <20190424211759.52xraajqwudc2fza@pburton-laptop>
 <2b2b07cc.bf42.16a52dc4e4d.Coremail.huangpei@loongson.cn>
 <20190425073348.GV11158@hirez.programming.kicks-ass.net>
 <5b13fd3b.c031.16a54452744.Coremail.huangpei@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b13fd3b.c031.16a54452744.Coremail.huangpei@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 07:32:59PM +0800, huangpei@loongson.cn wrote:

> > > If it is not LL/SC but other memory access from B on V, A's ll/sc can
> > > follow the atomic semantics even if A violate the coherence protocol
> > > in the same situation.
> > 
> > *shudder*...
> > 
> >   C atomic-set
> > 
> >   {
> > 	  atomic_set(v, 1);
> >   }

This is the initial state.

> 
> > 
> >   P1(atomic_t *v)
> >   {
> > 	  atomic_add_unless(v, 1, 0);
> >   }
> > 
> >   P2(atomic_t *v)
> >   {
> > 	  atomic_set(v, 0);
> >   }
> > 
> >   exists
> >   (v=2)
> > 
> > So that one will still work? (that is, v=2 is forbidden)
> 
> you mean C，P1, P2 on 3 different CPU? I do not know much about LKMM, can explain the test case more explicit?

The 'C' is the language identifier, the 'atomic-set' is the litmus name.

The unnamed block give the initial conditions.

Pn blocks give code sequences for CPU n

The 'exists' clause is evaluated after all Pn blocks are done.

There's others in this thread that can point you to many papers and
resources on these litmus test thingies.

So basically the initial value of @v is set to 1.

Then CPU-1 does atomic_add_unless(v, 1, 0)
     CPU-2 does atomic_set(v, 0)

If CPU1 goes first, it will see 1, which is not 0 and thus add 1 to 1
and obtains 2. Then CPU2 goes and writes 0, so the exist clause sees
v==0 and doesn't observe 2.

The other way around, CPU-2 goes first, writes a 0, then CPU-1 goes and
observes the 0, finds it matches 0 and doesn't add.  Again, the exist
clause will find 0 doesn't match 2.

This all goes unstuck if interleaved like:


	CPU-1			CPU-2

				xor	t0, t0
1:	ll	t0, v
	bez	t0, 2f
				sw	t0, v
	add	t0, t1
	sc	t0, v
	beqz t0, 1b

(sorry if I got the MIPS asm wrong; it's not something I normally write)

And the store-word from CPU-2 doesn't make the SC from CPU-1 fail.

