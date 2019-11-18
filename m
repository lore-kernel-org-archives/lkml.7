Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2214EC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE922067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfKRLfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:35:02 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:46073 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfKRLfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:35:01 -0500
Received: by mail-io1-f72.google.com with SMTP id c17so13084483ioh.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:35:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OKcSBLpcQwVpHujFTv8FpB4Au/9d3T/ERi36eX6lzZI=;
        b=L4iwhbjjMwx73wMlStIZ4Vj6vnykQvJ9KNNKE118llmmnpHOcVk4ek7i1Z3cIwOlJe
         zQbnk2mwjrfSWPHoXZ2oa50mD0u2W0T4P+T0QAWsOk9TIyRFYUUmdWEfSCKWpI67/7m3
         Q45g6A6l2X932yY7A+B/faRWxltsjFfjSSPa2/iUMDDyjuE9rf8UTwBeX4vdwgg7ktrY
         x7Sdst0qTGZsWmWI6bCWVprt0k7Ojg5ircAxDuZSL3/eJBh/tHd+kq6iCFZhoHMl2BN9
         ZTdTyrQDy3LLSIZ+fzMFLjy1f4cL94/jL3ZkL6OaMBUOkfMcMySzNBDq/QYj0+dt/Kjr
         zrpg==
X-Gm-Message-State: APjAAAU+zo9D7sfLepFCP0F8prGvLwQ9cnSEWAwOKZngpt1CPBwh0yfD
        OTrfeJJ7RYBBc+mQDGjLWTkF+NIZAiKip8/iOZ39KdWBzxfC
X-Google-Smtp-Source: APXvYqz5bu5rJHE/FbEt2tMmodc2aqbhvo8CHiTTuTBIRG4UDMrgh/XnnlvU+UwaeTJy4Ctb4swGcLR3So0ADXtsYuwV/jdtkqg7
MIME-Version: 1.0
X-Received: by 2002:a6b:7307:: with SMTP id e7mr11864167ioh.218.1574076900780;
 Mon, 18 Nov 2019 03:35:00 -0800 (PST)
Date:   Mon, 18 Nov 2019 03:35:00 -0800
In-Reply-To: <0000000000005175bf057617c71d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085314105979d561b@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in ip6_tnl_parse_tlv_enc_lim
From:   syzbot <syzbot+68dce7caebd8543121de@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ast@kernel.org, boqun.feng@gmail.com,
        byungchul.park@lge.com, daniel@iogearbox.net, davem@davemloft.net,
        kernel-team@lge.com, kirill@shutemov.name, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@kernel.org,
        netdev@vger.kernel.org, npiggin@gmail.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, walken@google.com,
        willy@infradead.org, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit a10b5c564741cd3b6708f085a1fa892b63c2063d
Author: Byungchul Park <byungchul.park@lge.com>
Date:   Mon Aug 14 07:00:51 2017 +0000

     locking/lockdep: Add a comment about crossrelease_hist_end() in  
lockdep_sys_exit()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1026190ce00000
start commit:   3a5af36b Merge tag '4.19-rc3-smb3-cifs' of git://git.samba..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1226190ce00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1426190ce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c4a80625153107e
dashboard link: https://syzkaller.appspot.com/bug?extid=68dce7caebd8543121de
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1068a44e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146386c6400000

Reported-by: syzbot+68dce7caebd8543121de@syzkaller.appspotmail.com
Fixes: a10b5c564741 ("locking/lockdep: Add a comment about  
crossrelease_hist_end() in lockdep_sys_exit()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
