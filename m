Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7463C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCA521A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qUV1crH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbfJCNmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:42:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbfJCNmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z4Fbmkp6VSKxSOTmoTLoE7iXbtqotSgieIcrdQiNoGU=; b=qUV1crH7ygkqKhnHi2IVWd+st
        lXJ7A/lJUBFz85JZLlVJDEsvt/Do5pDrSI/v/MZGzctjy/o+iO6mh7kPrEchwnC7N7ozweNvafw1K
        8Cah++IsdSrEEb4s0fueywltkwTz5WYtLFdGqLPdGIaqx5CvYiStBUK7T2K+BDwdBKHSjvxEkK0yo
        mVDv871kS9PrS7lOxVgzS6MFxvd/F2fsII/Z1vT0yPIND0VJG0f3DlOr3hMkrh279beQQjmNhcneR
        hSpthD0Hz0HZzmpDKsbuU8ZVsBDtPPFhw7TpklhppdFTcIwaM9v0uCw2ED99k57cdCrgjJXqGuKf+
        FmsVIEkpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iG1MN-0000Ba-AD; Thu, 03 Oct 2019 13:41:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D981D304B4C;
        Thu,  3 Oct 2019 15:40:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B8B5201EFE03; Thu,  3 Oct 2019 15:41:32 +0200 (CEST)
Date:   Thu, 3 Oct 2019 15:41:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Shane M Seymour <shane.seymour@hpe.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH tip/core/rcu 1/9] rcu: Upgrade rcu_swap_protected() to
 rcu_replace()
Message-ID: <20191003134131.GS4536@hirez.programming.kicks-ass.net>
References: <20191003014310.13262-1-paulmck@kernel.org>
 <20191003014153.GA13156@paulmck-ThinkPad-P72>
 <25408.1570091957@warthog.procyon.org.uk>
 <20191003090850.1e2561b3@gandalf.local.home>
 <20191003133315.GN2689@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003133315.GN2689@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 06:33:15AM -0700, Paul E. McKenney wrote:
> On Thu, Oct 03, 2019 at 09:08:50AM -0400, Steven Rostedt wrote:
> > On Thu, 03 Oct 2019 09:39:17 +0100
> > David Howells <dhowells@redhat.com> wrote:
> > 
> > > paulmck@kernel.org wrote:
> > > 
> > > > +#define rcu_replace(rcu_ptr, ptr, c)					\
> > > > +({									\
> > > > +	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
> > > > +	rcu_assign_pointer((rcu_ptr), (ptr));				\
> > > > +	__tmp;								\
> > > > +})  
> > > 
> > > Does it make sense to actually use xchg() if that's supported by the arch?
> 
> Historically, xchg() has been quite a bit slower than a pair of assignment
> statements, in part due to the strong memory ordering guaranteed by
> xchg().  Has that changed?  If so, then, agreed, it might make sense to
> use xchg().

Nope, still the case. xchg() is an atomic op with full ordering.
