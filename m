Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1577CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44592070B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="goBiunHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfFDRjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:39:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40588 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFDRjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FYzF5TUzK4CIyrNZDcehrGX3pjE6OWI8xK3W3Q1xIGQ=; b=goBiunHY6wYTm1oY59dUPWrE2
        bGDyhw4Bq2XyeUQexMKGZ+2tY3lYPJhdUUNJa3HI4AeIs7vU1Q4q9G00f5CLPylms+XR0W176eKTd
        yl8/SXaGn8OVpfRVlSp/vut3yoSuNSKK2XZ1fz1gHGrdQEyDBA8MgCZRbEdDmrlYrTnLabKvicqWZ
        tB3RAB594+C6KY3TGHEAW5JssSE8/PbQ+3HdSw4NZVmzSoi+x8pw2e6sFyOKPbCBEmsm/GDk7dyPn
        giVUyOLdypQfY0EJA88dhu1vRt2gGR+xV6iO7WOT83syV0lqC9F4MLQwErqU1ZMoAGc5vD/8uazkQ
        mKTxqRRnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYDOh-0005eB-S8; Tue, 04 Jun 2019 17:38:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE60C20114D93; Tue,  4 Jun 2019 19:38:53 +0200 (CEST)
Date:   Tue, 4 Jun 2019 19:38:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v8 15/19] locking/rwsem: Adaptive disabling of reader
 optimistic spinning
Message-ID: <20190604173853.GG3419@hirez.programming.kicks-ass.net>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-16-longman@redhat.com>
 <20190604092008.GJ3402@hirez.programming.kicks-ass.net>
 <8e7d19ea-f2e6-f441-6ab9-cbff6d96589c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e7d19ea-f2e6-f441-6ab9-cbff6d96589c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 01:30:00PM -0400, Waiman Long wrote:
> > That's somewhat inconsistent wrt the type. I'll make it unsigned long,
> > as that is what makes most sense, given there's a pointer inside.
> 
> Thank for spotting that, I will fix it.

I fixed a whole bunch of them; please find the modified patches here:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=locking/core
