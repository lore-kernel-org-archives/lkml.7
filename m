Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A8DC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0C62072B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPOUv+lu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfLTUhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 15:37:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29945 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726525AbfLTUhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 15:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576874220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4jjRnLYjGrqgF7WL+aNzr4dW0tQZdCM9Qqr1PxQyLYQ=;
        b=CPOUv+luqofKZe6ideEHXXcBsW3L4JPJKOxZSWOLEzNIqorxihmH7DX20/QiFvEZbw/oXY
        OgeIexMwwdPL7Ar5aOK9UdWOWoTzXsiVY82r9FG3pokzhelvGsYqgUssOYcpmM2i0t7DnD
        GX2/D6kcUnlioYNtT4iC4Q0Fdivl1jU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-eyXY7Fg4MeWQIpg8Nlm4TQ-1; Fri, 20 Dec 2019 15:36:57 -0500
X-MC-Unique: eyXY7Fg4MeWQIpg8Nlm4TQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 676271005513;
        Fri, 20 Dec 2019 20:36:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-204-70.brq.redhat.com [10.40.204.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id 899A17C839;
        Fri, 20 Dec 2019 20:36:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 20 Dec 2019 21:36:54 +0100 (CET)
Date:   Fri, 20 Dec 2019 21:36:50 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/3] clone3: allow spawning processes into cgroups
Message-ID: <20191220203650.GA15133@redhat.com>
References: <20191218173516.7875-1-christian.brauner@ubuntu.com>
 <20191218173516.7875-3-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218173516.7875-3-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18, Christian Brauner wrote:
>
> This adds support for creating a process in a different cgroup than its
> parent.

Cough... I will not comment the intent ;) I can't review the cgroup patches
anyway.

However,

> +int cgroup_lock_fork(struct kernel_clone_args *kargs)
> +	__acquires(&cgroup_mutex)
> +{
> +	struct cgroup *cgrp;
> +
> +	if (!(kargs->flags & CLONE_INTO_CGROUP))
> +		return 0;
> +
> +	cgrp = kargs->cgrp;
> +	if (!cgrp)
> +		return 0;
> +
> +	mutex_lock(&cgroup_mutex);
> +
> +	if (!cgroup_is_dead(cgrp))
> +		return 0;
> +
> +	mutex_unlock(&cgroup_mutex);
> +	return -ENODEV;

...

> @@ -2172,7 +2172,7 @@ static __latent_entropy struct task_struct *copy_process(
>  	 * between here and cgroup_post_fork() if an organisation operation is in
>  	 * progress.
>  	 */
> -	retval = cgroup_can_fork(p);
> +	retval = cgroup_can_fork(current, p, args);
>  	if (retval)
>  		goto bad_fork_cgroup_threadgroup_change_end;
>  
> @@ -2226,6 +2226,10 @@ static __latent_entropy struct task_struct *copy_process(
>  		goto bad_fork_cancel_cgroup;
>  	}
>  
> +	retval = cgroup_lock_fork(args);

mutex_lock() under spin_lock() ??


just in case, note that mutex_lock(&cgroup_mutex) is not safe even under
cgroup_threadgroup_change_begin(), this can deadlock.

Oleg.

