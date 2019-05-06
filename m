Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499B3C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE602082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfEFJ2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:28:41 -0400
Received: from relay.sw.ru ([185.231.240.75]:51292 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfEFJ2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:28:41 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hNZv4-0002jm-38; Mon, 06 May 2019 12:28:22 +0300
Subject: Re: [PATCH v3 2/2] prctl_set_mm: downgrade mmap_sem to read lock
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        gorcunov@gmail.com
Cc:     akpm@linux-foundation.org, arunks@codeaurora.org, brgl@bgdev.pl,
        geert+renesas@glider.be, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, mhocko@kernel.org, rppt@linux.ibm.com,
        vbabka@suse.cz
References: <0a48e0a2-a282-159e-a56e-201fbc0faa91@virtuozzo.com>
 <20190502125203.24014-1-mkoutny@suse.com>
 <20190502125203.24014-3-mkoutny@suse.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <961c4d8a-982f-720b-490b-dfb4dae7be25@virtuozzo.com>
Date:   Mon, 6 May 2019 12:28:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502125203.24014-3-mkoutny@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.05.2019 15:52, Michal Koutný wrote:
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

Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>

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
> 

