Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AE4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 20:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AA921873
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 20:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrWW+ZAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfCWUZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 16:25:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44000 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfCWUZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 16:25:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so3733175pfd.10;
        Sat, 23 Mar 2019 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0KQ81DxjOPGjaEtWHLtdrsk+PBSnkB1EK3oNl2i2BSo=;
        b=qrWW+ZAPE2cG7Ss0cHNcQWIuSgcE+ac6Sx7R5zO6RvEJ7fxOM4s7R2bwTrLXqNzlD0
         WW4DyjRR4CyFtsekXGzSY7isUx0EnllD2jwbWrHItKQjKVpnwq7hmXt3eo4CyzMgDpHx
         kPO96e5lP9nntt/d4p71YH7xk2TVv4vivt86ydkuVa+8o3Iw9Dik2Xd8lWUvjfpblfqx
         RCPyfZudpczOxl9GC0T2oXd1DjAc4ISZSA6NcWLui3UEytjvk/yI5v1xc4+YEevqUtOi
         ZSZqdJnIqJ2Q9XqfcoqA23OzDWJfulSWvrui9ZxA8fkVOolWUQF2XozZd5CncP0UcOkz
         gUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KQ81DxjOPGjaEtWHLtdrsk+PBSnkB1EK3oNl2i2BSo=;
        b=S4E8QVUYEjjWhUi/8MALVKAxkpia53+Y3nrHJnxtY6WZWZMt2U62Sb2dmj2SKlBQsn
         4Z28NFH6gunkeJbVdHLfTqGs25py2IKXX2Gf3Rcgq2xkqvfD39YS0duu2XhfxtPYzq8a
         PospO6/MkE8LPZPWT1uO7RQmwbMXHlf+gbgjODEEdR+bfn8BrOCS9nx2Gpmmpf/sYa83
         Yd79qQO8MGduwVkTUgB4MgfgHONWKgB+/vDgkqBlslv6cshcpUC6LOCnIJVO3pH/GF+r
         fs70yhR9xe/t8EATIiVGGCifpobghajfL1RzRNjtN2gU53t/zmkFWwwNlaBRsAENapti
         tUrg==
X-Gm-Message-State: APjAAAUOF69bZrVAMNxf7I0oTRs2eIn9NGSkRnj1dS5wVSAUdLLji3n/
        B2FVZn2qJjBNwlmf9vfgu3D3ksw1y5OziOQZJeKtciDp
X-Google-Smtp-Source: APXvYqx9/99LYR4LgVXyvmHt+G3hddxlVU0ASRaA+dPoIiRWrPw6zYSI5aQDP0XWHyo2FWgduDWZSEOwV7ulzy3LTso=
X-Received: by 2002:a65:610d:: with SMTP id z13mr15858446pgu.104.1553372720524;
 Sat, 23 Mar 2019 13:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003692760578e651dd@google.com> <0000000000007917ff0584ada6e7@google.com>
 <CACT4Y+b0Onk4AB0hkvhXgZPdk+rERFsYAQra681o6QLDH_Ct-g@mail.gmail.com>
In-Reply-To: <CACT4Y+b0Onk4AB0hkvhXgZPdk+rERFsYAQra681o6QLDH_Ct-g@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sat, 23 Mar 2019 13:25:08 -0700
Message-ID: <CAM_iQpVHgHM-5NCE+FNZfpH6CWtYdt8BSmHJj_oa7CLKxYKLQw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in hci_sock_release
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Fri, Mar 22, 2019 at 5:19 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Mar 22, 2019 at 1:04 PM syzbot
> <syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this bug to:
> >
> > commit c470abd4fde40ea6a0846a2beab642a578c0b8cd
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Sun Feb 19 22:34:00 2017 +0000
> >
> >      Linux 4.10
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1664c6df200000
> > start commit:   c470abd4 Linux 4.10
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7308e68273924137
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b364ed862aa07c74bc62
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152532bb400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f73320c00000
> >
> > Reported-by: syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com
> > Fixes: c470abd4fde4 ("Linux 4.10")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> The same story of HCI being broken before v4.10, so this is bisected
> to the release.

Does syzbot test the latest upstream? Isn't this supposed to be fixed by

commit e20a2e9c42c9e4002d9e338d74e7819e88d77162
Author: Myungho Jung <mhjungk@gmail.com>
Date:   Sat Feb 2 16:56:36 2019 -0800

    Bluetooth: Fix decrementing reference count twice in releasing socket

?
