Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191A2C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FDF21743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bx2BM+LK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387573AbfGQR4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:56:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34783 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfGQR4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:56:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so25831519wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bp6rpiIl1aH2Aku2NiC60FKj8zRmtUEHvpiqHnTUH5k=;
        b=bx2BM+LKhC48v2fYLzeXDSFw5DfHLwhua1ZNZ/EvOf9kzo1v5uhXmxht1HpqNQ/ATR
         iA8ZBEiRvKhROZa8K+Btv7vDwBwQgP3Nsx40HjYYUfpMwUKzi1A+ByCJU5oQeupNaLrR
         ruLlZ60Rr7u3RdM4HUcwmQ5epSk5Vlb3uqdBVJe6zFpW/NzfNcdedUjsFzNJou7CEqr1
         d7aP4RyuSkekutqyYpwgnN+Ps2yyxmn6E90wg8CXK7W0CBPUQPsg4DjdZSdgS+gfA5sA
         qU/tl/Ti9b4FLMPVbCfsSKFP1nGT5kRhbo8yeEswCrjEZ8g8DPf/cbIjzyafc5Y+0qB2
         O3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bp6rpiIl1aH2Aku2NiC60FKj8zRmtUEHvpiqHnTUH5k=;
        b=ZhUV+SQDFjSMW9/+I3DI3sVwdjMcF3F6V/fGS2iIxs3WnOf5K9TLWABf37CzF+bfAt
         UbrnwuAd33SB27mcPf1gI3ZUiOzDlOcAvVhppGMwbjXwVAuEh/1RViUiTqIJVhl/9EUE
         5nUVvWCvQohPDMfsQ/ZLfS7OdGQkgx4j+BsuQvNzeq2uOrCg42QeeovzmA2LcQ4Cmm6u
         LFHTFnZlrSvlKkgYsleH7YULrm+P02zzQZNB3hsu0nCNc5/+Z0jRgI6Xl0t2ZzDn2aqD
         BM8N0jO14dl1rEGgRWIhaB8nX4XwywcMnvifpJ3LcZHEIfIr3x9qUGUu0uy+E3q80b3D
         jagQ==
X-Gm-Message-State: APjAAAWuRLRnkIeJBN9e8HqtjlvLBvlh9AEJlL5J1byqHZMw74MHNm9n
        x3qAmatkuzUxO4clCD8kD3U=
X-Google-Smtp-Source: APXvYqyAlBAJU9VDuvuyeyo2Kg/21D91XvgWZ+MNrOmBjVegVRVqaSyhobM/bxzuhoqUEc/rtZksDw==
X-Received: by 2002:adf:de8e:: with SMTP id w14mr43918804wrl.79.1563386158965;
        Wed, 17 Jul 2019 10:55:58 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id u13sm29666448wrq.62.2019.07.17.10.55.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 10:55:58 -0700 (PDT)
Date:   Wed, 17 Jul 2019 19:55:57 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>,
        jannh@google.com
Subject: Re: [PATCH RFC v1] pidfd: fix a race in setting exit_state for pidfd
 polling
Message-ID: <20190717175556.axe2pne7lcrkmtzr@brauner.io>
References: <20190717172100.261204-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190717172100.261204-1-joel@joelfernandes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 01:21:00PM -0400, Joel Fernandes wrote:
> From: Suren Baghdasaryan <surenb@google.com>
> 
> There is a race between reading task->exit_state in pidfd_poll and writing
> it after do_notify_parent calls do_notify_pidfd. Expected sequence of
> events is:
> 
> CPU 0                            CPU 1
> ------------------------------------------------
> exit_notify
>   do_notify_parent
>     do_notify_pidfd
>   tsk->exit_state = EXIT_DEAD
>                                   pidfd_poll
>                                      if (tsk->exit_state)
> 
> However nothing prevents the following sequence:
> 
> CPU 0                            CPU 1
> ------------------------------------------------
> exit_notify
>   do_notify_parent
>     do_notify_pidfd
>                                    pidfd_poll
>                                       if (tsk->exit_state)
>   tsk->exit_state = EXIT_DEAD
> 
> This causes a polling task to wait forever, since poll blocks because
> exit_state is 0 and the waiting task is not notified again. A stress
> test continuously doing pidfd poll and process exits uncovered this bug,
> and the below patch fixes it.
> 
> To fix this, we set tsk->exit_state before calling do_notify_pidfd.
> 
> Cc: kernel-team@android.com
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

That means in such a situation other users will see EXIT_ZOMBIE where
they didn't see that before until after the parent failed to get
notified.

That's a rather subtle internal change. I was worried about
__ptrace_detach() since it explicitly checks for EXIT_ZOMBIE but it
seems to me that this is fine since we hold write_lock_irq(&tasklist_lock);
at the point when we do set p->exit_signal.

Acked-by: Christian Brauner <christian@brauner.io>

Once Oleg confirms that I'm right not to worty I'll pick this up.

Thanks!
Christian

> 
> ---
>  kernel/exit.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index a75b6a7f458a..740ceacb4b76 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -720,6 +720,7 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>  	if (group_dead)
>  		kill_orphaned_pgrp(tsk->group_leader, NULL);
>  
> +	tsk->exit_state = EXIT_ZOMBIE;
>  	if (unlikely(tsk->ptrace)) {
>  		int sig = thread_group_leader(tsk) &&
>  				thread_group_empty(tsk) &&
> @@ -1156,10 +1157,11 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
>  		ptrace_unlink(p);
>  
>  		/* If parent wants a zombie, don't release it now */
> -		state = EXIT_ZOMBIE;
> +		p->exit_state = EXIT_ZOMBIE;
>  		if (do_notify_parent(p, p->exit_signal))
> -			state = EXIT_DEAD;
> -		p->exit_state = state;
> +			p->exit_state = EXIT_DEAD;
> +
> +		state = p->exit_state;
>  		write_unlock_irq(&tasklist_lock);
>  	}
>  	if (state == EXIT_DEAD)
> -- 
> 2.22.0.657.g960e92d24f-goog
> 
