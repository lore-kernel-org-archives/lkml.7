Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED11C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 07:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5564721874
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 07:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfCWHuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 03:50:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:46637 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfCWHuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 03:50:02 -0400
Received: by mail-io1-f71.google.com with SMTP id k5so3668635ioh.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 00:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uyeFy9nr6uooYOVc0CHdUGqt9tT2hLYONRn7P4dDucg=;
        b=bDPLye0fJbycFu9BgEkSH+/o7H3DZSf8EJqTlX9GL7c6ISfv1PW8VeFGDpITCBMf5U
         f6zjHgTAwIIfyd48SsMY4WTIa0CwWBQdkmUretMVUE4ZVjVwij7HOrqGoiOtYTd+jlWH
         sgn8U+itxPRsfHhcIKiy3j/fsTszQjC9OoxOWpa1yfPM3mgALollPLgKtaa8AjImB/Tc
         tgRUOufTUy51pnT+mX0YfboUl3IE5YhyOmFcfaneEXL/oqj2KOyjtiigyUpNXh5RMcEJ
         kzUZXvGmoP5lQ/a/ozTxrjW1yJ55DXbgplMA1g7q7qo4KS01BNpAel4NWXj3hVOjJ8t4
         9rPg==
X-Gm-Message-State: APjAAAXB9WHy2qExIqK0xsrB0YnETtXfll4/XszKQZ3b3k2wVQifYfYs
        skidAqTF8MWmijaE4ouHj51o0++ziBfd2xg0dZiKSt/JBsT4
X-Google-Smtp-Source: APXvYqzZrZbo5PeFWeeCxw2kozFC7X+ewDnQXeBq96HUj4cWCMhdWnAAukpERSwWQxFqnqmC8wpB59chjLfgtwO7dEVA67L31Cso
MIME-Version: 1.0
X-Received: by 2002:a24:6b8e:: with SMTP id v136mr4335629itc.146.1553327401001;
 Sat, 23 Mar 2019 00:50:01 -0700 (PDT)
Date:   Sat, 23 Mar 2019 00:50:00 -0700
In-Reply-To: <0000000000006971fa05769d22f6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4efae0584be37ab@google.com>
Subject: Re: WARNING in request_end
From:   syzbot <syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com>
To:     dvyukov@google.com, ebiederm@xmission.com, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 4ad769f3c346ec3d458e255548dec26ca5284cf6
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Tue May 29 14:04:46 2018 +0000

     fuse: Allow fully unprivileged mounts

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16b4518b200000
start commit:   0238df64 Linux 4.19-rc7
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15b4518b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=11b4518b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=ef054c4d3f64cd7f7cec
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119bf2e6400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1760f806400000

Reported-by: syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com
Fixes: 4ad769f3c346 ("fuse: Allow fully unprivileged mounts")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
