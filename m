Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A93C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1412214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557250940;
	bh=IB53AUA4paDM5FMFWmLdu6yxUS3R+QMnsp6P8aQgDrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DNoXPq/Ch18zBk9brh1USGvFQhuRpeZYya0WEu4NVqbWJJqUtJeEFJHKx7gsOZXBQ
	 WAk+0Tart7acoJkYiVXhHSMw0ldYCnWtOe9RhM5gAxOxMK8lR60TphSVVln0pg3Ne+
	 oeeyk4tb6737ZEbdnoTzf2VlNUbBtbH+RthxAkl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfEGRmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:42:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726607AbfEGRmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:42:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14066AF7C;
        Tue,  7 May 2019 17:42:17 +0000 (UTC)
Date:   Tue, 7 May 2019 19:42:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     gorcunov@gmail.com, akpm@linux-foundation.org,
        arunks@codeaurora.org, brgl@bgdev.pl, geert+renesas@glider.be,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mguzik@redhat.com, rppt@linux.ibm.com,
        vbabka@suse.cz, ktkhai@virtuozzo.com
Subject: Re: [PATCH v3 2/2] prctl_set_mm: downgrade mmap_sem to read lock
Message-ID: <20190507174215.GT31017@dhcp22.suse.cz>
References: <0a48e0a2-a282-159e-a56e-201fbc0faa91@virtuozzo.com>
 <20190502125203.24014-1-mkoutny@suse.com>
 <20190502125203.24014-3-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190502125203.24014-3-mkoutny@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-05-19 14:52:03, Michal Koutny wrote:
> The commit a3b609ef9f8b ("proc read mm's {arg,env}_{start,end} with mmap
> semaphore taken.") added synchronization of reading argument/environment
> boundaries under mmap_sem. Later commit 88aa7cc688d4 ("mm: introduce
> arg_lock to protect arg_start|end and env_start|end in mm_struct")
> avoided the coarse use of mmap_sem in similar situations. But there
> still remained two places that (mis)use mmap_sem.
> 
> get_cmdline should also use arg_lock instead of mmap_sem when it reads the
> boundaries.
> 
> The second place that should use arg_lock is in prctl_set_mm. By
> protecting the boundaries fields with the arg_lock, we can downgrade
> mmap_sem to reader lock (analogous to what we already do in
> prctl_set_mm_map).
> 
> v2: call find_vma without arg_lock held
> v3: squashed get_cmdline arg_lock patch
> 
> Fixes: 88aa7cc688d4 ("mm: introduce arg_lock to protect arg_start|end and env_start|end in mm_struct")
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Mateusz Guzik <mguzik@redhat.com>
> CC: Cyrill Gorcunov <gorcunov@gmail.com>
> Co-developed-by: Laurent Dufour <ldufour@linux.ibm.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Just a nit. S-o-b chain is not correct here. The first s-o-b should
match the author (From) of the patch.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  kernel/sys.c | 10 ++++++++--
>  mm/util.c    |  4 ++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 5e0a5edf47f8..14be57840511 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2122,9 +2122,14 @@ static int prctl_set_mm(int opt, unsigned long addr,
>  
>  	error = -EINVAL;
>  
> -	down_write(&mm->mmap_sem);
> +	/*
> +	 * arg_lock protects concurent updates of arg boundaries, we need mmap_sem for
> +	 * a) concurrent sys_brk, b) finding VMA for addr validation.
> +	 */
> +	down_read(&mm->mmap_sem);
>  	vma = find_vma(mm, addr);
>  
> +	spin_lock(&mm->arg_lock);
>  	prctl_map.start_code	= mm->start_code;
>  	prctl_map.end_code	= mm->end_code;
>  	prctl_map.start_data	= mm->start_data;
> @@ -2212,7 +2217,8 @@ static int prctl_set_mm(int opt, unsigned long addr,
>  
>  	error = 0;
>  out:
> -	up_write(&mm->mmap_sem);
> +	spin_unlock(&mm->arg_lock);
> +	up_read(&mm->mmap_sem);
>  	return error;
>  }
>  
> diff --git a/mm/util.c b/mm/util.c
> index 43a2984bccaa..5cf0e84a0823 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -758,12 +758,12 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
>  	if (!mm->arg_end)
>  		goto out_mm;	/* Shh! No looking before we're done */
>  
> -	down_read(&mm->mmap_sem);
> +	spin_lock(&mm->arg_lock);
>  	arg_start = mm->arg_start;
>  	arg_end = mm->arg_end;
>  	env_start = mm->env_start;
>  	env_end = mm->env_end;
> -	up_read(&mm->mmap_sem);
> +	spin_unlock(&mm->arg_lock);
>  
>  	len = arg_end - arg_start;
>  
> -- 
> 2.16.4

-- 
Michal Hocko
SUSE Labs
