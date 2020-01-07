Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A576C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670F7206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="btXi/8aB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgAGJ3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:29:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgAGJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sZXc/SFe/LDxQMr1tMtTHpfYzLnb842y8KpXben4b1s=; b=btXi/8aBR87eesFRk9rVTf7MA
        Lo11ZldNjZKAaB6/9zJZ1gf9NCJZvkST1Vwo004YnQHoByFcCJfif+5Fqu4TzIXw5U0tGlHGJWd+a
        uAbdPGF/hE+gJrM45w6VbyVJMLfvZdman1WMvJ7duagTokTpaTco+9foSyaY6KC4KEi1apyy3gt3Z
        MyFzxQQ4CQ3HjQ7Ly+3LO79dRGmdWpV/ITVmEE62USnSeM4Sul7t2Qc2rcdQVThRujD+TAPDdf8sE
        Ls2wHFbHxc87Oh04zt8FDYANAYG0ibCN0a0J7L1coZDrTWqb/7TS0AcaWpbj9k4F209mloCRCp9DM
        w5WzTTcmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iolBA-0000AU-Tt; Tue, 07 Jan 2020 09:29:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A39A4304A59;
        Tue,  7 Jan 2020 10:28:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 24B232B5FBC95; Tue,  7 Jan 2020 10:29:35 +0100 (CET)
Date:   Tue, 7 Jan 2020 10:29:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] locking/refcount: add sparse annotations to dec-and-lock
 functions
Message-ID: <20200107092935.GU2844@hirez.programming.kicks-ass.net>
References: <20191226152922.2034-1-ebiggers@kernel.org>
 <20191228114918.GU2827@hirez.programming.kicks-ass.net>
 <201912301042.FB806E1133@keescook>
 <20191230191547.GA1501@zzz.localdomain>
 <201912301131.2C7C51E8C6@keescook>
 <20191230233814.2fgmsgtnhruhklnu@ltop.local>
 <20200106154119.GV2810@hirez.programming.kicks-ass.net>
 <20200106175459.tjuhmdrsusax3s4z@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106175459.tjuhmdrsusax3s4z@ltop.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 06:54:59PM +0100, Luc Van Oostenryck wrote:
> On Mon, Jan 06, 2020 at 04:41:19PM +0100, Peter Zijlstra wrote:

> > extern bool spin_trylock(spinlock_t *lock) __attribute__((context(lock, 0, spin_trylock(lock));
> 
> Well, allowing arbitrary conditions would be hard/impossible but you're
> only asking to have the *return value* as condition, right? That looks
> as reasonably feasible.

Just the return value would cover all the known cases yes. At the time
I might have been somewhat over ambitious..

> > Basically have sparse do a transform on its own expression tree and
> > inject the very same crud we now do manually. This avoids cluttering the
> > kernel tree with this nonsense.
> 
> So, a call of a function declared with __acquires() or releases() is
> interpreted by Sparse as if the call is immediately followed by an
> increase or a decrease of the context. It wouldn't be very hard to
> add a new attribute (something like __cond_context) and let Sparse do
> as if a call to a function with such attribute is directly followed
> by a test of its return value and a corresponding change in the context.
> It would boil down to:
> 
> 	extern bool spin_trylock(lock) __cond_context(lock);
> 
> 	if (spin_trylock(lock)) {
> 		/* do crap */
> 		spin_unlock();
> 	}
> 
> behaving like the following code currently would:
> 
> 	extern bool spin_trylock(lock);
> 
> 	if (spin_trylock(lock)) {
> 		__acquire(lock);
> 		/* do crap */
> 		spin_unlock();
> 	}
> 
> 
> Would something like this be satisfactory?

Very much so, Thanks!
