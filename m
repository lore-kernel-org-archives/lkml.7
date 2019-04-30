Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF05C04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658D520835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfD3J2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:28:01 -0400
Received: from relay.sw.ru ([185.231.240.75]:39614 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfD3J2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:28:01 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hLP3E-0007aV-RU; Tue, 30 Apr 2019 12:27:48 +0300
Subject: Re: [PATCH 2/3] prctl_set_mm: Refactor checks from validate_prctl_map
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        gorcunov@gmail.com
Cc:     akpm@linux-foundation.org, arunks@codeaurora.org, brgl@bgdev.pl,
        geert+renesas@glider.be, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, mhocko@kernel.org, rppt@linux.ibm.com,
        vbabka@suse.cz
References: <20190418182321.GJ3040@uranus.lan>
 <20190430081844.22597-1-mkoutny@suse.com>
 <20190430081844.22597-3-mkoutny@suse.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <e5353968-5c1b-7706-e5cc-8fb47f70c9ca@virtuozzo.com>
Date:   Tue, 30 Apr 2019 12:27:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430081844.22597-3-mkoutny@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.04.2019 11:18, Michal Koutný wrote:
> Despite comment of validate_prctl_map claims there are no capability
> checks, it is not completely true since commit 4d28df6152aa ("prctl:
> Allow local CAP_SYS_ADMIN changing exe_file"). Extract the check out of
> the function and make the function perform purely arithmetic checks.
> 
> This patch should not change any behavior, it is mere refactoring for
> following patch.
> 
> CC: Kirill Tkhai <ktkhai@virtuozzo.com>
> CC: Cyrill Gorcunov <gorcunov@gmail.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  kernel/sys.c | 45 ++++++++++++++++++++-------------------------
>  1 file changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 12df0e5434b8..e1acb444d7b0 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1882,10 +1882,12 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
>  }
>  
>  /*
> + * Check arithmetic relations of passed addresses.
> + *
>   * WARNING: we don't require any capability here so be very careful
>   * in what is allowed for modification from userspace.
>   */
> -static int validate_prctl_map(struct prctl_mm_map *prctl_map)
> +static int validate_prctl_map_addr(struct prctl_mm_map *prctl_map)
>  {
>  	unsigned long mmap_max_addr = TASK_SIZE;
>  	struct mm_struct *mm = current->mm;
> @@ -1949,24 +1951,6 @@ static int validate_prctl_map(struct prctl_mm_map *prctl_map)
>  			      prctl_map->start_data))
>  			goto out;
>  
> -	/*
> -	 * Someone is trying to cheat the auxv vector.
> -	 */
> -	if (prctl_map->auxv_size) {
> -		if (!prctl_map->auxv || prctl_map->auxv_size > sizeof(mm->saved_auxv))
> -			goto out;
> -	}
> -
> -	/*
> -	 * Finally, make sure the caller has the rights to
> -	 * change /proc/pid/exe link: only local sys admin should
> -	 * be allowed to.
> -	 */
> -	if (prctl_map->exe_fd != (u32)-1) {
> -		if (!ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> -			goto out;
> -	}
> -
>  	error = 0;
>  out:
>  	return error;
> @@ -1993,11 +1977,17 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>  	if (copy_from_user(&prctl_map, addr, sizeof(prctl_map)))
>  		return -EFAULT;
>  
> -	error = validate_prctl_map(&prctl_map);
> +	error = validate_prctl_map_addr(&prctl_map);
>  	if (error)
>  		return error;
>  
>  	if (prctl_map.auxv_size) {
> +		/*
> +		 * Someone is trying to cheat the auxv vector.
> +		 */
> +		if (!prctl_map.auxv || prctl_map.auxv_size > sizeof(mm->saved_auxv))
> +			return -EINVAL;
> +
>  		memset(user_auxv, 0, sizeof(user_auxv));
>  		if (copy_from_user(user_auxv,
>  				   (const void __user *)prctl_map.auxv,
> @@ -2010,6 +2000,14 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>  	}
>  
>  	if (prctl_map.exe_fd != (u32)-1) {
> +		/*
> +		 * Make sure the caller has the rights to
> +		 * change /proc/pid/exe link: only local sys admin should
> +		 * be allowed to.
> +		 */
> +		if (!ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> +			return -EINVAL;
> +
>  		error = prctl_set_mm_exe_file(mm, prctl_map.exe_fd);
>  		if (error)
>  			return error;
> @@ -2097,7 +2095,7 @@ static int prctl_set_mm(int opt, unsigned long addr,
>  			unsigned long arg4, unsigned long arg5)
>  {
>  	struct mm_struct *mm = current->mm;
> -	struct prctl_mm_map prctl_map;
> +	struct prctl_mm_map prctl_map = { .auxv = NULL, .auxv_size = 0, .exe_fd = -1 };
>  	struct vm_area_struct *vma;
>  	int error;
>  
> @@ -2139,9 +2137,6 @@ static int prctl_set_mm(int opt, unsigned long addr,
>  	prctl_map.arg_end	= mm->arg_end;
>  	prctl_map.env_start	= mm->env_start;
>  	prctl_map.env_end	= mm->env_end;
> -	prctl_map.auxv		= NULL;
> -	prctl_map.auxv_size	= 0;
> -	prctl_map.exe_fd	= -1;
>  
>  	switch (opt) {
>  	case PR_SET_MM_START_CODE:
> @@ -2181,7 +2176,7 @@ static int prctl_set_mm(int opt, unsigned long addr,
>  		goto out;
>  	}
>  
> -	error = validate_prctl_map(&prctl_map);
> +	error = validate_prctl_map_addr(&prctl_map);
>  	if (error)
>  		goto out;
>  
> 

