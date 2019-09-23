Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9495C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF78207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uaC4XjbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395475AbfIWNFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:05:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42112 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395406AbfIWNFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KK5CweoZFmTboyAVRkA3uCBmCg9UBP82hZtoihTcpvs=; b=uaC4XjbGqGx/N525LJnotE1lw
        Bh1Jj6OtGqlRFKF+Ss5FkhC4BEYrUKjOOmaN0ameuMUk1oEmxEXQQCwOE0/oLNn1O0DAEL2yZXt4H
        8wfog6n8GV1XGpKm3JEjBRYnOFhhOKGHLLrj3qfWA8HGxQiveAPAsZTzIbHPOdKgAX/5AZ1k3cHp4
        1Quuej74g5WKD7zij60AkD2A3Pj4mp2MKz+G2zx/YY2IoO9AFlibSDYJNFvx9iPCUXCmXY7Mj/A08
        WB05TEPgzeIQYqaWv92FYu2L9ERfBoGd2IQoE51iwbXGN+KsUxZTZdoePOMEbnngjpuTAwat5G3wF
        Juc4PYIkw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCO1p-0003U9-It; Mon, 23 Sep 2019 13:05:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 40DD6301A7A;
        Mon, 23 Sep 2019 15:04:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65FA620C3E177; Mon, 23 Sep 2019 15:05:19 +0200 (CEST)
Date:   Mon, 23 Sep 2019 15:05:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yunfeng Cui <cui.yunfeng@zte.com.cn>
Cc:     christian@brauner.io, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, akpm@linux-foundation.org, mingo@kernel.org,
        mhocko@suse.com, elena.reshetova@intel.com, aarcange@redhat.com,
        ldv@altlinux.org, arunks@codeaurora.org, guro@fb.com,
        joel@joelfernandes.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] futex: robust futex maybe never be awaked, on rare
 situation.
Message-ID: <20190923130519.GH2332@hirez.programming.kicks-ass.net>
References: <1569208700-24044-1-git-send-email-cui.yunfeng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569208700-24044-1-git-send-email-cui.yunfeng@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 11:18:20AM +0800, Yunfeng Cui wrote:
> I use model checker find a issue of robust and pi futex. On below
> situation, the owner can't find something in pi_state_list, while
> the requester will be blocked, never be awaked.
> 
> CPU0                       CPU1
>                            futex_lock_pi
>                            /*some cs code*/
> futex_lock_pi
>   futex_lock_pi_atomic
>     ...
>     newval = uval | FUTEX_WAITERS;
>     ret = lock_pi_update_atomic(uaddr, uval, newval);
>     ...
>     attach_to_pi_owner
>      ....
>      p = find_get_task_by_vpid(pid);
>      if (!p)
>        return handle_exit_race(uaddr, uval, NULL);
>        ....
>        raw_spin_lock_irq(&p->pi_lock);
>        ....
>        pi_state = alloc_pi_state();
>        ....
>                            do_exit->mm_release
>                            if (unlikely(tsk->robust_list)) {
>                              exit_robust_list(tsk);
>                              tsk->robust_list = NULL;
>                            }
>                            if (unlikely(!list_empty(&tsk->pi_state_list)))
>                              exit_pi_state_list(tsk); /*WILL MISS*/
>       list_add(&pi_state->list, &p->pi_state_list);
>     WILL BLOCKED, NEVER WAKEUP!

Did you forget/overlook the pi_lock fiddling in do_exit() ? I'm thinking
that would make the above impossible.

> Signed-off-by: Yunfeng Cui <cui.yunfeng@zte.com.cn>
> Reviewed-by: Bo Wang <wang.bo116@zte.com.cn>
> Reviewed-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  kernel/fork.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 53e780748fe3..58b90f21dac4 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1277,15 +1277,16 @@ void mm_release(struct task_struct *tsk, struct mm_struct *mm)
>  	if (unlikely(tsk->robust_list)) {
>  		exit_robust_list(tsk);
>  		tsk->robust_list = NULL;
> +		/*Check pi_state_list of task on pi_lock be acquired*/
> +		exit_pi_state_list(tsk);
>  	}
>  #ifdef CONFIG_COMPAT
>  	if (unlikely(tsk->compat_robust_list)) {
>  		compat_exit_robust_list(tsk);
>  		tsk->compat_robust_list = NULL;
> +		exit_pi_state_list(tsk);
>  	}
>  #endif
> -	if (unlikely(!list_empty(&tsk->pi_state_list)))
> -		exit_pi_state_list(tsk);
>  #endif

I'm also thinking this breaks all sorts by not unconditionally calling
exit_pi_state_list(). Specifically, it could leak PI-state for !robust
futexes.

>  
>  	uprobe_free_utask(tsk);
