Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61176C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363E022CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000122;
	bh=ia/i3B6LslmqZ9PUzT9PKV9D9hFu7MqfMZOZlxF+AXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZiB3kuY5KZ7FH81ISDXqEac7E3VE8gvrLswc7Oh7Br1MQyDPKgBoxBFfBEfY4oZ7c
	 6JSda+BZSPhX2K18p/FysK4usQtN9gds+kwUXzwXnQJ3lhQPbmdJHlkOoz7sB2AYfB
	 xMsloW6iNG8J4DsHcPn3m8iLdTFsRMTub0ZEMOvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfH1Nsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfH1Nsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:48:40 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79D420856;
        Wed, 28 Aug 2019 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567000119;
        bh=ia/i3B6LslmqZ9PUzT9PKV9D9hFu7MqfMZOZlxF+AXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZDVPniNNs/k7E/b/ZWu712xjswU+vuIx+goS5L31ocFDW6FsHqgCBQEFNLI3GflWb
         7OUMf7LllWNlmzexZKc028kS2UAnlQgqdz2DE/jyjFlyaQe47L5LEgcJfKopOyTDg3
         JXrRFGdPt9zfa2N0wMlgnba/5Mxd9oc51cYPYUx4=
Date:   Wed, 28 Aug 2019 15:48:36 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: timers/core] tick: Mark sched_timer to expire in hard
 interrupt context
Message-ID: <20190828134835.GA11560@lenoir>
References: <20190823113845.12125-3-bigeasy@linutronix.de>
 <156699021381.13479.1712414321907002833.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156699021381.13479.1712414321907002833.tip-bot2@tip-bot2>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:03:33AM -0000, tip-bot2 for Sebastian Andrzej Siewior wrote:
> The following commit has been merged into the timers/core branch of tip:
> 
> Commit-ID:     71fed982d63cb2bb88db6f36059e3b14a7913846
> Gitweb:        https://git.kernel.org/tip/71fed982d63cb2bb88db6f36059e3b14a7913846
> Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> AuthorDate:    Fri, 23 Aug 2019 13:38:45 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Wed, 28 Aug 2019 13:01:26 +02:00
> 
> tick: Mark sched_timer to expire in hard interrupt context
> 
> sched_timer must be initialized with the _HARD mode suffix to ensure expiry
> in hard interrupt context on RT.
> 
> The previous conversion to HARD expiry mode missed on one instance in
> tick_nohz_switch_to_nohz(). Fix it up.
> 
> Fixes: 902a9f9c50905 ("tick: Mark tick related hrtimers to expiry in hard interrupt context")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lkml.kernel.org/r/20190823113845.12125-3-bigeasy@linutronix.de
> 
> ---
>  kernel/time/tick-sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 01ff32a..9558517 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1233,7 +1233,7 @@ static void tick_nohz_switch_to_nohz(void)
>  	 * Recycle the hrtimer in ts, so we can share the
>  	 * hrtimer_forward with the highres code.
>  	 */
> -	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
> +	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);

That said, this instance only uses hrtimer for time computing. The backend is
clockevent directly.

>  	/* Get the next period */
>  	next = tick_init_jiffy_update();
>  
