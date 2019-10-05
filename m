Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0600CC47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FDE2245A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570294379;
	bh=/tJUC4aaSSDDFBbs7QrXLa4qZx9OsDdvlcydVNqJvzc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Gm3kcXuPcnIEjg4Bevj3UZiv4RIExCI3OwAX/vEM2Uc0yBwWIh/zDpbneGVhv7bAm
	 rrEIJnVD5/rj1qWPH7YHWwD7K5viurGLu/Ekjk0pOzkaeN4zoPJSuUJiFsmv1gE43Y
	 UR9D5G57mtXKhJaK9uS4sB/Unz0L5pHrtT55QzjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbfJEQw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 12:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbfJEQw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 12:52:58 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D9A322459;
        Sat,  5 Oct 2019 16:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570294378;
        bh=/tJUC4aaSSDDFBbs7QrXLa4qZx9OsDdvlcydVNqJvzc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R+AjC0yfsPIG540KxndAw5QDsq7CzmKxx2e6Sg/dFdtezE2GoEyYhSk/ZrpzcFE5B
         jbFMcxe8VXDi4OzzlQaz4F4jEZV2YVqjPjDpYIrngZoL7kwp/RnVkQB261TBp8JtJM
         eyTpkKLookilGNICtUuQrsO6gK1KvdqKix7rIZro=
Date:   Sat, 5 Oct 2019 09:52:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 04/12] rcutorture: Force on tick for readers
 and callback flooders
Message-ID: <20191005165256.GJ2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
 <20191003013903.13079-4-paulmck@kernel.org>
 <20191003141457.GA27555@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003141457.GA27555@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 04:14:58PM +0200, Frederic Weisbecker wrote:
> On Wed, Oct 02, 2019 at 06:38:55PM -0700, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@linux.ibm.com>
> > 
> > Readers and callback flooders in the rcutorture stress-test suite run for
> > extended time periods by design.  They do take pains to relinquish the
> > CPU from time to time, but in some cases this relies on the scheduler
> > being active, which in turn relies on the scheduler-clock interrupt
> > firing from time to time.
> > 
> > This commit therefore forces scheduling-clock interrupts within
> > these loops.  While in the area, this commit also prevents
> > rcu_torture_reader()'s occasional timed sleeps from delaying shutdown.
> > 
> > [ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> You can also remove all the IS_ENABLED here.

Again, good catch and fixed, thank you!

							Thanx, Paul
