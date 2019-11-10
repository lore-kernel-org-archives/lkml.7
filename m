Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F935C17443
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 11:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456BA20869
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 11:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfKJLtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 06:49:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:53449 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfKJLtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 06:49:01 -0500
Received: by mail-il1-f197.google.com with SMTP id y17so13712732ila.20
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 03:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=muS40/M+U7unS7Nwdhba7+0opY/I2Z2pZGBBgPUq8C0=;
        b=two3lPNPM+sQiSV14DN4MmD7JMEHp8igOEUgzrfGvP2u1Yd3GZSp8wHUJvaMoYTC/j
         Wdu1m2nOA9aT3T2dik+HFOOT2NCqvgDS+2AHq6UzOE1ZaZ/JmqZ9/2A5Xa2GOcWIemnl
         5AfNIqw6Tm32/w6hiBaIj2WaIdqBp8rrP7yvo/1X+Td+zwHS9QVvOyTLsKlMDAgUsejD
         FdroQfX9CFIvCSwKpQQYQMmz7f0X++bNWqZdZr3T8Sr/tRlCBZ6VT7TTnJsbhN+FSaut
         AfFYuOyb6CopL3moRVKZNS2fY5tzJUrhwzqjPlP33fnbd0A+n3xFbeuu0vjDalnWkuXU
         Z5Ew==
X-Gm-Message-State: APjAAAXI8QP2wG/ZepqVB5km61UeCJXbDwWpCRG0o+V8Elrk26IeKkm+
        T0LcsaGdDQhD3U5MoaBXH5eUE8uj9N1oTKVGuCqWuT5yMWiF
X-Google-Smtp-Source: APXvYqwG7iOuXUzrPn9C7IQw34I7LSwhAIRpMFyONIfQ9Z8ZWhdhx/QqVwYg/S2UFNW58oOzV3uQTeJdrwTJ/Pza/72hGbJAuyfE
MIME-Version: 1.0
X-Received: by 2002:a92:16d4:: with SMTP id 81mr24840022ilw.198.1573386541143;
 Sun, 10 Nov 2019 03:49:01 -0800 (PST)
Date:   Sun, 10 Nov 2019 03:49:01 -0800
In-Reply-To: <0000000000003659ef0596fa4cae@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e11df90596fc9955@google.com>
Subject: Re: KASAN: invalid-free in io_sqe_files_unregister
From:   syzbot <syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 65e19f54d29cd8559ce60cfd0d751bef7afbdc5c
Author: Jens Axboe <axboe@kernel.dk>
Date:   Sat Oct 26 13:20:21 2019 +0000

     io_uring: support for larger fixed file sets

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154f483ce00000
start commit:   5591cf00 Add linux-next specific files for 20191108
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=174f483ce00000
console output: https://syzkaller.appspot.com/x/log.txt?x=134f483ce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1036c6ef52866f9
dashboard link: https://syzkaller.appspot.com/bug?extid=3254bc44113ae1e331ee
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116bb33ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173f133ae00000

Reported-by: syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com
Fixes: 65e19f54d29c ("io_uring: support for larger fixed file sets")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
