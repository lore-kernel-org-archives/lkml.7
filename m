Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67C6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949D721D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vulhdg5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502463AbfJYL6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:58:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43726 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393594AbfJYL6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:58:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id a194so1435440qkg.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 04:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/CO042MKi/LDA0//fO8T8qW/x60c6gkFFIpJRb5i00=;
        b=Vulhdg5+bi6395aeNLgqwghz4EgLOcJsEI/3HMat2oFGMbAlTAIqYOokEpLLn/56bT
         oItkzIybVV+1L6fCOpOC/fdaFNHFpx23IV5vbo0coydsWc/Hm0eYsQEyBfZXWEAOYqeE
         HicdmU/loEWdtC6st19ARI4BPGcPV3K0QNkOW3gjEDRMI39IbhmkCXF6oEk2oF79A0MH
         SUeksEcorpIMghlhNHjO3OKPt5Z+cn2DvMQ0XvADz4AYmLvu1jPXIbkyU2duRyMCgVg1
         5MiuJLbd1M3m/Vbe9lhdcbcoL6YzUH+AJJ2NcaHJPeZXUA1WFACSeTycHATL6O00qjk6
         49jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/CO042MKi/LDA0//fO8T8qW/x60c6gkFFIpJRb5i00=;
        b=lBf0zff7g7AdRtZdsOP6eFLUd2LpUZkjh4HpydzKZZsS6XoAOd+V63asmO9ydpV31z
         9BpHV4kIwjvT1GNKqLaL+2OHGQnrHAgIYc9lr3oxAvR/8djxXoS9yxTsnTL6Da55pqGz
         4xhOOjfHtQry7xgrrexpUJwT4Dfo94ma5+7Ur3JBk1FtZvDHdZJXNGWUf0FQ1FF2b94X
         zEcnmJnliwkGNlqSGUaVY/0fwybkpJivdLqDyhd7JvDigsoXBuIWc12sEMO7cwQbKTyH
         iKBHQAJbEP7rkP8gXV3P+gYhfaV18YjnyGYKsfgx85OVoGcSs7L7DrX1S3iOVSV99An1
         L0GQ==
X-Gm-Message-State: APjAAAWNWfp4jHKGomeB6KXiKRva2MVwY6SB6g6M0Ac1folUAfmv9pI+
        IelVUOZj8wlkGNnPY6tp/S9Y4TsPk0s00GVywabX9Q==
X-Google-Smtp-Source: APXvYqwkabvJ1Z+Z6wGHKHEz2XSrHtVQfHPiyVmo2GjLPCCQJh5nhVsd3QSNFn2Ib30TbjvK3F/GQy52IW7MFslMkvg=
X-Received: by 2002:a37:4a87:: with SMTP id x129mr2363244qka.43.1572004712309;
 Fri, 25 Oct 2019 04:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000fbbe1e0595bac322@google.com>
In-Reply-To: <000000000000fbbe1e0595bac322@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 25 Oct 2019 13:58:21 +0200
Message-ID: <CACT4Y+Y946C-kyiBSZtyKY7PU4qxrysOfukd42--pXdyTRyjbw@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref Write in io_wq_cancel_all
To:     syzbot <syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 1:51 PM syzbot
<syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    139c2d13 Add linux-next specific files for 20191025
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17ab5a70e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=28fd7a693df38d29
> dashboard link: https://syzkaller.appspot.com/bug?extid=d958a65633ea70280b23
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com

+Jens

> ==================================================================
> BUG: KASAN: null-ptr-deref in set_bit
> include/asm-generic/bitops-instrumented.h:28 [inline]
> BUG: KASAN: null-ptr-deref in io_wq_cancel_all+0x28/0x2a0 fs/io-wq.c:574
> Write of size 8 at addr 0000000000000004 by task syz-executor.5/17477
>
> CPU: 1 PID: 17477 Comm: syz-executor.5 Not tainted 5.4.0-rc4-next-20191025
> #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>   __kasan_report.cold+0x5/0x41 mm/kasan/report.c:510
>   kasan_report+0x12/0x20 mm/kasan/common.c:634
>   check_memory_region_inline mm/kasan/generic.c:185 [inline]
>   check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
>   __kasan_check_write+0x14/0x20 mm/kasan/common.c:98
>   set_bit include/asm-generic/bitops-instrumented.h:28 [inline]
>   io_wq_cancel_all+0x28/0x2a0 fs/io-wq.c:574
>   io_ring_ctx_wait_and_kill+0x1e2/0x710 fs/io_uring.c:3679
>   io_uring_release+0x42/0x50 fs/io_uring.c:3691
>   __fput+0x2ff/0x890 fs/file_table.c:280
>   ____fput+0x16/0x20 fs/file_table.c:313
>   task_work_run+0x145/0x1c0 kernel/task_work.c:113
>   exit_task_work include/linux/task_work.h:22 [inline]
>   do_exit+0x904/0x2e60 kernel/exit.c:817
>   do_group_exit+0x135/0x360 kernel/exit.c:921
>   get_signal+0x47c/0x24f0 kernel/signal.c:2734
>   do_signal+0x87/0x1700 arch/x86/kernel/signal.c:815
>   exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:159
>   prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
>   do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x459ef9
> Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f7129716c78 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
> RAX: 0000000000000005 RBX: 0000000000000002 RCX: 0000000000459ef9
> RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000ebf
> RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f71297176d4
> R13: 00000000004c14ae R14: 00000000004d4c68 R15: 00000000ffffffff
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000fbbe1e0595bac322%40google.com.
