Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BEAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 03:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BE3206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 03:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfKKD5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 22:57:04 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:49282 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfKKD5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 22:57:03 -0500
Received: by mail-il1-f200.google.com with SMTP id c2so15781308ilj.16
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 19:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ahqf5JMi9x4MvVhOL42cOCJqrc4gS0aQJVD9aozCigk=;
        b=hvUBZ+8PG37+dBHkQLygVTgmQ9VdDwwnbD8DwZKHQqFiMC5xxVO/ucksQzu2n/CRzQ
         eOQHjj+asQTcjGuz5MM0bxaDxVJXbPle4Bhf1e5hsPVd+yfBi0sGDrBPcsDs6nZpZwg8
         5xBcHeY741peZcor0CMVqEFxLiBu0k7bCsHSWPMhKCK2bTYweQH7FNSaGRhi5S6CvbJT
         +K24oZER68H83Fi25aH/HqyxZ66i9H6paOOcDXRRrUzH0TloXDUUP+FMDVIcw0livnGj
         NNedU1OcMGU0/werj6eBCNBHGExmfduf2cmccax4OUhq880wd5vRv6YT1Y14mh20nDBa
         Ln3g==
X-Gm-Message-State: APjAAAUWpxgoh7T2TzjlhQy1Do5wICoSprKDmhOoNR2o9MjNEpPXXJ+f
        gIRmWQwoSvBW3wQb6CoqXzlWvjiiJ+1A1v6dyTJfmOE2Wusq
X-Google-Smtp-Source: APXvYqxIayoK3rWM7U/FC6CNlkGPnuolY7jUbXULvgiXcBHeAhVQj+4RetmukhTi4OYUOkBjLlTShjAPyzdnLzWMGXOucgeE3et/
MIME-Version: 1.0
X-Received: by 2002:a02:3903:: with SMTP id l3mr22649703jaa.72.1573444621272;
 Sun, 10 Nov 2019 19:57:01 -0800 (PST)
Date:   Sun, 10 Nov 2019 19:57:01 -0800
In-Reply-To: <00000000000082c66d059705e442@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b98cf305970a1fd3@google.com>
Subject: Re: KASAN: use-after-free Read in j1939_session_get_by_addr_locked
From:   syzbot <syzbot+ca172a0ac477ac90f045@syzkaller.appspotmail.com>
To:     bst@pengutronix.de, davem@davemloft.net,
        dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com,
        kernel@pengutronix.de, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de,
        netdev@vger.kernel.org, o.rempel@pengutronix.de, robin@protonic.nl,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 9d71dd0c70099914fcd063135da3c580865e924c
Author: The j1939 authors <linux-can@vger.kernel.org>
Date:   Mon Oct 8 09:48:36 2018 +0000

     can: add support of SAE J1939 protocol

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11bc06d6e00000
start commit:   00aff683 Merge tag 'for-5.4-rc6-tag' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13bc06d6e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15bc06d6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5e2eca3f31f9bf
dashboard link: https://syzkaller.appspot.com/bug?extid=ca172a0ac477ac90f045
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144150e2e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aaa9fce00000

Reported-by: syzbot+ca172a0ac477ac90f045@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
