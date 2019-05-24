Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1649C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67BB2177E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388602AbfEXB6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 21:58:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:53063 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388338AbfEXB6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 21:58:01 -0400
Received: by mail-io1-f70.google.com with SMTP id j26so1841256iog.19
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 18:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=955OHyvWfWzvm1GRTftGUzdKB7MA3Z4tCp1YPcfjoEE=;
        b=eEfZoqnlBE1fEK3RvI4Dj0FUPlbhvleiykMSUSC6h3qj5jPmWBWT5tUYhsqDBhsKUF
         V/MzmNshl+8gbOmMxFeYrt+bKYH5tRUVWJyRm5+Y4oPNNFBIVXUwWRwgpou1jCGdpiU/
         Wg1G4IZPkSRfdLJeDpOeOMI98ltCcYdKRNfdnIqlksJ6sIx1q4dkvHrUBPfUjQ6w9T6E
         zzHtKUEuYWWp4qiGsSR92CJwZ1Tg2J9/Mc0Wvsh15PbThWrAe/Lg7m5QoWBGXxFs85aq
         Q8hNiQyIPteD74vdiaRq79jNwSVLtP6FqUnEYYd4nINJIxzVk3ODiY+KlIN1CdiNnDJ/
         27YA==
X-Gm-Message-State: APjAAAVwEMw6GtHDR6kDznKTPBHKVV41vMIKMXfQbWraDf/4IA3gFeMP
        oCU0FiacWIDRjHselpZASK5uhZ8Wzs9S4Gzm54wVFzeX59C0
X-Google-Smtp-Source: APXvYqwaoXSCXsvV1QYH0vRAsKbXKMU3okraTaYo4SkwkMm0SrYG4erFBFg8bbcy+0lpOO4en1vA0texEuQay7Fz+tlfQjlA6QXh
MIME-Version: 1.0
X-Received: by 2002:a24:d845:: with SMTP id b66mr16266145itg.94.1558663080569;
 Thu, 23 May 2019 18:58:00 -0700 (PDT)
Date:   Thu, 23 May 2019 18:58:00 -0700
In-Reply-To: <000000000000af6c020589247060@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003df61e05899887d3@google.com>
Subject: Re: BUG: spinlock bad magic in rhashtable_walk_enter
From:   syzbot <syzbot+01dd5c4b3c34a5cf9308@syzkaller.appspotmail.com>
To:     davem@davemloft.net, hujunwei4@huawei.com, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, wangxiaogang3@huawei.com,
        ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 7e27e8d6130c5e88fac9ddec4249f7f2337fe7f8
Author: Junwei Hu <hujunwei4@huawei.com>
Date:   Thu May 16 02:51:15 2019 +0000

     tipc: switch order of device registration to fix a crash

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17c22c72a00000
start commit:   510e2ced ipv6: fix src addr routing with the exception table
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14222c72a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10222c72a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=82f0809e8f0a8c87
dashboard link: https://syzkaller.appspot.com/bug?extid=01dd5c4b3c34a5cf9308
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b6373ca00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1251e73ca00000

Reported-by: syzbot+01dd5c4b3c34a5cf9308@syzkaller.appspotmail.com
Fixes: 7e27e8d6130c ("tipc: switch order of device registration to fix a  
crash")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
