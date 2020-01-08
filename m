Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D62C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A923C20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgAHQxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:53:01 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:54272 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgAHQxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:53:01 -0500
Received: by mail-io1-f70.google.com with SMTP id u6so2393310iog.21
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QolCxUn5s/4K7GKyA5X2xLHSsYz24NpJzFUvvR3OMz0=;
        b=bWMJ5Wko/lCqnphIT6vqR5ivJbVduCOP8iOmWCUCu5GZxemvtu32nnVcOb4y0eYaaB
         Qfp25BZm1vxihbVSqk5BmrtNO9+u+JC7sYWGVHmgld4M8mwljjEfnz0i9S+u2p1QqVuQ
         G+HQzeeOLFyRZk4uXYm8rcPddJHw9OQZD6cp3KI/in0rlDs7D4WEthBXXjvIAiPBiHCe
         cxRKhhIbLKqHcB3g4d72vXIgs9gw25z6hOn4DLEhEQsEDB53gBE43MMICa1IyNVMb3v1
         tPDVSXCIXZI4gTEUkvqkjMDphG9eH/PAFVD2Dj2L15NyvpwA9bhra/8+0CWlWksVVA6E
         vnHQ==
X-Gm-Message-State: APjAAAVNZR/j5ABo/59XLa8uQrb8VT/qMgXcuH1Rd36VoyIWcHOgmYhN
        0H6Yu5Cav0J9nIEfEBOtnXEuuVUqDuaftQYeT9a9Jjmu9swH
X-Google-Smtp-Source: APXvYqw7GKpl01VnwgT3uyXH2jOmkGxwN/KTGFcWtwBlYHLJt+Fn1jSB1cHbmeA3E1QqBW3DFyLuj5USskG7K+2UGNRRJRO1ZW6V
MIME-Version: 1.0
X-Received: by 2002:a02:2446:: with SMTP id q6mr4800559jae.78.1578502380699;
 Wed, 08 Jan 2020 08:53:00 -0800 (PST)
Date:   Wed, 08 Jan 2020 08:53:00 -0800
In-Reply-To: <000000000000a347ef059b8ee979@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adcc3c059ba3b9e9@google.com>
Subject: Re: general protection fault in hash_ipportnet4_uadt
From:   syzbot <syzbot+34bd2369d38707f3f4a7@syzkaller.appspotmail.com>
To:     allison@lohutok.net, coreteam@netfilter.org, davem@davemloft.net,
        fw@strlen.de, gregkh@linuxfoundation.org, info@metux.net,
        jengelh@inai.de, jeremy@azazel.net, kadlec@blackhole.kfki.hu,
        kadlec@netfilter.org, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 23c42a403a9cfdbad6004a556c927be7dd61a8ee
Author: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Date:   Sat Oct 27 13:07:40 2018 +0000

     netfilter: ipset: Introduction of new commands and protocol version 7

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13a9d115e00000
start commit:   ae608821 Merge tag 'trace-v5.5-rc5' of git://git.kernel.or..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1069d115e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17a9d115e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18698c0c240ba616
dashboard link: https://syzkaller.appspot.com/bug?extid=34bd2369d38707f3f4a7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118d6971e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b47c9ee00000

Reported-by: syzbot+34bd2369d38707f3f4a7@syzkaller.appspotmail.com
Fixes: 23c42a403a9c ("netfilter: ipset: Introduction of new commands and  
protocol version 7")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
