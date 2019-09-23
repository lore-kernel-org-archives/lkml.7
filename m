Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850C9C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8FF20867
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569236118;
	bh=FBv6dFvilNwQAceMh2MzUfqouwIAOiD0slnrtmA3FXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tGzTWWqvFMOsN2E02Q94NCSnzGi6JBBu9YNj5mI1m8e5nTT3+jAEDHNfIIesB/cqv
	 yLGh8JeM7OD3E84d1D5VBWJfl3apPygcM23euSEn57xSx8AR7DJW9gpVUZ5gXj2rJr
	 z4iWotiYjIOFMlmnoEAdm0/NMtoiFI87Pqzu7Q4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbfIWKzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:55:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:50340 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732113AbfIWKzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:55:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44505B152;
        Mon, 23 Sep 2019 10:55:15 +0000 (UTC)
Date:   Mon, 23 Sep 2019 12:55:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yunfeng Cui <cui.yunfeng@zte.com.cn>
Cc:     christian@brauner.io, ldv@altlinux.org, luto@amacapital.net,
        keescook@chromium.org, wad@chromium.org, arunks@codeaurora.org,
        guro@fb.com, peterz@infradead.org, elena.reshetova@intel.com,
        joel@joelfernandes.org, mingo@kernel.org,
        akpm@linux-foundation.org, aarcange@redhat.com,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jiang.xuexin@zte.com.cn, wang.yi59@zte.com.cn,
        xue.zhihong@zte.com.cn, Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] futex: robust futex maybe never be awaked, on rare
 situation.
Message-ID: <20190923105514.GJ6016@dhcp22.suse.cz>
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

[Cc more futex people]

On Mon 23-09-19 11:18:20, Yunfeng Cui wrote:
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
> 
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
>  
>  	uprobe_free_utask(tsk);
> -- 
> 2.15.2
> 

-- 
Michal Hocko
SUSE Labs
