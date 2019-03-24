Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33384C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 07:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E3421019
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 07:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfCXHUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 03:20:02 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:35977 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbfCXHUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 03:20:01 -0400
Received: by mail-it1-f197.google.com with SMTP id i4so6030299itb.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 00:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ty3x8PotSBs0iABZkbu6IN5WExSmCOh7O/kSl2g5mEk=;
        b=EneX5NHa3+1Ubp2ZPNKxzUICtnWvSZ5Lz++lRJuXQ6nIRiI8DNXRTfvcvuIcnR6Spl
         nJlg2EybkCD1QZGcMw9LV+WTr0eWKn07VSkpBNFT/sxGFumwrRNdPA+Sfpzo/xL1gLWs
         0Fj+XWUolDc41mz0eVnnj0+9ux0oNd78ODsngwIZto/nm5vVMuvaemhHp8hxhuNhFeNs
         CbgbMjqBvh1pehKu/r9vMHKEGK2WjbsVEUl792JqEomnTDeXoQDLf2rfd+x2Mezi63yv
         OA4xos0Afp0dR5gWWK9rLHP5XkzGmdOwQb6BWV42W9LzLnOi0oiIABUGfo6Mh0+tU5up
         QlUw==
X-Gm-Message-State: APjAAAVZJjCn5L+pY47JI3STrB3+oClKl1CA1Qs6I5Jv0C+1vV3xrHwk
        d4ym66zEHOMnr+eRjj2+Nw+tY9Bkr40zqqVPkRkQx9UkcFpV
X-Google-Smtp-Source: APXvYqylm2z8GYuQCctMtEXkDTjAf5mHhKsA783+eiqBRZzF7RYJrpDjVls40cVzl8APzuYwWMcDRb/DdB73OrC0DXPiWuY9wz8s
MIME-Version: 1.0
X-Received: by 2002:a24:2251:: with SMTP id o78mr4671808ito.134.1553412001260;
 Sun, 24 Mar 2019 00:20:01 -0700 (PDT)
Date:   Sun, 24 Mar 2019 00:20:01 -0700
In-Reply-To: <00000000000060600e057e7748dc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000866e8d0584d1ea10@google.com>
Subject: Re: general protection fault in __smc_diag_dump
From:   syzbot <syzbot+5dd1f9327a9ee760048c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, eric.dumazet@gmail.com,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, mmarek@suse.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, ubraun@linux.ibm.com,
        xiyou.wangcong@gmail.com, yamada.masahiro@socionext.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Jul 2 23:07:02 2017 +0000

     Linux 4.12

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e319df200000
start commit:   28e8c4bc Merge tag 'rtc-4.21' of git://git.kernel.org/pub/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2ab9708c613a224
dashboard link: https://syzkaller.appspot.com/bug?extid=5dd1f9327a9ee760048c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d17880c00000

Reported-by: syzbot+5dd1f9327a9ee760048c@syzkaller.appspotmail.com
Fixes: 6f7da290413b ("Linux 4.12")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
