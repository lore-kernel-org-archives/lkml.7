Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB1FC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 22:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32BC206BB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 22:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfIAWsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 18:48:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:38095 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbfIAWsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 18:48:07 -0400
Received: by mail-io1-f70.google.com with SMTP id m5so3972117ioj.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 15:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oZ7PvWIwxMv1/cng7QdJTXniFprQdIabY+CLNCeHUIU=;
        b=PUjj9mzUHnubmoqJhGnC6SEa5mpbU+u2bbnC3C9ykAv3wLsqL0vWBgqDCzwVkDj1JO
         VG+TUwxXBKv7H1vLAfBf7q3jpZJQJ1cdYtH978YUGeh50HUUKUt1UHVQ2+SsuiSZjWiM
         px409RxSMjmdU6e9nIUJ7saCCMx5IV46m4KqPY+MW0Du3O/hs3haXCZ581pq9ssMGj73
         b9Lt3wiNygvG167mRv3TkTfUAVEZdgnq1cObVi7Lpw/LXiY0CJFfHyuTKrcXPaVqgeX8
         pQ5HyiwFisePL3Tz8ujR1eNKmP1TvoI0Rz8hqhqvgt4ZopvoA1GE42hqZLwcEgbzMGTH
         0YRw==
X-Gm-Message-State: APjAAAWIScThQZuThK32+TpXoEk3nHJjuhss4hi0OxCOP4b+MZCgnCb4
        fhwyRIuHVqqB5RV5Ab5HqWoJSfVYO0XW1frpsD+BpVTcijdU
X-Google-Smtp-Source: APXvYqxkOy9L/u3bMqXmgBaNVgEPTyYoJ1rsnAf2MDiw2d4CjHtOj2tKqoco+5DF2ypE6mSFR8x5mj40pTs1NqPNpKaYBkhbyw9g
MIME-Version: 1.0
X-Received: by 2002:a6b:d006:: with SMTP id x6mr30154654ioa.218.1567378086214;
 Sun, 01 Sep 2019 15:48:06 -0700 (PDT)
Date:   Sun, 01 Sep 2019 15:48:06 -0700
In-Reply-To: <0000000000009b3b80058af452ae@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ec274059185a63e@google.com>
Subject: Re: kernel panic: stack is corrupted in __lock_acquire (4)
From:   syzbot <syzbot+83979935eb6304f8cd46@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    38320f69 Merge branch 'Minor-cleanup-in-devlink'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13d74356600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1bbf70b6300045af
dashboard link: https://syzkaller.appspot.com/bug?extid=83979935eb6304f8cd46
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1008b232600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+83979935eb6304f8cd46@syzkaller.appspotmail.com

Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in:  
__lock_acquire+0x36fa/0x4c30 kernel/locking/lockdep.c:3907
CPU: 0 PID: 8662 Comm: syz-executor.4 Not tainted 5.3.0-rc6+ #153
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
Kernel Offset: disabled
Rebooting in 86400 seconds..

