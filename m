Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4A5C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977FB2070D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfDIIxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:53:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:42310 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfDIIxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:53:01 -0400
Received: by mail-io1-f69.google.com with SMTP id i1so13530186ioq.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WCY/slbNoUGU2VDyWfej6TKNgFSXM5Wu0v6JKAbVtfw=;
        b=NPL5RwJgUgklhYW98uK+cOx3+h39N3dB4jJQzyu6iNqeSFdO/hlRYHpUaKXhX+jUZl
         oiCtFo5YEdjWxSB1GkPZupP+/Dudd3Rl5Xdj+64Sx+z/oiYcB8fryFTtn8vPsZZr0ClO
         UYh+QIIIs0P2ImnlrACWUS6b1cEQUC0YMby+xRGxNEDj76vsNmlHSyx6JWGNqxzNWav5
         HrUvHLF4xxAt60w9TZtspm7fj9Ak79xqhRkaT7W6g4/Rzn+RG/REJMQU5uxTrBCTEkKa
         f9HCz2MymtV97VcLril/97rTpE9EuM0LcrjPYrxw7GQaY2n6WUtFWIABNPqrEpXGyxLI
         AY0w==
X-Gm-Message-State: APjAAAVSnnriQHdu1tzEZF7wxAeq6JYPA2gYbPYliewSQh6xj4e01ceu
        lyK+wXdc3+q1nyS0GsE7cOFXUYPuum4D+X9jmLsrsDbWesar
X-Google-Smtp-Source: APXvYqyzeV8wU08lUyBrO3II1NuHMqZEjMbqGJmoSPdWrCQUQmrjWA0Pa1jrgQ/wWpxl/39TTCu5DtbT10YJFk6ZfJzgXWe6qREL
MIME-Version: 1.0
X-Received: by 2002:a24:2281:: with SMTP id o123mr5076407ito.32.1554799980934;
 Tue, 09 Apr 2019 01:53:00 -0700 (PDT)
Date:   Tue, 09 Apr 2019 01:53:00 -0700
In-Reply-To: <0000000000000a5b840576bad225@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f7f3705861514b4@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in tls_write_space
From:   syzbot <syzbot+12638b747fd208f6cff0@syzkaller.appspotmail.com>
To:     aviadye@mellanox.com, borisp@mellanox.com, davejwatson@fb.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bisection is inconclusive: the first bad commit could be any of:

e3b5616a tcp: export do_tcp_sendpages and tcp_rate_check_app_limited  
functions
3c4d7559 tls: kernel TLS support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=168e797d200000
start commit:   bd4d08da Merge branch 'net-dsa-b53-SGMII-modes-fixes'
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=e79b9299baeb2298
dashboard link: https://syzkaller.appspot.com/bug?extid=12638b747fd208f6cff0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167d9b9e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c4003a400000

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
