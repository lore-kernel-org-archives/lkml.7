Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B14AC2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 13:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77310207E0
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 13:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfL1NLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 08:11:04 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:56561 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfL1NLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 08:11:04 -0500
Received: by mail-io1-f71.google.com with SMTP id d13so10419016ioo.23
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 05:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8/MjX1lwUwtL5T8VvrucT08m+Eu8aAT/rAF6iBvp3So=;
        b=uCF0Wg6LfZKSC8RkdDmpL3JQP1Hwqa7UPY08YCAPi4BBvbsETWK+m1IQHAB8yZRosI
         cuhCP6usIiTkhjiWiADRXxy16fCTGglaJMMVBzTDeasNRiAat0tTIiX700q+ePJpxIag
         JdJ8p3axT/xsAvqrLUeWdguNZNTCGwZfnGfgU1OVrg+feKS0JhHYfUKiN7wxgkTWFVj2
         NprphKOyZQszeFj20fwEbyxqEnamPHGA+bo1QQwn1FsWkiDfcy0TOyH209xDKGiMO8jx
         rg7dYlKUVpK26DT3fe7KSGoLndk5t+kYlymSmfUUF8aNe2gQ/qnstCfKE26qY/ofNcpP
         6Oqg==
X-Gm-Message-State: APjAAAUC0Ni9pIhjxD+xrS2+dioSUqd1pnaifyK3VFmJ0SmPmqsfjS04
        HnfTe1q2xQmOwAfx3RSoj3p6ckij7yCP6X+YzyGrOF/zlcIt
X-Google-Smtp-Source: APXvYqwpQmWyQ/qizdsQTsnFqN2fa3qKScrqkdeqj86w0HwUYbNMuL7um6mm8GUN+KnoVCKNQo9OCwzGNT899Y4BoZSj9y3CjtBh
MIME-Version: 1.0
X-Received: by 2002:a6b:7e02:: with SMTP id i2mr37722747iom.172.1577538662128;
 Sat, 28 Dec 2019 05:11:02 -0800 (PST)
Date:   Sat, 28 Dec 2019 05:11:02 -0800
In-Reply-To: <000000000000b63799059aba5164@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009360cb059ac3575d@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hsr_debugfs_rename
From:   syzbot <syzbot+9328206518f08318a5fd@syzkaller.appspotmail.com>
To:     ap420073@gmail.com, arvid.brodin@alten.se, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 4c2d5e33dcd3a6333a7895be3b542ff3d373177c
Author: Taehee Yoo <ap420073@gmail.com>
Date:   Sun Dec 22 11:26:39 2019 +0000

     hsr: rename debugfs file when interface name is changed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1391cfb6e00000
start commit:   3c2f450e Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       bpf
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1051cfb6e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1791cfb6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f6119e2e3675a73
dashboard link: https://syzkaller.appspot.com/bug?extid=9328206518f08318a5fd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106d4751e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1775a49ee00000

Reported-by: syzbot+9328206518f08318a5fd@syzkaller.appspotmail.com
Fixes: 4c2d5e33dcd3 ("hsr: rename debugfs file when interface name is  
changed")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
