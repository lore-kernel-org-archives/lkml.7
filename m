Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BA3C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 08:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C935920833
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 08:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WbdOU1MJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfK3IB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 03:01:27 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36860 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfK3IB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 03:01:27 -0500
Received: by mail-qk1-f194.google.com with SMTP id v19so8012332qkv.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 00:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xopoO7QTmMqAl137aSAIMPCPz+JISOQuaoX9y1SYgzs=;
        b=WbdOU1MJ8FOMdNtyb910nMwqZcOs9Fp/EUo/ZJ7vcpKHggvBIl5ymCWuD4Cj4RXgNX
         EgDaIhxn4os6zH72DqkQGt5inmpp8D28Lr2qdEXtVUxnh+27f6xMssihH8wyifmgRlp+
         whvd4e3OL6l0uG4naTPRZuVdjtFecWiCDtcR+e0MrwyzG5qhO2FCAONZia/WQT0nQD2l
         4gqZdRbN2ZjHAT/vrmw/8ykf0B981djTCaZtuIFuxjXy3noKqAR7UDCi10NSNlQMg7xx
         wnGW9zGdbolac+fEnZyL4F1ThnIPtALHazaeh/K1vqpNPfS8b3u9wM6KA7rNsa9/K97c
         XrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xopoO7QTmMqAl137aSAIMPCPz+JISOQuaoX9y1SYgzs=;
        b=ZPC3Pa2yMD7WydzQqp4n8VzfTQj1/xtlTbHCmcNeHf8N6Ns/+moVGkMK2JWbtvsiwS
         olu94JC6ZWdM6hVlsCK/xYvEi06pUL5yF5U74rHIaNFtkXsVRxexxFBLD1woVPLitg+V
         Qz5LtxWnl1mwRoKZuQyTaC3LeH37RL8t3BhiJyGvPe1BAuv7FhwpL9eJ7pUn1j/2jy/D
         +0bebNQjDoHhIy5JV/8W+KRPQpcIDJD4EcTT+aWIMOcdm4g2Rs8IB6Jv/RJ0lHCEM0yT
         7jVvcDMSpmlmzcwMVh6CGgiZQ9bfA66YQnUV1TZ0fy/yH1rqqV/Yqs9Xcfa2ZWOtvud3
         0ceQ==
X-Gm-Message-State: APjAAAXE5VaRQF0QtgjmCzos689WkQgok7L8diGB7PAeVbSi6azzLiUD
        jgHScSYt2kSIPFZY7C9JqDtmJXBKxQThTpaute1pLw==
X-Google-Smtp-Source: APXvYqwtA6svBwaL5lgo1c6jik89HUgULfo09BRKK+HEsmPPfoh5GzA+/3fjTNmztHHpQPnLhYpROE2+71j+t9egTF8=
X-Received: by 2002:a37:4782:: with SMTP id u124mr12295484qka.8.1575100885769;
 Sat, 30 Nov 2019 00:01:25 -0800 (PST)
MIME-Version: 1.0
References: <00000000000080f1d305988bb8ba@google.com>
In-Reply-To: <00000000000080f1d305988bb8ba@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 30 Nov 2019 09:01:14 +0100
Message-ID: <CACT4Y+ZFZxXDOEC3=wP8ZAcVoOjCZsvX07vvRP8yrTofg8sh_Q@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in ion_heap_clear_pages
To:     syzbot <syzbot+be6ccf3081ce8afd1b56@syzkaller.appspotmail.com>,
        Daniel Axtens <dja@axtens.net>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Laura Abbott <labbott@redhat.com>,
        linaro-mm-sig@lists.linaro.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2019 at 8:59 AM syzbot
<syzbot+be6ccf3081ce8afd1b56@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    419593da Add linux-next specific files for 20191129
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12bfd882e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7c04b0959e75c206
> dashboard link: https://syzkaller.appspot.com/bug?extid=be6ccf3081ce8afd1b56
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+be6ccf3081ce8afd1b56@syzkaller.appspotmail.com

+Daniel, kasan-dev
This is presumably from the new CONFIG_KASAN_VMALLOC and should be:
#syz fix: kasan: support vmalloc backing of vm_map_ram()


