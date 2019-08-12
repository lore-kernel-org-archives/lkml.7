Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72C2C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A9D2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfHLWcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:32:01 -0400
Received: from mail-ot1-f71.google.com ([209.85.210.71]:38912 "EHLO
        mail-ot1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHLWcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:32:01 -0400
Received: by mail-ot1-f71.google.com with SMTP id v49so87366580otb.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 15:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=64I6Vg7GG8+qFEb4faWzZMot279mVpkPc+JNG+pcnJo=;
        b=I44eFw5W7hKpwEbjrFKvt0Dkme6CJy4GUJnkNzqIAXMj1U87ID2gYh/fHcAmjK7xtN
         0tFvnQxTvhsDn3q9vlT/jQCcRxaJCMPvsxlCFiVlrUKkR8vPIv3AaekWKRCQZoTS4Joo
         +QmPJA9FALl0Gz4kajs3LCsVm+l6LsN75pFcVh3qd3o4NSnhZK0h0W4wN/l6ad/UAWI8
         C7rLuSjS9D2D5W32xxeWaUSleUaQ5IHlORyF6slg6/tVL4oibDhSyoC1Zki5BHuILRZf
         aL/2pls2D2IyMzwqpCwv2tspOAyfIIeckS8UzH3qT/j3lcC9aKsiu62gMqjQPhgdKyUd
         MM7w==
X-Gm-Message-State: APjAAAV3Hh+pwtOSxwezEFqICbNmGy+RVU53dQDnTGtq2zpq8qcIeczT
        tZ7szVH+6swmjEK3JXsjDX/3cHl+xNtkItUGO6nwiik+OUxP
X-Google-Smtp-Source: APXvYqxooASJlXu0RjqkCDVSMGmPqhOI1O1zfvCN3iXdvSrbaT+4RNgiVLCziOWr2XABL3qA2ywAcxce+Zmu66HFfJhZMK10foWY
MIME-Version: 1.0
X-Received: by 2002:a5e:924d:: with SMTP id z13mr1743448iop.247.1565649120561;
 Mon, 12 Aug 2019 15:32:00 -0700 (PDT)
Date:   Mon, 12 Aug 2019 15:32:00 -0700
In-Reply-To: <000000000000492086058fad2979@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac9048058ff3176e@google.com>
Subject: Re: BUG: corrupted list in rxrpc_local_processor
From:   syzbot <syzbot+193e29e9387ea5837f1d@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, davem@davemloft.net, dhowells@redhat.com,
        dirk.vandermerwe@netronome.com, edumazet@google.com,
        jakub.kicinski@netronome.com, jiri@mellanox.com,
        john.hurley@netronome.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 427545b3046326cd7b4dbbd7869f08737df2ad2b
Author: Jakub Kicinski <jakub.kicinski@netronome.com>
Date:   Tue Jul 9 02:53:12 2019 +0000

     nfp: tls: count TSO segments separately for the TLS offload

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d04eee600000
start commit:   125b7e09 net: tc35815: Explicitly check NET_IP_ALIGN is no..
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13d04eee600000
console output: https://syzkaller.appspot.com/x/log.txt?x=15d04eee600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4c9e9f08e9e8960
dashboard link: https://syzkaller.appspot.com/bug?extid=193e29e9387ea5837f1d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159d4eba600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ba194a600000

Reported-by: syzbot+193e29e9387ea5837f1d@syzkaller.appspotmail.com
Fixes: 427545b30463 ("nfp: tls: count TSO segments separately for the TLS  
offload")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
