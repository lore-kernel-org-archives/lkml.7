Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DBCC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 19:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BF22075E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 19:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKXTHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 14:07:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:42190 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfKXTHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 14:07:01 -0500
Received: by mail-il1-f198.google.com with SMTP id n16so11885328ilm.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 11:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0iPpdRzq0L7+RSFavqTsQfmCi/uTeccXAim0E/TGr2Q=;
        b=QWeETcvoFtFrb0em+pBCPMKNBSdgmBojAmBZl72mxOakfhwau2xzGW3zlCCLF8IdGc
         JHnzNv1W4FO1e8/OUtdVQsik9gdJBkObz1bTbXEQ5T31UFZNbKCIZmCdhQXLkYJo/2KD
         NRK1+HrMQCKRSIIa51U5jNQ5e6m3w1w1wuqFbGlpImwbRUn97byLOD/yDNbJfEB9nH5n
         zDIsvMm2sNvEZbTXxMDF8OJpKiRiZB2oBQXb60o/2uiVyDoTRd7weu1pHktOyC0nO0Fh
         MGhaikJG+OfmNxNLuw1HKLmhD2xdd0WuCRVYcs3NfJON6CsFgMjQFS6WZXLKhmyGOV6t
         Jx1A==
X-Gm-Message-State: APjAAAXnK6+bqceUcyuzxzOzJbatbXRyM5rqez1lybbG8S2jDo7oEpOR
        VJ6jaZkUZhpzYPj0GeFrzC6rr31OYHV2rdVsRuD0eAQ+LCAo
X-Google-Smtp-Source: APXvYqxzdQLTUAzZHkNrn+IW7dBHAAZnrSGKEzdtkJeRCBqjt/+dvnBg9GSfzUg/aUk4k+sN4UpRfbhAt4p8PcJXTniYzbgEeEFN
MIME-Version: 1.0
X-Received: by 2002:a5d:9153:: with SMTP id y19mr23281646ioq.26.1574622420789;
 Sun, 24 Nov 2019 11:07:00 -0800 (PST)
Date:   Sun, 24 Nov 2019 11:07:00 -0800
In-Reply-To: <000000000000e59aab056e8873ae@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000beff305981c5ac6@google.com>
Subject: Re: KASAN: use-after-free Read in blkdev_get
From:   syzbot <syzbot+eaeb616d85c9a0afec7d@syzkaller.appspotmail.com>
To:     cmetcalf@ezchip.com, coreteam@netfilter.org, davem@davemloft.net,
        dvyukov@google.com, gang.chen.5i5j@gmail.com, kaber@trash.net,
        kadlec@blackhole.kfki.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 77ef8f5177599efd0cedeb52c1950c1bd73fa5e3
Author: Chris Metcalf <cmetcalf@ezchip.com>
Date:   Mon Jan 25 20:05:34 2016 +0000

     tile kgdb: fix bug in copy to gdb regs, and optimize memset

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1131bc0ee00000
start commit:   f5b7769e Revert "debugfs: inode: debugfs_create_dir uses m..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1331bc0ee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1531bc0ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=709f8187af941e84
dashboard link: https://syzkaller.appspot.com/bug?extid=eaeb616d85c9a0afec7d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177f898f800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147eb85f800000

Reported-by: syzbot+eaeb616d85c9a0afec7d@syzkaller.appspotmail.com
Fixes: 77ef8f517759 ("tile kgdb: fix bug in copy to gdb regs, and optimize  
memset")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
