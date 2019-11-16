Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE89C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 21:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8048F206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 21:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfKPV6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 16:58:02 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:51506 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfKPV6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 16:58:01 -0500
Received: by mail-il1-f199.google.com with SMTP id x2so12392196ilk.18
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 13:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FivOluRux2/DVAkTpjJWtSvpnnKGD4Lb0eJIgMOZqFE=;
        b=akQ67PVH3NJPaVFRI1SmX/CneB1wMenow4c14tolbaZmcbQtSYwpdiBX5oedaS5CSU
         /HJ5wepe1dH85i8IPrh8Yrmd1VcvT9Rb0eoA8AAt+Lc46JMl2NT/ObddM1cxyl6oBqmt
         QC/mBltMUHTds5a9yOK7hsH9d/KXEgAZzqDBH0MgH/XrotZrsguDc89E+LpU8qaZ9tJz
         PXVEYFTrVHKEXEJhDzftGZL/YAlyna4R6mGq4lsjVsgmMQC6hDtqulaFC3DRUqpv1cc/
         yze2/qI2LhWRGPwV8hNFMGvWyBSSI7eonbSFjiRNHI5r7+uWAEG+0fQ3iPxRdDYp9wQ6
         0K4w==
X-Gm-Message-State: APjAAAVtBeCYFQDmGtu7bieK8Zae95UFl3tMUg66Gu8WbMK/rrD0IeQ3
        PpOsTAJzRJ10IIhRIgMNP05UyiOQT9T/ddT0wqHJDk0iE2Vi
X-Google-Smtp-Source: APXvYqyBClsLcSrM3dmH+CTnYr4efRlSIxtAlH+yao3jUBN/eeOlTRZsa2EivhAtWsDIyW2jCsP5hnuY0bzWexF2Lwoo7rY/12fX
MIME-Version: 1.0
X-Received: by 2002:a92:5fc2:: with SMTP id i63mr7652353ill.218.1573941480648;
 Sat, 16 Nov 2019 13:58:00 -0800 (PST)
Date:   Sat, 16 Nov 2019 13:58:00 -0800
In-Reply-To: <000000000000029056057cd141cb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9f8a805977dce36@google.com>
Subject: Re: possible deadlock in neigh_change_state
From:   syzbot <syzbot+6a3c02010a025ac7b7cf@syzkaller.appspotmail.com>
To:     christian@brauner.io, corbet@lwn.net, davem@davemloft.net,
        dsahern@gmail.com, dvyukov@google.com, ebiggers@kernel.org,
        edumazet@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        roopa@cumulusnetworks.com, syzkaller-bugs@googlegroups.com,
        w.bumiller@proxmox.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 58956317c8de52009d1a38a721474c24aef74fe7
Author: David Ahern <dsahern@gmail.com>
Date:   Fri Dec 7 20:24:57 2018 +0000

     neighbor: Improve garbage collection

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1328a1e2e00000
start commit:   addb0679 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10a8a1e2e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1728a1e2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9655b05acfc97ff
dashboard link: https://syzkaller.appspot.com/bug?extid=6a3c02010a025ac7b7cf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13317705400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177bb01b400000

Reported-by: syzbot+6a3c02010a025ac7b7cf@syzkaller.appspotmail.com
Fixes: 58956317c8de ("neighbor: Improve garbage collection")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
