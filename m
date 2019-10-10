Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F09C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8716206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gC9z/NCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfJJPg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:36:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42343 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJPg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:36:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so2964025pls.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 08:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+dHQ/Ya1glhI7Tow9GaPcAMPe0U4mqByUZ2lLkCSL/s=;
        b=gC9z/NCCunFF7N4yTQOPCCEC53abai2S/DpgzRFGlIWs7/Z18eQJ+NVXFOTs3rQDYd
         oz/l22tKQCfLlxlKps83vV4V1VPmBcHNPZZhc+pKYrRvpdozZTg++MJKPnyVFPnIjNXd
         kiLVt+NORfFg0kpykdQONAdxYwzsSNM5N8/flc6dmUON/DRObImD8pZG+xNrZrc86KoJ
         1cdOLu81n4FJDXvsHA5PMeVXI//ZHpkEVKXee7+hJT7Ws+OXrmCmsqXvkf1WCIQNDExT
         NsWGEJdMbQwebLCMbJiK3yyYWuzlE5TFCvK55ylcAifcEMtbfpHUxRMw9+PyGdRkgXY+
         dayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+dHQ/Ya1glhI7Tow9GaPcAMPe0U4mqByUZ2lLkCSL/s=;
        b=DTi6j0CTt+h1PVTpE+M0TbknjPfORLm/lEcX5bZ5i26NepObsk3oNUSJ76f1pRRmtO
         IhdcYYfibixupjEqd1yfOKQfertBxwVZpWwkCY6rxu2VX9ZC5vbMIGjXWQIp6XDRWt2k
         WSXo6qt1TKD62ETbt82mvQ2Bw+qq7LRZ19Q1uc+bWP4NVF3MXvsZghQADeESfQ/8rzcu
         9Z23NIj0SPEy4uM1UnMcQm5toNx9A9h73ILBsalbfOV8iYDEXlQjLWH+oDwh8OlNEq1g
         irS+v6hNB9BLqb2FnwfdtCC9d3+IDC8dBShMAiMbJquGLCR36gIku1gRrJgR8MtN/o/w
         rckQ==
X-Gm-Message-State: APjAAAV78J1lY+TnRni5SKHyaunUeb4ctJPbagD2pKdDrrJ7n3L/Z1/z
        Boaa+EZX/SIK+8yyUqrjooVqYoNx7Ks0lqxTSlMyTw==
X-Google-Smtp-Source: APXvYqx4bNmD+wqtCzmiwsqz2z098cxnBXmODxWznLGRj5L3YRdXzSQVNiepcatCKEUXSXhqRTpDBAd+g2t37x17B84=
X-Received: by 2002:a17:902:9002:: with SMTP id a2mr10334888plp.147.1570721784614;
 Thu, 10 Oct 2019 08:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001c3ae905947c81bd@google.com>
In-Reply-To: <0000000000001c3ae905947c81bd@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 10 Oct 2019 17:36:13 +0200
Message-ID: <CAAeHK+w4_Oje+MD7A5PRxbcffeft2U4Xk67F+WqizVPN+gj-og@mail.gmail.com>
Subject: Re: BUG: bad usercopy in read_rio
To:     syzbot <syzbot+43e923a8937c203e9954@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Qian Cai <cai@lca.pw>,
        info@metux.net, isaacm@codeaurora.org,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        william.kucharski@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 6:09 PM syzbot
<syzbot+43e923a8937c203e9954@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    58d5f26a usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=149329b3600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=aa5dac3cda4ffd58
> dashboard link: https://syzkaller.appspot.com/bug?extid=43e923a8937c203e9954
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+43e923a8937c203e9954@syzkaller.appspotmail.com
>
> usb 3-1: Rio opened.
> usercopy: Kernel memory exposure attempt detected from wrapped address
> (offset 0, size 18446612689754797056)!
> ------------[ cut here ]------------
> kernel BUG at mm/usercopy.c:99!
> invalid opcode: 0000 [#1] SMP KASAN
> CPU: 0 PID: 12744 Comm: syz-executor.2 Not tainted 5.4.0-rc1+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:usercopy_abort+0xb9/0xbb mm/usercopy.c:99
> Code: e8 42 55 d6 ff 49 89 d9 4d 89 e8 4c 89 e1 41 56 48 89 ee 48 c7 c7 00
> d8 cd 85 ff 74 24 08 41 57 48 8b 54 24 20 e8 b6 e6 c0 ff <0f> 0b e8 16 55
> d6 ff e8 11 8c fd ff 8b 54 24 04 49 89 d8 4c 89 e1
> RSP: 0018:ffff8881cf06fc60 EFLAGS: 00010282
> RAX: 000000000000006d RBX: ffffffff85cdd520 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8128bf9d RDI: ffffed1039e0df7e
> RBP: ffffffff85cdd6e0 R08: 000000000000006d R09: ffffed103b645d58
> R10: ffffed103b645d57 R11: ffff8881db22eabf R12: ffffffff85cdd880
> R13: ffffffff85cdd520 R14: ffff8881ca0c3400 R15: ffffffff85cdd520
> FS:  00007f3de63a2700(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f3de633edb8 CR3: 00000001c9e27000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   check_bogus_address mm/usercopy.c:152 [inline]
>   __check_object_size mm/usercopy.c:266 [inline]
>   __check_object_size.cold+0xb2/0xbb mm/usercopy.c:256
>   check_object_size include/linux/thread_info.h:119 [inline]
>   check_copy_size include/linux/thread_info.h:150 [inline]
>   copy_to_user include/linux/uaccess.h:151 [inline]
>   read_rio+0x223/0x47c drivers/usb/misc/rio500.c:423
>   __vfs_read+0x76/0x100 fs/read_write.c:425
>   vfs_read+0x1ea/0x430 fs/read_write.c:461
>   ksys_read+0x127/0x250 fs/read_write.c:587
>   do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x459a59
> Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f3de63a1c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459a59
> RDX: 00000000000000da RSI: 0000000020000140 RDI: 0000000000000004
> RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3de63a26d4
> R13: 00000000004c70d5 R14: 00000000004dc948 R15: 00000000ffffffff
> Modules linked in:
> ---[ end trace 5c4a17213aed3a20 ]---
> RIP: 0010:usercopy_abort+0xb9/0xbb mm/usercopy.c:99
> Code: e8 42 55 d6 ff 49 89 d9 4d 89 e8 4c 89 e1 41 56 48 89 ee 48 c7 c7 00
> d8 cd 85 ff 74 24 08 41 57 48 8b 54 24 20 e8 b6 e6 c0 ff <0f> 0b e8 16 55
> d6 ff e8 11 8c fd ff 8b 54 24 04 49 89 d8 4c 89 e1
> RSP: 0018:ffff8881cf06fc60 EFLAGS: 00010282
> RAX: 000000000000006d RBX: ffffffff85cdd520 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8128bf9d RDI: ffffed1039e0df7e
> RBP: ffffffff85cdd6e0 R08: 000000000000006d R09: ffffed103b645d58
> R10: ffffed103b645d57 R11: ffff8881db22eabf R12: ffffffff85cdd880
> R13: ffffffff85cdd520 R14: ffff8881ca0c3400 R15: ffffffff85cdd520
> FS:  00007f3de63a2700(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f3de633edb8 CR3: 00000001c9e27000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

#syz fix: USB: rio500: Remove Rio 500 kernel driver
