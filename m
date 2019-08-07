Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F26DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0641B21E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sdsD+XG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfHGOen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:34:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36982 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfHGOem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:34:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so41154107plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHwvH2IenI5I6BOpKEASSOSagsSSWPckINnb/r9Om0s=;
        b=sdsD+XG/A62SVCrfeJ+B5ABp3mNeNNw+iPeD4Z8U5zgghaSEmlrouqOw3k4+sm5yuS
         8fFQGgOH9HgiUauowsu1sHasF4j1K9RDOvUX+80x3BlGrp204ug3UieT2V5ATUM/1P31
         LitFv435Co8Sw1F0PLaskW8JQStoJFuvimG3E0OKdw5pSWQuxB9G2S743r/VcnIFu+3g
         s+O1d109GWMqh7CCMQWQVrFRcfJGns9pNxmIYtjjdP8vi25SqbRgZARFQ7XfUgp7vYtI
         g4W0/+z9UG55JCx68K0ON1IZXuhdg0DOSTh1LThJrL7g4eEXMPwjPwh5xZa3KSSUKsMb
         DtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHwvH2IenI5I6BOpKEASSOSagsSSWPckINnb/r9Om0s=;
        b=mn/E8JNm3Wu/QQyVbdodNYfeJbeFplsnDolBB95ta4q7zwVZXDovOT9/JKN6NP6rn/
         oPGbqV9I9wi27HtmhcMmtwD5/iXTS6U5fZny11FM2aT7ZWlbdJHZ2KG14fT/kmeLhvo4
         +tos2Ay7h7cFjMdEgeGRdMkXJgpq7WDA7aWjcgH67/x2Mt+lgLvtScYD0Q06Uic8VO1u
         7gaIBvYKgca0WmJXEcYd3o+bqjOmaBKrOAuc9j6hFfzs3fOeKDvKVBT7WSPz+cZoYJ/h
         5XlfCoZNAWJbiVW/KD4OEO8Hf5sJOkncu9g5PIQBXxdUQsVcZG3zJePaygRMgZcIiqmz
         /t5g==
X-Gm-Message-State: APjAAAXTYVLZHIaH/gtspBc/Hjyh6kayblYa4mkSASPJe2S2Ho/I36Lt
        Ae4c94ve2HhUJvnZDTmwcR5LbNbSxPabxncsZgCSiA==
X-Google-Smtp-Source: APXvYqy5B07ywMWJX2Uml9bcmJ7I45WeRc12CCI8A9D4FmFbKsVYlV2+jjkpWWNkmEsxnuS7+xCsBs1+fZYql6Ton/c=
X-Received: by 2002:a63:c442:: with SMTP id m2mr8183379pgg.286.1565188481270;
 Wed, 07 Aug 2019 07:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+zLrYaE+Kt6AULPjKhBNknxPBWncfkTDmm3eFoLSpsffw@mail.gmail.com>
 <Pine.LNX.4.44L0.1908071000560.1514-100000@iolanthe.rowland.org> <CAAeHK+yAY_ov4yH7n-R8ppnxc1ux33A-SEdxx18ywU1SyLGwug@mail.gmail.com>
In-Reply-To: <CAAeHK+yAY_ov4yH7n-R8ppnxc1ux33A-SEdxx18ywU1SyLGwug@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 7 Aug 2019 16:34:30 +0200
Message-ID: <CAAeHK+xV3SgXvu7RsGLVtPH7scV9GZ0uwPzTu8N2bw1kt9i7aw@mail.gmail.com>
Subject: Re: possible deadlock in open_rio
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+7bbcbe9c9ff0cd49592a@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Cesar Miquel <miquel@df.uba.ar>,
        rio500-users@lists.sourceforge.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 4:24 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Wed, Aug 7, 2019 at 4:01 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, 7 Aug 2019, Andrey Konovalov wrote:
> >
> > > On Tue, Aug 6, 2019 at 9:13 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > On Thu, 1 Aug 2019, syzbot wrote:
> > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following crash on:
> > > > >
> > > > > HEAD commit:    7f7867ff usb-fuzzer: main usb gadget fuzzer driver
> > > > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=136b6aec600000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=7bbcbe9c9ff0cd49592a
> > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > > >
> > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > Reported-by: syzbot+7bbcbe9c9ff0cd49592a@syzkaller.appspotmail.com
> > > > >
> > > > > ======================================================
> > > > > WARNING: possible circular locking dependency detected
> > > > > 5.3.0-rc2+ #23 Not tainted
> > > > > ------------------------------------------------------
> > > >
> > > > Andrey:
> > > >
> > > > This should be completely reproducible, since it's a simple ABBA
> > > > locking violation.  Maybe just introducing a time delay (to avoid races
> > > > and give the open() call time to run) between the gadget creation and
> > > > gadget removal would be enough to do it.
> > >
> > > I've tried some simple approaches to reproducing this, but failed.
> > > Should this require two rio500 devices to trigger?
> >
> > No, one device should be enough.  Just plug it in and then try to open
> > the character device file.
>
> OK, I've reproduced it, so I can test a patch manually. The reason
> syzbot couldn't do that, is because it doesn't open character devices.
> Right now the USB fuzzing instance only opens /dev/input*,
> /dev/hidraw* and /dev/usb/hiddev* (only the devices that are created
> by USB HID devices as I've been working on adding USB HID targeted
> fuzzing support lately).
>
> I guess we should open /dev/chr/* as well. The problem is that there
> 300+ devices there even without connecting USB devices and opening
> them blindly probably won't work. Is there a way to know which
> character devices are created by USB devices? Maybe they are exposed
> over /sys/bus/usb or via some other way?

Ah, OK, I see that it's also exposed as /dev/rio500 for this
particular driver. This doesn't really help, as these names will
differ for different drivers, and this will require custom syzkaller
descriptions for each driver. I'm planning to add them for some
widely-used (i.e. enabled on Android) drivers at some point, but it's
too much work to do it for all the drivers enabled on e.g. Ubuntu.

>
> >
> > Alan Stern
> >
> > > > Is there any way you can test this?
> > >
> > > Not yet.
> > >
> > > >
> > > > Alan Stern
> >
