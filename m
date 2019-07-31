Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFC9C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 21:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD07206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 21:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbfGaVcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 17:32:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:40063 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbfGaVcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 17:32:01 -0400
Received: by mail-io1-f70.google.com with SMTP id v11so76700653iop.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 14:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=f0dy6kexOd2FnIvWJ+xs8RuUZn++/g3nMaxpfE04Ep0=;
        b=cRaGC0qPWGJtWUiCYyiYkThItTkApgKOdlyKfNdbNaIgyU7oAxa7ccr5pKzqlx93bm
         7T8SSC/EEvJ3mrsmywhtmzOdsj+El7Y7ktxTM0WQBo3TWKte6N5/2JHJe2DAr2yaBPEJ
         WfNdEEoeEClHxoCcmURQGOtkg0E+MZXcW+hSdlApVtMXHh73jkyKHGIH5kSG3MP/GcbB
         y7Rm8kR2rIYJAj8dTO59FTwml9Kbzs4Gc4iLAoYQF7dlkI/bmrfSY/imQJHSFF0HpiCQ
         rb1ccxJstbL3DNorMu4hKz2dYP1XO1jXdAKOPXbBTpP4NEET0YXU5KR9b/3XUvGQ/cUK
         Dxag==
X-Gm-Message-State: APjAAAU6zRheY+BQEToM7M6TPH6qeh9zz6jRpxSk1SPDGxwjuyQuIal6
        4sXDkGQ8IQ+EbZ/gwKJC2PD9L0Sw3L2pvTaO9Ihhn8ac58tm
X-Google-Smtp-Source: APXvYqwVPz+8gD0GBmy3CsE0op/bI4tHp70A9CTOcj/3hT40iRHICuhe/dAtU7/Fw6Klat0pJPM5AyBuP8aWPA3vxEXR67WnoJpp
MIME-Version: 1.0
X-Received: by 2002:a02:914c:: with SMTP id b12mr83757999jag.105.1564608720391;
 Wed, 31 Jul 2019 14:32:00 -0700 (PDT)
Date:   Wed, 31 Jul 2019 14:32:00 -0700
In-Reply-To: <000000000000e42667058e554371@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdd90c058f00daca@google.com>
Subject: Re: KASAN: use-after-free Read in nr_rx_frame (2)
From:   syzbot <syzbot+701728447042217b67c1@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dvyukov@google.com,
        linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ralf@linux-mips.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit c8c8218ec5af5d2598381883acbefbf604e56b5e
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Jun 27 21:30:58 2019 +0000

     netrom: fix a memory leak in nr_rx_frame()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122ddaec600000
start commit:   629f8205 Merge tag 'for-linus-20190730' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=112ddaec600000
console output: https://syzkaller.appspot.com/x/log.txt?x=162ddaec600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e397351d2615e10
dashboard link: https://syzkaller.appspot.com/bug?extid=701728447042217b67c1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a6e008600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11937d92600000

Reported-by: syzbot+701728447042217b67c1@syzkaller.appspotmail.com
Fixes: c8c8218ec5af ("netrom: fix a memory leak in nr_rx_frame()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
