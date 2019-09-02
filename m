Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9651C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0032173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UWpX8lEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfIBQVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 12:21:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45654 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfIBQVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o6Yn2NMsFJ2wUEEsOCsnnqV0fjmvzAttDgZ1RcUU5Ss=; b=UWpX8lEbBZzw61JtVqHnMeEzm
        AIuC4o1Thd7Wve9NeBonbopz7Q3C+1tz6XnFJwJRbcMtLWrWGN9abdiRvL/C5mwKcfNb0YN4y0SdP
        PPTRt0M+RWEqSVfBQT1rhgfKxaQ3POFS75WrhZFI6/BDWZTA38SwzJPme/k9JH/uM/eAmZ9KYQ0B7
        OdnrNWe77s1qeaYjV2hrc47K++1fg28u1TXo6iUggyD+tqFJRV2DOZAkUpST1pw28AVsWv3osuJDe
        AUlGmO0/vV2tmyt7ZtYHT0MwDqwKTHJ/tUaR94vRKY0gMjNfDmMyB7o1AGOUzyWPagfaKCIHigJvB
        oTmBNCyLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4p4J-0002Hh-G2; Mon, 02 Sep 2019 16:20:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5140A305BDE;
        Mon,  2 Sep 2019 18:20:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 243CE20CD2B24; Mon,  2 Sep 2019 18:20:36 +0200 (CEST)
Date:   Mon, 2 Sep 2019 18:20:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [BUG] Use of probe_kernel_address() in task_rcu_dereference()
 without checking return value
Message-ID: <20190902162036.GS2369@hirez.programming.kicks-ass.net>
References: <20190830140805.GD13294@shell.armlinux.org.uk>
 <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
 <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com>
 <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <20190902135315.GR2369@hirez.programming.kicks-ass.net>
 <20190902144424.GB14770@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902144424.GB14770@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 04:44:24PM +0200, Oleg Nesterov wrote:

> speaking of the users of task_rcu_dereference(), membarrier_global_expedited()
> does
> 
> 		rcu_read_lock();
> 		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
> 		if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
> 				   MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
> 
> This asks for READ_ONCE, but this is minor. Why can't p->mm be freed?
> 
> I guess it is fine to read the garbage from &p->mm->membarrier_state if we race
> with the exiting task, but in theory this looks unsafe if CONFIG_DEBUG_PAGEALLOC.
> 
> Another possible user of probe_slab_address() or I am totally confused?

You're quite right; that's busted.

Due to the lack of READ_ONCE() on p->mm, the above can in fact turn into
a NULL deref when we hit do_exit() around exit_mm(). The first p->mm
read is before and sees !NULL, the second is after and does observe
NULL, and *bang*.

I suppose it wants to be something like:

	mm = READ_ONCE(p->mm);
	if (mm && probe_address())

(I'm not sure _slab_ is a useful part of the name; it should work on
kernel memory irrespective of the allocator)

If it got freed, that CPU already just did something that implies
smp_mb() so we're good. So whatever garbage gets read, is fine. Either
we do a superfluous IPI or not is immaterial.


