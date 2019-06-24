Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95FBC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F81213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561378683;
	bh=qI+nOBS7I+14IwIUt9KpcpGTazjFg0RUqJZL7RWpoiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IpwxMLf01E7TNFZkiFRdwUR/VOPBAmx/heFPJHrn7sHoFE8I46CFs4JcJ2Qw3zxXl
	 FvjeY9mh6mEx+bZxg+D+ol4+xCYDpmM1XGdZ+pyvHMlHj8wDADo6uoH6bvlTc4M7fz
	 ht1EackAVggsVXZYiNrMLUhO1dJ/MGb1CfOagaaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbfFXMSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfFXMSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:18:01 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A78FB20679;
        Mon, 24 Jun 2019 12:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561378681;
        bh=qI+nOBS7I+14IwIUt9KpcpGTazjFg0RUqJZL7RWpoiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsyfE3nZyXhY0/IZCS4LQdDGtxJEpDMB7ff/KYCnZckLQ83Yc56OeNIujCR8wCYk9
         YKvsiBvxkbnkDurDHUENRB4SotV1cHXQ5IVG2g1NBMdsC6MLFDFabJJw6OACRJFauz
         iE5G9z9ijcVgTXr13oL07wWunBCFWRIWplj3jHo4=
Date:   Mon, 24 Jun 2019 13:17:55 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Yuyang Du <duyuyang@gmail.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: Move mark_lock() inside
 CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING
Message-ID: <20190624121755.x5746xrskrbbhaft@willie-the-truck>
References: <20190617124718.1232976-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617124718.1232976-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Jun 17, 2019 at 02:47:05PM +0200, Arnd Bergmann wrote:
> The last cleanup patch triggered another issue, as now another function
> should be moved into the same section:
> 
> kernel/locking/lockdep.c:3580:12: error: 'mark_lock' defined but not used [-Werror=unused-function]
>  static int mark_lock(struct task_struct *curr, struct held_lock *this,
> 
> Move mark_lock() into the same #ifdef section as its only caller, and
> remove the now-unused mark_lock_irq() stub helper.
> 
> Fixes: 0d2cc3b34532 ("locking/lockdep: Move valid_state() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/locking/lockdep.c | 73 +++++++++++++++++++---------------------
>  1 file changed, 34 insertions(+), 39 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 48a840adb281..43e880ceafc2 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -437,13 +437,6 @@ static int verbose(struct lock_class *class)
>  	return 0;
>  }
>  
> -/*
> - * Stack-trace: tightly packed array of stack backtrace
> - * addresses. Protected by the graph_lock.
> - */
> -unsigned long nr_stack_trace_entries;
> -static unsigned long stack_trace[MAX_STACK_TRACE_ENTRIES];
> -
>  static void print_lockdep_off(const char *bug_msg)
>  {
>  	printk(KERN_DEBUG "%s\n", bug_msg);
> @@ -453,6 +446,15 @@ static void print_lockdep_off(const char *bug_msg)
>  #endif
>  }
>  
> +unsigned long nr_stack_trace_entries;
> +
> +#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)

Is this necessary, given that CONFIG_PROVE_LOCKING selects TRACE_IRQFLAGS?
I find that having both of the symbols makes this really hard to read. For
example:

> +/*
> + * Stack-trace: tightly packed array of stack backtrace
> + * addresses. Protected by the graph_lock.
> + */
> +static unsigned long stack_trace[MAX_STACK_TRACE_ENTRIES];

This is used later on by print_lock_trace(), which is only predicated
on #ifdef CONFIG_PROVE_LOCKING.

Will
