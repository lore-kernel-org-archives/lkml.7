Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D4CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DE62083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfCRH2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:28:02 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:56172 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfCRH2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:28:01 -0400
Received: by mail-it1-f197.google.com with SMTP id y6so11429400itj.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 00:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aeFmCyCrVYNIJIpQ8LKWDYL/lnJSaEOYRC0x1QHkJqU=;
        b=YpKOnSVL5+KuLd/PY2HLC4OWNlUALhzqNkSIxQmHqfrOtDxRwPDqJblS8o3n+PX29k
         rhKHseqVsnMG4IAMkuuJ7Fj/Ed6ZIKyqNG22mipdNxzqyfqLkRuFdRdtOUbG2Pga1EYX
         r9Fman1aCKVZk5H0f+ur2C7R/Mhv95fpZDq6UkMwzOzS3CxmBZ043HiPIrghorxKMAw1
         VjPKoqudUXCjhouZ6A17T3u/TJQLHLKaWuZYsOnYTAqij/etJaszYKSwgpET6Ospzlgk
         HGELk7r3RJnzVmgZBBgr/8NcN47sigswjJA9gYLWPfJV08Ljl9q9MbeK229Sv0/LjQia
         on+Q==
X-Gm-Message-State: APjAAAUutaPYrLp1102MxFICLNgzxIVEXP7gKg6LSPwUHwuwUctrMXuF
        wUoabDD6OR4x8+O8HSGkLjTqfZKcWmWxW3mp4vEsKQrT5nCA
X-Google-Smtp-Source: APXvYqxkcW5VKTJ6SV8hO6p+6nvEAtMVxGxrnALfyaEfJZ37V1vcKT4tN52FTc7HRZQricyyHc7mRTt3G6bu1f7mw3tZlSgZ+5GQ
MIME-Version: 1.0
X-Received: by 2002:a5e:de0d:: with SMTP id e13mr9936936iok.10.1552894080904;
 Mon, 18 Mar 2019 00:28:00 -0700 (PDT)
Date:   Mon, 18 Mar 2019 00:28:00 -0700
In-Reply-To: <000000000000dbe73a057cd65da2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010f4270584595484@google.com>
Subject: Re: general protection fault in fib6_purge_rt
From:   syzbot <syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 52dfae5c85a4c1078e9f1d5e8947d4a25f73dd81
Author: Jon Maloy <jon.maloy@ericsson.com>
Date:   Thu Mar 22 19:42:52 2018 +0000

     tipc: obtain node identity from interface by default

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1116d2a3200000
start commit:   52dfae5c tipc: obtain node identity from interface by defa..
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1316d2a3200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1516d2a3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8b6073d992e8217
dashboard link: https://syzkaller.appspot.com/bug?extid=a25307ad099309f1c2b9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b2c56f200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b8890b200000

Reported-by: syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com
Fixes: 52dfae5c ("tipc: obtain node identity from interface by default")
