Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA0CC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29FC206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3qMn/Oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfGXIbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:31:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33649 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXIbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:31:00 -0400
Received: by mail-io1-f67.google.com with SMTP id z3so87863683iog.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AaokkSIB8T6rCvGVztgZrAXJru2rWZPyc4+sjVG3Rlg=;
        b=K3qMn/OeMIMWIjZ9ESuP3Mbr2IoaW+ya8WAVIZo7hVgWKsF0wYm4Zs/WY23VkHpiHz
         MSQiPrS0LExa2cu+qH0917BNNinG4hma4fEuEj+kdN5TQinrpXignDNCLsQpJmuweYbh
         6IjgBg1BHpDTKB+LYWKwCgHAUjwP1nkunkhPmtgtsZJILj1FNJZwZ4Xs63kGZRh+oba1
         xuteJ2KnBlW2GP2ukGM6O2WFyOVJpQTI+hdTREb3XE4i6W44X/jKWY0Om1te6XcY7d0b
         abTSzaWlVNvcp2hucBZx303o5SzyTNvW3qNcMo/BN4bTdm32VK9nUm2gLD3cp6/0DWM9
         iwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AaokkSIB8T6rCvGVztgZrAXJru2rWZPyc4+sjVG3Rlg=;
        b=eMs/4QIjKrcbvK+W2DXxo+i8uyic071DaOcCGOM3tzpAdtDzoSMLEzeEm2C4rCPYTN
         BNueREWSEh2Vg960nQtf3Yemq2vZTV5MOWz5oXcTt7J6auv/h2/wJMz1lt0OnNKM0fLO
         NQv5R8cJjexh6LOYLIR3OTfKSlw94sO/0XVoYipF10LzD6hax+EK2OfYfcV52h2T2Wfj
         WbUpwZYexuDAIii8VhA83qfLnxClpbRfpOfSUJPKWCp0j3VfrBFSxC5GYiwG1QA5YUhy
         4hNJ4WmHWmLWg3LBfZODoCZgZSALfgkWAgYDLVTlwW5nbnZMNIfQOzddrU+gCQUilLWz
         GLkQ==
X-Gm-Message-State: APjAAAVoJtdeQS4o4tI6XrlTSkrw/mdfUiFWwa7gaZfr/Ux439udAAb5
        L78945HukdXLZMAXVZ1u4mfUdmm3MxCAryKLLyOttg==
X-Google-Smtp-Source: APXvYqxSlDUBj64fQa2XUD/GFRZKvTb+/OT1nJmyxCu9j1MOu5lLRDAbNSt995Cq9Nvar/xA7x1tOCdXOH7MllC/CCs=
X-Received: by 2002:a6b:b556:: with SMTP id e83mr73258880iof.94.1563957059834;
 Wed, 24 Jul 2019 01:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001a51c4058ddcb1b6@google.com> <CACT4Y+ZGwKP+f4esJdx60AywO9b3Y5Bxb4zLtH6EEkaHpP6Zag@mail.gmail.com>
 <5d37433a832d_3aba2ae4f6ec05bc3a@john-XPS-13-9370.notmuch>
In-Reply-To: <5d37433a832d_3aba2ae4f6ec05bc3a@john-XPS-13-9370.notmuch>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 24 Jul 2019 10:30:48 +0200
Message-ID: <CACT4Y+ZbPmRB9T9ZzhE79VnKKD3+ieHeLpaDGRkcQ72nADKH_g@mail.gmail.com>
Subject: Re: kernel panic: stack is corrupted in pointer
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     syzbot <syzbot+79f5f028005a77ecb6bb@syzkaller.appspotmail.com>,
        bpf <bpf@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
        Alexei Starovoitov <ast@kernel.org>, christian.koenig@amd.com,
        Daniel Borkmann <daniel@iogearbox.net>, david1.zhou@amd.com,
        DRI <dri-devel@lists.freedesktop.org>, leo.liu@amd.com,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 7:26 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Dmitry Vyukov wrote:
> > On Wed, Jul 17, 2019 at 10:58 AM syzbot
> > <syzbot+79f5f028005a77ecb6bb@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    1438cde7 Add linux-next specific files for 20190716
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=13988058600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=79f5f028005a77ecb6bb
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111fc8afa00000
> >
> > From the repro it looks like the same bpf stack overflow bug. +John
> > We need to dup them onto some canonical report for this bug, or this
> > becomes unmanageable.
>
> Fixes in bpf tree should fix this. Hopefully, we will squash this once fixes
> percolate up.
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Cool! What is the fix?
We don't need to wait for the fix to percolate up (and then down
too!). syzbot gracefully handles when a patch is not yet present
everywhere (it happens all the time).

Btw, this was due to a stack overflow, right? Or something else?
We are trying to make KASAN configuration detect stack overflows too,
so that it does not cause havoc next time. But it turns out to be
non-trivial and our current attempt seems to fail:
https://groups.google.com/forum/#!topic/kasan-dev/IhYv7QYhLfY


> > #syz dup: kernel panic: corrupted stack end in dput
> >
> > > The bug was bisected to:
> > >
> > > commit 96a5d8d4915f3e241ebb48d5decdd110ab9c7dcf
> > > Author: Leo Liu <leo.liu@amd.com>
> > > Date:   Fri Jul 13 15:26:28 2018 +0000
> > >
> > >      drm/amdgpu: Make sure IB tests flushed after IP resume
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a46200600000
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=16a46200600000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=12a46200600000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+79f5f028005a77ecb6bb@syzkaller.appspotmail.com
> > > Fixes: 96a5d8d4915f ("drm/amdgpu: Make sure IB tests flushed after IP
> > > resume")
> > >
> > > Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in:
> > > pointer+0x702/0x750 lib/vsprintf.c:2187
> > > Shutting down cpus with NMI
> > > Kernel Offset: disabled
> > >
> > >
> > > ---
> > > This bug is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this bug report. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > > syzbot can test patches for this bug, for details see:
> > > https://goo.gl/tpsmEJ#testing-patches
>
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/5d37433a832d_3aba2ae4f6ec05bc3a%40john-XPS-13-9370.notmuch.
