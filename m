Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA09C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55553222A7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfKSG1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:27:02 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:46839 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfKSG1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 01:27:02 -0500
Received: by mail-il1-f200.google.com with SMTP id i74so18554007ild.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 22:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dTjrrRy3LEozKwNXBV4Ty/FztuyvMkif/G8KKuV4T7c=;
        b=UjlMymMQTkTtaoSpNMSWThXWb8xB1a+6VHmJJ4LSUbZ6Lph5VmjRGPO/IcP8CauQTq
         NfH4TRf0ViH2HNKpax7KDBXm8rmT/vqTirKl1EDUmtPy/OiZfenOPnYWZjAJDMjRSZil
         tV5onT0b9N0vbNCo4Cu8LiuOqsynI+HFz1d4ZXre/xtmfetoBYvjxbdDpV8Gj+4HLBkJ
         yll/xikNmXxNwwgKIHBy4ZIx+ArpxuM3JBh0Unxvraeg4oWM0yO8XCNNABzNQA/FCtw3
         96/XREiOwtUCF21ZtMS891VgoCSDil0UlpeoK/HIizBnrW1u+mHGELsuG1f0BfQOasPJ
         HXIA==
X-Gm-Message-State: APjAAAWwhQbIeN8xZssOg3flY0Td+Qw1768cCo9b0vYiMipLF+XZ3774
        Tin39yrjvf2jSREJ0XdXA+MxUHDsS79+ym1A6veGW0+6tUhM
X-Google-Smtp-Source: APXvYqxZvBxKrwbxu9qvV0Jyk3hsGjLxdkmXOzmsk4XNGJ2ienhpi+0IdkUlIoYwY7dUgJAsHQDj6kE18pXPZ8tgrd8ZGgsoZJnx
MIME-Version: 1.0
X-Received: by 2002:a92:ce0d:: with SMTP id b13mr20495314ilo.26.1574144821076;
 Mon, 18 Nov 2019 22:27:01 -0800 (PST)
Date:   Mon, 18 Nov 2019 22:27:01 -0800
In-Reply-To: <000000000000bf6bd30575fec528@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2ac670597ad2663@google.com>
Subject: Re: general protection fault in kernfs_add_one
From:   syzbot <syzbot+db1637662f412ac0d556@syzkaller.appspotmail.com>
To:     benh@kernel.crashing.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 726e41097920a73e4c7c33385dcc0debb1281e18
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Tue Jul 10 00:29:10 2018 +0000

     drivers: core: Remove glue dirs from sysfs earlier

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=168e1012e00000
start commit:   5e335542 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=158e1012e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=118e1012e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9917ff4b798e1a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=db1637662f412ac0d556
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a66c11400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1346c771400000

Reported-by: syzbot+db1637662f412ac0d556@syzkaller.appspotmail.com
Fixes: 726e41097920 ("drivers: core: Remove glue dirs from sysfs earlier")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
