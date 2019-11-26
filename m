Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BEDC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5CF2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfKZKQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:16:04 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:51445 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfKZKQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:16:03 -0500
Received: by mail-il1-f198.google.com with SMTP id x2so16057823ilk.18
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 02:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7ecu66BMHVud9DuzcAquPrxjiVzhM/h7EUP/vbsVeT0=;
        b=EZQS6/cGgyceVt+smeIZC543Go80NJt9LlP+Tmg4ivdbdW2yyzylpaBNufqDfmlXCs
         EYInTYbIniTG6ikvUhh/yI/acJHT4EGqnCfbWKIWy479xsA6ZOcuAUhtq7V6DV2yMIoS
         9rrgJmlnziEhmb++iZPNlDwHp8KsC1dAbUG3OBLyhwKrQI/Me8to1AGBswumDtMbehCx
         jJmAn7WOIix6FjG3LRFh4oOJP+oCfUXJxm6Aa+cF7On+hchRHWj21RCJ1Z1Wi2TSq+Ra
         AW4naJkJdnN1x4BCxA0xjN/X79pnQYBnpgmXo+2D7XvLWkiELrS3Yk9vcmGy7A/aThz7
         wqjA==
X-Gm-Message-State: APjAAAVnzfq/1s7aiu5D45ZbUp7DDRyXzzHsjMCZ/ezsCgCTWeVq7oO9
        RXw2tdf2C+/qDRuH9oi07D5ePH/3kdMZ8Z/+M/Wrl1i09fv0
X-Google-Smtp-Source: APXvYqyozbo+bQ0Kv4jzAJMRKPS3S8LaBuyHiSS+ZbpT2Dw8Sg5CxjtmgBByAoHJJQ7lf7NxK6t1Htol/EVxcnlk7n9dOWJV1knV
MIME-Version: 1.0
X-Received: by 2002:a02:c9c6:: with SMTP id c6mr13899624jap.133.1574763361594;
 Tue, 26 Nov 2019 02:16:01 -0800 (PST)
Date:   Tue, 26 Nov 2019 02:16:01 -0800
In-Reply-To: <0000000000001558f3056a369689@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5f3d905983d2ae0@google.com>
Subject: Re: WARNING in __device_add_disk
From:   syzbot <syzbot+3337db851ace689ceb50@syzkaller.appspotmail.com>
To:     akinobu.mita@gmail.com, akpm@linux-foundation.org, axboe@kernel.dk,
        dvyukov@google.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@kernel.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e41d58185f1444368873d4d7422f7664a68be61d
Author: Dmitry Vyukov <dvyukov@google.com>
Date:   Wed Jul 12 21:34:35 2017 +0000

     fault-inject: support systematic fault injection

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17889f5ae00000
start commit:   6da6c0db Linux v4.17-rc3
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14489f5ae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10489f5ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a1dc06635c10d27
dashboard link: https://syzkaller.appspot.com/bug?extid=3337db851ace689ceb50
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15191837800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120af5c7800000

Reported-by: syzbot+3337db851ace689ceb50@syzkaller.appspotmail.com
Fixes: e41d58185f14 ("fault-inject: support systematic fault injection")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
