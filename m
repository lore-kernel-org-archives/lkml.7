Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C09C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29856208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfE1IfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:35:06 -0400
Received: from relay.sw.ru ([185.231.240.75]:44080 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfE1IfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:35:05 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hVXZU-000124-DK; Tue, 28 May 2019 11:35:00 +0300
Subject: Re: [PATCH] list_lru: fix memory leak in __memcg_init_list_lru_node
To:     Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        syzbot+f90a420dfe2b1b03cb2c@syzkaller.appspotmail.com
References: <20190528043202.99980-1-shakeelb@google.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <6ed45785-4b5b-83f9-6487-6c4142fe22ac@virtuozzo.com>
Date:   Tue, 28 May 2019 11:34:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528043202.99980-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.05.2019 07:32, Shakeel Butt wrote:
> Syzbot reported following memory leak:
> 
> ffffffffda RBX: 0000000000000003 RCX: 0000000000441f79
> BUG: memory leak
> unreferenced object 0xffff888114f26040 (size 32):
>   comm "syz-executor626", pid 7056, jiffies 4294948701 (age 39.410s)
>   hex dump (first 32 bytes):
>     40 60 f2 14 81 88 ff ff 40 60 f2 14 81 88 ff ff  @`......@`......
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000018f36b56>] kmemleak_alloc_recursive include/linux/kmemleak.h:55 [inline]
>     [<0000000018f36b56>] slab_post_alloc_hook mm/slab.h:439 [inline]
>     [<0000000018f36b56>] slab_alloc mm/slab.c:3326 [inline]
>     [<0000000018f36b56>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
>     [<0000000055b9a1a5>] kmalloc include/linux/slab.h:547 [inline]
>     [<0000000055b9a1a5>] __memcg_init_list_lru_node+0x58/0xf0 mm/list_lru.c:352
>     [<000000001356631d>] memcg_init_list_lru_node mm/list_lru.c:375 [inline]
>     [<000000001356631d>] memcg_init_list_lru mm/list_lru.c:459 [inline]
>     [<000000001356631d>] __list_lru_init+0x193/0x2a0 mm/list_lru.c:626
>     [<00000000ce062da3>] alloc_super+0x2e0/0x310 fs/super.c:269
>     [<000000009023adcf>] sget_userns+0x94/0x2a0 fs/super.c:609
>     [<0000000052182cd8>] sget+0x8d/0xb0 fs/super.c:660
>     [<0000000006c24238>] mount_nodev+0x31/0xb0 fs/super.c:1387
>     [<0000000006016a76>] fuse_mount+0x2d/0x40 fs/fuse/inode.c:1236
>     [<000000009a61ec1d>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
>     [<0000000096cd9ef8>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
>     [<000000005b8f472d>] do_new_mount fs/namespace.c:2790 [inline]
>     [<000000005b8f472d>] do_mount+0x932/0xc50 fs/namespace.c:3110
>     [<00000000afb009b4>] ksys_mount+0xab/0x120 fs/namespace.c:3319
>     [<0000000018f8c8ee>] __do_sys_mount fs/namespace.c:3333 [inline]
>     [<0000000018f8c8ee>] __se_sys_mount fs/namespace.c:3330 [inline]
>     [<0000000018f8c8ee>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
>     [<00000000f42066da>] do_syscall_64+0x76/0x1a0 arch/x86/entry/common.c:301
>     [<0000000043d74ca0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> This is a simple off by one bug on the error path.
> 
> Reported-by: syzbot+f90a420dfe2b1b03cb2c@syzkaller.appspotmail.com
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  mm/list_lru.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 0bdf3152735e..92870be4a322 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -358,7 +358,7 @@ static int __memcg_init_list_lru_node(struct list_lru_memcg *memcg_lrus,
>  	}
>  	return 0;
>  fail:
> -	__memcg_destroy_list_lru_node(memcg_lrus, begin, i - 1);
> +	__memcg_destroy_list_lru_node(memcg_lrus, begin, i);
>  	return -ENOMEM;
>  }
>  
> 

