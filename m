Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D00EC433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 07:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2F82087C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 07:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbfHCHnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 03:43:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:50909 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbfHCHnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 03:43:01 -0400
Received: by mail-io1-f69.google.com with SMTP id m26so85869009ioh.17
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 00:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yMorIrW4ay3tdK2qTcsDnVE/Pjijxze3b99wXe/WPcY=;
        b=OkTYuMUgOddbrmvENdtegQkrZr64pw9YQW600hHe1x7DlpEDJh71Ta9VIeiE1YJmWM
         d8ChvRyFeu0rGQ3lpfqPta2DQMprJ7IFt8QdyFcmHOQfBsnBwVcazYadrU+zvjffYreQ
         lsntvVFSKUrigDBstq7A8CG+kvjQL7hH8dIFhpl6qwX9qmg3W4srXHvCq659wvRMZDwA
         c2yskv53nwsvjGgDhI9nLo0qJ2ejY57Y3Z8Rm1Ux1zzz1xizLBe8t9y6ja+vvM7B2Ie+
         PquT010In9I2jMDAZlat0rO3m0hnYMAqUAAtojFUIf/mE03oQWEd++41idFE3iFd/0n0
         afig==
X-Gm-Message-State: APjAAAVJEt4kA5fpRBeT7jXHTG86jcLJlSxEXNCinRUWICoH0M8bQx/D
        yiRnIBFzov1cfna0yV2VItIwuWv3xDJO7XlyChbuN0GYMQPy
X-Google-Smtp-Source: APXvYqyODxVlDnjmRqYXt2tj0Z1xEFiKx4T/bWkQb1PzdLwDQuMC91pWxkePCa7Pu2aTkOoYz58Kc11H06whknBe3wOWUzTFH6uy
MIME-Version: 1.0
X-Received: by 2002:a6b:b804:: with SMTP id i4mr5520996iof.119.1564818180769;
 Sat, 03 Aug 2019 00:43:00 -0700 (PDT)
Date:   Sat, 03 Aug 2019 00:43:00 -0700
In-Reply-To: <000000000000a2db16058f2514fa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd8e92058f319f8c@google.com>
Subject: Re: KASAN: use-after-free Read in blkdev_direct_IO
From:   syzbot <syzbot+0a0e5f37746013dc7476@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, davem@davemloft.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit b9a1e627405d68d475a3c1f35e685ccfb5bbe668
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Jul 4 00:21:13 2019 +0000

     hsr: implement dellink to clean up resources

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1589f3e8600000
start commit:   1e78030e Merge tag 'mmc-v5.3-rc1' of git://git.kernel.org/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1789f3e8600000
console output: https://syzkaller.appspot.com/x/log.txt?x=1389f3e8600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7b914a2680c9c6
dashboard link: https://syzkaller.appspot.com/bug?extid=0a0e5f37746013dc7476
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fa7830600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f31c8a600000

Reported-by: syzbot+0a0e5f37746013dc7476@syzkaller.appspotmail.com
Fixes: b9a1e627405d ("hsr: implement dellink to clean up resources")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
