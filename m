Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9523EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C91F21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfCTUfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:35:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:55695 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCTUfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:35:01 -0400
Received: by mail-io1-f72.google.com with SMTP id l10so3166943iob.22
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JmLVF5snE2NyN7hOU1yFMUMgFKqoLudwJA/IgtiwKX4=;
        b=kGN/cmgWekUMNWMC0PMykS4614Vr74tvzEZmwea7clAH/S6hfIrscPB1gnwrvIyjtF
         rb6I3AJa3DgP6Euw1QePO4+sMqD039OUkte13jeVC5SL+hB3soRR6oymyR6maBd0hOAH
         j9pOKJfKfEUxvwtSV0nL4M5NVJof6v5Qv3Ic5knHnojRE8CXmSnj6lsrANnkDqXxunsf
         fIf51UldGnNWiWkq+0ZXjTytAJW0k6j6V5aQ75mT1Fu71DyllHg3UZypzLZLoEK3tkJD
         ck/fz0fnB9EDnG++0qPWOyfH2oR6cBxJO97IAKrOgc27S5k916pP61eokRPyHJrShkuX
         VjTQ==
X-Gm-Message-State: APjAAAXlLwHGHWMmQq479cq+YtXkdo1AeN4GS2paCRKEQSbzyeG6dC2w
        cwaeJaDsuFCbVYCanFza3bUYcJgHn7gnrS5HVzkkAELItrL+
X-Google-Smtp-Source: APXvYqw0cMwjeDljIAs1pj5QYCuuZfAcL8XbBmSJ95chswsZft4cVbAefhbc8z3zFJpn07YcUU+D6Vh1VJFN0w1k9tJPdafn/2IJ
MIME-Version: 1.0
X-Received: by 2002:a5d:9a0d:: with SMTP id s13mr5895129iol.26.1553114100801;
 Wed, 20 Mar 2019 13:35:00 -0700 (PDT)
Date:   Wed, 20 Mar 2019 13:35:00 -0700
In-Reply-To: <0000000000001c2b95057ad0935b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000462a4105848c8e12@google.com>
Subject: Re: kernel BUG at arch/x86/mm/physaddr.c:LINE! (2)
From:   syzbot <syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com>
To:     davem@davemloft.net, hverkuil@xs4all.nl, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, mchehab@s-opensource.com, mkl@pengutronix.de,
        netdev@vger.kernel.org, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 6d469a202ee73196d0df76025af80bd6a379e658
Author: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date:   Sun May 14 17:07:21 2017 +0000

     Merge tag 'v4.12-rc1' into patchwork

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12639fd7200000
start commit:   6d469a20 Merge tag 'v4.12-rc1' into patchwork
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15639fd7200000
console output: https://syzkaller.appspot.com/x/log.txt?x=11639fd7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
dashboard link: https://syzkaller.appspot.com/bug?extid=6c0effb5877f6b0344e2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1312062b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131bd093400000

Reported-by: syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com
Fixes: 6d469a20 ("Merge tag 'v4.12-rc1' into patchwork")
