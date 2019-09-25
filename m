Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B440C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58FD207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JcNqYn4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437913AbfIYPev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:34:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34425 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfIYPeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:34:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id k7so2023379pll.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRpIL/tAhQ7tmZdnSOSRTMvtx0laE3jI6sYZoK3gWPE=;
        b=JcNqYn4owFfGUXPFvzxQEUrFBHX+IEgzs8GRWys0yeJgQf6MJWCZEx46JGE0jk8bZk
         6TfwxC8Tr6fx40/rioCBHUcsrVCnm5TT31x14SFyXyf6Yoch2+ts9pIUW3VwG8GFGETX
         V2j7wmhNbSj0RRKUUtUOlQxO3xCNFQ0f4MGwe2ehQMw2NAtIN0E3GoGc2RoTuyTYlt6V
         da5hTXsK+A1M3B6oPBNSNg3qRb5ymXCx63+ZEBpMfBAUwWw179pEWQwNdUOYvTH+e0L0
         /ZZWPH/SDJINxrf7pT76Rrk3pfjVMlHtXbzistGM28bilBJMUo2s61THKVGVFgQN2lF1
         Uiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRpIL/tAhQ7tmZdnSOSRTMvtx0laE3jI6sYZoK3gWPE=;
        b=PhBj/QEHzL0MpgnVcM6FWuV36OxHKT73U0YJaFOoKw3AOBQsYI2MO504TNzJ0c5u6l
         bEbqWTcRxPx4OgCORLHjgd33z/h9WReobefZOJjtB2LT+xjaEhaZNPT+GwRm66/pWtDL
         KLwDacrBVrsvs9++vKVrpjGI7K+0grq5AEMAsRVVkgjnWHK7Vdneehmvl3VTimIjvwKz
         qc9CNTvjIQUphFK6a/quIlXbJ4ca3I5SnGwXWDxrGU9BBfarEI82gcj8AEqg4KKlWskk
         RWPMlzeF0ewG71iEEmm38Wvd8AG2tw4+iwvpG5wFRxXYCtyiikblaG5+PIz61sTTCt9k
         g9Cw==
X-Gm-Message-State: APjAAAWgD0oEPrBJ7MbK9RE3m/BOxJc+QnwY1/95W9dLpEMZCuTouHKM
        /m9kNsNuGn91CzIQAwJRII4D2tjECffi/bvdO7WPAw==
X-Google-Smtp-Source: APXvYqwb03jBv/q/OjCK6fv3NNJVzeeKBqjTw64ZXCSy9q0xHocdgul2oblxnMzitronqqBue11KbqD2D1BGoDqPtnk=
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr1687049plp.336.1569425689662;
 Wed, 25 Sep 2019 08:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c2ee6a059360376e@google.com> <Pine.LNX.4.44L0.1909251006040.14432-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909251006040.14432-100000@netrider.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 25 Sep 2019 17:34:38 +0200
Message-ID: <CAAeHK+zSYnRgUb_S9MwEp0rp5nk0YzpoVcYZOn_WooCW68EOmw@mail.gmail.com>
Subject: Re: WARNING in pvr2_i2c_core_done
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     syzbot <syzbot+e74a998ca8f1df9cc332@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 4:10 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, 25 Sep 2019, syzbot wrote:
>
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    d9e63adc usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16b5fcd5600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f4fa60e981ee8e6a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e74a998ca8f1df9cc332
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ec07b1600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ff0871600000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+e74a998ca8f1df9cc332@syzkaller.appspotmail.com
> >
> > pvrusb2: Device being rendered inoperable
> > cx25840 0-0044: Unable to detect h/w, assuming cx23887
> > cx25840 0-0044: cx23887 A/V decoder found @ 0x88 (pvrusb2_a)
> > pvrusb2: Attached sub-driver cx25840
> > pvrusb2: ***WARNING*** pvrusb2 device hardware appears to be jammed and I
> > can't clear it.
> > pvrusb2: You might need to power cycle the pvrusb2 device in order to
> > recover.
> > ------------[ cut here ]------------
> > sysfs group 'power' not found for kobject 'i2c-0'
> > WARNING: CPU: 0 PID: 102 at fs/sysfs/group.c:278 sysfs_remove_group
> > fs/sysfs/group.c:278 [inline]
> > WARNING: CPU: 0 PID: 102 at fs/sysfs/group.c:278
> > sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:269
>
> I have seen a lot of error messages like this one (i.e., "group 'power'
> not found for kobject"), in runs that involved fuzzing a completely
> different USB driver.  Initial testing failed to find a cause.
>
> This leads me to wonder whether the problem might lie somewhere else
> entirely.  A bug in some core kernel code?  Memory corruption?

AFAICS so far this has only been triggered from the usbvision driver
[1] and from the pvrusb2 driver (this report).

I wanted to loop in sysfs maintainers, but it seems that Greg and
Rafael are already cc'ed on this.

[1] https://syzkaller.appspot.com/bug?extid=7fa38a608b1075dfd634
