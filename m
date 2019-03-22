Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F67C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7719221873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzPRMVf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfCVGu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:50:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35875 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfCVGu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 02:50:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so41575ljg.3;
        Thu, 21 Mar 2019 23:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Og2qwT9BdQ4rmx69WidXs09mKQ/R1nn/AForRblNkDM=;
        b=qzPRMVf+ro/3nnUBrHuqbXLmFTDoq1/KpLRO5ATXRZk4HORnW2q5IS4GfnU0Vle3KJ
         5UkQHKKzQxJRqvlVCMov0u/xqijZNnL/MpnO47WcGMPOluATn59uUmEiVR0aWBLCbLEJ
         hJFDyyqPVG9Q4F/ZcGYfPnaFFScI3rslX2ZK5rhel9Q/nW6snWENKYxZFuZXv9u0d+++
         5IELeJOQ2gwKvwSt+Ho2LmBX8o11fUN/Ejqn7Fa+1FT7gfJbSB1dtnrgRdDZz9tNUA1I
         owrfRIIhgpGVqWB6wbmab18zagQCn7sp61+V7NBOC/yrU3XpDAP6dKw0QT3vTFL9zg0u
         fbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Og2qwT9BdQ4rmx69WidXs09mKQ/R1nn/AForRblNkDM=;
        b=E8OXEbHviP9PyKMC4aF7QUk/8uK618K7nEZBk5RLObESPApSBe1qrhn9RCp1Q5+CX3
         hRTf78bI5brZFJsMyoy2zyMAQVDgsy78wgAfjY4QlJTxeQk8LZw+b9lGDDLLYAhIvYRn
         ofh9ZiP/mvpYUKqjxD5ZDwXNUPIhUVYJIQNd6G/Vp6y/8s01FNHLr9CntUrZ8MToA72C
         Zp9BZklqhF8zX+vHcHfX+W0Pbi4e0hRa7BEZN2MPa77esYWr1ncngNToVREd8YHw1doY
         HlW4sp9uMF1Kj03OycE/7uy4keaYVKwelst+YnyNt/7u34Py59D1W4a3059MpIrEXvvH
         2a8Q==
X-Gm-Message-State: APjAAAUmIASiwLohlyzzTA3oec5KY9ufIlzzaDPo/acn3EoJMCzEFN69
        QF3P/cpQbEG+zqOOwaqFhhIhgo+IuE291ohLYsg=
X-Google-Smtp-Source: APXvYqye25nLtXIei9meg5Ob0R+OAKSYjlcqufEC/zrnmTQ8HeJNWf9KcKiJewC7kxZDqG79KIRyNJlr/L3aVjiVlXU=
X-Received: by 2002:a2e:9c10:: with SMTP id s16mr4385917lji.20.1553237424545;
 Thu, 21 Mar 2019 23:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190320204255.53571-1-cai@lca.pw>
In-Reply-To: <20190320204255.53571-1-cai@lca.pw>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 22 Mar 2019 12:20:12 +0530
Message-ID: <CAFqt6zbHwvTgFfrjvDbETRYu05O1W=_e_GT8R6pMkDhFfzYFOQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] mm/hotplug: fix notification in offline error path
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, osalvador@suse.de,
        anshuman.khandual@arm.com, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 2:13 AM Qian Cai <cai@lca.pw> wrote:
>
> When start_isolate_page_range() returned -EBUSY in __offline_pages(), it
> calls memory_notify(MEM_CANCEL_OFFLINE, &arg) with an uninitialized
> "arg". As the result, it triggers warnings below. Also, it is only
> necessary to notify MEM_CANCEL_OFFLINE after MEM_GOING_OFFLINE.

For my clarification, if test_pages_in_a_zone() failed in  __offline_pages(),
we have the similar scenario as well. If yes, do we need to capture it
in change log ?

>
> page:ffffea0001200000 count:1 mapcount:0 mapping:0000000000000000
> index:0x0
> flags: 0x3fffe000001000(reserved)
> raw: 003fffe000001000 ffffea0001200008 ffffea0001200008 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: unmovable page
> WARNING: CPU: 25 PID: 1665 at mm/kasan/common.c:665
> kasan_mem_notifier+0x34/0x23b
> CPU: 25 PID: 1665 Comm: bash Tainted: G        W         5.0.0+ #94
> Hardware name: HP ProLiant DL180 Gen9/ProLiant DL180 Gen9, BIOS U20
> 10/25/2017
> RIP: 0010:kasan_mem_notifier+0x34/0x23b
> RSP: 0018:ffff8883ec737890 EFLAGS: 00010206
> RAX: 0000000000000246 RBX: ff10f0f4435f1000 RCX: f887a7a21af88000
> RDX: dffffc0000000000 RSI: 0000000000000020 RDI: ffff8881f221af88
> RBP: ffff8883ec737898 R08: ffff888000000000 R09: ffffffffb0bddcd0
> R10: ffffed103e857088 R11: ffff8881f42b8443 R12: dffffc0000000000
> R13: 00000000fffffff9 R14: dffffc0000000000 R15: 0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000560fbd31d730 CR3: 00000004049c6003 CR4: 00000000001606a0
> Call Trace:
>  notifier_call_chain+0xbf/0x130
>  __blocking_notifier_call_chain+0x76/0xc0
>  blocking_notifier_call_chain+0x16/0x20
>  memory_notify+0x1b/0x20
>  __offline_pages+0x3e2/0x1210
>  offline_pages+0x11/0x20
>  memory_block_action+0x144/0x300
>  memory_subsys_offline+0xe5/0x170
>  device_offline+0x13f/0x1e0
>  state_store+0xeb/0x110
>  dev_attr_store+0x3f/0x70
>  sysfs_kf_write+0x104/0x150
>  kernfs_fop_write+0x25c/0x410
>  __vfs_write+0x66/0x120
>  vfs_write+0x15a/0x4f0
>  ksys_write+0xd2/0x1b0
>  __x64_sys_write+0x73/0xb0
>  do_syscall_64+0xeb/0xb78
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f14f75cc3b8
> RSP: 002b:00007ffe84d01d68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f14f75cc3b8
> RDX: 0000000000000008 RSI: 0000563f8e433d70 RDI: 0000000000000001
> RBP: 0000563f8e433d70 R08: 000000000000000a R09: 00007ffe84d018f0
> R10: 000000000000000a R11: 0000000000000246 R12: 00007f14f789e780
> R13: 0000000000000008 R14: 00007f14f7899740 R15: 0000000000000008
>
> Fixes: 7960509329c2 ("mm, memory_hotplug: print reason for the offlining failure")
> CC: stable@vger.kernel.org # 5.0.x
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0e0a16021fd5..0082d699be94 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1699,12 +1699,12 @@ static int __ref __offline_pages(unsigned long start_pfn,
>
>  failed_removal_isolated:
>         undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
> +       memory_notify(MEM_CANCEL_OFFLINE, &arg);
>  failed_removal:
>         pr_debug("memory offlining [mem %#010llx-%#010llx] failed due to %s\n",
>                  (unsigned long long) start_pfn << PAGE_SHIFT,
>                  ((unsigned long long) end_pfn << PAGE_SHIFT) - 1,
>                  reason);
> -       memory_notify(MEM_CANCEL_OFFLINE, &arg);
>         /* pushback to free area */
>         mem_hotplug_done();
>         return ret;
> --
> 2.17.2 (Apple Git-113)
>
