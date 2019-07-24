Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA971C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929F222ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563974584;
	bh=vI86Cb9bObgMVdZk6vXxi3znWGB57B0Oal7Vl2bmFW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r9fNUyW63mpFCc/+mCtrjlUmuWItoF3rFqmRq4i+NtPOJSJ+wkSEg8ZtuP+bZ8Xaj
	 r1DRITbm8dpnlcyu63ESsOZNvZCislsmjB9NfU8VfDGWEV/b2w2MziZzkYHtAlMbDf
	 2CP8XNlG/vGWGMwaxwdxGCYYPW8LX8rsy1GD9F40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfGXNXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbfGXNXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:23:03 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CA12229FA;
        Wed, 24 Jul 2019 13:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563974582;
        bh=vI86Cb9bObgMVdZk6vXxi3znWGB57B0Oal7Vl2bmFW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wt9/IVATBgt0Y6xz6sm/Ig+4zP1sU8BAsr6e0BYxOsgr9Ts0lObsvDR3TDjwoo3hp
         NUm4ypOKjhJPXQYorZIQh0qEiaDboIksNjyHZbivo3ktma2sGPk9+FCmSH7bCKeNwo
         l+Mu2pvt28qdcpsHyCLIeyRsJLnwdjgkdtBPQGSs=
Date:   Wed, 24 Jul 2019 15:22:59 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        peterz@infradead.org
Subject: Re: How to turn scheduler tick on for current nohz_full CPU?
Message-ID: <20190724132257.GA1029@lenoir>
References: <20190724115331.GA29059@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724115331.GA29059@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 04:53:31AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> One of the callback-invocation forward-progress issues turns out to
> be nohz_full CPUs not turning their scheduling-clock interrupt back on
> when running in kernel mode.  Given that callback floods can cause RCU's
> callback-invocation loop to run for some time, it would be good for this
> loop to re-enable this interrupt.  Of course, this problem applies to
> pretty much any kernel code that might loop for an extended time period,
> not just RCU.
> 
> I took a quick look at kernel/time/tick-sched.c and the closest thing
> I found was tick_nohz_full_kick_cpu(), except that (1) it isn't clear
> that this does much when invoked on the current CPU and (2) it doesn't
> help in rcutorture TREE04.  In contrast, disabling NO_HZ_FULL and using
> RCU_NOCB_CPU instead works quite well.
> 
> So what should I be calling instead of tick_nohz_full_kick_cpu() to
> re-enable the current CPU's scheduling-clock interrupt?

Indeed, kernel code is assumed to be quick enough (between two extended grace
periods) to avoid running the tick for RCU. But some long lasting kernel code
may require to tick temporarily.

You can use tick_nohz_dep_set_cpu(cpu, TICK_DEP_MASK_RCU) with the
following:

diff --git a/include/linux/tick.h b/include/linux/tick.h
index f92a10b5e112..3f476e2a4bf7 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -108,7 +108,8 @@ enum tick_dep_bits {
 	TICK_DEP_BIT_POSIX_TIMER	= 0,
 	TICK_DEP_BIT_PERF_EVENTS	= 1,
 	TICK_DEP_BIT_SCHED		= 2,
-	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3
+	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
+	TICK_DEP_BIT_RCU		= 4
 };
 
 #define TICK_DEP_MASK_NONE		0
@@ -116,6 +117,7 @@ enum tick_dep_bits {
 #define TICK_DEP_MASK_PERF_EVENTS	(1 << TICK_DEP_BIT_PERF_EVENTS)
 #define TICK_DEP_MASK_SCHED		(1 << TICK_DEP_BIT_SCHED)
 #define TICK_DEP_MASK_CLOCK_UNSTABLE	(1 << TICK_DEP_BIT_CLOCK_UNSTABLE)
+#define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
 
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
