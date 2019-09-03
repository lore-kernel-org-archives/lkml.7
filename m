Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B24C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7E320820
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L4LfdsP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfICTmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:42:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfICTmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tVoaFtSBwMjg9JqoG7kA7ufj+6zbx8emytRxQ3/Jfdc=; b=L4LfdsP/khhXQ0mvp66GynXRm
        Sd1nw9eDpmNka4+ABbNKHNNGsWeO2RUnNXXvQWUsdcWmuVIm6+HzncBNj4Dqfwt1IkcyaSENU3D8H
        wFP2pcLfmN4ZR4/604bycJnHtBUlM5llWHAwKbyFKGAV3yEKGI96ArFipqKcYg5nisT7GfKjMnFz+
        +8Y0lHg5ASFGdhIhns+MOKGm3ydmNKxkHtBXaz2cIo96E2ijRblI3MDazEI+y5/4vECf+QZoIARiq
        ApQ4eb6h54vBnEujSV8ZiwW/gveQYFT9MlVOYI4JfpKLJm6cs8aXhUuMuIR6y9jkeXXj0vES15Xyi
        r0UriEqIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5Eh3-0006Y3-Q0; Tue, 03 Sep 2019 19:42:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D74E430116F;
        Tue,  3 Sep 2019 21:41:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0306C20977765; Tue,  3 Sep 2019 21:42:18 +0200 (CEST)
Date:   Tue, 3 Sep 2019 21:42:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 2/3] task: RCU protect tasks on the runqueue
Message-ID: <20190903194218.GU2349@hirez.programming.kicks-ass.net>
References: <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
 <20190903074117.GX2369@hirez.programming.kicks-ass.net>
 <20190903074718.GT2386@hirez.programming.kicks-ass.net>
 <87k1apqqgk.fsf@x220.int.ebiederm.org>
 <CAHk-=wjVGLr8wArT9P4MXxA-XpkG=9ZXdjM3vpemSF25vYiLoA@mail.gmail.com>
 <874l1tp7st.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l1tp7st.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 01:13:22PM -0500, Eric W. Biederman wrote:

> I think this is where I am looking a things differently than you and
> Peter.  Why does it have to be ___schedule() that changes the value
> in the task_struct?  Why can't it be something else that changes the
> value and then proceeds to call schedule()?

If you call schedule() you will pass through plenty that already implies
smp_mb() before writing the ->curr pointer. If you care about that case,
adding RELEASE semantics to that store gains you absolutely nothing
except a marginally slower kernel.

> If we use RCU_INIT_POINTER if there was something that changed
> task_struct and then called schedule() what ensures that a remote cpu
> that has a stale copy of task_struct cached will update it's cache
> after following the new value rq->curr?  Don't we need
> rcu_assign_pointer to get that guarantee?

That whole construct doesn't really make sense: one it is very rare to
change task_struct content for !current tasks (and if we do, it must be
with atomic ops, because then there can be concurrency), secondly when
calling schedule() there is no guarantee on what @next will be.

