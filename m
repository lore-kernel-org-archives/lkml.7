Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E09C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDD02084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565857477;
	bh=OzrlIMzY8tc8U7cnzaLQr0bTV9LUS3vWJ3SRa58j0cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1V2tDisy9hgqtcNZOHyREkFCHEDeD20xXOep8CwIAxOX1n+esRvRzYd97vqFuqrsq
	 LlW444hZfteP8oC6VkA8iS4cY81nXXNZS1wigjK8PPBlaNgpyB9OqL1bRplLx8lQo+
	 Y6vLpu7AxrU+N1oe4g0QoUBuMYywuPxsgFy5vwQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfHOIYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:24:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:35722 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730898AbfHOIYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:24:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82E48AE2C;
        Thu, 15 Aug 2019 08:24:34 +0000 (UTC)
Date:   Thu, 15 Aug 2019 10:24:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Edward Chron <echron@arista.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, colona@arista.com
Subject: Re: [PATCH] mm/oom: Add killed process selection information
Message-ID: <20190815082433.GC9477@dhcp22.suse.cz>
References: <20190815060604.3675-1-echron@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815060604.3675-1-echron@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-08-19 23:06:04, Edward Chron wrote:
> For an OOM event: print oom_score_adj value for the OOM Killed process
> to document what the oom score adjust value was at the time the process
> at the time of the OOM event. The value can be set by the user and it
> effects the resulting oom_score so useful to document this value.

This value is interesting especially for setups which do not print
eligible tasks (sysctl oom_dump_tasks = 0) and helps to notice a
misconfiguration <YOUR UDEV EXAMPLE GOES HERE> or to confirm that
oom_score_adj configuration applies as expected.
 
> Sample message output:
> Aug 14 23:00:02 testserver kernel: Out of memory: Killed process 2692
>  (oomprocs) total-vm:1056800kB, anon-rss:1052760kB, file-rss:4kB,i
>  shmem-rss:0kB oom_score_adj:1000
> 
> Signed-off-by: Edward Chron <echron@arista.com>

With that feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

and post as a stand alone patch. Btw. the patch could be simplified by
not using a helper variable and using victim->signal->oom_score_adj
right in the pr_err.

Thanks!

> ---
>  mm/oom_kill.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index eda2e2a0bdc6..6b1674cac377 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -858,6 +858,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  	struct task_struct *p;
>  	struct mm_struct *mm;
>  	bool can_oom_reap = true;
> +	long adj;
>  
>  	p = find_lock_task_mm(victim);
>  	if (!p) {
> @@ -877,6 +878,8 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  	count_vm_event(OOM_KILL);
>  	memcg_memory_event_mm(mm, MEMCG_OOM_KILL);
>  
> +	adj = (long)victim->signal->oom_score_adj;
> +
>  	/*
>  	 * We should send SIGKILL before granting access to memory reserves
>  	 * in order to prevent the OOM victim from depleting the memory
> @@ -884,12 +887,12 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  	 */
>  	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
>  	mark_oom_victim(victim);
> -	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
> +	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB oom_score_adj:%ld\n",
>  		message, task_pid_nr(victim), victim->comm,
>  		K(victim->mm->total_vm),
>  		K(get_mm_counter(victim->mm, MM_ANONPAGES)),
>  		K(get_mm_counter(victim->mm, MM_FILEPAGES)),
> -		K(get_mm_counter(victim->mm, MM_SHMEMPAGES)));
> +		K(get_mm_counter(victim->mm, MM_SHMEMPAGES)), adj);
>  	task_unlock(victim);
>  
>  	/*
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