> BUG: unable to handle page fault for address: fffff52002e00000
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 21ffee067 P4D 21ffee067 PUD aa11c067 PMD 0
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 3644 Comm: ion_system_heap Not tainted
> 5.4.0-next-20191129-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:memory_is_nonzero mm/kasan/generic.c:121 [inline]
> RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:135 [inline]
> RIP: 0010:memory_is_poisoned mm/kasan/generic.c:166 [inline]
> RIP: 0010:check_memory_region_inline mm/kasan/generic.c:182 [inline]
> RIP: 0010:check_memory_region+0x9c/0x1a0 mm/kasan/generic.c:192
> Code: c9 4d 0f 49 c1 49 c1 f8 03 45 85 c0 0f 84 10 01 00 00 41 83 e8 01 4e
> 8d 44 c0 08 eb 0d 48 83 c0 08 4c 39 c0 0f 84 a7 00 00 00 <48> 83 38 00 74
> ed 4c 8d 40 08 eb 09 48 83 c0 01 49 39 c0 74 53 80
> RSP: 0018:ffffc9000c9f7ab8 EFLAGS: 00010212
> RAX: fffff52002e00000 RBX: fffff52002e01600 RCX: ffffffff85d5c229
> RDX: 0000000000000001 RSI: 000000000000b000 RDI: ffffc90017000000
> RBP: ffffc9000c9f7ad0 R08: fffff52002e01600 R09: 0000000000001600
> R10: fffff52002e015ff R11: ffffc9001700afff R12: fffff52002e00000
> R13: 000000000000b000 R14: 0000000000000000 R15: ffffc9000c9f7d08
> FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffff52002e00000 CR3: 00000000778bd000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   memset+0x24/0x40 mm/kasan/common.c:107
>   memset include/linux/string.h:410 [inline]
>   ion_heap_clear_pages+0x49/0x70 drivers/staging/android/ion/ion_heap.c:106
>   ion_heap_sglist_zero+0x245/0x270 drivers/staging/android/ion/ion_heap.c:130
>   ion_heap_buffer_zero+0xf5/0x150 drivers/staging/android/ion/ion_heap.c:145
>   ion_system_heap_free+0x1eb/0x250
> drivers/staging/android/ion/ion_system_heap.c:163
>   ion_buffer_destroy+0x159/0x2d0 drivers/staging/android/ion/ion.c:93
>   ion_heap_deferred_free+0x29d/0x630
> drivers/staging/android/ion/ion_heap.c:239
>   kthread+0x361/0x430 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> Modules linked in:
> CR2: fffff52002e00000
> ---[ end trace ee5c63907f1d6f00 ]---
> RIP: 0010:memory_is_nonzero mm/kasan/generic.c:121 [inline]
> RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:135 [inline]
> RIP: 0010:memory_is_poisoned mm/kasan/generic.c:166 [inline]
> RIP: 0010:check_memory_region_inline mm/kasan/generic.c:182 [inline]
> RIP: 0010:check_memory_region+0x9c/0x1a0 mm/kasan/generic.c:192
> Code: c9 4d 0f 49 c1 49 c1 f8 03 45 85 c0 0f 84 10 01 00 00 41 83 e8 01 4e
> 8d 44 c0 08 eb 0d 48 83 c0 08 4c 39 c0 0f 84 a7 00 00 00 <48> 83 38 00 74
> ed 4c 8d 40 08 eb 09 48 83 c0 01 49 39 c0 74 53 80
> RSP: 0018:ffffc9000c9f7ab8 EFLAGS: 00010212
> RAX: fffff52002e00000 RBX: fffff52002e01600 RCX: ffffffff85d5c229
> RDX: 0000000000000001 RSI: 000000000000b000 RDI: ffffc90017000000
> RBP: ffffc9000c9f7ad0 R08: fffff52002e01600 R09: 0000000000001600
> R10: fffff52002e015ff R11: ffffc9001700afff R12: fffff52002e00000
> R13: 000000000000b000 R14: 0000000000000000 R15: ffffc9000c9f7d08
> FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffff52002e00000 CR3: 00000000778bd000 CR4: 00000000001406f0
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
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000080f1d305988bb8ba%40google.com.
