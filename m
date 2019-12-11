Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F99C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A7620836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J2Od0lbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbfLKNoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:44:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfLKNoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dlfDc+m3w6hHBDkkaipfuULOtmHkWhQIg9hZcgUHcvA=; b=J2Od0lbu9thmJGNo+HyOOir9H
        E9q2U7abHevEy438bDiwfzL6Rn7paaukFBGB8NM/OdYeZx338ho4M8sYB1CaL/Eg5YaLgWVnnKQYw
        87qtVqwMCkcqxDv0h0Ed1B3JHigJIBrUfDS7BnijvmfsJ1CPvoIVDmsaYSSRCGi/bN1Y60pgqeAQ1
        8e+SWEq31E4FiwCjnsG7urG9dcR3JANLb/ZAylAWoNvG/eCaT6OIEcuq1EXTUWmKsYwzq6GFUy6Di
        I5RBqkoanzueb+UX4ntWLP54QFoTtR9lftueHe9Zz0R8kRbrZdb/ju2tTy5q55bCPFr+PMO2gLakk
        XlYGz70eg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if2IK-0006Tx-R9; Wed, 11 Dec 2019 13:44:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 699F4305E21;
        Wed, 11 Dec 2019 14:43:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 341F020137CBD; Wed, 11 Dec 2019 14:44:46 +0100 (CET)
Date:   Wed, 11 Dec 2019 14:44:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Malte Skarupke <malteskarupke@web.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, malteskarupke@fastmail.fm
Subject: Re: [PATCH] futex: Support smaller futexes of one byte or two byte
 size.
Message-ID: <20191211134446.GK2810@hirez.programming.kicks-ass.net>
References: <20191204235238.10764-1-malteskarupke@web.de>
 <20191206153129.GI2844@hirez.programming.kicks-ass.net>
 <20191206173705.GE2871@hirez.programming.kicks-ass.net>
 <81f9229b-76f8-495c-97b5-12bffee06b37@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f9229b-76f8-495c-97b5-12bffee06b37@www.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please read:

  https://people.kernel.org/tglx/notes-about-netiquette-qw89

On Sun, Dec 08, 2019 at 05:18:12PM -0500, Malte Skarupke wrote:
> In my first version WAKE also took a size parameter, however I chose
> to not send that version because there are two problems with that. You
> already noticed the first problem: we would have to store the size and
> verify that it matches on WAKE.
> 
> The second problem is with REQUEUE and CMP_REQUEUE: The usual case
> there will be that you have a mutex that's 8 bits in size, but the
> condition variable is harder to fit into 8 bits and will be larger. So
> you would need to pass in two different size flags. But REQUEUE
> doesn't actually care what the size is at all. It just moves waiters
> around. CMP_REQUEUE does care, but only for one of the arguments. So
> it works out perfectly that there is one flag for the size.
> 
> Those two cases really helped me clarify what the size argument
> actually is needed for. It's only needed for the "compare" part of
> CMP_REQUEUE. Similarly WAIT could have also been named CMP_WAIT and if
> it was named that, it would also be obvious that the size argument is
> only needed for the "compare" part of WAIT. All the other work that
> WAIT does doesn't actually care about the memory behind the pointer at
> all. It only cares about the address.
> 
> That also illustrates what should happen if we splice a futex and call
> WAIT on @ptr and WAKE on @ptr+1: If I understand you correctly, (and
> correct me if I'm wrong here) your point is that there would be an
> inconsistency in the API there. You say it would be inconsistent for a
> size-less WAKE to not wake a futex that it's pointing in the middle
> of.
> 
> But with the above thoughts, we realize that since those are two
> different addresses, they refer to two different futexes. It doesn't
> matter that the WAIT was for a four byte futex. That information was
> only relevant for the "compare" part of WAIT. It's not relevant for
> anything else, and therefore it's not relevant for the identity of the
> futex. So the fact that splicing a futex doesn't work (and can't
> easily be made to work) does not point at an inconsistency in the API.

See, I disagree. The WAIT/WAKE pair is an implementation of the MONITOR
pattern. Similar to x86's MONITOR/MWAIT or ARMv8's LDXR/WFE. It allows a
(task vs cpu) blocking implementation of:


  WAIT:
	while (READ_ONCE(*ptr) != val)
		cpu_relax;

  WAKE:
	WRITE_ONCE(*ptr, val);


With futex that turns into:


  WAIT:
	for (;;) {
		u32 t = READ_ONCE(*ptr);
		if (t == val)
			break;
		futex(WAIT, ptr, t);
	}

  WAKE:
	WRITE_ONCE(*ptr, val);
	futex(WAKE, ptr);


IOW, each WAKE corresponds to a STORE.

Extending the above to variable width, you'll see that:

	u32 var = 0xff;
	u32 *ptr = &var, val = 0xffff;

  WAIT:
	while (READ_ONCE(*ptr) != val)
		cpu_relax();

  WAKE:
	WRITE_ONCE(*(u8*)ptr+1, 0xff); // let's assume LE

will in fact release the WAIT. IOW, all WAIT cares about is that the
value it went to sleep on has changed. It doesn't care how many bits of
the variable changed or what size store made it happen.

It also works the other way:

	u8 var = 0, val = 1;
	u8 *ptr = &var;

  WAIT:
	while (READ_ONCE(*ptr) != val)
		cpu_relax();

  WAKE:
	WRITE_ONCE(*(u32 *)((unsigned long)ptr & ~0x3), 0x01010101);

That u32 store fills our @var with 1 and the WAIT terminates.

In neither example does @ptr (necessarily) match.

> Taking all that into account, I believe there are two possible
> consistent implementations for sized futexes. One of them is the one
> you're asking for, where the size is always passed and always verified
> to be correct. The other one is the one I'm proposing, where the size
> argument only applies to the "compare" part of WAIT and CMP_REQUEUE,
> and all the other work of futexes is size-less and only works on the
> address. (and I think similar reasoning will work for the operations
> that are not supported yet)
> 
> I believe that between those two consistent implementations, the one
> with size-less WAKE and REQUEUE is preferable. REQUEUE in particular
> makes clear how we really don't care about the size in these
> operations. There is no difference in behavior when moving between
> futexes of different sizes or the same size. It just doesn't matter.
> But if REQUEUE is size-less, it would be inconsistent for WAKE to
> require a size since REQUEUE is just a WAKE with extra features.
> 
> The other downside of the version that checks the size is that we,
> well, have to check the size. That's extra work we have to do and
> extra data we have to store, and I can't come up with any case where a
> user would actually benefit from us doing that extra work.

So I'll argue that, while the pure address mode is perhaps convenient,
it is not consistent.  In particular it allows some but disallows other
mixed size overlapping operations. Consistency would either allow or
disallow all.

Yes, being strict is perhaps a little more expensive, but I so prefer
strict and narrow semantics over weird and fuzzy semantics. Also, I
don't think it is actually that much more expensive.

Specifically, as you found, we have available space in
futex_key::offset, 2 more FUT_OFF_ bits would allow encoding 4 different
sizes (1,2,4,8 bytes).

Re REQUEUE, using 4 instead of 2 extra bits in the command word would
allow encoding 2 sizes, one for uaddr and one for uaddr2.

Thomas?
