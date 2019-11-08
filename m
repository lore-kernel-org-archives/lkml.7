Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A766C17440
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 23:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE4420674
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 23:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfKHXWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 18:22:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:56104 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfKHXWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 18:22:01 -0500
Received: by mail-il1-f197.google.com with SMTP id n81so8547289ili.22
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 15:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fZBWZmhBvbt6zcf8opfeH4uRGdLcSuaPay33uvUsov8=;
        b=FqU9UOuzhRn0BBA/rK5KyfGSDg5fEhiB2gViXO14kbdP1LRr5CzsYM1ThRSpRpetmh
         ZgSoN0QFCG3ELNotLVFKAUMlXUf59uN65prRx6Hy0mVLCHnK+Sn0ErDjvnT3cnfHN2ye
         HsWh9WeMbuxAPG8L9x/LxZwEyB+viVJlEMlmj0gTL9O4dM/TDSa3UeNw7BxK7Qq4tr6L
         9L1hDe0yBcwVcPUL2BLA0XTAoOwJsP/WX1I59DHAeDvkvTGQchDTlf8Z47R2LwufZxTl
         /bghoZeG+AC5FY9QGelt4xvfWuGTXQvUXQy9JqUoUVEVpytLxvNku4ctl6AxASZoET/E
         gpjw==
X-Gm-Message-State: APjAAAU20YhLuI7jKt+NAbV6Rm+Tvx8OGx4lBGY+t8xk3Qq+09b55tb+
        YWPaYtKHP8KDYIZhlIysqRtJ97R/v/02dyk4nMwn3aUrv0ph
X-Google-Smtp-Source: APXvYqxXK+B0noGMchCiLhdOqlZkZLD11zQO6N8pxV4Mx78bt78T6dhHXUrD3Fbmsm2Qj/LYzrfMK2p60Ns7ZEMWeqS+vpidEYKD
MIME-Version: 1.0
X-Received: by 2002:a92:9e4c:: with SMTP id q73mr15670936ili.53.1573255320305;
 Fri, 08 Nov 2019 15:22:00 -0800 (PST)
Date:   Fri, 08 Nov 2019 15:22:00 -0800
In-Reply-To: <0000000000006264c60596d8c5fa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008207e30596de0cf3@google.com>
Subject: Re: KASAN: use-after-free Read in j1939_session_deactivate
From:   syzbot <syzbot+a47537d3964ef6c874e1@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17325552e00000
start commit:   847120f8 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14b25552e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10b25552e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5e2eca3f31f9bf
dashboard link: https://syzkaller.appspot.com/bug?extid=a47537d3964ef6c874e1
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164973b4e00000

Reported-by: syzbot+a47537d3964ef6c874e1@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
