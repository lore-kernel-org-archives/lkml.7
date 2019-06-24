Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23477C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B2E2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hBD3Z/tN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfFXJ2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:28:32 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46242 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfFXJ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:28:32 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so753735iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 02:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6DpP4P5H8yV1mb1kZ3rW1l+srfewAeWKH+iTqFQUwmM=;
        b=hBD3Z/tNYbZkAQC3D22H7riQ4gMrxvDvdzYGBgfkdV70wwCAzi+YAD95zVKUb6mU3k
         fHr140oU8mIwIzVHrADEjl5OSCIWd+jjJKJs/qMeAXAb28W7zA1MBBM438gLgzV+g599
         qNlrVVvAVGcc5RFWcwKZ7UbSr7XC3oO5dI6pZlDBZ3n2qvClh8yc2CO7Ffb4SAwWI/Dt
         CsZllwYZBVAcv3ixjGKcW2zO35DwefnBL9JtPgHSnvu3WWkj9nTLpfb/s4kzl/u2Ejs2
         c9e9kpg+85urAheXm+AWQE5xhQ3aS4iRS22IenNrefhSXlZ6jB7GW58/AWDEyiBLF/Gc
         JjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6DpP4P5H8yV1mb1kZ3rW1l+srfewAeWKH+iTqFQUwmM=;
        b=Z3z2PnwvLxqGI67PcOwda+7dWBHFH8m0pdpGRbZYTs700nrPf5dt/A9twhxfLc6XPh
         B7knvZBS/pjD/UaKLRkAczgZAjJnHhyotXuyM39Lr2rePLqI08pQx+IBa+ypSFrdk3OV
         rhrKugdhciv2OdKhEPizMzhlxowjyfkT/o3gqk6Ud552YlXxmV7MYQQkyvarzA9dOdar
         1aO+zcIm4NFVVnJBnUjBa/pDMPY9RY0vqpsTrLX0/C+cHc3X3twwegNiFOXkvtkAB9yW
         WKMGrV8xKSUjGf32iX+5XTuUGOfwuq7LnC+89cRejvArV8lSeSqNm5zaWhOVBfKk2N0U
         2W0Q==
X-Gm-Message-State: APjAAAVSBcel6l3dQNvIA4AvRhc4YXbEhNmJ6hWocdMtIVeGY92heGnb
        TOnMtMoA72WyHA+c25bKp4NN4UixwCpxZPNKC+ItVA==
X-Google-Smtp-Source: APXvYqzs/C+I2k5zMhYuS21PxyB//gPteWn4ghlZ9GUtazBEuBQQgRg27KAq+8zBBz+1X/mmrTeyh15XbD0fJhhRPPE=
X-Received: by 2002:a6b:fb0f:: with SMTP id h15mr36700690iog.266.1561368511114;
 Mon, 24 Jun 2019 02:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bb362d058b96d54d@google.com> <20190618140239.GA17978@ZenIV.linux.org.uk>
In-Reply-To: <20190618140239.GA17978@ZenIV.linux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Jun 2019 11:28:18 +0200
Message-ID: <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
Subject: Re: general protection fault in do_move_mount (2)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+6004acbaa1893ad013f0@syzkaller.appspotmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Hannes Reinecke <hare@suse.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 4:03 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Jun 18, 2019 at 03:47:10AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    9e0babf2 Linux 5.2-rc5
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=138b310aa00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d16883d6c7f0d717
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6004acbaa1893ad013f0
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154e8c2aa00000
>
> IDGI...
>
> mkdir(&(0x7f0000632000)='./file0\x00', 0x0)
> mount(0x0, 0x0, 0x0, 0x0, 0x0)
> syz_open_procfs(0x0, 0x0)
> r0 = open(&(0x7f0000032ff8)='./file0\x00', 0x0, 0x0)
> r1 = memfd_create(&(0x7f00000001c0)='\xb3', 0x0)
> write$FUSE_DIRENT(r1, &(0x7f0000000080)=ANY=[], 0x29)
> move_mount(r0, &(0x7f0000000040)='./file0\x00', 0xffffffffffffff9c, &(0x7f0000000100)='./file0\x00', 0x66)
>
> reads as if we'd done mkdir ./file0, opened it and then tried
> to feed move_mount(2) "./file0" relative to that descriptor.
> How the hell has that avoided an instant -ENOENT?  On the first
> pair, that is - the second one (AT_FDCWD, "./file0") is fine...
>
> Confused...  Incidentally, what the hell is
>         mount(0x0, 0x0, 0x0, 0x0, 0x0)
> about?  *IF* that really refers to mount(2) with
> such arguments, all you'll get is -EFAULT.  Way before
> it gets to actually doing anything - it won't get past
>         /* ... and get the mountpoint */
>         retval = user_path(dir_name, &path);
>         if (retval)
>                 return retval;
> in do_mount(2)...

Yes, mount(0x0, 0x0, 0x0, 0x0, 0x0) is mount with 0 arguments. Most
likely it returns EFAULT.
Since the reproducer have "threaded":true,"collide":true and no C
repro, most likely this is a subtle race. So it attempted to remove
mount(0x0, 0x0, 0x0, 0x0, 0x0) but it did not crash, so the conclusion
was that it's somehow needed. You can actually see that other
reproducers for this bug do not have this mount, but are otherwise
similar.

With "threaded":true,"collide":true the execution mode is not just
"execute each syscall once one after another".
The syscalls are executed in separate threads and actually twice. You
can see the approximate execution mode in this C program:
https://gist.githubusercontent.com/dvyukov/c3a52f012e7cff9bdebf3935d35245cf/raw/b5587824111a1d982c985b00137ae8609572335b/gistfile1.txt
Yet using the C program did not trigger the crash somehow (maybe just
slightly different timings).

Since syzkaller was able to reproduce it multiple times, it looks like
a real bug rather than an induced memory corruption or something.
