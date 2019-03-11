Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3C2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D56206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfCKN0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:26:04 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:47227 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfCKN0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:26:02 -0400
Received: by mail-io1-f72.google.com with SMTP id b199so4135127iof.14
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dC2/S12LudiC91A+3Jzu7G1IuaZ15WyK3Dbh5uAud2Y=;
        b=c1Ht7f2cIUI0dJ/p0FrwTreD6jeGhQY8c9arm9ek6rjrq2Ot+F9gC1BwtDO7aPeY41
         Qr9/J05+IOtu6S2lImnEZS9frAefQX6bGHT6E5qvdiM5syJN7GljActYSjgg1R7h1n2n
         w8M/nhkc+adFecME3k1h+0raglmDr5I+55j71K/iYmIdOcYUdr3m0rSgr8frpkXyPEwb
         JVJro7m5gkYxukw/KEvNRVGkTPGJYQpLVfzdYIg0DuEFd4m3/xG2DIGor0t7M6IuG0ZV
         l8mX6P8cIVpRONJ15Kdlq0mlml7TDEYdFQwXn/mHp29mQmZOH0zqGdkl5XJ/kZbtW6+P
         WTCg==
X-Gm-Message-State: APjAAAWm6dsIUvPBhx6NH0lT1rmb1p1Smvv4TxnvFGw7GEBvvZWNT/Ri
        eaipSK2M4jRjjyzFCnn8AmPfHfwHTRgx8VACKovMzIiob2h3
X-Google-Smtp-Source: APXvYqybyyz92WURHq4RPTXO6DqaPyhkSMukRwJMFl1miRQnuyVAUZixolvpRI2U2XoM40CIZrFFb+c1QI3M+zO5APSkYcFxifNK
MIME-Version: 1.0
X-Received: by 2002:a02:6018:: with SMTP id i24mr19188472jac.6.1552310761194;
 Mon, 11 Mar 2019 06:26:01 -0700 (PDT)
Date:   Mon, 11 Mar 2019 06:26:01 -0700
In-Reply-To: <000000000000299b190583172880@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080952b0583d183f0@google.com>
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low!
From:   syzbot <syzbot+78923eea7cf44364f4fb@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bvanassche@acm.org,
        darrick.wong@oracle.com, dledford@redhat.com,
        gustavo@embeddedor.com, hch@infradead.org, jannh@google.com,
        jgg@ziepe.ca, johannes.berg@intel.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-xfs@vger.kernel.org, longman@redhat.com, mingo@kernel.org,
        mingo@redhat.com, paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        roland@purestorage.com, sean.hefty@intel.com,
        shamir.rabinovitch@oracle.com, swise@opengridcomputing.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org,
        torvalds@linux-foundation.org, will.deacon@arm.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 669de8bda87b92ab9a2fc663b3f5743c2ad1ae9f
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Thu Feb 14 23:00:54 2019 +0000

     kernel/workqueue: Use dynamic lockdep keys for workqueues

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17dec757200000
start commit:   669de8bd kernel/workqueue: Use dynamic lockdep keys for wo..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=143ec757200000
console output: https://syzkaller.appspot.com/x/log.txt?x=103ec757200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd349f14600e1305
dashboard link: https://syzkaller.appspot.com/bug?extid=78923eea7cf44364f4fb
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149c858d200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111aee33200000

Reported-by: syzbot+78923eea7cf44364f4fb@syzkaller.appspotmail.com
Fixes: 669de8bd ("kernel/workqueue: Use dynamic lockdep keys for  
workqueues")
