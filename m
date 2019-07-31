Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2535C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BCB20693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfGaN6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:58:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:51259 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbfGaN6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:58:01 -0400
Received: by mail-io1-f72.google.com with SMTP id c5so74883818iom.18
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 06:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FEF26j1D9ZvC1FOg/2C+u2C5uOIP0wZpzYnp05nqnRo=;
        b=NU4uPfXf1gnj4nrA5uyQpqj2kdaDA6fg1hm/CJc8Fj9GvPHCsqJbaPcsYTI2QV9xhf
         HUNq4cc9qL6j87BVGRKnnBHk3tjPMZzbRaDbow8vrVQQcteuKfStFMZ7We/K1zXF93B5
         jQZ416llyysiRQE8uhy14/r4/m4T7N7zZXDnjQ6ZLgLbmVuuXxkMBkX3K+leNAW3zN9J
         N4biUV57SlEmAklJ2qmgLpfZay8js6vsbI9rbvE+kjmfhznyFIBcbVkohsmjGt5H635K
         J9/Uqh+vKQufe/udlol3ZuqAZTLdRBEOYpyniPCkRAKGo9LXPMolujzJL+T12H6uQIRp
         7Ydw==
X-Gm-Message-State: APjAAAVnlM/HtipS5VyOSZiJswEMwxLhDeA5Se/d2ZYzqLlisIlV9GRn
        kfTZC7/rC2IRYCFnkwrGu+7oLgk9PQlMEAUYFfnxZf00KcUg
X-Google-Smtp-Source: APXvYqx4v+2B+tDfNufu/8jabqDh174TMHU9YBPhF6J18gSgAFOcH5r9L9/kPu54zg3r+7UAdLNDk/GmtNOPv60wADHFIKWDIzGs
MIME-Version: 1.0
X-Received: by 2002:a02:230a:: with SMTP id u10mr43840113jau.117.1564581480591;
 Wed, 31 Jul 2019 06:58:00 -0700 (PDT)
Date:   Wed, 31 Jul 2019 06:58:00 -0700
In-Reply-To: <000000000000de000a058e9025db@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f7805058efa8333@google.com>
Subject: Re: KASAN: use-after-free Read in release_sock
From:   syzbot <syzbot+107429d62fb1d293602f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit c8c8218ec5af5d2598381883acbefbf604e56b5e
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Jun 27 21:30:58 2019 +0000

     netrom: fix a memory leak in nr_rx_frame()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b52242600000
start commit:   629f8205 Merge tag 'for-linus-20190730' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10752242600000
console output: https://syzkaller.appspot.com/x/log.txt?x=17b52242600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7b914a2680c9c6
dashboard link: https://syzkaller.appspot.com/bug?extid=107429d62fb1d293602f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a7c8dc600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1498cfa2600000

Reported-by: syzbot+107429d62fb1d293602f@syzkaller.appspotmail.com
Fixes: c8c8218ec5af ("netrom: fix a memory leak in nr_rx_frame()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
