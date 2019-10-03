Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE002C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E18621A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfJCAjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:39:03 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:53608 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfJCAjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:39:03 -0400
Received: by mail-io1-f72.google.com with SMTP id w8so2178294iol.20
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 17:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hAyRxHbLq7PsOy9LqQwegUEDVde8994wxe1XrflzGUM=;
        b=alHFQrZJa+X6uudn+7eTsCSUSXOZuf/NyNs4vMuBJ2Ee+z4Yh0dqYnj1zhdz8bDFte
         osxOARg1IIDHLcI8t60XKMeF9jku+LXyc3vw2m+faaXJL+ThDOKEfPXVbmfo2POkyb9d
         IGfRpFQj0Kl+BGZhcbcHHNdviK6kqgLoow/v8GpMz3MRardYwy5b6k4jcHv73dmzirNo
         6xkWNXihPfUdmRfPZTwQgsoewJQzH9TVI5S2Q1zLQbhKxHermNrxKM/a7oS1JhEBkYjC
         KFlFwS3AUtUPWE3v0tdMFmeQ4LGdj2qqeNasBeIN7semD9QhqT1+UrsVc5u2pgucgsZc
         KZOg==
X-Gm-Message-State: APjAAAUsTHRHDlZEUWVdPaZQu7AZgBEV627pZMlkKG1svaPybInjFtsO
        xw7oInrJf075vrHmKkb9EXVo7SyXYuwyVlbkN6DNR58QNXw6
X-Google-Smtp-Source: APXvYqxLjRUmgh2d6EecgdKK5+UBkQJlDH3RJylgogoZWNEXOfN2dd+nu0IV57qzRQ40+amE9KW3w1+hdoL4brm4t/WLU7XYn/av
MIME-Version: 1.0
X-Received: by 2002:a92:9915:: with SMTP id p21mr7204717ili.74.1570063141284;
 Wed, 02 Oct 2019 17:39:01 -0700 (PDT)
Date:   Wed, 02 Oct 2019 17:39:01 -0700
In-Reply-To: <0000000000001530e00593f47496@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cfb2cb0593f6cfad@google.com>
Subject: Re: general protection fault in sit_exit_batch_net
From:   syzbot <syzbot+1695af5ca559927e2db8@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, f.fainelli@gmail.com,
        gbastien@versatic.net, idosch@mellanox.com, jiri@mellanox.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, petrm@mellanox.com,
        sd@queasysnail.net, stephen@networkplumber.org,
        syzkaller-bugs@googlegroups.com, willemb@google.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit ff92741270bf8b6e78aa885f166b68c7a67ab13a
Author: Jiri Pirko <jiri@mellanox.com>
Date:   Mon Sep 30 09:48:15 2019 +0000

     net: introduce name_node struct to be used in hashlist

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13719e33600000
start commit:   c01ebd6c r8152: Use guard clause and fix comment typos
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10f19e33600000
console output: https://syzkaller.appspot.com/x/log.txt?x=17719e33600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ffbfa7e4a36190f
dashboard link: https://syzkaller.appspot.com/bug?extid=1695af5ca559927e2db8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1156242b600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17253b19600000

Reported-by: syzbot+1695af5ca559927e2db8@syzkaller.appspotmail.com
Fixes: ff92741270bf ("net: introduce name_node struct to be used in  
hashlist")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
