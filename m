Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9744FC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 17:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701A92072B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 17:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfLURtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 12:49:03 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:55030 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfLURtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 12:49:03 -0500
Received: by mail-il1-f198.google.com with SMTP id t4so10487135ili.21
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 09:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GshsWrdoEPyx2vd7d7UXajSCgogocC5OTxKPrWDtn2k=;
        b=Ef5L888kkXV575so9vu0tN2nA/oIT2FT/Z0u51wGUvGoExeP3+AhW+kfTIcf1JL0+D
         yc6y0UnvxoAhWE0H/AxUgDInsWhKi/JVZht+2xTGzduPICmjg2MMReAXVIFNPOaG8LVw
         6UMNQx0+iurYRmJuCzD6MJB3RjLqx3+27FOgiDV3iFq6rEGe7pr0FxL0x3ykQtseFMbu
         f1EyCOaFnZ8t4vPlvsKOXFIoimjSLXeRwhrofWrd53aBnhnJ2/bhi1uQwluo3OdO9gLq
         CzasbyRshyraWcYbip+ZQZRShFEdX4srvgtEpFn/Q4lMIedxfTT2qqmJc7dJ/fVcAoPn
         BKXA==
X-Gm-Message-State: APjAAAWT3cTbPqd2LiQ9SrO0GKfltFyHYIEMtmmXx6Exqgwc5d+qvYdv
        S45ygI1gWXNEr/a+St1a1NJYYcO8G89/JN78hfaRq7EOZgq4
X-Google-Smtp-Source: APXvYqyCKPkUw/hvhEZzXqoyo1tTaKHhSZzOInzWI8gOHUFYW5HjZUeSJEoBRod5KvA94zqYvimn+I2NEHvJijo6waweNFndE35n
MIME-Version: 1.0
X-Received: by 2002:a92:d809:: with SMTP id y9mr18895833ilm.261.1576950541498;
 Sat, 21 Dec 2019 09:49:01 -0800 (PST)
Date:   Sat, 21 Dec 2019 09:49:01 -0800
In-Reply-To: <00000000000031376f059a31f9fb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dac3b1059a3a684b@google.com>
Subject: Re: WARNING: ODEBUG bug in io_sqe_files_unregister
From:   syzbot <syzbot+6bf913476056cb0f8d13@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit cbb537634780172137459dead490d668d437ef4d
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Dec 9 18:22:50 2019 +0000

     io_uring: avoid ring quiesce for fixed file set unregister and update

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10eadc56e00000
start commit:   7ddd09fc Add linux-next specific files for 20191220
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12eadc56e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14eadc56e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f183b01c3088afc6
dashboard link: https://syzkaller.appspot.com/bug?extid=6bf913476056cb0f8d13
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15653c3ee00000

Reported-by: syzbot+6bf913476056cb0f8d13@syzkaller.appspotmail.com
Fixes: cbb537634780 ("io_uring: avoid ring quiesce for fixed file set  
unregister and update")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
