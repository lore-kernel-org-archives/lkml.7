Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5197C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 15:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18F521EF2
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 15:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfHQP2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 11:28:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:48179 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfHQP2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 11:28:01 -0400
Received: by mail-io1-f70.google.com with SMTP id 67so6744380iob.15
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 08:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qXE76hfKHYN2qVI6DJHVNV4EHRnZduBHUK4jM6XkuBk=;
        b=pdz1E3qwVIdVA5lLKm7++hgzMVm8vxlfr6n1D7C6wuF0U17yfzdq7o40xI7mSKMGN4
         9uu6Qwkf1MoP4A6ZD4g58TgM7//LB1kfBV8FsbNSz1JPHc1PW4fy+1PYsNMBOVofs2iu
         ZzkzV+VEJzuLgf93OcEGfg7x5J5Qs/Cy6SNSV6iLe67ZUQSMbziCTFX9c6wPeWBWf0jb
         WdivSWAi9FxUT0BhbSkTBEIbxEAs/qU3Rf1KwVPKnP1Vxa+Gk3tC16iLAQsRVJnNa6LJ
         nhwWGoxjc4f+PONqZvXWBPTKTOESbcQ0C7xhAf721TpYTF2v3huui0lxIrfiiJO4pHxa
         yWDQ==
X-Gm-Message-State: APjAAAXJXehXNR1C7iMm3At664464AgePwDVBzMEEfwpKr/3xJudLmmS
        tSedyGQkAPiU9cMCk5d9+2aNkpxCIfZlnZwnbp4Q283c8OKC
X-Google-Smtp-Source: APXvYqy32T19mCY7ScSzCH1AG2iuA/7tu57F30CzrxJU8e3Sn3tTW2DL/KSoBpfG8OZDLLKbeWQvoE0KFNbqI5MpLRsdLPIx4Cxm
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2193:: with SMTP id b19mr11372341iob.113.1566055680310;
 Sat, 17 Aug 2019 08:28:00 -0700 (PDT)
Date:   Sat, 17 Aug 2019 08:28:00 -0700
In-Reply-To: <0000000000008182a50590404a02@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000860647059051c0b8@google.com>
Subject: Re: kernel BUG at include/linux/skbuff.h:LINE! (2)
From:   syzbot <syzbot+eb349eeee854e389c36d@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, davem@davemloft.net,
        edumazet@google.com, f.fainelli@gmail.com, idosch@mellanox.com,
        kimbrownkd@gmail.com, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vyasevich@gmail.com, wanghai26@huawei.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit bc389fd101e57b36aacfaec2df8fe479eabb44ea
Author: David S. Miller <davem@davemloft.net>
Date:   Tue Jul 2 21:12:30 2019 +0000

     Merge branch 'macsec-fix-some-bugs-in-the-receive-path'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=125c5c4c600000
start commit:   459c5fb4 Merge branch 'mscc-PTP-support'
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=115c5c4c600000
console output: https://syzkaller.appspot.com/x/log.txt?x=165c5c4c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4cf1ffb87d590d7
dashboard link: https://syzkaller.appspot.com/bug?extid=eb349eeee854e389c36d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111849e2600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1442c25a600000

Reported-by: syzbot+eb349eeee854e389c36d@syzkaller.appspotmail.com
Fixes: bc389fd101e5 ("Merge  
branch 'macsec-fix-some-bugs-in-the-receive-path'")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
