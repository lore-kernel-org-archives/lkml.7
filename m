Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FE3C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2082077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389349AbfKGNmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:42:24 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:44339 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389202AbfKGNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:10 -0500
Received: by mail-il1-f200.google.com with SMTP id 13so2642887iln.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=plVVKO/TiA9qEadFaudHEttDM/umSvqIdncqMChXxEU=;
        b=pHzW00dowN9O4vb0gERfwmkCfI5e2P+GAh/cH+LMe04wrg4g9I4vlOvuHhN+KlgaIB
         pJdq0AX1QTCQypIoYvcvbilm1AkSpVaeZcsH2hQ0k6QSDzkBTdxozqdlE/VDOnPZprP5
         +6J9bhZzmv9Lx5Ri1wn0SdZ0uSfwkzKARl1KX+okeuYDohAj7KG7dSXmA32gfzXAHt4X
         25/qnxqqkSzHItzswpdx3/bllsZG7UfSVkwwkJr1+83fQGK7LhSQBBVNt5r3RvI84B9v
         vgu8IhGv54dvxfwKXAzs3DG1OCx3p6YXI2td8WMgFx9anZX5Xt+jLc/hAhgXymvVMBbR
         t1pA==
X-Gm-Message-State: APjAAAWg7X+lm442tZpse+Fxfn7ZYlvVxe3686FYjZ3MCeYRJTEKdd8T
        +B/ibUj5YVUW/ZPL+mV82SJ7h/mKZAr7ko6ExgSmDT9SpEDk
X-Google-Smtp-Source: APXvYqz89Y/yuNQA4WzBGuScF8zNVGHvJlrs0FJ9K6h7EcNx1xXc2GImTi/JmclT7DQJhjOdTsD9CyLEIgow8UlTrEVxqU48Kbux
MIME-Version: 1.0
X-Received: by 2002:a92:ce0d:: with SMTP id b13mr4719390ilo.26.1573134128397;
 Thu, 07 Nov 2019 05:42:08 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:08 -0800
In-Reply-To: <000000000000a5390a0568d7508a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8435e0596c1d44f@google.com>
Subject: Re: KASAN: stack-out-of-bounds Read in xfrm_state_find (5)
From:   syzbot <syzbot+d90468452f685a0b28eb@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, stranche@codeaurora.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 32bf94fb5c2ec4ec842152d0e5937cd4bb6738fa
Author: Sean Tranchetti <stranche@codeaurora.org>
Date:   Wed Sep 19 19:54:56 2018 +0000

     xfrm: validate template mode

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1090f0a6600000
start commit:   10b84dad Merge branch 'perf-urgent-for-linus' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9b0d91297e224bc
dashboard link: https://syzkaller.appspot.com/bug?extid=d90468452f685a0b28eb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1231c30b800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c1c37b800000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: xfrm: validate template mode

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
