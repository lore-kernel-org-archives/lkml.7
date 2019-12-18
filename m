Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C883C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CE0206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XSIt63bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfLRUjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:39:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRUjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5IRekf7Hfq0F+Zs5ey5GQlKOYNtd0pnVixx2++Tjts0=; b=XSIt63bn3+h51oZ/5uaig/NOu
        tFArHm61DH2FN0mgqglrTl5zKVhpSO7LuMmNRCoIXRmTZt5bZoRkL5YY9B9nkcVaeD5/dD9z+X00p
        tN0VRF1fIvb7Rp0xMS5MDbXsddPNA0eLVfg9XM+jBSFMm/XIXuaAyAGNZphBQlWjc7j2fzzbhWMEt
        k+RcqOpGsZtcOCG0OeJqGrYr8VtZ3pduTlmbJiTo1Wa0bTET8aziDg+/qRkipWT4/Fff//AH1Mdym
        1Vbaxyye5BoJhHTrsGLym2XeSxr0lP9xMRW/VzMveg8bL2NTgzitT6LtVzLATjjErAcV7hXPkFLfR
        GbdToNU0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihg6m-0002vS-Tm; Wed, 18 Dec 2019 20:39:49 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8D47980E35; Wed, 18 Dec 2019 21:39:46 +0100 (CET)
Date:   Wed, 18 Dec 2019 21:39:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rxrpc: struct mutex cannot be used for
 rxrpc_call::user_mutex
Message-ID: <20191218203946.GL11457@worktop.programming.kicks-ass.net>
References: <157659672074.19580.11641288666811539040.stgit@warthog.procyon.org.uk>
 <20191218135047.GS2844@hirez.programming.kicks-ass.net>
 <20191218190833.ufpxjrvin5jvp3m5@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218190833.ufpxjrvin5jvp3m5@linux-p48b>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 11:08:33AM -0800, Davidlohr Bueso wrote:
> On Wed, 18 Dec 2019, Peter Zijlstra wrote:
> 
> > On Tue, Dec 17, 2019 at 03:32:00PM +0000, David Howells wrote:
> > > Standard kernel mutexes cannot be used in any way from interrupt or softirq
> > > context, so the user_mutex which manages access to a call cannot be a mutex
> > > since on a new call the mutex must start off locked and be unlocked within
> > > the softirq handler to prevent userspace interfering with a call we're
> > > setting up.
> > > 
> > > Commit a0855d24fc22d49cdc25664fb224caee16998683 ("locking/mutex: Complain
> > > upon mutex API misuse in IRQ contexts") causes big warnings to be splashed
> > > in dmesg for each a new call that comes in from the server.
> > 
> > FYI that patch has currently been reverted.
> > 
> > commit c571b72e2b845ca0519670cb7c4b5fe5f56498a5 (tip/locking/urgent, tip/locking-urgent-for-linus)
> 
> Will we ever want to re-add this warning (along with writer rwsems) at some point?

Yes, we can try again for the next cycle.
