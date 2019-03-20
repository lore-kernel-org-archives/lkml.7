Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1555C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF67218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfCTUzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:55:01 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:50777 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTUzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:55:01 -0400
Received: by mail-it1-f199.google.com with SMTP id i63so590977itb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ATMdaYfMrEzLAK/3qVE6JRfPa140C73ivhkxaf+hG2g=;
        b=r960IvT03qtUooHy+a+6lXCr6BJwvT80FBQhY6nxiOj/lDlcVuepvNrcKzgsErIgcD
         jBpZrMo8/+WRHDAjgsnxS3g/BxsZoaHP4s3NRYTU8rQ2oAZhjVt/MAJwSZHcDVB1QEKe
         i/+31A5mKEssfZI9j7noVeUUBOAzGX+Lmv7IscmI1rFJqTm4ZGQVVd2GKLrkvfet7M5z
         ZlKCrkVdeq84ozPlHElSB/ipBW992flG04Hc6zxH01fuRu1UBJpZHfQ5SHK0XR5qozbM
         JbFVHNVcoDN14Sc986BR5Imh7wTmLiym3GBCF9jFAgoL/Ja/EG3LCQxXIIngEzgApQLf
         +p2A==
X-Gm-Message-State: APjAAAUbxHjk7KCKswIDQyk2Hvn+D51Zuv874G4NC5SP6qfDq+tYW4Hi
        mn7peFPFwSEPjLX+TbIsE5vV03FuayjTJ2YsSZwGlNmZ5FpT
X-Google-Smtp-Source: APXvYqwKWmO54DQg68LMcZG0mYLaGtrq1IyFFVS31blZL0BGi+p6SIX8ng6BT6POF8LV5tRBsdsrdl/RPJeOjZV3hvpuM7aEMCJ7
MIME-Version: 1.0
X-Received: by 2002:a5e:a904:: with SMTP id c4mr6838iod.19.1553115300405; Wed,
 20 Mar 2019 13:55:00 -0700 (PDT)
Date:   Wed, 20 Mar 2019 13:55:00 -0700
In-Reply-To: <0000000000005b7456057a9abc57@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6a7d005848cd56d@google.com>
Subject: Re: kernel BUG at mm/slab.c:LINE! (3)
From:   syzbot <syzbot+2182db487a523d86bf34@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=161b63cf200000
start commit:   b8a51b38 fou, fou6: ICMP error handlers for FoU and GUE
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=151b63cf200000
console output: https://syzkaller.appspot.com/x/log.txt?x=111b63cf200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
dashboard link: https://syzkaller.appspot.com/bug?extid=2182db487a523d86bf34
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148d46d5400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c6a225400000

Reported-by: syzbot+2182db487a523d86bf34@syzkaller.appspotmail.com
Fixes: b8a51b38 ("fou, fou6: ICMP error handlers for FoU and GUE")
