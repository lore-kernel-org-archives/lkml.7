Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F492C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1626120693
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfCPOtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:49:09 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:51529 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfCPOtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:49:02 -0400
Received: by mail-io1-f70.google.com with SMTP id k24so9426967ioa.18
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/FZEL/bPt7ujmqAcs94QDjsDpx2LyNR4B1N3uAyx96s=;
        b=TWr4ZqtL/XERYmZjM3qH5S6uKah6kMDQlWqYgpFze5KQiYXvvkkHydLwc4N1HYtIx0
         XoFjlJCVdO+f/JOfZWrrmJOZ5GWRQ8PH4A46bqlOidqtCgXehOysnhPKLsdMLnM9GXbB
         sL7MFJRX9psPcTiKymWfcayLpuQIEyow+tb0DI2N+oZJWiq+9rxUijNnrL8H1lT/ga6x
         Jmpz8pN+JScE+YVsz98F6GecnY6oVgTNxJeU/OEZcTMsxgpCeSgj/DP7XmgudfsnDtxR
         hciqzP4TXnm6v9H0KujzWDn62gjrPG4ZHrD+MAJMahu13DUPMKQhGuG0vQnYE5hrcD1d
         a7Hg==
X-Gm-Message-State: APjAAAW55zSgPIg7v+IaGMhDSLJrmZUcHp21opzlmRYeJtXvgbBcdXFi
        y1GHgUD3KPLtLCSm0gqyA3TgLvANCVkk7QGJx/1E5nErOelA
X-Google-Smtp-Source: APXvYqzTe6vkXvmrGcwVvHNAMaL8BdxscrwjI2qCqAeFKJMscXsrEW3HAv5AFwp82N4x61aTzgpJPDd0NpUhfx4yKnoXFQWOo3ic
MIME-Version: 1.0
X-Received: by 2002:a5e:8f0d:: with SMTP id c13mr5661772iok.37.1552747741829;
 Sat, 16 Mar 2019 07:49:01 -0700 (PDT)
Date:   Sat, 16 Mar 2019 07:49:01 -0700
In-Reply-To: <000000000000551b80057d31a5f7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093e58e0584374110@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in tick_sched_handle
From:   syzbot <syzbot+09d51a30df9fe76edb2a@syzkaller.appspotmail.com>
To:     davem@davemloft.net, fweisbec@gmail.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        netdev@vger.kernel.org, sbrivio@redhat.com, sd@queasysnail.net,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        yoshfuji@linux-ipv6.org
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f943e7200000
start commit:   b8a51b38 fou, fou6: ICMP error handlers for FoU and GUE
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15f943e7200000
console output: https://syzkaller.appspot.com/x/log.txt?x=11f943e7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b05cfdb4ee8ab9b2
dashboard link: https://syzkaller.appspot.com/bug?extid=09d51a30df9fe76edb2a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17359fab400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154a2a37400000

Reported-by: syzbot+09d51a30df9fe76edb2a@syzkaller.appspotmail.com
Fixes: b8a51b38 ("fou, fou6: ICMP error handlers for FoU and GUE")
