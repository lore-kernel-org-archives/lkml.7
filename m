Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD58C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 11:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC31E222CD
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 11:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfCXLuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 07:50:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:43899 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfCXLuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 07:50:02 -0400
Received: by mail-io1-f69.google.com with SMTP id n23so5602669ioj.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 04:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4nkXhEuASLuB9PFJDypOiqD/XDxVUWqQn3NVoTa3Vx0=;
        b=VQ8h3jWmfEEdaS8IDiNkA1mADbRHUcaDFre+Ntm/b556fvm7biDFuV8AdU5LpqHTri
         Ayxbi4eI6c2rxhGZnvLZCr0Hdmg5NWmDktXziwHwJdaLJ+YmJVk9TqEMTPL+LxgJ+6q1
         yCr0MK3Q+zv9DtFUudso11CYkCMTwsAOM3jTgORlthkwJuVAIDyBkNL/spBRcHj8hbll
         JF0LPTLQAasRoBglEdN7eisB1v9Yb4XUqWhtTjyVfN//AlmpxpSOYyGlE+Pue7KJ8YT/
         R3MFCUQ0/lTKn9r64UDoFdGdA3Fs8Kjccj2RRxl4C4NKjjPOO11TOkXIafkZLQxKOfJa
         Fa1Q==
X-Gm-Message-State: APjAAAWB2Ok+RqAYu/cPtc4Q1FFze7sU/d7b3rtDlh6B1k+5kb80Hf7H
        FT9g7rGYXXs4whU4MCmiZVQt+ry6SntmWnT+TSGcU1zyUN69
X-Google-Smtp-Source: APXvYqzd0SKT1OfTwGmKmd37SivDX9lTl5UsptW6jVDYAOs2LtbnkvFavW1QzSqWToybRXlvTJd5lMWeINBLmsGWJuaIMMwFYYPb
MIME-Version: 1.0
X-Received: by 2002:a24:dd8c:: with SMTP id t134mr6920363itf.59.1553428201297;
 Sun, 24 Mar 2019 04:50:01 -0700 (PDT)
Date:   Sun, 24 Mar 2019 04:50:01 -0700
In-Reply-To: <00000000000055ee31057ce8f277@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f5bce0584d5b095@google.com>
Subject: Re: KASAN: use-after-free Read in addr_handler
From:   syzbot <syzbot+b358909d8d01556b790b@syzkaller.appspotmail.com>
To:     alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        andrew@lunn.ch, avagin@gmail.com, danielj@mellanox.com,
        davem@davemloft.net, dledford@redhat.com,
        dmitry.torokhov@gmail.com, gregory.clement@bootlin.com,
        jason@lakedaemon.net, jeffrey.t.kirsher@intel.com, jgg@ziepe.ca,
        joe@perches.com, leon@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, marc.zyngier@arm.com,
        miquel.raynal@bootlin.com, netdev@vger.kernel.org,
        parav@mellanox.com, sebastian.hesselbarth@gmail.com,
        swise@opengridcomputing.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, tyhicks@canonical.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 4f4c867c91e644fc9d461c8c5cf2f09d6d5bcac2
Author: Miquel Raynal <miquel.raynal@bootlin.com>
Date:   Tue Oct 2 08:54:16 2018 +0000

     irqchip/irq-mvebu-icu: Support ICU subnodes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=163319df200000
start commit:   a3b22b9f Linux 5.0-rc7
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=153319df200000
console output: https://syzkaller.appspot.com/x/log.txt?x=113319df200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
dashboard link: https://syzkaller.appspot.com/bug?extid=b358909d8d01556b790b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1493d4d0c00000

Reported-by: syzbot+b358909d8d01556b790b@syzkaller.appspotmail.com
Fixes: 4f4c867c91e6 ("irqchip/irq-mvebu-icu: Support ICU subnodes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
