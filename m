Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0950C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 23:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B89D20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 23:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbfHEX7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 19:59:02 -0400
Received: from mail-oi1-f199.google.com ([209.85.167.199]:49676 "EHLO
        mail-oi1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfHEX7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 19:59:02 -0400
Received: by mail-oi1-f199.google.com with SMTP id m24so20019836oih.16
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 16:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cCEYw1YNz6YzHWfgF679x03NeagqCuKTljhuC5ujasE=;
        b=re1/pip6YgeLyfYr8B383WdgNFV2jKcpejJEBa13KlUdRtBMUvHO2ci6/wl6pDaJBH
         X7Gc9DTf4Xj19s6v+XW04vJpMwRkXY/c5T2eULF3F0EccRkxFd8wPSK0esx/y6GywNJt
         aFv9+BCQH1MMbsn2Kcrwpsp1hB9tV0AlC8Qtalr1l7kONzcnJyA+hA1+bV8b6VGoGvxE
         fz6mnzSJ1D48LsCyfdhfyqOTBASSvKH1Id5NthifJ5RDEQw9Zk1ey65v+C3u3jrTtwOU
         532PeHSebC5uJwPngDG2hrLcKphpaSs3sD9SVjEsioETkP8yDtsgWylKDap7HYd2fZZT
         x5Ww==
X-Gm-Message-State: APjAAAVHYxjg3ZQjwzPG5ze40XbQrN+L8ohXD5n2+7pNqPX6BmLwSH4q
        2kYdMPdbKyFWRizOmAVBoX76NfEBezoIbzUIAk4kXaIpJ6na
X-Google-Smtp-Source: APXvYqwnWehfXVv+cTgMbmC8JDtGgeKanwz/g7rHrVO82/VKU6rQkcOihO2EYpiU+OJoGnyjFk/K9Z7NbCjOUvfNijzTrmNmUP5+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:5:: with SMTP id z5mr1098412jao.58.1565049541088;
 Mon, 05 Aug 2019 16:59:01 -0700 (PDT)
Date:   Mon, 05 Aug 2019 16:59:01 -0700
In-Reply-To: <000000000000d0df7f058f625d13@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3dd5b058f677d84@google.com>
Subject: Re: WARNING: refcount bug in blk_mq_free_request (2)
From:   syzbot <syzbot+f4316dab9d4518b755eb@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hch@lst.de, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 12f5b93145450c750f315657ef239a314811aeeb
Author: Keith Busch <keith.busch@intel.com>
Date:   Tue May 29 13:52:28 2018 +0000

     blk-mq: Remove generation seqeunce

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1263808c600000
start commit:   e21a712a Linux 5.3-rc3
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1163808c600000
console output: https://syzkaller.appspot.com/x/log.txt?x=1663808c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4c9e9f08e9e8960
dashboard link: https://syzkaller.appspot.com/bug?extid=f4316dab9d4518b755eb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117a1906600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aa11aa600000

Reported-by: syzbot+f4316dab9d4518b755eb@syzkaller.appspotmail.com
Fixes: 12f5b9314545 ("blk-mq: Remove generation seqeunce")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
