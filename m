Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C947C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E6E20652
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uvr7eYDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfEBQKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:10:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46716 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfEBQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:10:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi2so1227839plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tL3Pud+YJBNQiO93dRarRa44+urFtai9+XXdaXC1EX8=;
        b=Uvr7eYDD/u9aWB5XeiFkGkmMbcelulOeVmqQHiPNC2nzMhwcnYR4+lUYoOpWkPOzDk
         WdZFHHq+gptNhRKAm3jIP7r3Rt8dM+1ScsteT2tAHKYQLm397E4YNxFFXHB1tJ17Pr71
         cQJl7nL0hUVEwvelRott1dHL/TNQY+gaIQTShEzmXgZIrNQcl4zpwNuV4CAg+K1GAyYL
         zQceMqLx64TWFVEi5oLoIskYJvElCbKVOTSeW6vLbtpbmyAbGVjRK4GmKFsAZ2zj0QqV
         VLjwgBaIqgxKv4iGzBpB9wnRFhq/2LGGx+otORB2k0+HN1RXbikKMPQMIzxT+Dx329Zy
         3HnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tL3Pud+YJBNQiO93dRarRa44+urFtai9+XXdaXC1EX8=;
        b=tu0sdbf63nCT3Cq4EZLFLaPl4Oppgibl0jabPkJI5oVN3ZN/Kh4oIY2gxgHdcaAsI4
         NoBd2iUQJ55HUt5k7WMyFHj6Ft7MQ8DHthi/66DSWq8mkvK2+cp9VN4LmyHPlaAHZGnM
         Ax0De6SseCVIl/1XWKV9XeHbtweegf5NGoiL5GDBG2cJMBhDHBmcEVIqTEbXD2tTPDNs
         QYYEhajC3jB5cCkQTz/KJvrBhht/RPT3T3JAqZ//m3MBCKGZNmMiJD/aLmmoZcR4HHqQ
         hIUUifItMDr+NjXhyqQUDj8iRIJ6apHacyguCVwpYDMVBN4dZcIPf4hO1ylXPtwK9Lxn
         nUMg==
X-Gm-Message-State: APjAAAXJWCA8ak88N3BWXtns5ImYympi8qcEVYAhCl+mCJKwzLcFeyXA
        NQRTPJhy6l69ob2+iv49o6RBDzMhTHihSqnBwQKYMQ==
X-Google-Smtp-Source: APXvYqweiMYDaxRdcX6bGs9e5ycuS+mIRgrgR9TjYwmXsa0frVpfhEjm9i8hQX6HSpAqSO8yl/Bh4U950qcyLeHLpMs=
X-Received: by 2002:a17:902:7207:: with SMTP id ba7mr4392261plb.329.1556813400075;
 Thu, 02 May 2019 09:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004101370587c052fb@google.com> <Pine.LNX.4.44L0.1904301058150.1465-100000@iolanthe.rowland.org>
 <CAAeHK+zYQ0QF_vo+iYns2d0O7RZ=Uq0kxi1mWc1W_0bBxMGR0A@mail.gmail.com> <20190430154000.GB23459@kroah.com>
In-Reply-To: <20190430154000.GB23459@kroah.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 2 May 2019 18:09:48 +0200
Message-ID: <CAAeHK+w6NfdqLRCxO8J24YqdmTRkipyG3GaCZBaYdNE5b+Ojeg@mail.gmail.com>
Subject: Re: WARNING: Support for this device (Terratec Grabster AV400) is experimental.
To:     Greg KH <greg@kroah.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+af8f8d2ac0d39b0ed3a0@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 5:40 PM Greg KH <greg@kroah.com> wrote:
>
> On Tue, Apr 30, 2019 at 05:14:28PM +0200, Andrey Konovalov wrote:
> > On Tue, Apr 30, 2019 at 5:00 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Tue, 30 Apr 2019, syzbot wrote:
> > >
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
> > > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=141ca62d200000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=af8f8d2ac0d39b0ed3a0
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1405bedd200000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ce3bbb200000
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+af8f8d2ac0d39b0ed3a0@syzkaller.appspotmail.com
> > > >
> > > > usb 1-1: New USB device found, idVendor=0ccd, idProduct=0039, bcdDevice=
> > > > d.3c
> > > > usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> > > > usb 1-1: config 0 descriptor??
> > > > pvrusb2: Hardware description: Terratec Grabster AV400
> > > > pvrusb2: **********
> > > > pvrusb2: WARNING: Support for this device (Terratec Grabster AV400) is
> > > > experimental.
> > > > pvrusb2: Important functionality might not be entirely working.
> > > > pvrusb2: Please consider contacting the driver author to help with further
> > > > stabilization of the driver.
> > > > pvrusb2: **********
> > > >
> > > >
> > > > ---
> > > > This bug is generated by a bot. It may contain errors.
> > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > This does seem like a bug in syzbot.  Why does it think this pr_info()
> > > output indicates a crash?  Is it fooled by the capitalized "WARNING" at
> > > the start of one of the lines?
> >
> > Well, as of [1] WARN*() should only be used to indicate a kernel bug.
> > Normally, WARN*() prints a line that start with a warning, which is
> > followed by a stack trace. Unfortunately the stack trace is not always
> > present (kernel memory is badly corrupted, console deadlocked, etc.),
> > so syzbot detects the "WARNING:" line as a beginning of a WARN*()
> > reported bug. In this case the driver does something like
> > `pr_info("WARNING: ...", ...)`, which confuses syzbot. I'd say it's
> > the kernel that needs to be changed here to use some other kind of
> > prefix for printing warning messages.
> >
> > [1] https://github.com/torvalds/linux/commit/96c6a32ccb55a366054fd82cc63523bb7f7493d3
>
> Ok, we can change these to "Warning" then.  Want to send a patch?

Done.

>
> thanks,
>
> greg k-h
