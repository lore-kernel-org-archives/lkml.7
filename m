Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A9BC06508
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 10:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AC120665
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 10:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfF3KkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 06:40:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:44980 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfF3KkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 06:40:01 -0400
Received: by mail-io1-f72.google.com with SMTP id i133so12022996ioa.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 03:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=eziCMEFtU+C3qoNYfJHsPKHY2FKR9JngSHlmZZHqzFo=;
        b=rP+sNu4kFpbxaw03nVjCo7VEL3ZbEkrgoK2KdaGQWvw1MRzMKEBWTk+ZQuhlemhoBG
         iLpDpEbl77QMqj1MVPlvnjAF7gFcyypbjKf0U88Fsk/5uY/HWvPIexFenIN/knsneiSV
         8J2Di9VMcLVIyHZeQqXVkZt5H6yUFNZeor39cnJb29oRlIm0jYb36cFsVIk7w12wqD1b
         SDBR8hCgbxUsBavI3gk2Xf3iienf0f5WD1ZfklqOG5jXGvNPMZfcvBdO50poWKv3s9W2
         Y70sQl+nsDkKjjsUifMaKqUO5Om9yQPe7ntjvZOFEBIH+R1BDst7Q2moQNdQUu1OHZQP
         Otyg==
X-Gm-Message-State: APjAAAU7gJbqY0cI4a1hwSTGLOFEGvbGHJnPuF/og3eP7YalmmstO+fZ
        yUQ4TBCtvVcLamm2BQU7jwoDqP7ToBy6o/nGIjsqa1/pIN9M
X-Google-Smtp-Source: APXvYqwc7jNxeDwuXuaVmtRV4iFyubee59JJU/yaTue7FDuw9a59U5XBHdkSI5CIzX3MUpYnDTjMD5X25A8OGVnPI50yMEKLHG28
MIME-Version: 1.0
X-Received: by 2002:a02:c6a9:: with SMTP id o9mr10128962jan.90.1561891200769;
 Sun, 30 Jun 2019 03:40:00 -0700 (PDT)
Date:   Sun, 30 Jun 2019 03:40:00 -0700
In-Reply-To: <0000000000003ec128058c7624ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003326c1058c8822c7@google.com>
Subject: Re: WARNING in kernfs_create_dir_ns
From:   syzbot <syzbot+38f5d5cf7ae88c46b11a@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        hongjiefang@asrmicro.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 7f38abf220e2c800a2c451372e9f07ed5fd0ea49
Author: Hongjie Fang <hongjiefang@asrmicro.com>
Date:   Tue Jul 31 02:55:09 2018 +0000

     mmc: core: improve reasonableness of bus width setting for HS400es

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129d6755a00000
start commit:   72825454 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=119d6755a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=169d6755a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31528e58cc12e2
dashboard link: https://syzkaller.appspot.com/bug?extid=38f5d5cf7ae88c46b11a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a6c439a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1353c323a00000

Reported-by: syzbot+38f5d5cf7ae88c46b11a@syzkaller.appspotmail.com
Fixes: 7f38abf220e2 ("mmc: core: improve reasonableness of bus width  
setting for HS400es")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
