Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728D2C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A97121848
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568648218;
	bh=UVEDiSFb7PbBmSMCLBsQzUaNXwy9lDl9mXB28flFCjM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=eG8v4O7elZaNwgLK8/F6QlehEiIfMHbXAhMCOhbDstFwsHIjkfa39vRJaHuzjp0lR
	 LIt3nO/LnGiDnpD2dInbQnqNA3poIfgDhJqHbnTjbfvB1mWy5r9Qpj5zM4MjgRU4u7
	 XlNJFuZhANC5zZp8n8v3m51G7d8gUDdoRGNIrTKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389294AbfIPPg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731764AbfIPPg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:36:57 -0400
Received: from paulmck-ThinkPad-P72 (96-84-246-146-static.hfc.comcastbusiness.net [96.84.246.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5076214D9;
        Mon, 16 Sep 2019 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568648216;
        bh=UVEDiSFb7PbBmSMCLBsQzUaNXwy9lDl9mXB28flFCjM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=S4mKDYB5Uh2xN7T2aFOQ7jXK3WPpOjzcYSDbt6MBn8I7/78XOoRqqlJuYaJcQuJmi
         X/LYo+Yujjsn8R8nsn6G/I3EqjRJLXKqadyob5XN+WQ8Y14ygoYuHQYrTU1/a+eeqn
         U4BQjPTMllUR3eXwsbLn6nBPL3WV87gbkfCDkUzA=
Date:   Mon, 16 Sep 2019 08:36:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking: locktorture: Do not include rwlock.h directly
Message-ID: <20190916153651.GW30224@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20190916145404.bukcmlliequu77wk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916145404.bukcmlliequu77wk@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 04:54:04PM +0200, Sebastian Andrzej Siewior wrote:
> From: Wolfgang M. Reimer <linuxball@gmail.com>
> 
> Including rwlock.h directly will cause kernel builds to fail
> if CONFIG_PREEMPT_RT is defined. The correct header file
> (rwlock_rt.h OR rwlock.h) will be included by spinlock.h which
> is included by locktorture.c anyway.
> 
> Remove the include of linux/rwlock.h.
> 
> Signed-off-by: Wolfgang M. Reimer <linuxball@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Queued for further review and testing, thank you both!

							Thanx, Paul

> ---
>  kernel/locking/locktorture.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index c513031cd7e33..9fb042d610d23 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -16,7 +16,6 @@
>  #include <linux/kthread.h>
>  #include <linux/sched/rt.h>
>  #include <linux/spinlock.h>
> -#include <linux/rwlock.h>
>  #include <linux/mutex.h>
>  #include <linux/rwsem.h>
>  #include <linux/smp.h>
> -- 
> 2.23.0
> 
