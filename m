Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC7DC41517
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C2F22387
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392357AbfGWWRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:17:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:34174 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731353AbfGWWRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:17:01 -0400
Received: by mail-io1-f72.google.com with SMTP id u84so48892157iod.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Wc2GRQ8gP6XwuqazuIoFspLdgI5vGhNFmUdsnDHhoCY=;
        b=BJW0Q2zNkGbBkBPVYS2ZmL+kKYOYNJbc6aBJ1O2iHqP/VwdJ5inG0k41j1GtsuNpTB
         WqeCcMuH8ihnQcaRW0OW84cl0JhBwOe0AhYguJWoSFO9XMnvMd7GkOTOiyg/S5ZOgwoa
         x/hsZ/ohqVP8A2Uejw8vQIXjXRdeg5ZMj64RIrX8dkMkaKsbUCnXaZP8dmxUWThbK2jK
         tBa7qO18a8aFhd4TGmW5dtE+nQs4sa3ybmKPKiyB+mB+PGMignpnDnmPjKEcb2/mR3R6
         GNxXxhAoceWF4b/Uy2Rgc0Lvzyd52CpVST+MaHY2X9c7jJmg+iYTbu2GxKX0F2XNB37w
         sBQA==
X-Gm-Message-State: APjAAAWLr+u6pPKuE4BQPkXxft6zeU3ALjX8j+JGN1E9M1YdTO4wbkKc
        wR7fDxeFyQ/h+gdIHHhu6D3cTUseMemPsn/LDRe/375GVVyK
X-Google-Smtp-Source: APXvYqynAoeiP6otUFVILsXnOFuFz0uSuLj1NQooZi4V+EzbzIGh6v4AwqOrxFa7CDpPfgeCk6q5DDGEZIUetLOW5G1d8Jhge8u1
MIME-Version: 1.0
X-Received: by 2002:a6b:6310:: with SMTP id p16mr73998019iog.118.1563920220602;
 Tue, 23 Jul 2019 15:17:00 -0700 (PDT)
Date:   Tue, 23 Jul 2019 15:17:00 -0700
In-Reply-To: <000000000000ad1dfe058e5b89ab@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034c84a058e608d45@google.com>
Subject: Re: memory leak in rds_send_probe
From:   syzbot <syzbot+5134cdf021c4ed5aaa5f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        davem@davemloft.net, dvyukov@google.com, jack@suse.com,
        kirill.shutemov@linux.intel.com, koct9i@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, neilb@suse.de, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, ross.zwisler@linux.intel.com,
        santosh.shilimkar@oracle.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, willy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit af49a63e101eb62376cc1d6bd25b97eb8c691d54
Author: Matthew Wilcox <willy@linux.intel.com>
Date:   Sat May 21 00:03:33 2016 +0000

     radix-tree: change naming conventions in radix_tree_shrink

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176528c8600000
start commit:   c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14e528c8600000
console output: https://syzkaller.appspot.com/x/log.txt?x=10e528c8600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8de7d700ea5ac607
dashboard link: https://syzkaller.appspot.com/bug?extid=5134cdf021c4ed5aaa5f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145df0c8600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170001f4600000

Reported-by: syzbot+5134cdf021c4ed5aaa5f@syzkaller.appspotmail.com
Fixes: af49a63e101e ("radix-tree: change naming conventions in  
radix_tree_shrink")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
