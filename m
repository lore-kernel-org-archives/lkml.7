Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFADC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCFE216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfEUHvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:51:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35804 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfEUHvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:51:15 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id ABD7C1F462;
        Tue, 21 May 2019 07:51:14 +0000 (UTC)
Date:   Tue, 21 May 2019 07:51:14 +0000
From:   Eric Wong <e@80x24.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Azat Khuzhin <azat@libevent.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/13] epoll: offload polling to a work in case of
 epfd polled from userspace
Message-ID: <20190521075114.if4urjezominbojj@dcvr>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-6-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516085810.31077-6-rpenyaev@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Penyaev <rpenyaev@suse.de> wrote:
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 81da4571f1e0..9d3905c0afbf 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -44,6 +44,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/compat.h>
>  #include <linux/rculist.h>
> +#include <linux/workqueue.h>
>  #include <net/busy_poll.h>
>  
>  /*
> @@ -185,6 +186,9 @@ struct epitem {
>  
>  	/* The structure that describe the interested events and the source fd */
>  	struct epoll_event event;
> +
> +	/* Work for offloading event callback */
> +	struct work_struct work;
>  };
>  
>  /*

Can we avoid the size regression for existing epoll users?

> @@ -2547,12 +2601,6 @@ static int __init eventpoll_init(void)
>  	ep_nested_calls_init(&poll_safewake_ncalls);
>  #endif
>  
> -	/*
> -	 * We can have many thousands of epitems, so prevent this from
> -	 * using an extra cache line on 64-bit (and smaller) CPUs
> -	 */
> -	BUILD_BUG_ON(sizeof(void *) <= 8 && sizeof(struct epitem) > 128);
> -
>  	/* Allocates slab cache used to allocate "struct epitem" items */
>  	epi_cache = kmem_cache_create("eventpoll_epi", sizeof(struct epitem),
>  			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL);

Perhaps a "struct uepitem" transparent union and separate slab cache.
