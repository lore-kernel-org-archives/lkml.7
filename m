Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91CCC2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 09:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF53920748
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 09:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfL1JGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 04:06:02 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:47244 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfL1JGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 04:06:02 -0500
Received: by mail-il1-f199.google.com with SMTP id x69so24816912ill.14
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 01:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WfGb9lGFdGhSi8hZEfWk/M3G0IsGwYCNAdgm6CjQ7QI=;
        b=oK/Dj5II0ahdU3hgdW2/eyeInI0QMp07SjoLNfbLF2R8WGL1YxPXX1dkZjionl6sCK
         iFmIMgvvSHn+nnInodETnt1FGTrZSmbL7D/LHX5POTAuFIm+ijJIHXGmMQhiZjsJP6pA
         52IaEofuh0syKGTLqqnhgPTyqG09Q+ikE0ES/kiE0Ssr1EenNvUBKYW7YwC09UEv7P2S
         5Ep7VL/p0x/wx57Tp2J7DjbpYmmA+in4ZfKX0n8tQV44QDctmQF4zvvmY4LZJ+1VosnT
         I4+ZwvUnxw0b0gbFyDuN5WaXMPd4qPmYA34/X8EutgtIdE6W//wKIKhVYTLxxalfYnu8
         gfcw==
X-Gm-Message-State: APjAAAW+E/1+5G/WyGbKzL5gc/2ni44GsJVCNN/x/zcTKUvZpJ8I52OM
        KXl6hjFy3/TvoH+czl0cZ7mKAdMNBP8CL3qClqt2kz3MHCc2
X-Google-Smtp-Source: APXvYqyJDTFrNl+ZpW3oGkoUn5Ny0lVdEe36WgM5iN4TzGysRfB97r5Zok5DVtIDafRKxTRvqHwhuE0e1QpHyIt/5WWgjBGqL612
MIME-Version: 1.0
X-Received: by 2002:a6b:f404:: with SMTP id i4mr37323657iog.252.1577523961683;
 Sat, 28 Dec 2019 01:06:01 -0800 (PST)
Date:   Sat, 28 Dec 2019 01:06:01 -0800
In-Reply-To: <0000000000004718ff059abd88ef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c669c059abfebe7@google.com>
Subject: Re: general protection fault in nf_ct_netns_do_get
From:   syzbot <syzbot+19616eedf6fd8e241e50@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        hpa@zytor.com, kadlec@netfilter.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, mareklindner@neomailbox.ch, mingo@redhat.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 0a957467c5fd46142bc9c52758ffc552d4c5e2f7
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Wed Aug 15 20:22:27 2018 +0000

     x86: i8259: Add missing include file

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1579e751e00000
start commit:   46cf053e Linux 5.5-rc3
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1779e751e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1379e751e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=19616eedf6fd8e241e50
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a47ab9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170f2485e00000

Reported-by: syzbot+19616eedf6fd8e241e50@syzkaller.appspotmail.com
Fixes: 0a957467c5fd ("x86: i8259: Add missing include file")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
