Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661FEC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C2E214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PzA2VQsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfFSS6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:58:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36066 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSS6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:58:01 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so14311ioh.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XJdb/lVfbtfXiEjreTu1uEKBsL/x987CWFxEJNc1reM=;
        b=PzA2VQslHqTpTK/yrooQb5dubV00UqUxhsaLXfJbWWOprZJ4T13OxZ62666+8sRErZ
         iZIO5vNsUQLZOllSFo11v7RfK+SwXwtGISW8lNNsqIbvHZl/N1zVCufz483uPR8fc8c6
         Xse3SNO3LEvBwpmwKLf0BNHMzPCmtgfHpLmI9vzYsBvkBxLLmpdjUqy+pFDRRRPlpVs9
         twP2cTVAABBthEJUOr483gT36o4vCvw8wPIxzJm5tHBwFO+Q7m84soyqq6X/ukK0qSON
         cyvWOO0hLvVG+JQKctOUx5daZKNSE6stKiBTCy3jWVxyHOAKkJhd+SpAbKEGps9KedGC
         dUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XJdb/lVfbtfXiEjreTu1uEKBsL/x987CWFxEJNc1reM=;
        b=mUmToiyOz2Lt3rw9lh5pth54RJfd3BAoIzpTOBlycr5JEVOnGm6xk9jeUJefFkytMM
         wU72WU8pNWDoeio7RR9Rspsuiy2qrKSEma0sT6TKobldnlL82E2Aw7HejojpFlcExt/7
         nVrDe4eN6vXppJwHbSJZ7p/8plZ6rug5lD+ka+pDurXIbQWH+PcbjjRcYzAhbpqSTYyM
         PLpwN7vuYgWAitz/OxO8MBoaj+qdx49101GIfa0fWFtM9KlPml8yIvVNNagOs+/iRAjZ
         649OH00Ogv7tJPDxgTUF/36kw7/cLs9I8qBHcx8n0YZqDFWrbBy6Lj+C/ZFyM26Z6Cl/
         yk4g==
X-Gm-Message-State: APjAAAWtBJLf/K7NIt5I3N4v3Wg9CamDafgz6YdxFMHQBg+vM9hZKtGi
        RvwqYbPsO4N3JQXuqfJWfP3czWXCKwG9mrG8aVqyLw==
X-Google-Smtp-Source: APXvYqxCJnwm2yKlOywLCJTfIbxN2wDW69hqz/fGxfknmnuqbHNleaEdSbJhKharc5aNmMSg+35m5KMd37kPyEd5SW8=
X-Received: by 2002:a6b:4101:: with SMTP id n1mr2855343ioa.138.1560970679336;
 Wed, 19 Jun 2019 11:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001c03bf058baf488a@google.com>
In-Reply-To: <0000000000001c03bf058baf488a@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 19 Jun 2019 20:57:45 +0200
Message-ID: <CACT4Y+ZarLOBUUAnp7AMRuicCpOTc-t89wE3G4HNCzRO82w0jQ@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in hrtimer_interrupt
To:     syzbot <syzbot+037e18398ba8c655a652@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 5:57 PM syzbot
<syzbot+037e18398ba8c655a652@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    29f785ff Merge branch 'fixes' of git://git.kernel.org/pub/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10539ceaa00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e5c77f8090a3b96b
> dashboard link: https://syzkaller.appspot.com/bug?extid=037e18398ba8c655a652
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16da8cc9a00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+037e18398ba8c655a652@syzkaller.appspotmail.com

The same bpf plague bug...
+bpf mailing list

> kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> BUG: unable to handle page fault for address: ffff88807a92fb10
> #PF: supervisor instruction fetch in kernel mode
> #PF: error_code(0x0011) - permissions violation
> PGD b401067 P4D b401067 PUD 80000000400001e3
> Thread overran stack, or stack corrupted
> Oops: 0011 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 9205 Comm: syz-executor.0 Not tainted 5.2.0-rc5+ #2
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:0xffff88807a92fb10
> Code: ff ff 15 b8 0d 86 ff ff ff ff 00 b5 0d 86 ff ff ff ff 40 8c f0 89 80
> 88 ff ff 00 00 00 00 00 00 00 00 a0 a9 1d 8b ff ff ff ff <40> fb 92 7a 80
> 88 ff ff 15 b8 0d 86 ff ff ff ff 00 b5 0d 86 ff ff
> RSP: 0018:ffff8880ae909e10 EFLAGS: 00010006
> RAX: ffff88807a92fb10 RBX: 0000000000000000 RCX: ffffffff816162e2
> RDX: 0000000000010000 RSI: ffffffff81615cdf RDI: ffff88807a92fab8
> RBP: ffff8880ae909f08 R08: ffff888092914180 R09: ffffed1015d26c70
> R10: ffffed1015d26c6f R11: ffff8880ae93637b R12: ffff8880ae926d80
> R13: ffffffff8b1da9a0 R14: ffff88807a92fab8 R15: dffffc0000000000
> FS:  0000555557401940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff88807a92fb10 CR3: 000000009016a000 CR4: 00000000001406e0
> Call Trace:
>   <IRQ>
>   hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
>   smp_apic_timer_interrupt+0x111/0x550 arch/x86/kernel/apic/apic.c:1066
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:806
>   </IRQ>
> Modules linked in:
> CR2: ffff88807a92fb10
> ---[ end trace f7934f1b1fe3f476 ]---
> RIP: 0010:0xffff88807a92fb10
> Code: ff ff 15 b8 0d 86 ff ff ff ff 00 b5 0d 86 ff ff ff ff 40 8c f0 89 80
> 88 ff ff 00 00 00 00 00 00 00 00 a0 a9 1d 8b ff ff ff ff <40> fb 92 7a 80
> 88 ff ff 15 b8 0d 86 ff ff ff ff 00 b5 0d 86 ff ff
> RSP: 0018:ffff8880ae909e10 EFLAGS: 00010006
> RAX: ffff88807a92fb10 RBX: 0000000000000000 RCX: ffffffff816162e2
> RDX: 0000000000010000 RSI: ffffffff81615cdf RDI: ffff88807a92fab8
> RBP: ffff8880ae909f08 R08: ffff888092914180 R09: ffffed1015d26c70
> R10: ffffed1015d26c6f R11: ffff8880ae93637b R12: ffff8880ae926d80
> R13: ffffffff8b1da9a0 R14: ffff88807a92fab8 R15: dffffc0000000000
> FS:  0000555557401940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff88807a92fb10 CR3: 000000009016a000 CR4: 00000000001406e0
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000001c03bf058baf488a%40google.com.
> For more options, visit https://groups.google.com/d/optout.
