Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F8FCA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 08:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A13C2084D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 08:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfKCIEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 03:04:02 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:41330 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfKCIEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 03:04:02 -0500
Received: by mail-io1-f71.google.com with SMTP id v5so4236238iot.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 01:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zseyQcg9WNy0u+ZF8nDZWMDUBvH4F12JJ+AwXYNDi7k=;
        b=G/TwKxxzeGbcqrzRr9303SXdFrqVMPcm6PS5TwhzpXuKlcas4bZaXssf9naRacG2HO
         jLXV4Zu2kxGQaQcYcA/nMY3Lu5fuhlvB/pcqLbHF572FYOr+v+840cnD4YVRDuJcKj8G
         e8CIZ3mMk69S3KGMX/18NxDqrqT8LLAFG+XXGGmPIyOswqVUYVdvODNTvJ3Xn3yiQ89Z
         56Gm2e4nCuIR+k4hJG7Jcz56GyPwYqL1PoWr1G4QypKsTUiQy+Y0Uj1VFwul1/rijHdb
         HobLtcA8VuOGM+O0/dnCEaS7JnvW33phIYgVrjgDm9vJH8DkT9bpuBswY1s4/57Cyg+C
         +ebQ==
X-Gm-Message-State: APjAAAVEAUb5OMFjiWbZOOxpTg1HRx+4cAPbtfL2HBA28R92qD0kWm8N
        31alOOYjHmUED667InBebe6EErKNt+uWsZbS77OWjkL7hpxC
X-Google-Smtp-Source: APXvYqxhpKGHhcgtYbw7xsqihd/PM8MbI+nKemnT0QhuOdgsKosxm+PpEDNBXQGgcoZ/5EDuT2djHH4Mdf+3AZesnhq9ApTQpTn+
MIME-Version: 1.0
X-Received: by 2002:a92:99d1:: with SMTP id t78mr21495252ilk.122.1572768240955;
 Sun, 03 Nov 2019 01:04:00 -0700 (PDT)
Date:   Sun, 03 Nov 2019 01:04:00 -0700
In-Reply-To: <000000000000595be405966c3231@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050f87c05966ca43a@google.com>
Subject: Re: general protection fault in j1939_priv_get_by_ndev_locked
From:   syzbot <syzbot+feff46f1778030d14234@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11267914e00000
start commit:   7de08690 powerpc/bpf: Fix tail call implementation
git tree:       bpf
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13267914e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15267914e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cc209e226c8fbbd
dashboard link: https://syzkaller.appspot.com/bug?extid=feff46f1778030d14234
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1726e97ce00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1678e4ece00000

Reported-by: syzbot+feff46f1778030d14234@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
