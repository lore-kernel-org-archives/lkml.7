Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42A2C19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 14:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895ED20844
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 14:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IVjn9fgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfHDOoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 10:44:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43142 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfHDOoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 10:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5rdh5G3lzzyq4EoUCDQ5vzYWt2z2/ddaXxkgEfQ0PHo=; b=IVjn9fgQ9/E+g8+WjfQVMK8Q5
        j3vCPYCzAnTsHuLB3r5Um+aCRhNQoONqJDIW+mm7keg+rMTJOYyuQx3tLtFpeCUwFnt4qPMdU/eJV
        Y7y4b2LNzuhyq3dJ2QdG42K6fm+WX1m2hC1UzI0/vL2zzszTBpt+WEc43P+4zqMHji7qRWpHAp/Jz
        214HVmu6/gHGEDUGbm9p9pHYDE/TE3qnvT3YPoLCkfwD9GWuSMZmO9f/XnK5RwL7LlyrcgeXGx8q2
        TvtPgbj3uCporq3u8KsFfM7TXQainyMrQ5LwTpdcZrHMtS+fb54fKAVLSRsGVIDaK2o6x47Sda/0g
        Es6Wam6GA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huHjE-0007Le-Lx; Sun, 04 Aug 2019 14:43:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CAEA2202989CD; Sun,  4 Aug 2019 16:43:17 +0200 (CEST)
Date:   Sun, 4 Aug 2019 16:43:17 +0200
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
Message-ID: <20190804144317.GF2349@hirez.programming.kicks-ass.net>
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-14-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802151501.13069-14-paulmck@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:15:01AM -0700, Paul E. McKenney wrote:
> The multi_cpu_stop() function relies on the scheduler to gain control from
> whatever is running on the various online CPUs, including any nohz_full
> CPUs running long loops in kernel-mode code.  Lack of the scheduler-clock
> interrupt on such CPUs can delay multi_cpu_stop() for several minutes
> and can also result in RCU CPU stall warnings.  This commit therefore
> causes multi_cpu_stop() to enable the scheduler-clock interrupt on all
> online CPUs.

This sounds wrong; should we be fixing sched_can_stop_tick() instead to
return false when the stop task is runnable?
