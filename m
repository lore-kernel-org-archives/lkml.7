Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778DDC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBEA206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566862134;
	bh=+PCYrbCYsv08oORslG/sR4tDPw7S19G790Zs3azzrO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=riwT8po9d7Wtw6rdH3058tySusAdQxZyA2suQDD3WdAe68S+ez6bxyDprQ8lWbUjj
	 k5lkcT7rdztUfsXTVr0MAgfOuZP+KPa+HBjgCtD2AzopWRu7akHF676udyFErwK+bp
	 Ynw3I0cRLePYF59y+jgxjV1g0K2EBnxQO2AhlDWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfHZX2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 19:28:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfHZX2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 19:28:53 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A61A2053B;
        Mon, 26 Aug 2019 23:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566862132;
        bh=+PCYrbCYsv08oORslG/sR4tDPw7S19G790Zs3azzrO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RYEVns07Qs/j5/Jn5Rws2+J286T3kPDko5dWgxFuQWC/2nMJxOpWl1j+SFQg/MLHY
         dLDxVKDKPhWwjluDB0IM/lP/uve605pW9RcslvL+WcMqAT2HP/Tg7Gr9OLBLZgGqCh
         TzT/SCt0N9+rfE2qVdrFwsZMf5e8BiCyzbAuS8d4=
Date:   Tue, 27 Aug 2019 01:28:49 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 37/38] posix-cpu-timers: Move state tracking to struct
 posix_cputimers
Message-ID: <20190826232849.GL14309@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192922.743229404@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192922.743229404@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:24PM +0200, Thomas Gleixner wrote:
> Put it where it belongs and clean up the ifdeffery in fork completely.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Adopt to the per clock base struct
> ---
>  include/linux/posix-timers.h   |    8 ++++
>  include/linux/sched/cputime.h  |    9 +++--
>  include/linux/sched/signal.h   |    6 ---
>  init/init_task.c               |    2 -
>  kernel/fork.c                  |    6 ---
>  kernel/time/posix-cpu-timers.c |   73 ++++++++++++++++++++++-------------------
>  6 files changed, 54 insertions(+), 50 deletions(-)
> 
> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h
> @@ -77,15 +77,23 @@ struct posix_cputimer_base {
>  /**
>   * posix_cputimers - Container for posix CPU timer related data
>   * @bases:		Base container for posix CPU clocks
> + * @timers_active:	Timers are queued.
> + * @expiry_active:	Timer expiry is active. Used for
> + *			process wide timers to avoid multiple
> + *			task trying to handle expiry concurrently

So those two fields are also added to struct task_struct but unused there,
right?


>   *
>   * Used in task_struct and signal_struct
>   */
>  struct posix_cputimers {
>  	struct posix_cputimer_base	bases[CPUCLOCK_MAX];
> +	unsigned int			timers_active;
> +	unsigned int			expiry_active;
>  };
