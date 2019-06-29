Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D544AC5B57B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 21:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6E9216FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 21:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfF2VLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 17:11:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:43012 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfF2VLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 17:11:01 -0400
Received: by mail-io1-f71.google.com with SMTP id y5so10810634ioj.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 14:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=iI+vf7XGdxN/YYPP07HgU1JapV/In43CoBtMmVlU0zc=;
        b=Mv5szL/2E+/uanHVomOyWF4Go+A4XaCOfj10rfsK9/6RjWzFy8vqYZMwOBzFisTyL2
         +9D10+WaOc1HuW9Jr5tQI6NHflvD2P2PUnp7YNpjdN93oZjEvRWVsHrg1/pKuwaayxlA
         DBwE/zP6nwaaxSr4QLXPQW6c9HmrctHwG8/nnfB/BGaMxqumF8RlgQyQiYGKkzRaNRc2
         NJ/mJwmTivODen4aGkrgL5XQjY8jUk/eFKHGIIr2jBOWU8bdsKPJ1CgUoy6PLQDzjOLR
         JRUtRAAu3x/AXm+G3zPw3zH36SINM0qTL415UvTwaNmgMF1+ekX25xRWZQk6ixODxJMW
         v+Kg==
X-Gm-Message-State: APjAAAWz0Zz3Izhsh1tUkZ3aKHy9JN6nrHem02KEhAHbR6jJ3VtpZXmf
        UHdCFojHUdW3BAWxB0jHDFGWAJZLftalDLznFlXVcPTcXNCG
X-Google-Smtp-Source: APXvYqxUrjoo3PnWRqtB9E0kVCAY8bEvzzwxgHzzPwfKIzGqVN9E4ibJvNZEVz7+4oUptRKrbedzide4XQN2Mi9uNOkrx1Kx7s+W
MIME-Version: 1.0
X-Received: by 2002:a5d:9ec4:: with SMTP id a4mr14785908ioe.125.1561842660304;
 Sat, 29 Jun 2019 14:11:00 -0700 (PDT)
Date:   Sat, 29 Jun 2019 14:11:00 -0700
In-Reply-To: <000000000000d028b30588fed102@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f66c6e058c7cd4e0@google.com>
Subject: Re: KASAN: use-after-free Write in xfrm_hash_rebuild
From:   syzbot <syzbot+0165480d4ef07360eeda@syzkaller.appspotmail.com>
To:     davem@davemloft.net, fw@strlen.de, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 1548bc4e0512700cf757192c106b3a20ab639223
Author: Florian Westphal <fw@strlen.de>
Date:   Fri Jan 4 13:17:02 2019 +0000

     xfrm: policy: delete inexact policies from inexact list on hash rebuild

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1734cba9a00000
start commit:   249155c2 Merge branch 'parisc-5.2-4' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14b4cba9a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10b4cba9a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31528e58cc12e2
dashboard link: https://syzkaller.appspot.com/bug?extid=0165480d4ef07360eeda
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cf37c3a00000

Reported-by: syzbot+0165480d4ef07360eeda@syzkaller.appspotmail.com
Fixes: 1548bc4e0512 ("xfrm: policy: delete inexact policies from inexact  
list on hash rebuild")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
