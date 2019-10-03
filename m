Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D90C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239FC215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570112103;
	bh=FqDlb1Rwc/xpHJ7qw5aClKOmelJXqFwY55ekxtX+iUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qFfsptCUeT6phT9DefNf8WCFJaewuLTrr7Q+21oqWCiac02Jq6hAcxibOijTz0Q8f
	 ypXZ0LOxQj2jnP7sWzuzs7kedAbyFMIDrs2FRGGn3LFYos+xOJIPvregfxJdnrOT7D
	 rfXd0jLV1XCqeaMCOJLiiraeFsDcjZkxS24JA+Lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbfJCOPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729311AbfJCOPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:15:01 -0400
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B187A207FF;
        Thu,  3 Oct 2019 14:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570112101;
        bh=FqDlb1Rwc/xpHJ7qw5aClKOmelJXqFwY55ekxtX+iUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JHwYkLnx2aNLH1hc3eZrX8jB3QdwTnt6mJGtRMi9f3dXRHtAmzeH5SOdov/dWPWuY
         /Y57kehhhhi3F/IyMdxexMw9RjFZS1jRhwQzIvdYvs7TW8ucJ6i6eJVxXrG6f7odAb
         ZttFkc0y/hsPnfj1XYDQkujeRA+0Ix9yCW9kXARw=
Date:   Thu, 3 Oct 2019 16:14:58 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH tip/core/rcu 04/12] rcutorture: Force on tick for readers
 and callback flooders
Message-ID: <20191003141457.GA27555@lenoir>
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
 <20191003013903.13079-4-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003013903.13079-4-paulmck@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 06:38:55PM -0700, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@linux.ibm.com>
> 
> Readers and callback flooders in the rcutorture stress-test suite run for
> extended time periods by design.  They do take pains to relinquish the
> CPU from time to time, but in some cases this relies on the scheduler
> being active, which in turn relies on the scheduler-clock interrupt
> firing from time to time.
> 
> This commit therefore forces scheduling-clock interrupts within
> these loops.  While in the area, this commit also prevents
> rcu_torture_reader()'s occasional timed sleeps from delaying shutdown.
> 
> [ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

You can also remove all the IS_ENABLED here.

Thanks!
