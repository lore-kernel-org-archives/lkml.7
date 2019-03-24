Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B794C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF49820828
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfCXUoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 16:44:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:56692 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXUoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 16:44:01 -0400
Received: by mail-io1-f69.google.com with SMTP id s184so6314854iod.23
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 13:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=c+s9tWvVworkCYx2JoCEUeoAaXjwlLSSZzkTKQU1SMA=;
        b=ZlDpZn/ccwPf1j1YVg0/ife73D0heiRMBosBXeyopMCRiyQs/cRF3M2qU2hCF0C1Fy
         dU10SLbw1byS5/18XlGuqPpRt8oA3YcDYkmqSNtMbtTQ4YNDo4PlNGh7B7LZS5HrYt5b
         n9zgVbR9tvuv5kVJOviN+cEoJ0JYQ8VUKylU29wq6bSEG2iCEf+Bbt5rOa6nIK7udn+s
         U5cIYchYL8QvrugmUSRA4lW000b2/oAFDpteGfWv29QOcRv3klrA074yGoelxJsVK4mG
         AvTj13vP9EHSR7qb7nl/bn9bYbBv3hnm/beuUOyDgb494W2WXGtJNPpaHCQWs+yBm2iT
         R7BA==
X-Gm-Message-State: APjAAAWUNgz42tP7UyQccU2O6CifRWRrfWJHZTj3Cl17oplbU291b1CJ
        IqHtUGMaY1jPRgow+imcTFnPdMwZKTruTuiP2tTuilC/Se1q
X-Google-Smtp-Source: APXvYqwxEXst9lvpD1gep57sfayH4XUWdajkCov9aZ8fQj/63rCGPGzcSytUzDfDXuAE4DSPX7R8wd5TJ7d8BfiebCrZva2L+/MI
MIME-Version: 1.0
X-Received: by 2002:a05:660c:1c8:: with SMTP id s8mr6429399itk.20.1553460241119;
 Sun, 24 Mar 2019 13:44:01 -0700 (PDT)
Date:   Sun, 24 Mar 2019 13:44:01 -0700
In-Reply-To: <0000000000006c6fee057bbd0ef3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d83e790584dd2500@google.com>
Subject: Re: KASAN: use-after-free Read in trailing_symlink
From:   syzbot <syzbot+a13e5ead792d6df37818@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 0f98621bef5d2b7ad41f6595899660af344f5016
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Sat Oct 29 00:30:46 2016 +0000

     bpf, inode: add support for symlinks and fix mtime/ctime

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1050253b200000
start commit:   ef78e5ec ia64: export node_distance function
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1250253b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1450253b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c94f9f0c0363db4b
dashboard link: https://syzkaller.appspot.com/bug?extid=a13e5ead792d6df37818
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13633e47400000

Reported-by: syzbot+a13e5ead792d6df37818@syzkaller.appspotmail.com
Fixes: 0f98621bef5d ("bpf, inode: add support for symlinks and fix  
mtime/ctime")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
