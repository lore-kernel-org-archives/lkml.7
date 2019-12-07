Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ECAC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD88121835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLGTpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 14:45:01 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:42664 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfLGTpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 14:45:01 -0500
Received: by mail-io1-f72.google.com with SMTP id e7so6067040iog.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 11:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wS16iwY4SHAgS9TQBNqZiLR/a6ESQzbpzGaub4GpqpA=;
        b=M/Nq2Hfs65GR8GTIy/Hee2N8rAKpXRC2BqQNIbZnKYRRppnHlcVAIJIIYiatMZWJ/j
         mbLCgOkIX3lW+Jo2tCW4hdiI0t5CiVXV0pL1Uv63BBfLvV0E51q2pR2dOJ/56JW+a0o9
         h39iHPYL2HkZkC1qKhKUpRt9zoQm7ua2o/iApazrhI1rRnWXZrrg4NE7OSXFClF0P4L9
         sX3AKmMgRvULkUq+QjcuUvFBZpuQGEoZk0sab4ndQBZvo3/u/H3nZmesct8ssDGTYvql
         OdHUifY459aWSv/2qaL2NCyOHUr9qTOjvRfnJCV5legVH6pfekrb6lj3dei2tnfZGnm3
         mTjw==
X-Gm-Message-State: APjAAAXI6JjFmmo57l4oosPDmCg6enScYTAPU1/+aFPhkCXIEXHgCi7r
        bDDWrKBWc005GK0UaXHeD5txIJHiWgu5T9TmMBhCHvJFxyEG
X-Google-Smtp-Source: APXvYqxMOz34v4xow1dYjI+bbaCYsdOSN0ZdxyIPBJDZ8r/SQQJ0i2OUsyFKZ5sPLHCufzkzxsAmqoemLoiPMD9bsX8FJt+NfxS0
MIME-Version: 1.0
X-Received: by 2002:a6b:f60e:: with SMTP id n14mr14826689ioh.147.1575747900539;
 Sat, 07 Dec 2019 11:45:00 -0800 (PST)
Date:   Sat, 07 Dec 2019 11:45:00 -0800
In-Reply-To: <000000000000f665a30570885589@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de09e70599226583@google.com>
Subject: Re: KASAN: use-after-free Read in __queue_work (2)
From:   syzbot <syzbot+1c9db6a163a4000d0765@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net,
        dominique.martinet@cea.fr, ericvh@gmail.com, jiangyiwen@huwei.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com, tomasbortoli@gmail.com,
        v9fs-developer@lists.sourceforge.net, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 430ac66eb4c5b5c4eb846b78ebf65747510b30f1
Author: Tomas Bortoli <tomasbortoli@gmail.com>
Date:   Fri Jul 20 09:27:30 2018 +0000

     net/9p/trans_fd.c: fix race-condition by flushing workqueue before the  
kfree()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15661282e00000
start commit:   ca04b3cc Merge tag 'armsoc-fixes' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
dashboard link: https://syzkaller.appspot.com/bug?extid=1c9db6a163a4000d0765
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1473a452400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14087748400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: net/9p/trans_fd.c: fix race-condition by flushing workqueue  
before the kfree()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
