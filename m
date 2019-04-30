Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69E2C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05A120835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNZiJIi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfD3POl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:14:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41684 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3POl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:14:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so6975536pgs.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 08:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d8dn/0dTKiykpcgtb/y9QsyEoWiQzsibeWC7CLJMvwc=;
        b=NNZiJIi2WT1N0507K72evR/BwmrEwAGuAarbetxNWBhkR9dS73mA51rISAyU5CMJnx
         xOZtroOnkEue6rrtt4jkSD1X54vzGc/BQWyOZwJweYHq+6hD7AKb2SrYdFKVvnLLwwJU
         MnMM/EecZ9vKnJaVgVjNGb9WRoOXQwC+hX1vi5bTQg+CcVcxayzzHBN8FqbU2lW8ChsR
         OSF1uouxhbqtiZjQq4d+Jzg8B/Lpw3vOKqSrI21L6gHA4wpC47FJ+KTAAoNF8tpixhOa
         tgP2/gN3dYrC5R1xvbk8r6qJqSzC7jqqUxEXXymcLJGlXFEQO7SWie46y980eZeayUSo
         /vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8dn/0dTKiykpcgtb/y9QsyEoWiQzsibeWC7CLJMvwc=;
        b=Tq+bs3ux4OsQdImLQRcak02/m2m1xMf7rn8TOyby6q5JlHu7bwCSKP+wojDPYcztnx
         iQ4M/mz+19xjEfCdDNWzi/r1alCv+ICdKenOMlgR05Thn0BT4689wX1hLus+GWNBkMmy
         Z9XaR3jgwJ4D1CsSBd+n9J9EcCcOzBWQAEpSTZKAzjrepM3UYQcqVA1AmZerWB5KNSc5
         kSeVAN3/GZCQbWZws3tvM4eN8/ETx+l+FvlQdB4GT8zHDhMruO5TPkzDsldpplCVD35X
         lz/V901xTol8nyBf2SPldHeHK+U3yWO9bKw0XoLAqk4kO4cmYUbdxBDjG2Tq3ygs//0+
         DVnQ==
X-Gm-Message-State: APjAAAUEAvvXsCdWLsYPPA3JMdqunb9w7UAY+wnmyslo/B9lmX7yExOY
        zyYth4/0BoLOOrmwFrwgYOjO+txbDOOuw+2VBJ6ebg==
X-Google-Smtp-Source: APXvYqyvAA3eJRPNypOhfXPzlmZ04818wxauB/jQRH57quac32ODx5CTPaelKgpLLLI28p0EZrCHsD2dpQjnLdwCCSA=
X-Received: by 2002:a65:628b:: with SMTP id f11mr1068488pgv.95.1556637280087;
 Tue, 30 Apr 2019 08:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004101370587c052fb@google.com> <Pine.LNX.4.44L0.1904301058150.1465-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1904301058150.1465-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 30 Apr 2019 17:14:28 +0200
Message-ID: <CAAeHK+zYQ0QF_vo+iYns2d0O7RZ=Uq0kxi1mWc1W_0bBxMGR0A@mail.gmail.com>
Subject: Re: WARNING: Support for this device (Terratec Grabster AV400) is experimental.
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+af8f8d2ac0d39b0ed3a0@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 5:00 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, 30 Apr 2019, syzbot wrote:
>
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=141ca62d200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
> > dashboard link: https://syzkaller.appspot.com/bug?extid=af8f8d2ac0d39b0ed3a0
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1405bedd200000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ce3bbb200000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+af8f8d2ac0d39b0ed3a0@syzkaller.appspotmail.com
> >
> > usb 1-1: New USB device found, idVendor=0ccd, idProduct=0039, bcdDevice=
> > d.3c
> > usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> > usb 1-1: config 0 descriptor??
> > pvrusb2: Hardware description: Terratec Grabster AV400
> > pvrusb2: **********
> > pvrusb2: WARNING: Support for this device (Terratec Grabster AV400) is
> > experimental.
> > pvrusb2: Important functionality might not be entirely working.
> > pvrusb2: Please consider contacting the driver author to help with further
> > stabilization of the driver.
> > pvrusb2: **********
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> This does seem like a bug in syzbot.  Why does it think this pr_info()
> output indicates a crash?  Is it fooled by the capitalized "WARNING" at
> the start of one of the lines?

Well, as of [1] WARN*() should only be used to indicate a kernel bug.
Normally, WARN*() prints a line that start with a warning, which is
followed by a stack trace. Unfortunately the stack trace is not always
present (kernel memory is badly corrupted, console deadlocked, etc.),
so syzbot detects the "WARNING:" line as a beginning of a WARN*()
reported bug. In this case the driver does something like
`pr_info("WARNING: ...", ...)`, which confuses syzbot. I'd say it's
the kernel that needs to be changed here to use some other kind of
prefix for printing warning messages.

[1] https://github.com/torvalds/linux/commit/96c6a32ccb55a366054fd82cc63523bb7f7493d3
