Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566BDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E862075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfC1LgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:36:02 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:35706 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfC1LgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:36:01 -0400
Received: by mail-it1-f198.google.com with SMTP id s3so2962537itl.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 04:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IeQZN5DzFCOw9ygnpDu52QTqLny3txcxZoSYPkvsPAc=;
        b=T7ulaKtyW7TjX3Gune+ujPzLRSvR1FuOBnoCC2srK331NOl+ptf4S3uej3p98lRtH1
         f1rxs8OWHk6VZF4JiAL7TqqPG/6CVgZv1Sam9Mi10edhDaky6Gn6GFVeQieN0VR3XZfU
         dIA5Y21bVGJz/jbD2g2R0icY6y4sHgkF1PkTmnKvykimdeuhvNfpSh/GBOMH0VmflMQQ
         GS1WKuJg3XsFoeG1Iuv7khWgX2+ZPShT1AuIGdgXgL/NW69UZ/BGlT4LWagPrzgR1wZK
         KHbMWPn0W+XhITH9g3y8wyS0yXwm/yRigiITLqP3loV6cJu0qAzObL3ORTwicwRkcR+A
         3hxg==
X-Gm-Message-State: APjAAAXmQw/X4f1j78lVJF8fe2SpYV4RbtzdikRlgSkBpY75/odk1EG5
        mHLdooazBu2IzHtxraZW1dm+aB/frFm77I9ZTP6iUggn8BOX
X-Google-Smtp-Source: APXvYqyZPXOFB5iijfyr3vhC7APuaXAAGVZyB+81evChjYCtfAUvlq5aOG5TST+YM4QbqCf7Jcfe79860ETHF4Mwusd3fqLMH5/r
MIME-Version: 1.0
X-Received: by 2002:a05:660c:288:: with SMTP id s8mr1952223itl.25.1553772960580;
 Thu, 28 Mar 2019 04:36:00 -0700 (PDT)
Date:   Thu, 28 Mar 2019 04:36:00 -0700
In-Reply-To: <0000000000007f82d805783fe8ce@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006088db058525f51f@google.com>
Subject: Re: INFO: task hung in genl_rcv_msg
From:   syzbot <syzbot+c3b90a95b2d6bd4f29b1@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org,
        jon.maloy@ericsson.com, keescook@chromium.org,
        kstewart@linuxfoundation.org, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        nicolas.dichtel@6wind.com, pombredanne@nexb.com,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 928df1880e24bcd47d6359ff86df24db3dfba3c3
Author: Jon Maloy <jon.maloy@ericsson.com>
Date:   Thu Mar 15 15:48:51 2018 +0000

     tipc: obsolete TIPC_ZONE_SCOPE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1487ea0f200000
start commit:   a5ed1e96 Merge tag 'powerpc-5.1-3' of git://git.kernel.org..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1687ea0f200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1287ea0f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31fb246de2a622
dashboard link: https://syzkaller.appspot.com/bug?extid=c3b90a95b2d6bd4f29b1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176657ef200000

Reported-by: syzbot+c3b90a95b2d6bd4f29b1@syzkaller.appspotmail.com
Fixes: 928df1880e24 ("tipc: obsolete TIPC_ZONE_SCOPE")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
