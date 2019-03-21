Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155C9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14C921902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O4XIbFl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfCUSdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:33:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbfCUSdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O7oxcJZ6vp83f1ybgTEKyA+rD1L2wZJLmqLWa5IzaA4=; b=O4XIbFl4cvlQnYuHj7muS3JdP
        O1fty8L4RKzbFF21DWYIu/c7pNPpRr/+kIzppbPdOJkDpXSQIksBcjbQ6E57KyiXt13pcM19AuQzl
        PTEpOpxeqN/slcMU1Ilgl7ho0yotkU1Qhj330UpWMweKqZ2o/mB7vbWx1+nv8etIGUdoM4D59CNQQ
        uqcKtYYfsRaYnGZwmaXKEHaKBg9A3sG0Xfx2qoxtDczYfHxAMNbcS0Nc/8e0aycOiOeyNnT2UvFwn
        P7GoWCVMpsHrgMZfIMpHAcjZ/jdYQo9bmKv/tX4kcrrOIyD0GoD0C++jbsGylYqV4DgzpPRf6yyIB
        Giiai+k5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h72VN-00049V-Im; Thu, 21 Mar 2019 18:33:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14B50203CBE11; Thu, 21 Mar 2019 19:33:28 +0100 (CET)
Date:   Thu, 21 Mar 2019 19:33:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on
 error_entry
Message-ID: <20190321183327.GW5996@hirez.programming.kicks-ass.net>
References: <20190320221534.165ab87b@oasis.local.home>
 <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net>
 <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home>
 <20190321172203.GS5996@hirez.programming.kicks-ass.net>
 <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com>
 <20190321182745.GU5996@hirez.programming.kicks-ass.net>
 <CALCETrVd8i9xmGT9GPXU6tuvte+M9e3otYa8YNLEgPE+W81E2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVd8i9xmGT9GPXU6tuvte+M9e3otYa8YNLEgPE+W81E2w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:28:50AM -0700, Andy Lutomirski wrote:
> On Thu, Mar 21, 2019 at 11:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Mar 21, 2019 at 11:05:06AM -0700, Andy Lutomirski wrote:
> >
> > > Ugh.
> > >
> > > I certainly agree in principle that sticking the CR2 read into the asm
> > > is the right solution.  But this patch makes the spaghetti even more
> > > tangled.  Maybe we can rearrange the code a bit so that the entry
> > > sequence saves at least one register before calling error_entry, so we
> > > can do it the obvious way.
> >
> > What is the obvious way? Note that with all the Xen/paravirt-me-harder
> > bits on, we need to clobber at least RAX to get CR2.
> >
> > And most of the patch was munging the paravirt bits to make that happen.
> >
> > Another thing I did notices is that CLAC and CLD are not next to one
> > another in these paths.
> 
> The thing I really don't like is all the EBX crud to try to get
> everything in to the right order.

Ah yes, granted. I hate that part too but didn't see a way around it :/
