Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C950C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA6B22DBF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S50WnuIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfICHlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:41:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfICHlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LRQvH9pG4Tq58hJ83V4MT/wMnFnKxLezVFN0uvP/QWA=; b=S50WnuIMLsP5L0Bm83sVi1xLN
        EwEwkQ8FEZ2/hM0vfhoLpzYiz/MRMInp/xyRgCO7M2c+yRocPAqn/RGgSgzjo/kiW46r1BlfNoWQ/
        20TI5f850DpDWnrvozTqgHA9FpkWluWI1AWDVQbICnt9DSMXZJQREWvCxuDzcUQlxhpbK+UHEofEN
        4Llca0PuqWZR+jSjuaFAZxextuA9PvK6ndlRg2WC0kZqMfPOpLdqhwlHm59n1i4MLaEpI7YNter35
        azl4MLawOWCDCHLBpwMQHx6Ia0krX6MbFDJ5rJvyMc9F67GcaZ5d/hw/zVcyloEeQdafjLOeb/47E
        tT893cBEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i53RI-0003ws-Jf; Tue, 03 Sep 2019 07:41:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D718F30116F;
        Tue,  3 Sep 2019 09:40:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0AB929BA4608; Tue,  3 Sep 2019 09:41:17 +0200 (CEST)
Date:   Tue, 3 Sep 2019 09:41:17 +0200
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
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 2/3] task: RCU protect tasks on the runqueue
Message-ID: <20190903074117.GX2369@hirez.programming.kicks-ass.net>
References: <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
 <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com>
 <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 11:52:01PM -0500, Eric W. Biederman wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2b037f195473..802958407369 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c

> @@ -3857,7 +3857,7 @@ static void __sched notrace __schedule(bool preempt)
>  
>  	if (likely(prev != next)) {
>  		rq->nr_switches++;
> -		rq->curr = next;
> +		rcu_assign_pointer(rq->curr, next);
>  		/*
>  		 * The membarrier system call requires each architecture
>  		 * to have a full memory barrier after updating

This one is sad; it puts a (potentially) expensive barrier in here. And
I'm not sure I can explain the need for it. That is, we've not changed
@next before this and don't need to 'publish' it as such.

Can we use RCU_INIT_POINTER() or simply WRITE_ONCE(), here?

