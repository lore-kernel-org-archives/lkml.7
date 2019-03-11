Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ED8C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60142084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfCKNIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:08:02 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:51190 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfCKNIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:08:01 -0400
Received: by mail-it1-f199.google.com with SMTP id i63so4951456itb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jV0TIOFNu+hVCGZgL94GVpwyNNbbjqUpazKlNnc3uFo=;
        b=Rkvq4wIBLy64VxBvwNJaTLkDdCPwpj5eWQISpeqgpTMl8Xc6ff8pioeLFBdWWXk/J6
         it2txT29z/3UGQMS0l/A2gUS6ggtHnzmiaR3BDICTlrh0P3pBB7pxiSus3f+IQgLZYhI
         b4uv1TYHFlAdaoPABFqYnVIFCYK9l44gyCocw1yHv0s0b26YkOfdhLu/qq+ouCv06rUi
         eoWJQ4NwgmuRKM16I8va3T9MhJ0NDL5P1Z09UW24Nys6kUM49KzFNjFkIRTUkaBaBFRU
         B3veCg4+4JU1qlyykHuWdS4s1BgmFjBOb6Omv+Z47lCldPh3lGp9dP4wkjQ/CK75PmCl
         yeew==
X-Gm-Message-State: APjAAAUYwWsRAOo55BaKTwVAW54PSQVYsdJHSXEoZQ9nvNIa9aDeog9r
        DVklarFzRpkTWNy2ZNTR96h4dCNPr2qX1Na3Sh1WSurNu3kR
X-Google-Smtp-Source: APXvYqxMWqYladm/NuaaRcwSzK/ttla74H8jKKFHCdgh/T+j32JYKNzD0KzruYXhlxc68jbCk92jCqJ8tzbdub8vUeRjgDEPOdul
MIME-Version: 1.0
X-Received: by 2002:a5d:954c:: with SMTP id a12mr19448883ios.14.1552309681113;
 Mon, 11 Mar 2019 06:08:01 -0700 (PDT)
Date:   Mon, 11 Mar 2019 06:08:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fd5780583d1433f@google.com>
Subject: KASAN: null-ptr-deref Read in reclaim_high
From:   syzbot <syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, mhocko@suse.com,
        sfr@canb.auug.org.au, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 29a4b8e275d1f10c51c7891362877ef6cffae9e7
Author: Shakeel Butt <shakeelb@google.com>
Date:   Wed Jan 9 22:02:21 2019 +0000

     memcg: schedule high reclaim for remote memcgs on high_work

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155bf5db200000
start commit:   29a4b8e2 memcg: schedule high reclaim for remote memcgs on..
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=175bf5db200000
console output: https://syzkaller.appspot.com/x/log.txt?x=135bf5db200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=611f89e5b6868db
dashboard link: https://syzkaller.appspot.com/bug?extid=fa11f9da42b46cea3b4a
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14259017400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141630a0c00000

Reported-by: syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com
Fixes: 29a4b8e2 ("memcg: schedule high reclaim for remote memcgs on  
high_work")
