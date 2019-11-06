Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5469C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B549A2178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbfKFUpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:45:03 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:56671 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfKFUpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:45:03 -0500
Received: by mail-io1-f69.google.com with SMTP id o2so18899222ioa.23
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 12:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CKhbFMY96UkeeYW1AdsC4faXW9TdZP8Wwxs32ZLveY8=;
        b=nXBiv87Pkycw41ePAlpcrbQbh+tE4fCMrGzJbRiFO/6XQo4SvMV2RbZv4lKTLW7FCz
         sH2UNxnTKM3Z7j7WP6+Zaq8SspHq4A20XVTyTj0n/NOm/qu2XymB7WHyBaXRm9C891cw
         kRZxYXk45SBaSLIg3OHhV4iap6Yl3C7+b//NN/UcZYm55WASJbYx763vcLEZvEvSZXEI
         CNgIvFE3B9HXtN6HJR4568J0ram06kmXaz6Ues0HqAc+5fYkIBIyXyP+Q7JEtCKe1Azh
         UK9Hdvma+4rme/7Q+yUIasVFGHgXEEbDeVMGTwpG7hpIoQ+Prf8Ywx7D78Vmm59q0F1V
         c+Cw==
X-Gm-Message-State: APjAAAWhjQEhHWy1sI+8xgFDiMLawCc7cKKAXRfx7GiJA/kxMRP64jfg
        VXopsqgp0//z7u9OjKUURI/yo8SOnPx9r4ehuh38Sv1T5k1I
X-Google-Smtp-Source: APXvYqwl8xKQyAsVboee3xTmV8yURBuHXGkB2ppXEIOqV4SbB6Al/gxxM/2HT9zBlaqoXRoMypAC6mCYV+vxyagef7GIdokmiA+8
MIME-Version: 1.0
X-Received: by 2002:a05:6638:68f:: with SMTP id i15mr20761396jab.37.1573073100939;
 Wed, 06 Nov 2019 12:45:00 -0800 (PST)
Date:   Wed, 06 Nov 2019 12:45:00 -0800
In-Reply-To: <000000000000994f3c059691c676@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000632acf0596b39f6f@google.com>
Subject: Re: general protection fault in j1939_jsk_del
From:   syzbot <syzbot+6d04f6a1b31a0ae12ca9@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13341558e00000
start commit:   a99d8080 Linux 5.4-rc6
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10b41558e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17341558e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5e2eca3f31f9bf
dashboard link: https://syzkaller.appspot.com/bug?extid=6d04f6a1b31a0ae12ca9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1450cc58e00000

Reported-by: syzbot+6d04f6a1b31a0ae12ca9@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
