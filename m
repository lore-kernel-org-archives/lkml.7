Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83271C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C44A20880
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rk9Fldlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfGRLJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 07:09:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43174 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfGRLJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WkAmz9ErFFMrP6yoc8ym+52otaHCvNXCSIBUiMMe6Ow=; b=rk9FldloEb7sNuqItRd33pML7
        eCHNmsllqc/6/RCNqz1N9v8yDSIZIkufa3MY6o2o/Y95x/fZjm2FENTqsl1CX5VW9CRng7fd08OXp
        Ly5SMMufDho/D1LFBj9V11nMpHQ9P0xYTQGTAKJ7KBvmkA5mTeK/51s6DxeiKdt51oAbndcdy4XvZ
        NbJyYO3AP464Kq/+ksmWAx4nq5k8grJVyK0FuflX/IilseUdqavU2ttJ/Re0ZBZ2TcGq4U10sz2Mq
        6wtw00o3YlefMLRfZNXG0RAiQkSzT316JClL+A+nPMtvLardQjVQydUFC3w9Qzsmcj1wue+XVRI/S
        nlT+YwK9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ho4Hx-00034d-Js; Thu, 18 Jul 2019 11:09:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5AB2320197A71; Thu, 18 Jul 2019 13:09:28 +0200 (CEST)
Date:   Thu, 18 Jul 2019 13:09:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
        linux-kernel@vger.kernel.org, dbueso@suse.de, mingo@redhat.com,
        jade alglave <jade.alglave@arm.com>, paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v2] locking/rwsem: add acquire barrier to read_slowpath
 exit when queue is empty
Message-ID: <20190718110928.GT3463@hirez.programming.kicks-ass.net>
References: <20190716185807.GJ3402@hirez.programming.kicks-ass.net>
 <a524cf95ab0dbdd1eb65e9decb9283e73d416b1d.1563352912.git.jstancek@redhat.com>
 <20190717131335.b2ry43t2ov7ba4t4@willie-the-truck>
 <21ff5905-198b-6ea5-6c2a-9fb10cb48ea7@redhat.com>
 <20190717192200.GA17687@dustball.usersys.redhat.com>
 <20190718092640.52oliw3sid7gxyh6@willie-the-truck>
 <79224323.853324.1563447052432.JavaMail.zimbra@redhat.com>
 <20190718110446.GC3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718110446.GC3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


It's simpler like so:

On Thu, Jul 18, 2019 at 01:04:46PM +0200, Peter Zijlstra wrote:
> X = 0;
> 
> 	rwsem_down_read()
> 	  for (;;) {
> 	    set_current_state(TASK_UNINTERRUPTIBLE);
>
>								X = 1;
>                                                               rwsem_up_write();
> 								  rwsem_mark_wake()
> 								    atomic_long_add(adjustment, &sem->count);
> 								    smp_store_release(&waiter->task, NULL);
> 
> 	    if (!waiter.task)
> 	      break;
> 
> 	    ...
> 	  }
> 
> 	r = X;
> 

