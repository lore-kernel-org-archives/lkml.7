Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA28DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE1A218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfCUCDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:03:04 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:49131 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfCUCDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 22:03:01 -0400
Received: by mail-io1-f69.google.com with SMTP id 186so3879396iox.15
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 19:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1R50ONlQ6mKiAOyj0s+7aiQDS6ROh29uHJivg+HXM6g=;
        b=fFbcwuRWFD6Mk2ZsVcgNxEocNn5LwJ7TqxB9hIbJlrZuedOyC4mJdYgCKvQfSXbiwo
         Jorke1HH9ZE2DQ/VMqb1ywj85mRX/HqoeoGuTVnAhLWwBV8tZtkaOKaRFghZyvSyQMob
         1/HE7H+yxnr6ZfRFtKbJamYEM+BChZtG2oFFm5iLdZeUeBWwvg3FVo5vYoWMTwDbHkYF
         FvaIltEiYk3N0ju8VyQzTEIkCZzpxZoo39Pg08DcsL/zxmegShPtKV2gTI/j1R4pvII2
         y6QgmMCQmjKuvvAuW6pcfMFEm6vUBjlgC5DsowPir/CiY6E2wcC+wYNXND+j/udI87I0
         In+g==
X-Gm-Message-State: APjAAAWS8ZusctTWsiwmEWZOy9ku2K0qeJKRf926urvd8bZJ5F/g3HJo
        hdxhMz7c1zJx5+GErMN3ftGXEFtfWZyoRZrqHsh5RGLO7KI8
X-Google-Smtp-Source: APXvYqyxULQgqaG+X+CPfJEGVPmX6eN5HYfBE4/ShwbEhbe1Ii/ebmkBZZlSW2nqegHHPLJkx27BJaNUYoZq4bVMb6sn+DXVcp7Q
MIME-Version: 1.0
X-Received: by 2002:a5d:899a:: with SMTP id m26mr609234iol.5.1553133780355;
 Wed, 20 Mar 2019 19:03:00 -0700 (PDT)
Date:   Wed, 20 Mar 2019 19:03:00 -0700
In-Reply-To: <000000000000445dd9057a7149f1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044534c058491234b@google.com>
Subject: Re: general protection fault in rds_recv_rcvbuf_delta
From:   syzbot <syzbot+4b4f8163c2e246df3c4c@syzkaller.appspotmail.com>
To:     chien.yen@oracle.com, davem@davemloft.net,
        dennis.dalessandro@intel.com, dledford@redhat.com,
        ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, mike.marciniszyn@intel.com,
        netdev@vger.kernel.org, rds-devel@oss.oracle.com,
        santosh.shilimkar@oracle.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit b534875d5ab348fb9193692589e2ee82ae768e3a
Author: Dennis Dalessandro <dennis.dalessandro@intel.com>
Date:   Wed Jan 6 18:02:59 2016 +0000

     IB/rdmavt: Add device specific info prints

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13e03843200000
start commit:   b534875d IB/rdmavt: Add device specific info prints
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10103843200000
console output: https://syzkaller.appspot.com/x/log.txt?x=17e03843200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e0064f906afee10
dashboard link: https://syzkaller.appspot.com/bug?extid=4b4f8163c2e246df3c4c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11631328c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1172c7ef400000

Reported-by: syzbot+4b4f8163c2e246df3c4c@syzkaller.appspotmail.com
Fixes: b534875d ("IB/rdmavt: Add device specific info prints")
