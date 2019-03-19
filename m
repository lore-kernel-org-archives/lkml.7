Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCFEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7907620811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfCSRYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:24:02 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:39127 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfCSRYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:24:02 -0400
Received: by mail-it1-f198.google.com with SMTP id e124so5481174ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=A5/q4swmgLnBGaVhc342tSJYMVLflngDQewiKppz+44=;
        b=ZPopxt6VcKxO5MhJvh8uPYXOGZXGCrFjEpKhVGDOVR/9V7oUTBOSfR1NsQbCpxMkgP
         /l84fS4qUiiCgvpZbGsw2vLxLFxKZrL8VlDuZ4gDA/gdtOUvrQNZeX7sqjY4asMNNa1N
         YKXJ6p0302ah9HJ//fqBLr7ml+l8dfzyUfQQR3Wn2lwkyWHCHKtP54mmKkeifM32k/Pz
         BYq4d/wx0iRSv3RSk90lgX9X+4Dpzr573MiKVYBTdEKwpBENwjYwqcFhWsErypYLEoYI
         z+8dCKf0k2obrpRfP7jaLf5jGunipJZ36kQ7bisSmrgAMjoBA5mjoPIG0NTG7LjjJtcj
         oZGA==
X-Gm-Message-State: APjAAAVegcYcW22bqZR551C5mHOI9y8t6peWzSn1FICeMlYDYE3FmM5q
        TyxK7RL519uPMgxoQJR4oOOY7tuv8xqNrRUPf3Rh8oQx7V49
X-Google-Smtp-Source: APXvYqyPRz8P22dRbTU/+gHqvKGuW+9VzG94ZuWsSXuFooGgqPabQAyRM5McH4f486X+nzSQDMyij2ngjGv/3hS2Zn8ZpxN7bEZw
MIME-Version: 1.0
X-Received: by 2002:a24:4d8e:: with SMTP id l136mr2467612itb.5.1553016241037;
 Tue, 19 Mar 2019 10:24:01 -0700 (PDT)
Date:   Tue, 19 Mar 2019 10:24:01 -0700
In-Reply-To: <000000000000352b7e057cc0a13f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060a659058475c57e@google.com>
Subject: Re: general protection fault in dst_dev_put (2)
From:   syzbot <syzbot+9d4c12bfd45a58738d0a@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@gmail.com, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 52dfae5c85a4c1078e9f1d5e8947d4a25f73dd81
Author: Jon Maloy <jon.maloy@ericsson.com>
Date:   Thu Mar 22 19:42:52 2018 +0000

     tipc: obtain node identity from interface by default

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1631fc2b200000
start commit:   52dfae5c tipc: obtain node identity from interface by defa..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1531fc2b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1131fc2b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f00801d7b7c4fe6
dashboard link: https://syzkaller.appspot.com/bug?extid=9d4c12bfd45a58738d0a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17254878c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171ca5df400000

Reported-by: syzbot+9d4c12bfd45a58738d0a@syzkaller.appspotmail.com
Fixes: 52dfae5c ("tipc: obtain node identity from interface by default")
