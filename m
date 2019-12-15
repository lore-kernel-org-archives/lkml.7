Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3086C2D0CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 01:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8385E2073D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 01:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfLOB1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 20:27:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:42721 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfLOB1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 20:27:01 -0500
Received: by mail-il1-f197.google.com with SMTP id n79so3196103ilh.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 17:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=c+s69FUrevmh/qMLgOyZw9GWvtN3ytNCAie8XX1Wio0=;
        b=JHgfIwaDc1WKkR0OufYUnXjF/B3uC5CHPrGdmUupJHLcireINhhal1xqe/7r1u5/fK
         YZo++lazSjn/2mR5CfWfyshglTxMbxcgnqlpKaWM/cA2aVFD0gtK5Ped31hTOJ3h6VhW
         gWnwQojJEXgdJL5xCH6UhA3BsqZZRPcum1AReYSwx+wati1VNMsRyitV+QmF13SAuctw
         Fy0iuVoyOGgg4/pq5bTf5w3YyaHdkKbLj3bAwBk2495d0/W/i/niVaaUIigz8YQYGihv
         M83nq+fWbw7F8Fu21B1wVcTajD13oJHTjbgDlZA4iMbH0qiIuSm0RR87XJ3Blok5+wQE
         w7vQ==
X-Gm-Message-State: APjAAAUU2NscH/HO3lfB2/XmeCo4Ph693sAHaQekS9Jxjf9NYKjoeZKx
        YGoY+RQKu3kTq3swNnpJHyAUy2NAmRlDtiKJTs5HPrRlvunl
X-Google-Smtp-Source: APXvYqy7O21f8gr/KcYVDGHHA00H9AO2+CAAcrvPyJbJkQR9bGCOqaPnuFyWq42GKUJVdxRtIb/Aqis0HVOF9COqLeCaOOMD3jTv
MIME-Version: 1.0
X-Received: by 2002:a92:5a56:: with SMTP id o83mr2853063ilb.97.1576373220852;
 Sat, 14 Dec 2019 17:27:00 -0800 (PST)
Date:   Sat, 14 Dec 2019 17:27:00 -0800
In-Reply-To: <000000000000c71dcf0579b0553f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dcc9b10599b3fd5e@google.com>
Subject: Re: KASAN: use-after-free Read in ext4_xattr_set_entry (2)
From:   syzbot <syzbot+4a39a025912b265cacef@syzkaller.appspotmail.com>
To:     a@unstable.cc, adilger.kernel@dilger.ca, afd@ti.com,
        b.a.t.m.a.n@lists.open-mesh.org, chris@lapa.com.au,
        davem@davemloft.net, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 8835cae5f2abd7f7a3143afe357f416aff5517a4
Author: Chris Lapa <chris@lapa.com.au>
Date:   Wed Jan 11 01:44:47 2017 +0000

     power: supply: bq27xxx: adds specific support for bq27520-g4 revision.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16661f41e00000
start commit:   ae4b064e Merge tag 'afs-fixes-20191211' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15661f41e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11661f41e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=4a39a025912b265cacef
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ec1332e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163455dee00000

Reported-by: syzbot+4a39a025912b265cacef@syzkaller.appspotmail.com
Fixes: 8835cae5f2ab ("power: supply: bq27xxx: adds specific support for  
bq27520-g4 revision.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
