Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B6BC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 03:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D4520868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 03:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfFGDZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 23:25:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:39956 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfFGDZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 23:25:01 -0400
Received: by mail-io1-f71.google.com with SMTP id v11so598605iop.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 20:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=e6etfNurQQo9Va6VpYHCA2sien54nXIZ+EIMOWfPhpg=;
        b=Uue1ExTgnVAQF0UY3OSMHK9/d5pi5vwn99brUvZaPlfwaPUkHOX5Hae9A82HmrZ8G0
         2JFzIQKqRRTbr7Xsly07HgrI2IjJwYzJtMMbWUHRlCKDRviWRTjyk7a9216ZmQ28Yein
         n76NrHvZ3hpQRqLTtuxLnYyXP/slkaUjK50BT0S0Xe+M2+SJolDYjRSLBmuF01ML3S52
         vn2f+sMWREGKc/iHNJF6IHDhX4ZXhmHwFgYJ5gJy9NzN7/Nh6xKPWto1Pq3WOc1f4fI0
         +1Ao46O8hPhjLnX2rgGj2Y8gt/ski357Pwv6w5hwEQxDcMTUimXNX5Jr8tqR6a6QOC83
         f/wA==
X-Gm-Message-State: APjAAAXb77QkjXKGi/Chx5pmSbt56eA29uBB8sD22nmKvUTtU6TMD2ZS
        7ztNiahF7bWLvXaCaNkXORj1kt5+EeS+59cs6nSG6vejWImn
X-Google-Smtp-Source: APXvYqye5xa1Ca/EaWr+y6R3z3/VH0PShIIRB83YYxYRr5VL2+2o8N9WKQzv8UUonOlR9ZG4NAHpnj7r5bzEM/0sAQVJZSzGAe01
MIME-Version: 1.0
X-Received: by 2002:a24:f807:: with SMTP id a7mr2825641ith.166.1559877900241;
 Thu, 06 Jun 2019 20:25:00 -0700 (PDT)
Date:   Thu, 06 Jun 2019 20:25:00 -0700
In-Reply-To: <0000000000006b30f30587a5b569@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002314b3058ab3605c@google.com>
Subject: Re: general protection fault in ip6_dst_lookup_tail (2)
From:   syzbot <syzbot+58d8f704b86e4e3fb4d3@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, dsahern@gmail.com, dvyukov@google.com,
        edumazet@google.com, kafai@fb.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit f40b6ae2b612446dc970d7b51eeec47bd1619f82
Author: David Ahern <dsahern@gmail.com>
Date:   Thu May 23 03:27:55 2019 +0000

     ipv6: Move pcpu cached routes to fib6_nh

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13c969a6a00000
start commit:   07c3bbdb samples: bpf: print a warning about headers_install
git tree:       bpf-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=102969a6a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17c969a6a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7b54c66298f8420
dashboard link: https://syzkaller.appspot.com/bug?extid=58d8f704b86e4e3fb4d3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117f50e1a00000

Reported-by: syzbot+58d8f704b86e4e3fb4d3@syzkaller.appspotmail.com
Fixes: f40b6ae2b612 ("ipv6: Move pcpu cached routes to fib6_nh")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
