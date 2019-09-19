Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5282EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A9221907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gh1PJb4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbfISNJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:09:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35777 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731819AbfISNJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:09:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id a24so1907309pgj.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 06:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b7eB2Zj0HMh+W1nUIU3X2oj3xDi67z7zqFrF3NQgu6w=;
        b=Gh1PJb4k9dC4So0WrZHGTSEMtfNWz5B6hV9FfAhQayjN0gLcUsyUQm7U4dAX7PtgFT
         aGSZT0ghnsD/5OmmtSGnd88iM7mzyiwug9j2/7yXfaeV1/7innuJpEpvvBWB4ngmqjQA
         g2iWLxc3fscHGG+zXZ/VvAUlQ2iHtpT2WKCBQmuCks1UHkFfHyOOicvxjtBNJpAnpwXX
         SEVCOYy9z/5KcFTw84Tk01h0fKbv66Y97XEs3RpJa6x1QimcGrFefUeWd2ENdNaN4+G0
         AogBoa29Ofd2Et4opfLNeHj2w6XO5PK29CD0aupFPA/yo4SWSYWqNLi+cprrspErsk3t
         Z6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b7eB2Zj0HMh+W1nUIU3X2oj3xDi67z7zqFrF3NQgu6w=;
        b=plmojXGfkum6xDLQl1jaT//nKAgg2sPqnR//NLBZwa9twOHbR3DQvDIIWAytJ3ufcK
         Hj8hB/m9347Tb22wFvwKvOE3c3IbGEbwnByrbV6mek90QuVf/OMtx9Ob2TTT5+dBX5Ou
         R9ChaB05tDALaVSKl3eTmj2l4ECSB+wugmJTXLp5hG6AtvWctbCyKnF6igpUp9+apv0h
         ipfvD3PsZYz/jXzdUscxSTb7o6zZNuXv0GguQPFD5XxibVR1Rn16yoXKosWOZnu5Z0Yc
         Qn0t0HBBXpzPX8no6xiaD5xgOxx32pmNJqjWigoGDP/Za/y+NKb0NURNir7UMo4ZgP8b
         nXPg==
X-Gm-Message-State: APjAAAV3WOMnzUMmeqFBl8G9U1yAFlUGNsMXiWnzboNOXZXuRaDiek7r
        zq0SQ6LWZftWPdsZ4zE802csxdK/bZaCJKxd86Eq2g==
X-Google-Smtp-Source: APXvYqy9CZ28RW2zKXiUC9d6EbgNnSdWP2+JzbdmSoIMlTI53bhmKqSgfp9RMosERJQCBAbFi870wx+/J0sJND9jXEA=
X-Received: by 2002:a63:3006:: with SMTP id w6mr9148267pgw.440.1568898551847;
 Thu, 19 Sep 2019 06:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e669b80592ab96fc@google.com> <20190919082359.GA30545@localhost>
In-Reply-To: <20190919082359.GA30545@localhost>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 19 Sep 2019 15:09:00 +0200
Message-ID: <CAAeHK+zspPwm9vRHz3JNNzD5W+B-d4o7-br65Jcn1KCDJtBzZQ@mail.gmail.com>
Subject: Re: possible deadlock in tower_open
To:     Johan Hovold <johan@kernel.org>
Cc:     syzbot <syzbot+66935bec147fbf68d9f8@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        legousb-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        starblue@users.sourceforge.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 10:24 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Sep 16, 2019 at 06:29:12AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13c8d14e600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=66935bec147fbf68d9f8
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+66935bec147fbf68d9f8@syzkaller.appspotmail.com
> >
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 5.3.0-rc7+ #0 Not tainted
> > ------------------------------------------------------
> > syz-executor.1/8155 is trying to acquire lock:
> > 0000000086c1bdfc (open_disc_mutex){+.+.}, at: tower_open+0xce/0x9b0
> > drivers/usb/misc/legousbtower.c:335
> >
> > but task is already holding lock:
> > 000000000f520f73 (minor_rwsem){++++}, at: usb_open+0x23/0x270
> > drivers/usb/core/file.c:39
> >
> > which lock already depends on the new lock.
>
> This looks like a duplicate of
>
> https://lkml.kernel.org/r/000000000000d58eb90592add24e@google.com
>
> Not sure if this is the right way to report this (quoting needed?):
>
> #syz dup: possible deadlock in usb_deregister_dev (2)

Hi Johan,

You did it right, now the status is changed to "closed as dup":

https://syzkaller.appspot.com/bug?extid=66935bec147fbf68d9f8

Thanks!
