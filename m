Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D12C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9062339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566402171;
	bh=Wp+ODOHDeqGQ7Y3Y6Q88xJtkHwkUH+VZ94UTCEXHS5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jdoh6mptNzTquu/t8oIOcN2qwQDS+d5z8+o130nINNwE4jSsanhC3Kyi8d9xTI9IN
	 6r0qTR1kokECZS1Xl2/5weFc31DB2RzIdElRWzW7rnqNFUimu2MSBlcTLvFbZpzKs5
	 V/EkCVPglDS2vLgIfefGalbn6qWHW06WBvUzFnkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfHUPmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfHUPmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:42:49 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DEBD22DA7;
        Wed, 21 Aug 2019 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566402168;
        bh=Wp+ODOHDeqGQ7Y3Y6Q88xJtkHwkUH+VZ94UTCEXHS5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uKt8tTNzk68PHBxBos6yppP5TXL5KKI1al693lREmmAzGPjzy/FbY39LU0DtsTS+Y
         6wyfVNRSFBfLPlkywMACGcVYsfsYLloJ15C8bpdeyg/1b9UATngf+S3RCpwdYncpAq
         SxDCwnnIPYBAK1f+m0VYt24/PqdjLEn0o9Nx0IoY=
Date:   Wed, 21 Aug 2019 17:42:46 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 07/44] posix-cpu-timers: Simplify sighand locking in
 run_posix_cpu_timers()
Message-ID: <20190821154245.GA22020@lenoir>
References: <20190819143141.221906747@linutronix.de>
 <20190819143802.038794711@linutronix.de>
 <20190821120912.GD16213@lenoir>
 <alpine.DEB.2.21.1908211523580.2223@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908211523580.2223@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 03:25:01PM +0200, Thomas Gleixner wrote:
> On Wed, 21 Aug 2019, Frederic Weisbecker wrote:
> 
> > On Mon, Aug 19, 2019 at 04:31:48PM +0200, Thomas Gleixner wrote:
> > > run_posix_cpu_timers() is called from the timer interrupt. The posix timer
> > > expiry always affects the current task which got interrupted.
> > > 
> > > sighand locking is only racy when done on a foreign task, which must use
> > > lock_task_sighand(). But in case of run_posix_cpu_timers() that's
> > > pointless.
> > > 
> > > sighand of a task can only be dropped or changed by the task itself. Drop
> > > happens in do_exit()
> > 
> > Well, that's only in case of autoreap. Otherwise this is dropped by the reaper.
> 
> Right, but in the reaper case the task cannot be on the CPU running and
> being interrupted by the tick. I might be missing something subtle though.

That looks possible. After exit_notify() and until the final schedule(), the exiting task
can execute concurrently with the reaper calling release_task().
