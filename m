Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC4DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24FC217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfCTAsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:48:01 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:57201 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfCTAsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:48:00 -0400
Received: by mail-it1-f198.google.com with SMTP id j18so716225itl.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3/728mE6SbMqzXA8ngA0Ve0rl4E1oX2rE7P9QzlZUs8=;
        b=OM8uMPo/1bBinbDx/ZkD4Q4qQYmm9CcfAQHBdsAQMLLPklsVKG4tLxD3Gp+EMtSbCM
         NKiqWjhiWghrq4g5bgPyBMA8up7LHjoSaI/NuK79ONdA7qvU0dRaDlf1FxmSgWx6b8bg
         nMHP/f5h+l/5Ms09rkrXekEt9iGzo/ed5XFauvTaxJnmsMEKdZY+B0uGCLbGhsbBFtHy
         niR7bKGDiZweeF4DF2NKGpQ0U9YfatC5LQKGB3vXIPCRxfGWGbroR0xOYhCPiOmOZxxe
         JOO8tJoRj86g9JLZOVNInm3YEA1mpBeZBCLwy2nJb55i0wyJOl0DvqE0EVXqL8cDxqr5
         G4WA==
X-Gm-Message-State: APjAAAU+hZlME2hlOeBxqZdT3eoqP9gcdkNCtPu6PFVfAtH/SUXLOQLP
        /Pb9X3dRa5wFY77IpGGc71zyKa1t0cWxydu6x0OeBmFgm+Fg
X-Google-Smtp-Source: APXvYqzQNf6asasGYyVRtcCvh8WP+tL2AOm1njJVJmZj45Eecy58z2fkBMq5KCwbwggD+N7+57TCpeHI2mkuMEZYiKRDVrqgURqN
MIME-Version: 1.0
X-Received: by 2002:a5d:8b47:: with SMTP id c7mr15720367iot.21.1553042880214;
 Tue, 19 Mar 2019 17:48:00 -0700 (PDT)
Date:   Tue, 19 Mar 2019 17:48:00 -0700
In-Reply-To: <000000000000e10044057ba6fbcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000323a9805847bf9fd@google.com>
Subject: Re: KASAN: out-of-bounds in update_curr
From:   syzbot <syzbot+d3bf6aae26942dc9c8dc@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dvyukov@google.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sbrivio@redhat.com, sd@queasysnail.net,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
Author: Stefano Brivio <sbrivio@redhat.com>
Date:   Thu Nov 8 11:19:23 2018 +0000

     fou, fou6: ICMP error handlers for FoU and GUE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14de0d27200000
start commit:   b8a51b38 fou, fou6: ICMP error handlers for FoU and GUE
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12de0d27200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c36a72af2123e78a
dashboard link: https://syzkaller.appspot.com/bug?extid=d3bf6aae26942dc9c8dc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107b426d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b2e533400000

Reported-by: syzbot+d3bf6aae26942dc9c8dc@syzkaller.appspotmail.com
Fixes: b8a51b38 ("fou, fou6: ICMP error handlers for FoU and GUE")
