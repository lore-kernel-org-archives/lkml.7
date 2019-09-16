Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED58C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3AC206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4xQx2sZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbfIPP3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:29:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34716 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfIPP3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:29:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so218192pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+y4AkvsKSUe07hNkypQ1HfKQPXtAqApgQQ2c6pYsyvM=;
        b=r4xQx2sZTsVMGJQTG+yP4K5+89JMjruqVFAgOZPhHjy/5EkjLo1a+GA6OjtG8UcSAO
         fvBhCoNTRyRrS6Ofwjw+bvMrNKaGQkXc1Uuk9sFidnQFMWlNE0jPWFEhejNhE6IvaJDA
         m8mYa79vRNAwdeqXH6tiYsmBklPEU+vPM4OCoAjyp7c701HPMbeM0QF1B66YfF2EoD9T
         jI7RZ2FLOTYh61RKVmjkGCq1L0resvYIZdl0COVppwxBXUik4hh127syb1lEODBawtYR
         qyXRY5d02OFbdtt7s3xfzuwme6NwGVVbYTa7Q3Z9JbUNYkHgmsdHlsyLIRnbvKyrewHR
         kZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+y4AkvsKSUe07hNkypQ1HfKQPXtAqApgQQ2c6pYsyvM=;
        b=eQ7acYTrEP6xruAJBgkVhnp4jzXqYnO9tvqVuuUm+i03GnuhWGCSIpYv2ssiYJn/Yf
         VFbLqb1GMK/KM5/5OWHCWPwWecBtLhigm1pBzR0bqS3U2Iz5NPvP855rTmJdQe0+XyCb
         c1AEz5qXuvgC57UTDBiixt5XmavGp1F25hQOTvO4CeYg/L3Ybt1dH8KlUfxc7/4IEK+k
         Pr/CO+DJUJCiG5wfKhT+PCQy2x5i2BVDRWq/Yx785KovYBlZxLw7spohIy3fSpIqj1mQ
         0FsqI0syf7NNJfL4lZ9ssp/YG4obkGRgXC6GG/wucLad13h3lO9Pxva6ZUTW3dTMfu62
         TLDA==
X-Gm-Message-State: APjAAAXQcDYbgVy0VlToNqgocYNR+ryJ2gxI1srGP6QUQImy9coPSuPi
        pvaqjRpRP2onopYS5+yw1a5XaIiGENPVt112NP4xFg==
X-Google-Smtp-Source: APXvYqx/vQc7AckoJDceJnazN6xeds3moRiKMgeAsWhEzJVlkiGKHFbOefeJamw6iyqI1oA7OyuAW3Aoh1iFTqCs1mE=
X-Received: by 2002:a17:90a:1990:: with SMTP id 16mr278460pji.47.1568647790078;
 Mon, 16 Sep 2019 08:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004fb020059274a5ff@google.com> <Pine.LNX.4.44L0.1909131629230.1466-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909131629230.1466-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 16 Sep 2019 17:29:39 +0200
Message-ID: <CAAeHK+zrR3pB2R3yyyUdGM4Vrv77o47MHsgvbQ+LFHfiWBt1OQ@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in dummy_timer
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com>,
        Felipe Balbi <balbi@kernel.org>, chunfeng.yun@mediatek.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 10:35 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, 13 Sep 2019, syzbot wrote:
>
> > syzbot has found a reproducer for the following crash on:
> >
> > HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1146550d600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b24d736f18a1541ad550
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11203fa5600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162cd335600000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com
> >
> > yurex 3-1:0.101: yurex_interrupt - unknown status received: -71
> > yurex 5-1:0.101: yurex_interrupt - unknown status received: -71
> > yurex 6-1:0.101: yurex_interrupt - unknown status received: -71
> > rcu: INFO: rcu_sched self-detected stall on CPU
>
> Andrey:
>
> This problem may be a result of overloading dummy_timer.  The kernel
> config you are using has CONFIG_HZ=100, but dummy-hcd needs
> CONFIG_HZ=1000 (see the comment on line 1789).  That is, lower values
> of HZ will occasionally lead to trouble, and this may be an example.
>
> Can you change the config value for HZ and see if the bug still
> reproduces?

Hi Alan,

I've tried running the reproducer with CONFIG_HZ=1000 and still got
the same stall message. It's accompanied by countless "yurex
6-1:0.101: yurex_interrupt - unknown status received: -71" messages,
so I believe this is an issue in the yurex driver.

Why does dumy_hcd require CONFIG_HZ=1000? The comment doesn't really
explain the reason.

Thanks!
