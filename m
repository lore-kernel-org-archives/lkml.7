Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8433AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB6B227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfLSAj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 19:39:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51080 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLSAj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 19:39:59 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ihjr9-0002Ra-Ac; Thu, 19 Dec 2019 00:39:55 +0000
Date:   Thu, 19 Dec 2019 01:39:54 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/3] cgroup: unify attach permission checking
Message-ID: <20191219003953.y26rclexqwijxmvz@wittgenstein>
References: <20191218173516.7875-1-christian.brauner@ubuntu.com>
 <20191218173516.7875-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191218173516.7875-2-christian.brauner@ubuntu.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 06:35:14PM +0100, Christian Brauner wrote:
> The core codepaths to check whether a process can be attached to a
> cgroup are the same for threads and thread-group leaders. Only a small
> piece of code verifying that source and destination cgroup are in the
> same domain differentiates the thread permission checking from
> thread-group leader permission checking.
> Since cgroup_migrate_vet_dst() only matters cgroup2 - it is a noop on
> cgroup1 - we can move it out of cgroup_attach_task().
> All checks can now be consolidated into a new helper
> cgroup_attach_permissions() callable from both cgroup_procs_write() and
> cgroup_threads_write().
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: cgroups@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  kernel/cgroup/cgroup.c | 46 +++++++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 735af8f15f95..5ee06c1f7456 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2719,11 +2719,7 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
>  {
>  	DEFINE_CGROUP_MGCTX(mgctx);
>  	struct task_struct *task;
> -	int ret;
> -
> -	ret = cgroup_migrate_vet_dst(dst_cgrp);
> -	if (ret)
> -		return ret;
> +	int ret = 0;
>  
>  	/* look up all src csets */
>  	spin_lock_irq(&css_set_lock);
> @@ -4690,6 +4686,33 @@ static int cgroup_procs_write_permission(struct cgroup *src_cgrp,
>  	return 0;
>  }
>  
> +static inline bool cgroup_same_domain(const struct cgroup *src_cgrp,
> +				      const struct cgroup *dst_cgrp)
> +{
> +	return src_cgrp->dom_cgrp == dst_cgrp->dom_cgrp;
> +}
> +
> +static int cgroup_attach_permissions(struct cgroup *src_cgrp,
> +				     struct cgroup *dst_cgrp,
> +				     struct super_block *sb, bool thread)
> +{
> +	int ret;

This needs to be

ret = 0

> +
> +	ret = cgroup_procs_write_permission(src_cgrp, dst_cgrp, sb);
> +	if (ret)
> +		return ret;
> +
> +	ret = cgroup_migrate_vet_dst(dst_cgrp);
> +	if (ret)
> +		return ret;
> +
> +	if (thread &&
> +	    !cgroup_same_domain(src_cgrp->dom_cgrp, dst_cgrp->dom_cgrp))
> +		ret = -EOPNOTSUPP;
> +
> +	return 0;

and this

return ret;
