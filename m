Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77BBC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 14:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B412072C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 14:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfK3OuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 09:50:03 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:55065 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfK3OuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 09:50:03 -0500
Received: by mail-io1-f72.google.com with SMTP id f15so6983096iol.21
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 06:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jII87kLhfoGRXBIl4TNhBeD/bYyBWSNWa+TtrCAMKnM=;
        b=jo0DrB7Qi4pQ7I2vvHbQJMCudmegxCfflAxrpP/r3pdyVl6WTeB1nQnaGbhsBLOVQ3
         b4aG1RhJcaeUHLbL85qXrr7HJ3MXQl/koiYskIbFlTo6aCbAhJs1Gi0mfIt9DnnvQglI
         InD6y9/f/TnuLGyus7vY2j5wPAaHCQzfd3Hauz9LhfBG0pNz7zYI/kG9yJj/mP0rMKbT
         +nfFTC/awiwUwGYjuHVjaBYbeuTrtToo7T/AIWDZLgq3JOeI7Y5d5xXneFzF1JscNIF4
         HILU2SGp+mwJ0s/j/gZQvdMRJVioqKa4+khxz7Yfxt6k5NiEkQz5zPfLMLAKzjfNol6Q
         /1zw==
X-Gm-Message-State: APjAAAXs7rF1oPxG/ficVzMXVg/1w2E47lHf4Kw1Ij/ovcHS1McUQ8Gq
        h8wiFFO/N40fLiOI3WDbLSJPfBMzQEGBB9juAzaCzRN5vZi8
X-Google-Smtp-Source: APXvYqzUupElDR1SDA77br+UIp2Mr5RrWPkK2noS9cYjk6kGU0lH4u9b3aZAbIjVILLbVLabmwApKQam8lGumAvU4U75q4v173bg
MIME-Version: 1.0
X-Received: by 2002:a92:5bdd:: with SMTP id c90mr2923790ilg.78.1575125401177;
 Sat, 30 Nov 2019 06:50:01 -0800 (PST)
Date:   Sat, 30 Nov 2019 06:50:01 -0800
In-Reply-To: <001a114372a6074e6505642b7f72@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000039751059891760e@google.com>
Subject: Re: kernel BUG at net/core/skbuff.c:LINE! (3)
From:   syzbot <syzbot+b2bf2652983d23734c5c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dvyukov@google.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
        lucien.xin@gmail.com, mvohra@vmware.com, netdev@vger.kernel.org,
        nhorman@tuxdriver.com, syzkaller-bugs@googlegroups.com,
        u9012063@gmail.com, vyasevich@gmail.com,
        websitedesignservices4u@gmail.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 84e54fe0a5eaed696dee4019c396f8396f5a908b
Author: William Tu <u9012063@gmail.com>
Date:   Tue Aug 22 16:40:28 2017 +0000

     gre: introduce native tunnel support for ERSPAN

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=158a2f86e00000
start commit:   f9f1e414 Merge tag 'for-linus-4.16-rc1-tag' of git://git.k..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=178a2f86e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=138a2f86e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=34a80ee1ac29767b
dashboard link: https://syzkaller.appspot.com/bug?extid=b2bf2652983d23734c5c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147bfebd800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d8d543800000

Reported-by: syzbot+b2bf2652983d23734c5c@syzkaller.appspotmail.com
Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
