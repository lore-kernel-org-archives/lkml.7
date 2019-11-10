Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641FCC17443
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 22:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D9920854
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 22:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfKJWzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 17:55:02 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:36983 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfKJWzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 17:55:01 -0500
Received: by mail-io1-f72.google.com with SMTP id p2so3002573iof.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 14:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/Pa8UKCMA8SPihRiDsHarMOuNUw5vqsXgCzbPaMPce4=;
        b=LuXojvJZmzXUUJvxC+XVCAwUpPFZMxzThvmisR2SHMFaP6K+3ti29HskIU2wEGfJ42
         iQBIBwy/GLvxEv3Oz97FmBWzcAXD65Vl8GTegDnwJFH8FFApudIqDpTmZ8PoJDTtvATd
         zXYx5rtleLjj1jzsnsxIVciflaYz5GKzKgLTH73N5q2lHYLzlji5bN3Dbt0NaTi57uvo
         6IFrmYBn2QSwnf9HHHL3/qIKrIPoq6SGFDJ+Km5qhidS11ZrsA50d+mSiS/zIX+EedFK
         Ir57T1wywGkQMmJRIzqm/jzHE3tGn2aZs5Y3bUSIAB2mSoJVlLx9wX1bvtZ3F4VL0UEs
         oGHA==
X-Gm-Message-State: APjAAAUUw77zuKZuVGnvAXVySqOQa46IU9pAPWY6kXIoW17jm5iGlTbt
        1vBqA16ctk80jFI6XdNOXrjoz0pmaL3hB8WUg38zMo5DE7n/
X-Google-Smtp-Source: APXvYqxWupxkjD8ceSh/6a3yrJv8V9rVgU5A/fgW9YnNAd6CimDELG1I6tO19zEfdiU5wFsMPZGE1ex5HT3ZsMNciuLWHpaXCXfE
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6b6:: with SMTP id d22mr23089821jad.60.1573426500631;
 Sun, 10 Nov 2019 14:55:00 -0800 (PST)
Date:   Sun, 10 Nov 2019 14:55:00 -0800
In-Reply-To: <000000000000a3cc890597025437@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a68113059705e7d4@google.com>
Subject: Re: KASAN: use-after-free Read in j1939_sk_recv
From:   syzbot <syzbot+07ca5bce8530070a5650@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f08e72e00000
start commit:   5591cf00 Add linux-next specific files for 20191108
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12f08e72e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14f08e72e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1036c6ef52866f9
dashboard link: https://syzkaller.appspot.com/bug?extid=07ca5bce8530070a5650
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165ad206e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14cf9c3ce00000

Reported-by: syzbot+07ca5bce8530070a5650@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
