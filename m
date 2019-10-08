Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CA1C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 21:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5216320679
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 21:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbfJHVGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 17:06:01 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:35684 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbfJHVGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 17:06:01 -0400
Received: by mail-io1-f69.google.com with SMTP id r5so361934iop.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 14:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5OZYjJeBjxMldAqDjmUv3YST3sHnUbSp1FVhq0/E4ug=;
        b=kTCzBLTO39HkQyW9atPcQhqJ6i6tr5gC1h4uYgGb98aoyg5GMWwKJJ+UCuJB7br5lt
         NguqE+R4JLnvBZZ4wEbraFNTfkwzHO3VgsR4x9CCqnL0+YrD1kVKImsGWDPyUfvfAGIn
         8SzIGZakRaFqQTU5bdQo7lSvCcAFpjVJ7E8H8+j2uFr1bURTUjSi9Mkfx0HjMrUELb1+
         KOV82v23tg4RE0LeDvzuSxjk3JkkhS6JTmPg+PUgVjSQOdBXVMSG00S54js+CBVX/Ma+
         5QwAbRBVtKFKWs5odr8GFplykMcp4PZLJIvvEPcF273zIb4utwpssYkPFFdSU1MNKZ9Y
         Lz3A==
X-Gm-Message-State: APjAAAVUCFwuL78E82naNGdqr/LgcL6o9JcAsa4UBQ5Y/Rsp5IzCs5Of
        yzmlZa3aUcSoG4OXFLPmMjvjW7tJgGTN4aPCYkh6fqe7ur3U
X-Google-Smtp-Source: APXvYqxkpDR9xlwVvue+X5tARQuOgfz8PB0tweOP1gQoq32F203J0Jk/tAMzCvPLWK9XR3S5tVTZLE+JHE1dUP0S2f4Zh+UiKYbr
MIME-Version: 1.0
X-Received: by 2002:a6b:5a09:: with SMTP id o9mr180937iob.241.1570568760396;
 Tue, 08 Oct 2019 14:06:00 -0700 (PDT)
Date:   Tue, 08 Oct 2019 14:06:00 -0700
In-Reply-To: <000000000000c1e5e8059456a5bf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f13e105946c89e9@google.com>
Subject: Re: KASAN: use-after-free Read in tipc_udp_nl_dump_remoteip
From:   syzbot <syzbot+dbe02e13bcce52bcf182@syzkaller.appspotmail.com>
To:     Ying.Xue@windriver.com, davem@davemloft.net, jiri@mellanox.com,
        jon.maloy@ericsson.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 057af70713445fad2459aa348c9c2c4ecf7db938
Author: Jiri Pirko <jiri@mellanox.com>
Date:   Sat Oct 5 18:04:39 2019 +0000

     net: tipc: have genetlink code to parse the attrs during dumpit

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11675620e00000
start commit:   056ddc38 Merge branch 'stmmac-next'
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13675620e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15675620e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9be300620399522
dashboard link: https://syzkaller.appspot.com/bug?extid=dbe02e13bcce52bcf182
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137ecdfb600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dd0d0b600000

Reported-by: syzbot+dbe02e13bcce52bcf182@syzkaller.appspotmail.com
Fixes: 057af7071344 ("net: tipc: have genetlink code to parse the attrs  
during dumpit")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
