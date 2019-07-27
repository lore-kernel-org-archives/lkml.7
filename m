Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB81C76190
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 10:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C467217D9
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 10:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfG0KQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 06:16:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:43815 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbfG0KQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 06:16:01 -0400
Received: by mail-io1-f71.google.com with SMTP id q26so61574683ioi.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 03:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=x2XPPyWw+kTQEvjXcX/vC5JNb6a5vMqFuiwlUWd2Kag=;
        b=IWkCjkRE1RR2zAHFoU9UbQ5mA/tKurG6Uk1k5BvUg/f76z2XasFLXrdbq43dQJozvw
         k+7Zj1XSXG91XPO/ugBKL800hfglCzoVfbZWHoPEZXUW4Z7UpNfYUS9nG0GpOqMgkrfg
         h7BZ9T5WO4fiogfDYEkVAJ3+PpuZsyVbkBDNj9GOj/q0DOoqzgqfFA5TuBdRCjS7339g
         vejkmjSycqaHSSxEImGCPRcqv+DT0BdvFo83zrtUV+0RYXUkW9CwZNZXO6CK+7ioKaFh
         cbirDGUO7m71l+2yKbXP+/1EO5hyXB/xjpk2nZKpBtr9KYfHNGndic+YtMYMmIihnxt0
         cxVA==
X-Gm-Message-State: APjAAAXXRpHitJFFMnebdLoi0eOiR2DYOu0EmfuiJy0+Ibe6EkYPoU5F
        Nax+9RVzCT5ra2KKWoOnlBr52LsTtMbNzvOaHtL6z0wzRuBU
X-Google-Smtp-Source: APXvYqyUUXRwrDhv+Q8VwK3XJ+lyMBkXhuGvc/B+mH+HMjh06Rq3S9TIzl2shA7qpymnG5hvTqwSBsZorpk8Y0tjAKx1u9bCuJWS
MIME-Version: 1.0
X-Received: by 2002:a5d:994b:: with SMTP id v11mr46002856ios.165.1564222560256;
 Sat, 27 Jul 2019 03:16:00 -0700 (PDT)
Date:   Sat, 27 Jul 2019 03:16:00 -0700
In-Reply-To: <000000000000111cbe058dc7754d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000dc874058ea6f261@google.com>
Subject: Re: memory leak in new_inode_pseudo (2)
From:   syzbot <syzbot+e682cca30bc101a4d9d9@syzkaller.appspotmail.com>
To:     axboe@fb.com, axboe@kernel.dk, catalin.marinas@arm.com,
        davem@davemloft.net, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        michaelcallahan@fb.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit a21f2a3ec62abe2e06500d6550659a0ff5624fbb
Author: Michael Callahan <michaelcallahan@fb.com>
Date:   Tue May 3 15:12:49 2016 +0000

     block: Minor blk_account_io_start usage cleanup

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13565e92600000
start commit:   be8454af Merge tag 'drm-next-2019-07-16' of git://anongit...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10d65e92600000
console output: https://syzkaller.appspot.com/x/log.txt?x=17565e92600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d23a1a7bf85c5250
dashboard link: https://syzkaller.appspot.com/bug?extid=e682cca30bc101a4d9d9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155c5800600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1738f800600000

Reported-by: syzbot+e682cca30bc101a4d9d9@syzkaller.appspotmail.com
Fixes: a21f2a3ec62a ("block: Minor blk_account_io_start usage cleanup")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
