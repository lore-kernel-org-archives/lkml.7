Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41ACC19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 14:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F3020844
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 14:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wz3Uq0R7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfHDOtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 10:49:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43184 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfHDOtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 10:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Mtp+g7WpBJD26BgXFj0gCm0hISNxvHloZHwb4noPA5U=; b=Wz3Uq0R74klNGaZu8UGNMJB7/
        5QuAOTFIN3hvqlrVTOCAov5Cxt6LAww48N/CD5nk48MEnMN8hDGjlsbl9X02gy945lYsWp4WnCdac
        1+kZg1V9wBj0Zv2rTK4Sck4yazQ1yiheMTR7V+VJ3OHFVm9571NMq/FSqBjkZT+ZRd+4E+GWGoWq6
        pyugE2JiEBRZJaT73ax+ciahKlgbWY3syqdZliCP3WW9T8dRQl/4XVlMzqMImf7NzzlrnvF0kFXgI
        /DWMvKoI20lBAHgHayh1izWP/SYiwC+H12s43xwNA1m/jaYZ4klJlrnAaZIJKv4kJutAamtmERqWK
        3oGoFQYnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huHoM-0007Oo-Hk; Sun, 04 Aug 2019 14:48:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C63B20274D75; Sun,  4 Aug 2019 16:48:35 +0200 (CEST)
Date:   Sun, 4 Aug 2019 16:48:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC tip/core/rcu 14/14] rcu/nohz: Make multi_cpu_stop()
 enable tick on all online CPUs
Message-ID: <20190804144835.GB2386@hirez.programming.kicks-ass.net>
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-14-paulmck@linux.ibm.com>
 <20190804144317.GF2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190804144317.GF2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2019 at 04:43:17PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 02, 2019 at 08:15:01AM -0700, Paul E. McKenney wrote:
> > The multi_cpu_stop() function relies on the scheduler to gain control from
> > whatever is running on the various online CPUs, including any nohz_full
> > CPUs running long loops in kernel-mode code.  Lack of the scheduler-clock
> > interrupt on such CPUs can delay multi_cpu_stop() for several minutes
> > and can also result in RCU CPU stall warnings.  This commit therefore
> > causes multi_cpu_stop() to enable the scheduler-clock interrupt on all
> > online CPUs.
> 
> This sounds wrong; should we be fixing sched_can_stop_tick() instead to
> return false when the stop task is runnable?

And even without that; I don't understand how we're not instantly
preempted the moment we enqueue the stop task.

Any enqueue, should go through check_preempt_curr() which will be an
instant resched_curr() when we just woke the stop class.
