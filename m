Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BB3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8946D20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wq99Y347"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfCYIEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:04:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37797 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbfCYIEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:04:39 -0400
Received: by mail-io1-f68.google.com with SMTP id x7so6854607ioh.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 01:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FxHIzxzQt8MhOtJtBfGwY4lxcYyDsCzTF5PMZqP3SvU=;
        b=Wq99Y347r5AopZVBXUxSr15YIcBSP8bWT2UvNSEtjTcZHBpBjpMpdEHnK+QUxMw/OY
         n+daIsPwedg3uHp46KtrUB05INoszJgqNkDW1IIfB3fHG0PMbFxDFbHNMke0B8w7SjYi
         Qjr8hcsPT8UEBpp2NEeUz2XU/rM9VCz5OWMfPyqqUc4AIXLFFmWNB86lbBenfDR6xd/M
         0HQDN7XSPnxW8f+fLt43aftcQSKMfimbMVrHIyXIvSvT2E6P2cCnAaKjQVSbF/3Jdp67
         lowwtIUwZq0HH+K0Sdqtt4KBpqtQ5+CZ1leyR+fvjkfgGo8Ff+AmdFNP5H3m/UzoVg5w
         03Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxHIzxzQt8MhOtJtBfGwY4lxcYyDsCzTF5PMZqP3SvU=;
        b=phWlhoCDGi/UKYHpvWXKc6q4HS8WZCJArcjI66iQ7xLryyLvhxIdVsaXROHtoD+A/X
         Bac0Cjf8W9LraQps32SOXUCvZmhEBnUpABSYnCMBFmnyERuFmA8hPg7NfhQe0zC1EZkv
         8r8hkysbJpwdWWUTKcEz5njdOMgHR/VsSd4jU+qdc6uVVyrANZmTj7bgunxARHL3TVVk
         RBlz5LZbwdiF9SbmS3GRzc+dt9z4ShfGDYqYR/tX0jfWCAGvNSkx+CkOVBGaUz/vl280
         7utkL3p8yNE158EhFf+YT67KWFBOKLFLfSAVcCbX8SRVaaKJxWwmSxkKxMy3Kk70TxVx
         PpIw==
X-Gm-Message-State: APjAAAXJyiJLjv7pQAR3pOdEptNm5a1U+oqMBvbFLaf2LAU8qFig+YPf
        QS0tVJw+GyblJyeGtxzPCvIYnZltFoLB5gOaDQ3u0A==
X-Google-Smtp-Source: APXvYqxwV/Xss6b08ljC3tdfRnjL/tkVWuTKzPsF9o1QSQSaGBTiHogu/X9FNq9/wmhh4FQs2JyfsHxPiZPbCDyhMa4=
X-Received: by 2002:a5d:9457:: with SMTP id x23mr11583316ior.271.1553501077883;
 Mon, 25 Mar 2019 01:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003692760578e651dd@google.com> <0000000000007917ff0584ada6e7@google.com>
 <CACT4Y+b0Onk4AB0hkvhXgZPdk+rERFsYAQra681o6QLDH_Ct-g@mail.gmail.com> <CAM_iQpVHgHM-5NCE+FNZfpH6CWtYdt8BSmHJj_oa7CLKxYKLQw@mail.gmail.com>
In-Reply-To: <CAM_iQpVHgHM-5NCE+FNZfpH6CWtYdt8BSmHJj_oa7CLKxYKLQw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 25 Mar 2019 09:04:26 +0100
Message-ID: <CACT4Y+b5T6x_crSRStNST-btPYDGzujZ=Q20RLpaJs=taLA9wg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in hci_sock_release
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     syzbot <syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "open list:KERNEL BUILD + fi..." <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Michal Marek <mmarek@suse.com>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 9:25 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Fri, Mar 22, 2019 at 5:19 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Fri, Mar 22, 2019 at 1:04 PM syzbot
> > <syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot has bisected this bug to:
> > >
> > > commit c470abd4fde40ea6a0846a2beab642a578c0b8cd
> > > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > > Date:   Sun Feb 19 22:34:00 2017 +0000
> > >
> > >      Linux 4.10
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1664c6df200000
> > > start commit:   c470abd4 Linux 4.10
> > > git tree:       upstream
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=7308e68273924137
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=b364ed862aa07c74bc62
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152532bb400000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f73320c00000
> > >
> > > Reported-by: syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com
> > > Fixes: c470abd4fde4 ("Linux 4.10")
> > >
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> >
> > The same story of HCI being broken before v4.10, so this is bisected
> > to the release.
>
> Does syzbot test the latest upstream?

Yes, it does.

> Isn't this supposed to be fixed by
>
> commit e20a2e9c42c9e4002d9e338d74e7819e88d77162
> Author: Myungho Jung <mhjungk@gmail.com>
> Date:   Sat Feb 2 16:56:36 2019 -0800
>
>     Bluetooth: Fix decrementing reference count twice in releasing socket
>
> ?

I and syzbot have no idea. You may know better. Is it? If yes, please
tell syzbot about the fix.
