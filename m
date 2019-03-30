Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C47C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08171218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfC3FRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 01:17:02 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:53410 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfC3FRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 01:17:02 -0400
Received: by mail-it1-f197.google.com with SMTP id 190so4151463itv.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 22:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=eQHRr9Tl3iWA/tAC3rOoFC/Acid0hZi2e+ZYmjdnEhc=;
        b=KsddFyhnu27PytVCKTYRF6sBj5womwuSDPWP+1X626n95vs209sAjx17eHSi1pOCjQ
         KO0LnQjUqpvhM9/2N+wG3cJdjdij90XIlO5vsOQ3cMwlMA4VWOBAmlpP2HbeihJMb4Kq
         czQqCs13UBLlDqCo2LlCjrlTUEBiYB32GM1dRzkSxvsokEUpMh9qOKb10AIbpQqSc2nN
         UI6Tbs1Iy/TgkrvvXHC9LkDNAEELpMSBL0xLYVZh9iceLwita4qvJfwJBIR36WBLYjmV
         iUsu+dJAC5vcfmKHZPTQJfDInwE92qWwt+okM0oAwy0Y69tFeUL0zN9TqdUCxzpqWkIc
         2vSw==
X-Gm-Message-State: APjAAAXnYHZCo/5sjBu+/PXPVZ1Z/yltfC9r80EOb1qd0scdD7X7Frd1
        d4PTkz4k3+OZxyziL8AClK41S6OHQpIc6VMVeGfpEXP/L4Fo
X-Google-Smtp-Source: APXvYqyUrGXnxeyNx/Ny2a1mSn2QPuivugZT22c1VykyKiGmUbYWAMvWZ03eHH9ErtA2Rbj0Fwv/tbxEEPmEbrZMTMBCcb+/HLRC
MIME-Version: 1.0
X-Received: by 2002:a02:4086:: with SMTP id n128mr6036484jaa.19.1553923021525;
 Fri, 29 Mar 2019 22:17:01 -0700 (PDT)
Date:   Fri, 29 Mar 2019 22:17:01 -0700
In-Reply-To: <00000000000006602605752ffa1a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4d871058548e5c8@google.com>
Subject: Re: general protection fault in tcp_cleanup_ulp
From:   syzbot <syzbot+0b3ccd4f62dac2cf3a7d@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        edumazet@google.com, john.fastabend@gmail.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 90545cdc3f2b2ea700e24335610cd181e73756da
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Thu Aug 16 19:49:07 2018 +0000

     tcp, ulp: fix leftover icsk_ulp_ops preventing sock from reattach

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15dab897200000
start commit:   28619527 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       bpf
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17dab897200000
console output: https://syzkaller.appspot.com/x/log.txt?x=13dab897200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=0b3ccd4f62dac2cf3a7d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13537269400000

Reported-by: syzbot+0b3ccd4f62dac2cf3a7d@syzkaller.appspotmail.com
Fixes: 90545cdc3f2b ("tcp, ulp: fix leftover icsk_ulp_ops preventing sock  
from reattach")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
