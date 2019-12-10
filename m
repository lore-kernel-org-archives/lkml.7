Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D17C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D33206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfLJM7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:59:02 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:54125 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfLJM7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:59:01 -0500
Received: by mail-io1-f72.google.com with SMTP id m10so13200433ioo.20
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 04:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=K7gPl1FphJWhh8zq+KZGN6d9O0Mc9hz+Z8xkj8vZdlQ=;
        b=lc9UWFYv4mgWazfau5JB4NoRQUvvScJNXrnnn+ggM8+7fNbPeuKm92/F/a8llyJME4
         V3/QtFoCeSKTgFeM9UTf5jYQ2U2Bes7tnJNPOQBZH+gd11MMU2Pv/kgcSNv8UcbAJE9o
         Ix+gW09fJt8EG3QishSBXdFyAEMcbq38BYQuPdqpF4DkgVDxusi3b1nKiPo8Xg3PLgyZ
         eqixJAVd6qfPU1IOCWuAPYnaEv4EVnSHIroFZPvlLrH9iN2/apSt8HEt9K0P0URFg1yz
         LbzzKmcT2jYeltJabSQ+sgMvf3Vrj2/JnhrUHIhnvfJAA4xEn0/zalHHDKEpgs6KObV+
         VqzQ==
X-Gm-Message-State: APjAAAWhVPbbeAsw9S7K+As9ukcuwFT9Smn6Q4e93cq/cBqx08spQtiw
        +gVqrpVb0iIr1OMh58iGtD4T1eHs5NrNvGEKqpgQ6X1fhtPF
X-Google-Smtp-Source: APXvYqwDCe80r9YbW2QQnA0KjjLSvil/nEblKeil0eEsHFedCe59r/gm8ekpcNZa3NtXqCgGqqZ6wrMr2kggORAQDm9RLlN60DpJ
MIME-Version: 1.0
X-Received: by 2002:a92:5e4b:: with SMTP id s72mr32788228ilb.211.1575982741163;
 Tue, 10 Dec 2019 04:59:01 -0800 (PST)
Date:   Tue, 10 Dec 2019 04:59:01 -0800
In-Reply-To: <0000000000007f075c0598f7aa38@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007598ae0599591335@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bit_putcs
From:   syzbot <syzbot+998dec6452146bd7a90c@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, coreteam@netfilter.org,
        davem@davemloft.net, dri-devel@lists.freedesktop.org,
        gwshan@linux.vnet.ibm.com, kaber@trash.net,
        kadlec@blackhole.kfki.hu, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, ruscur@russell.cc, stewart@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 2de50e9674fc4ca3c6174b04477f69eb26b4ee31
Author: Russell Currey <ruscur@russell.cc>
Date:   Mon Feb 8 04:08:20 2016 +0000

     powerpc/powernv: Remove support for p5ioc2

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16af042ae00000
start commit:   9455d25f Merge tag 'ntb-5.5' of git://github.com/jonmason/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15af042ae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11af042ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3b8f5088d4043a
dashboard link: https://syzkaller.appspot.com/bug?extid=998dec6452146bd7a90c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fa5c2ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e327f2e00000

Reported-by: syzbot+998dec6452146bd7a90c@syzkaller.appspotmail.com
Fixes: 2de50e9674fc ("powerpc/powernv: Remove support for p5ioc2")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
