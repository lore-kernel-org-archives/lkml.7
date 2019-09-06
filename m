Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BA4C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F87F20578
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NA2rM7b2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404566AbfIFSZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 14:25:08 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40916 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403780AbfIFSZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:25:08 -0400
Received: by mail-yb1-f196.google.com with SMTP id t15so2494612ybg.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WdTZMbaXp+Fn3AW7k8huzJkb6vrG4Ilofg/RU4HTeY4=;
        b=NA2rM7b2J7kiX/KSSoT1y5lY3VpV+gLXHY/TO80Ow2FpxJNrx6zL6ET28GwSbzajnl
         5vFbvIWKF7AXXTMV9g9fpKp6EIWYzo5dJwIWVjdWsEFBpWU51bcoZNOnaG2ptwZWrc6g
         yZfBN6yvMHi0MP1s7RhhFajCqT0lOQsbzlQIqZo46sJW8GL1AeyMZBu97ZhekQcBfQ6A
         ONCy4kLsD/T8jNrpd/DrieiJqYYYm5P9vvKdZFeqkIIauC6ejyFT1hY8S/wEHa+us09g
         IyIxQPR4YLa3a1hi31r0pixDWfe1AnQK7p1AYfE0x5OxnnOyIyjzRhPzGgTO0s+B8PY2
         bOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WdTZMbaXp+Fn3AW7k8huzJkb6vrG4Ilofg/RU4HTeY4=;
        b=gY8+mjAqub0iJiS6uSLWHYRO4Trq+GJxItI6rQG8h43wZs5nWgQ2QuMKYMmVleg1EH
         NXFcuYT2Bl2PA/oqWGN3z4tqu88SWVNAL9ltMY7vWo4ot/kMuZCcJxovcorQ3Xz0zecD
         sipsTWVUN7aazXQqg7KNMg2izatOJ6xaHDcMqDm/H5pSZKkoqzmGaI+Q939Y6vUopksg
         w+c3xqiwNN2lFfUVPtObTkUkdAmafABogsJz2KHD4oPy0/O8m9sApxP4z7HuYjRCFx6e
         rUBleu0jIn7TfItYR1CBTbWQv7n62yUDWtbjee4lvcHEyX4ZU9wNuuy/98vzJCAYYQ2/
         +KRw==
X-Gm-Message-State: APjAAAVzji501pcORPPpSIwwEiN4+2E55+Rp/9C5V5rMKdMgCJT+T1mS
        2EQwU4tqKCkU9Nt+X7a4lKE5UTjm2zsU90jPuCI/xg==
X-Google-Smtp-Source: APXvYqz/avyNpX/28xYHRUNsgpOhH5S6IbAc3ig7Z/fEr6/umwtbXAZXYCmxo4NTh3quf0HEuq2lwJBpTRveyfFVW9s=
X-Received: by 2002:a25:c708:: with SMTP id w8mr7607450ybe.358.1567794306397;
 Fri, 06 Sep 2019 11:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <31131c2d-a936-8bbf-e58d-a3baaa457340@gmail.com> <20190906125608.32129-1-mhocko@kernel.org>
In-Reply-To: <20190906125608.32129-1-mhocko@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 6 Sep 2019 11:24:55 -0700
Message-ID: <CALvZod5w72jH8fJSFRaw7wgQTnzF6nb=+St-sSXVGSiG6Bs3Lg@mail.gmail.com>
Subject: Re: [PATCH] memcg, kmem: do not fail __GFP_NOFAIL charges
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 5:56 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> From: Michal Hocko <mhocko@suse.com>
>
> Thomas has noticed the following NULL ptr dereference when using cgroup
> v1 kmem limit:
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> PGD 0
> P4D 0
> Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 3 PID: 16923 Comm: gtk-update-icon Not tainted 4.19.51 #42
> Hardware name: Gigabyte Technology Co., Ltd. Z97X-Gaming G1/Z97X-Gaming G1, BIOS F9 07/31/2015
> RIP: 0010:create_empty_buffers+0x24/0x100
> Code: cd 0f 1f 44 00 00 0f 1f 44 00 00 41 54 49 89 d4 ba 01 00 00 00 55 53 48 89 fb e8 97 fe ff ff 48 89 c5 48 89 c2 eb 03 48 89 ca <48> 8b 4a 08 4c 09 22 48 85 c9 75 f1 48 89 6a 08 48 8b 43 18 48 8d
> RSP: 0018:ffff927ac1b37bf8 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: fffff2d4429fd740 RCX: 0000000100097149
> RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff9075a99fbe00
> RBP: 0000000000000000 R08: fffff2d440949cc8 R09: 00000000000960c0
> R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff907601f18360 R14: 0000000000002000 R15: 0000000000001000
> FS:  00007fb55b288bc0(0000) GS:ffff90761f8c0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 000000007aebc002 CR4: 00000000001606e0
> Call Trace:
>  create_page_buffers+0x4d/0x60
>  __block_write_begin_int+0x8e/0x5a0
>  ? ext4_inode_attach_jinode.part.82+0xb0/0xb0
>  ? jbd2__journal_start+0xd7/0x1f0
>  ext4_da_write_begin+0x112/0x3d0
>  generic_perform_write+0xf1/0x1b0
>  ? file_update_time+0x70/0x140
>  __generic_file_write_iter+0x141/0x1a0
>  ext4_file_write_iter+0xef/0x3b0
>  __vfs_write+0x17e/0x1e0
>  vfs_write+0xa5/0x1a0
>  ksys_write+0x57/0xd0
>  do_syscall_64+0x55/0x160
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
>  Tetsuo then noticed that this is because the __memcg_kmem_charge_memcg
>  fails __GFP_NOFAIL charge when the kmem limit is reached. This is a
>  wrong behavior because nofail allocations are not allowed to fail.
>  Normal charge path simply forces the charge even if that means to cross
>  the limit. Kmem accounting should be doing the same.
>
> Reported-by: Thomas Lindroth <thomas.lindroth@gmail.com>
> Debugged-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Cc: stable
> Signed-off-by: Michal Hocko <mhocko@suse.com>

I wonder what has changed since
<http://lkml.kernel.org/r/20180525185501.82098-1-shakeelb@google.com/>.

> ---
>  mm/memcontrol.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 9ec5e12486a7..e18108b2b786 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2821,6 +2821,16 @@ int __memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
>
>         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
>             !page_counter_try_charge(&memcg->kmem, nr_pages, &counter)) {
> +
> +               /*
> +                * Enforce __GFP_NOFAIL allocation because callers are not
> +                * prepared to see failures and likely do not have any failure
> +                * handling code.
> +                */
> +               if (gfp & __GFP_NOFAIL) {
> +                       page_counter_charge(&memcg->kmem, nr_pages);
> +                       return 0;
> +               }
>                 cancel_charge(memcg, nr_pages);
>                 return -ENOMEM;
>         }
> --
> 2.20.1
>
