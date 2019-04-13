Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A36C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 09:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC442084D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 09:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfDMJjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 05:39:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:37057 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfDMJjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 05:39:01 -0400
Received: by mail-io1-f72.google.com with SMTP id u22so9934621iof.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 02:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zhnnMPAYyjhof9DGu4JH1t3WZ26OhXzs43pjx2pf0ms=;
        b=HQBMNyXudoGS7vwMcQV9/7XknAUMDxK6L1BKkTzy+Z/R1P1xYWIgUrdM9YotVT/OKs
         pH8b6GJsPABKdE5NOJt/0fIlshWoMT4igZRtw0gwjx1BZwPTlrR26OOE2uK0itMAph3D
         Dcn/ZpUnd52g5gniMxKg+cGCsIeI9SqWhpm8eXm7EJfUj+ddyaUsc9RBqLkkVZwF1g+I
         8/QlzV0wTV7JUBpxaM07LvsMmGyVFDANTUGXp8+vLR8UPq0r0GsdGLcl6BENz30l5Yrh
         zc8yPrUcfccm4k2LQUUHHGGPurs/9dYnUrtzelSH2qseScJNErH/RhHYqqtf8Fi3PolP
         Lpag==
X-Gm-Message-State: APjAAAV8L1y3acvTE8PALIKOQN9UJNVVVtu+5dyQYE3gTf/lcBe9bWua
        jS3c46IpGNxQ7LR08pj28M2tqQHaIUExqH/0oQpvL+082B5O
X-Google-Smtp-Source: APXvYqzW076067G76jydyCII3hjbjjKj5S9k1lW0JJ+YklPs+IiyQoR57G2c/BFFM+q5yxVVXgZ7A5PJBxRpJXExyr8dQcUnBHgJ
MIME-Version: 1.0
X-Received: by 2002:a6b:c403:: with SMTP id y3mr4247190ioa.38.1555148340625;
 Sat, 13 Apr 2019 02:39:00 -0700 (PDT)
Date:   Sat, 13 Apr 2019 02:39:00 -0700
In-Reply-To: <0000000000000482ce056d7c1436@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a8b3505866630b5@google.com>
Subject: Re: general protection fault in requeue_rx_msgs
From:   syzbot <syzbot+554266c04a41d1f9754d@syzkaller.appspotmail.com>
To:     alan.brady@intel.com, andrewx.bowers@intel.com,
        davem@davemloft.net, ebiggers@google.com, edumazet@google.com,
        intel-wired-lan@lists.osuosl.org, jeffrey.t.kirsher@intel.com,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tom@quantonium.net, viro@ZenIV.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 11a350c965cc5ac2f5d0ed1fb336735a0c1a6344
Author: Alan Brady <alan.brady@intel.com>
Date:   Fri Dec 29 13:48:33 2017 +0000

     i40e: fix typo in function description

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1534b397200000
start commit:   0044cdeb Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1734b397200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1334b397200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=968b0b23c7854c0b
dashboard link: https://syzkaller.appspot.com/bug?extid=554266c04a41d1f9754d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131a208f800000

Reported-by: syzbot+554266c04a41d1f9754d@syzkaller.appspotmail.com
Fixes: 11a350c965cc ("i40e: fix typo in function description")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
