Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DEFC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5400E214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568668215;
	bh=Tde6N2xhrmVBkJfj/im8DRub08KbWyqXLl1/zMxtQ6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=An/10wg8+vqE7w4btvvEjwrSQhZpJiM49lUuzusk47d86ChrAvMdMBM4RGAx1u+Lu
	 jVtuEpblv6kWWBkrJKS9EemARxYmfpye/zgwX1qUf5rwILSKw2TGm8XVNtHNwc4Bfd
	 I/Crk9YzN9ofWutwm54PE80ZksmYbcO0zKAkhGGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388974AbfIPVKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388909AbfIPVKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:10:14 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90754214AF;
        Mon, 16 Sep 2019 21:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568668213;
        bh=Tde6N2xhrmVBkJfj/im8DRub08KbWyqXLl1/zMxtQ6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FsW3jY4EeWAULrHBDSmT917vaTr4bDCJcXllwSYUJRjK8Ai4H3rO9gXQKXu9TRMw7
         s3SUzbwDXd/V/04UXu0dtglSvpj8+ooF8AAr+2KpuAILa8kA+yqhTLHJK+yUEZyi35
         gnDeZvd3M2aL9N/Lom526UNpd3bH3ulyWhCnPSg4=
Date:   Mon, 16 Sep 2019 22:10:08 +0100
From:   Will Deacon <will@kernel.org>
To:     KeMeng Shi <shikemeng@huawei.com>
Cc:     akpm@linux-foundation.org, james.morris@microsoft.com,
        gregkh@linuxfoundation.org, mortonm@chromium.org,
        will.deacon@arm.com, kristina.martsenko@arm.com,
        yuehaibing@huawei.com, malat@debian.org, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] connector: report comm change event when modifying
 /proc/pid/task/tid/comm
Message-ID: <20190916211008.ipqe3j7s22aannta@willie-the-truck>
References: <20190916141341.658-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916141341.658-1-shikemeng@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:13:41AM -0400, KeMeng Shi wrote:
> Commit f786ecba41588 ("connector: add comm change event report to proc
>  connector") added proc_comm_connector to report comm change event, and
> prctl will report comm change event when dealing with PR_SET_NAME case.
> 
> prctl can only set the name of the calling thread. In order to set the name
> of other threads in a process, modifying /proc/self/task/tid/comm is a
> general way.It's exactly how pthread_setname_np do to set name of a thread.
> 
> It's unable to get comm change event of thread if the name of thread is set
> by other thread via pthread_setname_np. This update provides a chance for
> application to monitor and control threads whose name is set by other
> threads.
> 
> Signed-off-by: KeMeng Shi <shikemeng@huawei.com>
> ---
>  fs/proc/base.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ebea9501afb8..34ffe572ac69 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -94,6 +94,7 @@
>  #include <linux/sched/debug.h>
>  #include <linux/sched/stat.h>
>  #include <linux/posix-timers.h>
> +#include <linux/cn_proc.h>
>  #include <trace/events/oom.h>
>  #include "internal.h"
>  #include "fd.h"
> @@ -1549,10 +1550,12 @@ static ssize_t comm_write(struct file *file, const char __user *buf,
>  	if (!p)
>  		return -ESRCH;
>  
> -	if (same_thread_group(current, p))
> +	if (same_thread_group(current, p)) {
>  		set_task_comm(p, buffer);
> -	else
> +		proc_comm_connector(p);
> +	} else {
>  		count = -EINVAL;
> +	}
>  
>  	put_task_struct(p);

The rough idea looks ok to me but I have two concerns:

  (1) This looks like it will be visible to userspace, and this changes
      the behaviour after ~8 years of not reporting this event.

  (2) What prevents proc_comm_connector(p) running concurrently with itself
      via the prctl()? The locking seems to be confined to set_task_comm().

Will
