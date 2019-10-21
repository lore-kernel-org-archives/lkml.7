Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77478CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA112067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQ6vIYvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfJUIrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:47:07 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38085 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfJUIrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:47:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id p4so11805383qkf.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 01:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DtjIchbJTLdcx+znb56sUdWYGPfELNfxtIFmYniUoJE=;
        b=OQ6vIYvl4mi/PcAJc/h1G/qm7X+OVNhUPYXhGjCutoh92FSRaBH9YIMZl3KKh9HOTQ
         7B34NBxutw1RAByvF0u509Pbzl51zJiGL3/BJkwAJPQRrajAOd8k9/gceJbSgVsOtUcz
         Kru+H36CmHZNQ7vSe+srljxese0+WjN9IMOHJCC22UbjaG1q0XCs5PblNKWKE/yIL6Dq
         viNZXzN7tRIQ2MEPYp75sx+Pu5Xrsnp2z1jRghi/uMe/60MrTJEnKJfahDntYaAcxSH1
         nCqkgSf0r9CIfRxxFus8xzy2EPN6bC2qmSzhF2eii73uKY2e+HsmbHJkXQLmE85pitCP
         gn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DtjIchbJTLdcx+znb56sUdWYGPfELNfxtIFmYniUoJE=;
        b=gvD+2QcWDbe5v8AHdYqdrHhSF0ssXEgI76Cvqhf5QLcrmFMxZ+SVeFRhzZetRWLi+r
         pmFYr7BKLyH4ru4ETUJ25GsEQWE2Ook+3shvL9fC+mdD+sGsHsksZBuGowX/tUhzv2RQ
         8PgbUk/EpyszQ6mmKgHShagrY9tOzm1iPc/lCx8vArDbVFjstoNta0Q6NCa8gCDHHBvg
         Ycr8HiLvLfKlkiTvmJmDEQF6Ml3anuN8eVZDH8W2Dizx74uSV8HwQeEBzq2oyDzyugzw
         3jV60O8LXzoxkBlmG0q3Fnh+XEhhe+OlpFsrm64SR4Qj50W2sAkhcT9DVPa8n3OzqLXo
         +HMA==
X-Gm-Message-State: APjAAAWlrVkm7A1q5vkMskgtzWBFzd9nRyK/FEnmspMIKMrVhvHNyDSa
        FscZx67z70LC08RNNB9n98pzCH3y0Tv+JeOhbb4WnA==
X-Google-Smtp-Source: APXvYqwKlJCHjWk95yYwKYeFCZVOA0EzjGSfaZn58qYXqZcLheQazIHwu0irbc8W2y1XR2BxTNWu4s3xX5rANvWIdWE=
X-Received: by 2002:a37:9202:: with SMTP id u2mr21465267qkd.8.1571647624861;
 Mon, 21 Oct 2019 01:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000eed19705952fee5a@google.com>
In-Reply-To: <000000000000eed19705952fee5a@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 21 Oct 2019 10:46:53 +0200
Message-ID: <CACT4Y+bj5_3cAjTJSG12abwZd1LZfRe0+tgZFQLMOSsafZwB5g@mail.gmail.com>
Subject: Re: WARNING in check_corruption
To:     syzbot <syzbot+2e88d23c0143e90d8303@syzkaller.appspotmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, wang.yi59@zte.com.cn,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 4:13 PM syzbot
<syzbot+2e88d23c0143e90d8303@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    8ada228a Add linux-next specific files for 20191011
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=144265ab600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7cf4eed5fe42c31a
> dashboard link: https://syzkaller.appspot.com/bug?extid=2e88d23c0143e90d8303
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1249ad80e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ca6de7600000

syzkaller managed to write to /dev/mem.
https://github.com/google/syzkaller/commit/ef4a2149feeadf5833638d9b6ec3e53cb8dfd39d
disables CONFIG_DEVMEM and CONFIG_DEVKMEM is syzbot config.

#syz invalid


> Bisection is inconclusive: the bug happens on the oldest tested release.
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=158d26d7600000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=178d26d7600000
> console output: https://syzkaller.appspot.com/x/log.txt?x=138d26d7600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2e88d23c0143e90d8303@syzkaller.appspotmail.com
>
> check: Corrupted low memory at 00000000b9a95c9f (2900 phys) = 000000e8
> ------------[ cut here ]------------
> Memory corruption detected in low memory
> WARNING: CPU: 0 PID: 3473 at arch/x86/kernel/check.c:161
> check_for_bios_corruption arch/x86/kernel/check.c:161 [inline]
> WARNING: CPU: 0 PID: 3473 at arch/x86/kernel/check.c:161
> check_corruption+0x159/0x1fc arch/x86/kernel/check.c:169
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 3473 Comm: kworker/0:2 Not tainted 5.4.0-rc2-next-20191011 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: events check_corruption
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>   panic+0x2e3/0x75c kernel/panic.c:221
>   __warn.cold+0x2f/0x35 kernel/panic.c:582
>   report_bug+0x289/0x300 lib/bug.c:195
>   fixup_bug arch/x86/kernel/traps.c:174 [inline]
>   fixup_bug arch/x86/kernel/traps.c:169 [inline]
>   do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
>   do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
>   invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
> RIP: 0010:check_for_bios_corruption arch/x86/kernel/check.c:161 [inline]
> RIP: 0010:check_corruption+0x159/0x1fc arch/x86/kernel/check.c:169
> Code: 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 80 3d 8b 00 90 08 00 75 a2
> 48 c7 c7 e0 6b a8 87 c6 05 7b 00 90 08 01 e8 af 0b 12 00 <0f> 0b eb 8b 48
> 89 df 89 55 d0 e8 88 45 7c 00 8b 55 d0 e9 4e ff ff
> RSP: 0018:ffff88809c8d7cf8 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff888000010000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff815cb3a6 RDI: ffffed101391af91
> RBP: ffff88809c8d7d30 R08: ffff88809c8e2080 R09: ffffed1015d06161
> R10: ffffed1015d06160 R11: ffff8880ae830b07 R12: ffff888000010000
> R13: 0000000000000001 R14: dffffc0000000000 R15: ffff888000000000
>   process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
>   worker_thread+0x98/0xe40 kernel/workqueue.c:2415
>   kthread+0x361/0x430 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000eed19705952fee5a%40google.com.
