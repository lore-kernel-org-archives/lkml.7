Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB3EC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 06:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3962820725
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 06:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfK3GwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 01:52:03 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:40880 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfK3GwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 01:52:03 -0500
Received: by mail-il1-f197.google.com with SMTP id y3so22222883ilk.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 22:52:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=LH+oNIdXBIwxjg57W3FD/l3zRLVtt0ZQgS0IxdqkKI4=;
        b=gLUg6j5v58NvT2s+Seiy9wNEoSAyD7a9VrIr5gUlNR7FJmwuNAiEhbTny1cn4pNhAm
         XMmt3n8nGdThqDhuwSIZHByU2OgNrvGbhl9lpd9ccRC/nu4jtMogtaGbgP2BgXdv0s5J
         dvpWJ1JGVrZIk2YXUV1aFNP69UJzD25H0wcVsC7lKrBMhCwGF5PlRY5K1SlNhwLy4h+s
         mZJuuNU3t3q5pdxoltgPZO5VmT8QGUBWC2GWrseXkLg+rCAjbdUFcmGVIAZBnNYXjb1T
         60yIibx45KK1gCscE1iQnhD9wo9eNDB/bsP7n9TDvH2Ifk5wtIgBNpHJuLK3PhnI8ASJ
         jbsA==
X-Gm-Message-State: APjAAAX0bv/v+/1yfiquWfmv/pWknLCJV/MLq4QM9X11hZmI0oZhtobr
        mFHHOv3qKMuCn4srsAtzSEmAdq5Dbp1m4D4wo9TpEWguSuOY
X-Google-Smtp-Source: APXvYqzqoowMlvXf8CnOvya7QGH5LnuwTEQxwGpMIbMv3o9ZqFbpzbnW4ixzkc+NCt/1cA8yqhHjXrz1y4jgMjrpQgUS8JclaVsN
MIME-Version: 1.0
X-Received: by 2002:a6b:6e05:: with SMTP id d5mr11393518ioh.90.1575096721095;
 Fri, 29 Nov 2019 22:52:01 -0800 (PST)
Date:   Fri, 29 Nov 2019 22:52:01 -0800
In-Reply-To: <001a113f39820d16d50567379661@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c415905988ac808@google.com>
Subject: Re: WARNING in tcp_enter_loss (2)
From:   syzbot <syzbot+c5a3099b94cbdd9cd6da@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, jmorris@namei.org,
        kaber@trash.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, ncardwell@google.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        ycheng@google.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit a0370b3f3f2cfb8b424b04c0545414abaa53f5ee
Author: Yuchung Cheng <ycheng@google.com>
Date:   Fri Jan 13 06:11:36 2017 +0000

     tcp: enable RACK loss detection to trigger recovery

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=114cbdf2e00000
start commit:   0644f186 Merge tag 'for_linus' of git://git.kernel.org/pub..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=134cbdf2e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=154cbdf2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61c12b53c2a25ec4
dashboard link: https://syzkaller.appspot.com/bug?extid=c5a3099b94cbdd9cd6da
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112146e7800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1317f95b800000

Reported-by: syzbot+c5a3099b94cbdd9cd6da@syzkaller.appspotmail.com
Fixes: a0370b3f3f2c ("tcp: enable RACK loss detection to trigger recovery")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
