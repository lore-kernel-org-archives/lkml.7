Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45FAC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775D6217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jKN4G9K8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390062AbfGRLEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 07:04:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfGRLEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Mu6JgufiifeVCl5ahdzNFF6iFcPalKmCtlVpF9MQKr8=; b=jKN4G9K8EwPrqjC/8/JSP/m5S
        TcLMiwu4DvM/TqjWUr4BtZbfSEy0MjVH/ZTsf1dj+GBuHNoi9r6GoymAmvrVuL4RWPpnn7H+WVyay
        rCK4Y1pfOJH1jfPbRAY4kAS2Q3bVbOeA/eHxqhE47maCBr2kbFAvIZwB/7gsA4ZtGrELeouczRWsa
        4J+6bKQ87LVxMn5Qfiwyia/jOs7bfCVOnDI3K4S0xiw8eTJ4N51Xld0jg8vq1EHsoETd5yIwGTpIr
        Lrfr/gT8b1WS7TqOkefy9ygY7HhrKYB/QGeUrbU6VX6ZuI6auNysqLKCLN0rCBA5kOLCGlLhKWaDt
        1sz9FC9lQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ho4DQ-0001yJ-8K; Thu, 18 Jul 2019 11:04:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1687B20197A71; Thu, 18 Jul 2019 13:04:46 +0200 (CEST)
Date:   Thu, 18 Jul 2019 13:04:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
        linux-kernel@vger.kernel.org, dbueso@suse.de, mingo@redhat.com,
        jade alglave <jade.alglave@arm.com>, paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v2] locking/rwsem: add acquire barrier to read_slowpath
 exit when queue is empty
Message-ID: <20190718110446.GC3419@hirez.programming.kicks-ass.net>
References: <20190716185807.GJ3402@hirez.programming.kicks-ass.net>
 <a524cf95ab0dbdd1eb65e9decb9283e73d416b1d.1563352912.git.jstancek@redhat.com>
 <20190717131335.b2ry43t2ov7ba4t4@willie-the-truck>
 <21ff5905-198b-6ea5-6c2a-9fb10cb48ea7@redhat.com>
 <20190717192200.GA17687@dustball.usersys.redhat.com>
 <20190718092640.52oliw3sid7gxyh6@willie-the-truck>
 <79224323.853324.1563447052432.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79224323.853324.1563447052432.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 06:50:52AM -0400, Jan Stancek wrote:
> > In writing this, I also noticed that we don't have any explicit ordering
> > at the end of the reader slowpath when we wait on the queue but get woken
> > immediately:
> > 
> > 	if (!waiter.task)
> > 		break;
> > 
> > Am I missing something?
> 
> I'm assuming this isn't problem, because set_current_state() on line above
> is using smp_store_mb().


X = 0;

								X = 1;
	rwsem_down_read()					rwsem_up_write();

	  for (;;) {
	    set_current_state(TASK_UNINTERRUPTIBLE);

								  rwsem_mark_wake()
								    atomic_long_add(adjustment, &sem->count);
								    smp_store_release(&waiter->task, NULL);

	    if (!waiter.task)
	      break;

	    ...
	  }


	r = X;


can I think result in r==0 just fine, because there's nothing ordering
the load of waiter.task with the store of X.

It is exceedingly unlikely, but not impossible afaict.
