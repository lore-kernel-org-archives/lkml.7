Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EFFC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B2420880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qZBWheaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfDIIW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:22:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40082 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIIW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ii/PcFpBEd8OfeS8tymzEanfScvUm6QZjS+vGg+V5EA=; b=qZBWheaKEgKy46W2CHzPGg+Wv
        aLspId+ZZiZOTFErLSqtzKl0PFfF5UH2wj6q74hfEN9RtXR95y9ZzeUe01PWAeQ8fiEF0mW5iNBFB
        L9wdn3rfFxKYbNBnvGInkbXtPCVXjjTBN5zf/PaprfKvs+5QX9K2114+V6zWmYqKXUk/m+HAoBOTW
        DjRvSVTrkQMf2RxHbXBYljgmKFN8bcq/tP+hmv5ooyb5Bsr8JwSFOU/cJnAj6CxUdN/Rxz2C50j5g
        j5OXyOtPBulLIl99DRopM/XLvupE1rLVTZAhiIWA2vWC8rvHiq0g26UsYljnF97k0N+ZnKxLfUlwf
        gZLO828pw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDm1s-0005ix-JP; Tue, 09 Apr 2019 08:22:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69C8E2030C779; Tue,  9 Apr 2019 10:22:50 +0200 (CEST)
Date:   Tue, 9 Apr 2019 10:22:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 2/2] sched: Distangle worker accounting from rq lock
Message-ID: <20190409082250.GY12232@hirez.programming.kicks-ass.net>
References: <20190313165548.19713-1-bigeasy@linutronix.de>
 <20190313165548.19713-3-bigeasy@linutronix.de>
 <20190408194505.GK1975820@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408194505.GK1975820@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 12:45:05PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Wed, Mar 13, 2019 at 05:55:48PM +0100, Sebastian Andrzej Siewior wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > The worker accounting for CPU bound workers is plugged into the core
> > scheduler code and the wakeup code. This is not a hard requirement and
> > can be avoided by keeping track of the state in the workqueue code
> > itself.
> > 
> > Keep track of the sleeping state in the worker itself and call the
> > notifier before entering the core scheduler. There might be false
> > positives when the task is woken between that call and actually
> > scheduling, but that's not really different from scheduling and being
> > woken immediately after switching away. When nr_running is updated when
> > the task is retunrning from schedule() then it is later compared when it
> > is done from ttwu().
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Link: http://lkml.kernel.org/r/20110622174919.135236139@linutronix.de
> > Link: http://lkml.kernel.org/r/ad2b29b5715f970bffc1a7026cabd6ff0b24076a.1532952814.git.bristot@redhat.com
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > [bigeasy: preempt_disable() around wq_worker_sleeping() by Daniel Bristot de
> >           Oliveira]
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> This looks good from wq side.  Peter, are you okay with routing this
> through the wq tree?  If you wanna take it through the sched tree,
> please feel free to add
> 
> Acked-by: Tejun Heo <tj@kernel.org>

If you don't mind I'll take it through the sched tree, because while
looking at it I did a few cleanups on top.

Thanks!
