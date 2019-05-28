Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC16C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 04:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0561D2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 04:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mhw9cuI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfE1EgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 00:36:15 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36395 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfE1EgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 00:36:14 -0400
Received: by mail-yb1-f193.google.com with SMTP id y2so4548899ybo.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 21:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EhZXEPaGOndmbMF7hBpdNSLf/Wn42Ho6pv5iLoXbO8E=;
        b=Mhw9cuI3Uguy91f7l2VsS1lLuaKukCk2S5h+I08iNodfJOgE0KM1cosNBc/F04PqQu
         OHEWYViHOr0kxioEUZKFcp1prBcM6SOtKBwjpHXnmhN09r/m+M7514payGiojqn/p8U7
         WpEF22+fEE4vFWX+KYIWCwDKYsdCuyBkH/Q0f9sLfSb3p+lUcpZ1/a5JE1mcVdFiuMeT
         H0NHYV7z/MJcPmvwGieBAb0xZUVIbRixRKdmjojXoScIPnkOoZVJo8AqmsnVOjwg9/Ji
         xJuUEXtayITVXKX3VCehfJUC4f/luD0DgIhUlHBemNrc9G5BsnERyeaUmecclwm7Ku1r
         sLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EhZXEPaGOndmbMF7hBpdNSLf/Wn42Ho6pv5iLoXbO8E=;
        b=MHkXLqf9jDQ7z7ZuLoAJa2XB4YgkPodX/2HqL4L+bqdcAjdjeV9deBzrD7Apl57Ri6
         M558L/X8u9HVh3ByfYFDdk8RGSWxxxZ/ARphnFu3fR+giGsH/+xfH4jJYz3WswIdxFbg
         NKq8n4d3KxMoVQ8JASbrEw1g7EMMSoWduCdz4YUDyQTLSDAZa1EyxaoiGb43DA9zQ0GU
         w9L2YvvA5sufNNhrxAiz6JqRnkXf9lrAvlIqtWQOk83J5ZTLxq85/M0W+zsr+o7HezRy
         D/wEm0SrGhGS4A16hvz8teTiw7Oxv4wrB38Y7FpvO+6llZHYV9WXv5pGdd7Bdmp/D/Rk
         Ua2w==
X-Gm-Message-State: APjAAAUQgCPYBJNccXTM3rpM8fp5r9Z0EmX9UIDnqp/T+2RVSk/AnE/b
        wBUQuC4wXY6+aptxKKiAr8ruiahfyYVPpC/ptTH1Og==
X-Google-Smtp-Source: APXvYqxlGLX0hGvbz3YS/QjwcbuvyttsCokhfzJ5VDEpy0YXYNYGjNH07HgDr9vxxbss9W6b6TRHZZRUBKMopZ+Vj9U=
X-Received: by 2002:a25:1ed6:: with SMTP id e205mr5487694ybe.467.1559018173464;
 Mon, 27 May 2019 21:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190528043202.99980-1-shakeelb@google.com>
In-Reply-To: <20190528043202.99980-1-shakeelb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 27 May 2019 21:36:02 -0700
Message-ID: <CALvZod7Or8diV5i2eayiP9NZHfGn503j+6TpSV1CP9fTmSjEug@mail.gmail.com>
Subject: Re: [PATCH] list_lru: fix memory leak in __memcg_init_list_lru_node
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        syzbot+f90a420dfe2b1b03cb2c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 9:32 PM Shakeel Butt <shakeelb@google.com> wrote:
>
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

Forgot to add:

Fixes: 60d3fd32a7a9 ("list_lru: introduce per-memcg lists")
Cc: stable@vger.kernel.org # 4.0+

> ---
>  mm/list_lru.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 0bdf3152735e..92870be4a322 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -358,7 +358,7 @@ static int __memcg_init_list_lru_node(struct list_lru_memcg *memcg_lrus,
>         }
>         return 0;
>  fail:
> -       __memcg_destroy_list_lru_node(memcg_lrus, begin, i - 1);
> +       __memcg_destroy_list_lru_node(memcg_lrus, begin, i);
>         return -ENOMEM;
>  }
>
> --
> 2.22.0.rc1.257.g3120a18244-goog
>
