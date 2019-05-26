Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8445DC282E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 06:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E537206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 06:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fkkRsj7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfEZGkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 02:40:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39001 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfEZGkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 02:40:04 -0400
Received: by mail-io1-f65.google.com with SMTP id r185so5992359iod.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 23:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mac88AXIZVYEge7FmGHAzepQi9wUqNvqvrSB29BmdjQ=;
        b=fkkRsj7VabbXTAJZL4y6jgyxjsVy0dhj2Us0DhIy0PX0ZFbsEo2dzmPlbdYSsHDTN6
         Fqebs+PA9BFe1dqEIyt2tihBOIKFI+tNFU1BpaGDEYFfZIvKvX5lzypgOqqlbUjm8hMw
         QaeNxtuYzhIqErrPD2vWPulBffY/8bMj8751DDg0jQ1IYyRgedMcXD0LUm85HqF4sVDH
         v5tRvpVdzmJpMbHXxP+IQTocSnC9J6oD3u/K3va2KLOi1fu/aaWDuRB89tgdO1XbIRsW
         09+XppCljPnQk5xBmVE+uxTi1cM7rM6svXhkftra/4lLhSrRD6sIZv1SeJaKLfmJ4FTn
         NJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mac88AXIZVYEge7FmGHAzepQi9wUqNvqvrSB29BmdjQ=;
        b=FNJY7bJPD1alvz9D9i+Skj5ApooNOi/GKMqbjJQ8k0kod5J7aciw68MsAauQKPHQRT
         jvStYC9B1S8bGk3rrMyQOIfeyP5rPAV8f9BF+SQ8whYeQOMXQJ0DHA83pjTTTgsmQnpf
         X8q/O43eC0JM7EwWYbj65RyffVK9rxp0nwJ6RQVETqKucnwzvPIATsV/NSQW4bi2118C
         DoMIYPDRxLt1Ke3dvmqnfqfyINCGLEw7j4hHmIq7FtSe+MpV4GFRUik3uLvCRH9MeIUK
         1xhkX22jS5H1txVJAg9TSjsxlxfZxtKReb7pJ0cLwTa4P4Mg+Qk8NkiBcBNTOJ6kWAsv
         EOmg==
X-Gm-Message-State: APjAAAVn0M8dp+14n7BJPOqJ0BWrH9UCWM8yAr1WkNq3mHGgdNRftEa0
        PRoyeARW9OkWa8eNGOAeHUrZWHNwDkAjqW8Qnqtj0g==
X-Google-Smtp-Source: APXvYqwr+Pbfv9HVtVvN4paEdgzLh64zq2Bz4HBoqNNJWROVH+MXUxZ6H6H9tss02/3v7gqNHGb16hV+0Ctqt0bTtCg=
X-Received: by 2002:a6b:6006:: with SMTP id r6mr2046417iog.231.1558852802751;
 Sat, 25 May 2019 23:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000016cb560589b9c7c4@google.com>
In-Reply-To: <00000000000016cb560589b9c7c4@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 26 May 2019 08:39:50 +0200
Message-ID: <CACT4Y+Yi=hLvp7MfAnZ2YbGE=pTmqNHFZ0kZ=y7uuUYALnnUbg@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in class_equal
To:     syzbot <syzbot+3d04999521633dceb439@syzkaller.appspotmail.com>,
        bpf <bpf@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 7:38 PM syzbot
<syzbot+3d04999521633dceb439@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    af5136f9 selftests/net: SO_TXTIME with ETF and FQ
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13164ee4a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fc045131472947d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=3d04999521633dceb439
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1661b6e4a00000

Looking at the reproducer, it may be bpf-related. +bpf mailing list.


> Bisection is inconclusive: the first bad commit could be any of:
>
> 7c00e8ae Merge tag 'armsoc-soc' of
> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
> a2b7ab45 Merge tag 'linux-watchdog-4.18-rc1' of
> git://www.linux-watchdog.org/linux-watchdog
> 721afaa2 Merge tag 'armsoc-dt' of
> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1062daaaa00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3d04999521633dceb439@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in class_equal+0x40/0x50
> kernel/locking/lockdep.c:1527
> Read of size 8 at addr ffff8880813cdab0 by task syz-executor.0/9147
>
> CPU: 0 PID: 9147 Comm: syz-executor.0 Not tainted 5.2.0-rc1+ #6
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>
> Allocated by task 2266519551:
> ------------[ cut here ]------------
> kernel BUG at mm/slab.c:4178!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 9147 Comm: syz-executor.0 Not tainted 5.2.0-rc1+ #6
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__check_heap_object+0xa5/0xb3 mm/slab.c:4178
> Code: 2b 48 c7 c7 4d fc 61 88 e8 28 ad 07 00 5d c3 41 8b 91 04 01 00 00 48
> 29 c7 48 39 d7 77 bd 48 01 d0 48 29 c8 4c 39 c0 72 b2 c3 <0f> 0b 48 c7 c7
> 4d fc 61 88 e8 3c b2 07 00 44 89 e1 48 c7 c7 08 fd
> RSP: 0018:ffff8880813cd370 EFLAGS: 00010046
> RAX: 0000000000000001 RBX: 0000000000000001 RCX: 000000000000000c
> RDX: ffff8880813cc340 RSI: 0000000000000000 RDI: ffff8880813cd468
> RBP: ffff8880813cd3c0 R08: 0000000000000001 R09: ffff8880aa594c40
> R10: 0000000000000f23 R11: 0000000000000000 R12: ffff8880813cd468
> R13: ffffea000204f300 R14: ffff8880813cd469 R15: 0000000000000001
> FS:  00005555564e1940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffff8c046bd8 CR3: 000000009a952000 CR4: 00000000001406f0
> Call Trace:
> Modules linked in:
> ---[ end trace e78aeeb619bc791b ]---
> RIP: 0010:__check_heap_object+0xa5/0xb3 mm/slab.c:4178
> Code: 2b 48 c7 c7 4d fc 61 88 e8 28 ad 07 00 5d c3 41 8b 91 04 01 00 00 48
> 29 c7 48 39 d7 77 bd 48 01 d0 48 29 c8 4c 39 c0 72 b2 c3 <0f> 0b 48 c7 c7
> 4d fc 61 88 e8 3c b2 07 00 44 89 e1 48 c7 c7 08 fd
> RSP: 0018:ffff8880813cd370 EFLAGS: 00010046
> RAX: 0000000000000001 RBX: 0000000000000001 RCX: 000000000000000c
> RDX: ffff8880813cc340 RSI: 0000000000000000 RDI: ffff8880813cd468
> RBP: ffff8880813cd3c0 R08: 0000000000000001 R09: ffff8880aa594c40
> R10: 0000000000000f23 R11: 0000000000000000 R12: ffff8880813cd468
> R13: ffffea000204f300 R14: ffff8880813cd469 R15: 0000000000000001
> FS:  00005555564e1940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffff8c046bd8 CR3: 000000009a952000 CR4: 00000000001406f0
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000016cb560589b9c7c4%40google.com.
> For more options, visit https://groups.google.com/d/optout.
