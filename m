Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4154AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 18:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0929120880
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 18:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfCWSDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 14:03:02 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:36081 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfCWSDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 14:03:02 -0400
Received: by mail-it1-f197.google.com with SMTP id i4so4988275itb.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 11:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+N7awhHuWyN2YJV30w2jij/7haw9+uyVGOS5hExwIlg=;
        b=Mqntm8ITIK5JsBv0Qc+b2H1xK4+Lhvwjx/ey9Wc3nvhoiepD/GC4b8nHmHRr708cHp
         h1nMBRz4NDZ4YX3ySfDIs0nsACkjvgUCz2VdWUXQt8pIl9wa8eeTPm+oe6BVHIxXkLtA
         i2Cq42ymaDjdvAb+H6YppWZnAaJ55gF55e9RdYukXiAjhhCUAKShlgP0D0I5WXHL50qt
         vzw9z7vtnL96lZm6v8qF7yVETijG7c676iofUbK5kkzfXXNbuzZZbJsdgeJSQHNegw0Q
         sUJdb3QXcNIiYgE0hmtxjsxBO1Ouk+CuYo4Oo0noqLtA5oYz6kGhdJfPLyLxgJJxJwwt
         JGvw==
X-Gm-Message-State: APjAAAUelJ8SeyrgNs8ShYH/V/C5akZxXXVlL/DorSnW91F2W66qRm+2
        u1FrbEnztcIswDxjynN6jJcSLKcW4Cs8gCkBorcLtWpg9cmf
X-Google-Smtp-Source: APXvYqy2f4IKreOjAKpXR9xHjRHHTkGH/PFYpnaIPPaxvRM2wYm9pzSJXeKCl31B+nGCBH6YNFI0V3Lbma8yqZvbeuk7F4ChT+2Q
MIME-Version: 1.0
X-Received: by 2002:a5d:980c:: with SMTP id a12mr12258850iol.58.1553364181399;
 Sat, 23 Mar 2019 11:03:01 -0700 (PDT)
Date:   Sat, 23 Mar 2019 11:03:01 -0700
In-Reply-To: <000000000000bc227a0582464e62@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d44980584c6c82a@google.com>
Subject: Re: WARNING: locking bug in icmp_send
From:   syzbot <syzbot+ba21d65f55b562432c58@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 52dfae5c85a4c1078e9f1d5e8947d4a25f73dd81
Author: Jon Maloy <jon.maloy@ericsson.com>
Date:   Thu Mar 22 19:42:52 2018 +0000

     tipc: obtain node identity from interface by default

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b6dc5d200000
start commit:   b5372fe5 exec: load_script: Do not exec truncated interpre..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13b6dc5d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=15b6dc5d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
dashboard link: https://syzkaller.appspot.com/bug?extid=ba21d65f55b562432c58
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c90fa7400000

Reported-by: syzbot+ba21d65f55b562432c58@syzkaller.appspotmail.com
Fixes: 52dfae5c85a4 ("tipc: obtain node identity from interface by default")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
