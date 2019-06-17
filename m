Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E16C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5496D218C9
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560753083;
	bh=E1N41cylcCvClx041UaN3kZbEpO1JBbXfqyUD8vU8Ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yJt0n01O5qDeOLbwjYrnKGNpTUA7uzT9GzROtpC+rsjS3rkwIoPcIVvDHxZT+bjJG
	 AkYmfONDLw4Jc1PkPC5ubRC9MpimdXq4x6AFwW4CLZeg15TbFIUggkQeXbMnTHG3pw
	 B+kwnA1aG+AVztht+QBHZEnS7JM4wAtV0vnXeP3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfFQGbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 02:31:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:46972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbfFQGbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 02:31:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6195FAFAC;
        Mon, 17 Jun 2019 06:31:20 +0000 (UTC)
Date:   Mon, 17 Jun 2019 08:31:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Shakeel Butt <shakeelb@google.com>,
        syzbot <syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuzhoujian@didichuxing.com
Subject: Re: general protection fault in oom_unkillable_task
Message-ID: <20190617063118.GA30420@dhcp22.suse.cz>
References: <0000000000004143a5058b526503@google.com>
 <CALvZod72=KuBZkSd0ey5orJFGFpwx462XY=cZvO3NOXC0MogFw@mail.gmail.com>
 <20190615134955.GA28441@dhcp22.suse.cz>
 <CALvZod4hT39PfGt9Ohj+g77om5=G0coHK=+G1=GKcm-PowkXsw@mail.gmail.com>
 <5bb1fe5d-f0e1-678b-4f64-82c8d5d81f61@i-love.sakura.ne.jp>
 <CALvZod4etSv9Hv4UD=E6D7U4vyjCqhxQgq61AoTUCd+VubofFg@mail.gmail.com>
 <791594c6-45a3-d78a-70b5-901aa580ed9f@i-love.sakura.ne.jp>
 <840fa9f1-07e2-e206-2fc0-725392f96baf@i-love.sakura.ne.jp>
 <c763afc8-f0ae-756a-56a7-395f625b95fc@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c763afc8-f0ae-756a-56a7-395f625b95fc@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-06-19 00:13:47, Tetsuo Handa wrote:
[...]
> >From 415e52cf55bc4ad931e4f005421b827f0b02693d Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Mon, 17 Jun 2019 00:09:38 +0900
> Subject: [PATCH] mm: memcontrol: Use CSS_TASK_ITER_PROCS at mem_cgroup_scan_tasks().
> 
> Since commit c03cd7738a83b137 ("cgroup: Include dying leaders with live
> threads in PROCS iterations") corrected how CSS_TASK_ITER_PROCS works,
> mem_cgroup_scan_tasks() can use CSS_TASK_ITER_PROCS in order to check
> only one thread from each thread group.

O(Threads#) is definitely much worse than O(proc#)

> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ba9138a..b09ff45 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1163,7 +1163,7 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>  		struct css_task_iter it;
>  		struct task_struct *task;
>  
> -		css_task_iter_start(&iter->css, 0, &it);
> +		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
>  		while (!ret && (task = css_task_iter_next(&it)))
>  			ret = fn(task, arg);
>  		css_task_iter_end(&it);
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
