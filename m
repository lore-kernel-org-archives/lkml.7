Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC47C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 23:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E5320656
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 23:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKWXhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 18:37:02 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:48443 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfKWXhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 18:37:02 -0500
Received: by mail-il1-f199.google.com with SMTP id j68so10133012ili.15
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 15:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rcXyQARNFeEGX/5R/wh8uboQxfvT9hdMO0gGiQWOSiI=;
        b=DsDX3kn6G1xtkcULwIVQ3qDOdVM867gYhvo1CAcSo6PqIVFz1T/dWYP2O40bAcMVAP
         QCnc7aQaryucxDo4PqqoiMWg56VissdUwOZz0Yfj51/yhPJjYhOde3uI+DyccQ3Kq3Sn
         Dzb1o8fKXWDnOioUzb8PQgkIKfhpJVHigsCAsQim33obgevWrNMh7ozUSNibB7vThsW1
         4F40vulPY44N9m7P/5AhnsxSyZPILlfh3uYmG7C7RkXnPYzGYTtfLDUhMoFfcfzQbF6C
         JoK7T6BaYshHIRhLoGoOQAECnKfbgGtaPPOdSWV0ciywkYKBTupNI2GJ3eVkbgOs0K6h
         MrFQ==
X-Gm-Message-State: APjAAAWscxag81aP0ZObE0/RyT/HPaW7syC83+EbOkYTR+AjIlLwAicf
        POSGeuzoD5uVoatK1R9oj7l2o96D+i9vIZk3G1jfJ9ZiHow6
X-Google-Smtp-Source: APXvYqwj40xk+Xd7ru4QMKddn8/SsIpJKtP1YXxZ615/+EY9PfAFOY8RE0ZRU+3mTx9eSm5J1cqivLB4uhge43PShk8uF8pfq69t
MIME-Version: 1.0
X-Received: by 2002:a92:3904:: with SMTP id g4mr7836256ila.242.1574552221276;
 Sat, 23 Nov 2019 15:37:01 -0800 (PST)
Date:   Sat, 23 Nov 2019 15:37:01 -0800
In-Reply-To: <000000000000f665a30570885589@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d45f7b05980c01ce@google.com>
Subject: Re: KASAN: use-after-free Read in __queue_work (2)
From:   syzbot <syzbot+1c9db6a163a4000d0765@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 7594bf37ae9ffc434da425120c576909eb33b0bc
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Jul 17 02:53:08 2017 +0000

     9p: untangle ->poll() mess

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ad235ee00000
start commit:   ca04b3cc Merge tag 'armsoc-fixes' of git://git.kernel.org/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11ad235ee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16ad235ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
dashboard link: https://syzkaller.appspot.com/bug?extid=1c9db6a163a4000d0765
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1473a452400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14087748400000

Reported-by: syzbot+1c9db6a163a4000d0765@syzkaller.appspotmail.com
Fixes: 7594bf37ae9f ("9p: untangle ->poll() mess")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
