Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C437C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D311F20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551982213;
	bh=GMHU2asFXrZ4vEhKxRWZZdBfAr3HCQv5wj8xNofcdH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ga6iARGux8b5teiYZYynvnqB7NFC/HS5jMFxfkXuWTW4ii3xi05bGsIVjZuwCWBpw
	 +SCHx0M0TOf0u6acNuAHanmbVeELf3Mqm+FTTBsJu4stRdpIFeonOvezU9qrXaATfl
	 pTTd50LC/5pl8asoP0aHLzm7Ulc2rvuSAXbLOawI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfCGSKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:10:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38476 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCGSKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:10:11 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 282E7C602;
        Thu,  7 Mar 2019 18:10:11 +0000 (UTC)
Date:   Thu, 7 Mar 2019 10:10:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ipc: prevent lockup on alloc_msg and free_msg
Message-Id: <20190307101010.919d18394ae43ecf9d2a2212@linux-foundation.org>
In-Reply-To: <1551946222-25470-1-git-send-email-lirongqing@baidu.com>
References: <1551946222-25470-1-git-send-email-lirongqing@baidu.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Mar 2019 16:10:22 +0800 Li RongQing <lirongqing@baidu.com> wrote:

> From: Li Rongqing <lirongqing@baidu.com>
> 
> msgctl10 of ltp triggers the following lockup When CONFIG_KASAN
> is enabled on large memory SMP systems, the pages initialization
> can take a long time, if msgctl10 requests a huge block memory,
> and it will block rcu scheduler, so release cpu actively.
> 
> ...
>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

This signoff ordering somewhat implies that Zhang Yu was the author. 
But you added "From: Li Rongqing", so you will be recorded as the
patch's author.  Is this correct?

> --- a/ipc/msgutil.c
> +++ b/ipc/msgutil.c
> @@ -18,6 +18,7 @@
>  #include <linux/utsname.h>
>  #include <linux/proc_ns.h>
>  #include <linux/uaccess.h>
> +#include <linux/sched.h>
>  
>  #include "util.h"
>  
> @@ -72,6 +73,7 @@ static struct msg_msg *alloc_msg(size_t len)
>  		seg->next = NULL;
>  		pseg = &seg->next;
>  		len -= alen;
> +		cond_resched();
>  	}

This looks OK.

>  	return msg;
> @@ -178,5 +180,6 @@ void free_msg(struct msg_msg *msg)
>  		struct msg_msgseg *tmp = seg->next;
>  		kfree(seg);
>  		seg = tmp;
> +		cond_resched();
>  	}

This does not.  mqueue_evict_inode() (at least) calls free_msg() from
under spin_lock().

