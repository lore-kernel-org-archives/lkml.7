Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3D8C432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 12:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5939C206F0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 12:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfLAMVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 07:21:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:52267 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfLAMVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 07:21:02 -0500
Received: by mail-il1-f198.google.com with SMTP id d28so21111902ill.19
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 04:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GVY0UTUiXioZDjlRk/qecxkTZeBZDfVOMX99Ih6OaLc=;
        b=EJli8nWS381tb7jqm22X4S2+E/ow9nexximY4krk9uX3xd/akdGIvY1v09VcJCIP9S
         SMdHuW7Pwt8pLZGnNeSe6F82Ui8CFNCHiAT04otXvA7/lRIamUxf3X7oYaggm6MvOJJQ
         pIqODQiVcRfEPOcezfOonlyQ3iWatYDykPNC/CtBqfr5xvLDHOLb/wXAygMebOYFqGPD
         WHYy7S6DvM3/8dLMwoopguhEHKH3ZvMsixGHrGFJTonLXdhDzgesJG1CSzDzyKeZYlUA
         27Sy/2OqE2bc47u+Q3XKVIoU09zOXxL6nD5ibIf1nFGGXbWMm0W2zXUlCmEoOGQtE44O
         4SQw==
X-Gm-Message-State: APjAAAUX3C3U1W6yaYlVdYZsyKwHRSixJerEVobB9DWE3aosQdVOEBAR
        oeknHDPnrhiWFqoutc0ALU8/WxN6qz7OQKsBJxJ+xMLRg+am
X-Google-Smtp-Source: APXvYqwLjsnwo03Ul2BYgUkun/p3JrCB6SxssAjMKsUkndmkq3uSYWsLeXnN03u+Z3ZugKktO5DrMm7z1HBb+XaIz9d6MA9i8PdJ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:6c1:: with SMTP id p1mr19554105ils.217.1575202861317;
 Sun, 01 Dec 2019 04:21:01 -0800 (PST)
Date:   Sun, 01 Dec 2019 04:21:01 -0800
In-Reply-To: <0000000000007cace40598282858@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff87e40598a37ead@google.com>
Subject: Re: WARNING: refcount bug in smc_release (2)
From:   syzbot <syzbot+96d3f9ff6a86d37e44c8@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kgraul@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        ubraun@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 50717a37db032ce783f50685a73bb2ac68471a5a
Author: Ursula Braun <ubraun@linux.ibm.com>
Date:   Fri Apr 12 10:57:23 2019 +0000

     net/smc: nonblocking connect rework

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a234a2e00000
start commit:   32ef9553 Merge tag 'fsnotify_for_v5.5-rc1' of git://git.ke..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12a234a2e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14a234a2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
dashboard link: https://syzkaller.appspot.com/bug?extid=96d3f9ff6a86d37e44c8
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b57336e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149e357ae00000

Reported-by: syzbot+96d3f9ff6a86d37e44c8@syzkaller.appspotmail.com
Fixes: 50717a37db03 ("net/smc: nonblocking connect rework")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
