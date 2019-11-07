Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A6AC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A37207FA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389648AbfKGNoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:44:02 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:42450 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388785AbfKGNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:06 -0500
Received: by mail-io1-f69.google.com with SMTP id w1so1863694ioj.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9/okOXkdmyxLp+oZdwuHSBXPqMIfQXakCi7QdBsKzL0=;
        b=tFxTkOdx6RhMcxAjlhqpLZVV4nC1zYuWCC9CDcMUbGmd/JQB4QURk36x25OFN0KgCv
         ZzcLmghJI/7rrgcT1Yd/Y1gFZUusnEcNEflYqVgveaLrOOaQKIj9vAoG/NAPUscGzJJV
         m0alb5FFqkkiIXeHKgZFSpXfbQ5r2ZWDrU3Y1ZW6By4CV4+9mX6zXwRMy7+JqMYCpvUH
         +3/lIJGlJsXBQyF+xUPQQVt2CHnqrienYu+poU6tCHK2DAP+dyrOkvoo2U3fPhRopveN
         3St9qLwnjwIyJDbu8Y3RTHEhhPzMBE+msEUQTuRHCN34uxZ5TiecwxyYl7byWa2XI/gc
         q/6w==
X-Gm-Message-State: APjAAAUEhdraXXcNxUPd35rJ8Y0xNY+rCybZDTSwQKZ6K3M6+kbk6Nui
        tRYbRJHTER5dNQ3tgRlWHW+TfL8v19sxX5L0GG03nWJSXLjp
X-Google-Smtp-Source: APXvYqz62VjOcTgDOFUdTJ8ThmzQiqH3nU+L2+77ligMCjRnKr8tpBSanxdr4g/glcLnWKYfWPvY/mTB8gNEft9wB4uAI6DEqooQ
MIME-Version: 1.0
X-Received: by 2002:a6b:f914:: with SMTP id j20mr3763359iog.223.1573134125585;
 Thu, 07 Nov 2019 05:42:05 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:05 -0800
In-Reply-To: <00000000000024f01405708aab83@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd5cdb0596c1d4a7@google.com>
Subject: Re: WARNING: ODEBUG bug in p9_fd_close
From:   syzbot <syzbot+d702a81aadeedd565723@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net,
        dominique.martinet@cea.fr, ericvh@gmail.com, jiangyiwen@huwei.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com, tomasbortoli@gmail.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 430ac66eb4c5b5c4eb846b78ebf65747510b30f1
Author: Tomas Bortoli <tomasbortoli@gmail.com>
Date:   Fri Jul 20 09:27:30 2018 +0000

     net/9p/trans_fd.c: fix race-condition by flushing workqueue before the  
kfree()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b5c342600000
start commit:   1e4b044d Linux 4.18-rc4
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=d702a81aadeedd565723
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17fa550c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1214c2c2400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: net/9p/trans_fd.c: fix race-condition by flushing workqueue  
before the kfree()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
