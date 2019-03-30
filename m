Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E529C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 21:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5587F217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 21:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbfC3V6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 17:58:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:40348 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730582AbfC3V6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 17:58:01 -0400
Received: by mail-io1-f70.google.com with SMTP id e72so4808772iof.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 14:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=k6B3sI3f01UvtTgl/Kut52Y+9/3D0rGdINg0/Zq16/g=;
        b=f/5x6x1vr/MMlYlnOyMWbhubTzsx9dQZKwXurP+4APCKW4fC6QMfdcyBalBKlR1gSW
         WJ4qj8tr2esvTqU4wIqXI3/ueB/ZUPgjAKNJNDruXOTbG98iLRN6CTEs/ybZvk05Q6vo
         +Hw4jG7FBXgSGc0Z8guuRG+1iAokA2GWI6mUN86+8gOuFJDz82Kn6fL4lg+3RsGIZqEM
         EQEFHEM3nisv7u5T5qFuetVy2F+OCS9KmtmczZHNAJz9jkOAuh5Qb10dnT7dmJrmZxSc
         5eW1xBmQxpJSNvuNr5A04jIDi8uXtR0v0MREKSmpc4VdeLEgWHbvFjHdyPehpKWsI9pV
         nGeA==
X-Gm-Message-State: APjAAAVUxZLmpUC6tiDpQdN3pxl9ArUz0L/37gI2HK85kF8D2o8Jtytg
        i2HPhSKSolnvAt2wfdEhaNLch3GpCRNGFY5WtgOZgikpor+T
X-Google-Smtp-Source: APXvYqzCnqzUt3/H+l8Aaq9aPhcPibViVv39HNOVnP4QwM6x2tqXyb1c/pHWDNrIBO/mnknZhtx/YIpB4/a4KiESA9+DNghmOHdn
MIME-Version: 1.0
X-Received: by 2002:a6b:ee16:: with SMTP id i22mr4604371ioh.9.1553983081126;
 Sat, 30 Mar 2019 14:58:01 -0700 (PDT)
Date:   Sat, 30 Mar 2019 14:58:01 -0700
In-Reply-To: <0000000000005ff8b20585395280@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089a718058556e1d8@google.com>
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
From:   syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bvanassche@acm.org, danitg@mellanox.com,
        darrick.wong@oracle.com, dledford@redhat.com,
        gustavo@embeddedor.com, jannh@google.com, jgg@ziepe.ca,
        johannes.berg@intel.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-xfs@vger.kernel.org, longman@redhat.com, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        roland@purestorage.com, shamir.rabinovitch@oracle.com,
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f1bacd200000
start commit:   0e40da3e Merge tag 'kbuild-fixes-v5.1' of git://git.kernel..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1409bacd200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1009bacd200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
dashboard link: https://syzkaller.appspot.com/bug?extid=6f39a9deb697359fe520
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e1bacd200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1120fe0f200000

Reported-by: syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com
Fixes: 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for  
workqueues")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
