Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CC1C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7393C20848
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgAGTnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:43:02 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:54502 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgAGTnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:43:02 -0500
Received: by mail-io1-f71.google.com with SMTP id u6so516966iog.21
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 11:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zJNitKAgVyD6L05mimG8VM/c6DYKBTWRutBYb9hJfsg=;
        b=BUFpmCFGjKa5xAkkFreeM3zC5wSFUWNV8rliwvbmVaB/ZpTQRktErqNW9z6Uwe/ChB
         LysG3ABkq2eMFVmOZxJUTr3jsXvEPVwKK/F4K76GTBE94ritXBHo6bgpCG6GwMCjO82J
         HnDZ6yZJoBHZRpJK43KP2iPWm2JyVcGEraYsQ41zXVNTRu/APQVTQm2l9A9j1c/iETPJ
         +uokorV3P0ARkUEcp+N4WjdHdnEhz9X5pwrxnRfQWUhXU7zMVPbMglYtioABww4UAyCH
         ItHInRyEgS/lwaLHS5Pk6OZy7SPrUD7TMu5iOzFo/iMGfqr8B9FYRyN2JxCjAEHLuRac
         VVuw==
X-Gm-Message-State: APjAAAXHJA7yfdp1we6ovsRMGSg/JLMQs0zuYx8eotSCSYkrvkkKBaSR
        4H89B01SkgILqkCEK354HL/YackQmqY3haOAlRpK79r0Vu3g
X-Google-Smtp-Source: APXvYqxzHYUUKPkOmQcPvEfIBx0vVL1cBuV0YQ2jq2bdAO99TQxTbcUhwD9QCib5JPi2GrYjV7Q7faGDMF0Lr3JsMKGszJFwr3Zv
MIME-Version: 1.0
X-Received: by 2002:a92:c9cc:: with SMTP id k12mr674567ilq.269.1578426181701;
 Tue, 07 Jan 2020 11:43:01 -0800 (PST)
Date:   Tue, 07 Jan 2020 11:43:01 -0800
In-Reply-To: <0000000000001483d7059b8eed67@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd593e059b91fbff@google.com>
Subject: Re: general protection fault in hash_mac4_uadt
From:   syzbot <syzbot+cabfabc5c6bf63369d04@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        info@metux.net, jeremy@azazel.net, kadlec@blackhole.kfki.hu,
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16b9d5fee00000
start commit:   c101fffc Merge tag 'mlx5-fixes-2020-01-06' of git://git.ke..
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15b9d5fee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11b9d5fee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2f3ef188b7e16cf
dashboard link: https://syzkaller.appspot.com/bug?extid=cabfabc5c6bf63369d04
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14896eb9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139ed115e00000

Reported-by: syzbot+cabfabc5c6bf63369d04@syzkaller.appspotmail.com
Fixes: 23c42a403a9c ("netfilter: ipset: Introduction of new commands and  
protocol version 7")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
