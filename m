Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB988C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DF721904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfCVHIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:08:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:34730 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfCVHIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:08:01 -0400
Received: by mail-io1-f72.google.com with SMTP id y13so1025160iol.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 00:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=We/Sg27LqRj2nWSdbJg1A6SLyTwFCLM1xyYF+U7bC/g=;
        b=jcTkkSeRB/d4nAe2Mh66sQ5m07duGAWWuFzuvfvblbhTNS5yRx4oq1aPxHdzhNnR4G
         HtVoR4wHOFSywOwe+nIq3+1C5WRUzmT1HUgCK6iVY73//DTf7yDhlp6pjmq/0/OS049P
         X4x0AZYIaV8r9p1TyDxhV87fAxA7eTwZejGCQGM92SyLZaRmHJaXQ1XKdGgGCv0Od96u
         j7LT3JowOHgtEY3gKukbqkuSFIukZxk64uiA2AgQ0IC0GPWHplbeho7TlU/Sqf1ubGVe
         c8DZHbZJhGO6TqXI2JxESQfT8kZyS9BvWEiNzk+PL8/k94ea5hgVwLrSNAJwIZr6m4tf
         ntMw==
X-Gm-Message-State: APjAAAWOCxjgowcDMsA0X6ZgfleuXNybdo7LM1K+oCSU6XcYKyqX/AuW
        loSAH/Vuj+GEwIM9boj0VnABLCrKc0Emmrz1bjWG0cSmBs62
X-Google-Smtp-Source: APXvYqy7Aky+F53NuKK5x5RtyI0ve6II5XMGbh2PGk4QjvMLoUnO1wr6ezUcLU4k6A+9z1PAAFkU6O0JTiM34h3c47R1BqElu7bH
MIME-Version: 1.0
X-Received: by 2002:a5e:da0b:: with SMTP id x11mr5537935ioj.200.1553238480789;
 Fri, 22 Mar 2019 00:08:00 -0700 (PDT)
Date:   Fri, 22 Mar 2019 00:08:00 -0700
In-Reply-To: <00000000000080601805795ada2e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e626290584a983c0@google.com>
Subject: Re: INFO: task hung in vivid_stop_generating_vid_cap
From:   syzbot <syzbot+06283a66a648cd073885@syzkaller.appspotmail.com>
To:     andy@greyhouse.net, davem@davemloft.net, hverkuil@xs4all.nl,
        j.vosburgh@gmail.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, maheshb@google.com,
        mchehab@kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, vfalico@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 4493b81bea24269df898339dee638d7c5cb2b2df
Author: Mahesh Bandewar <maheshb@google.com>
Date:   Wed Mar 8 18:55:54 2017 +0000

     bonding: initialize work-queues during creation of bond

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176d1617200000
start commit:   4493b81b bonding: initialize work-queues during creation o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14ed1617200000
console output: https://syzkaller.appspot.com/x/log.txt?x=10ed1617200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62118286bb772a24
dashboard link: https://syzkaller.appspot.com/bug?extid=06283a66a648cd073885
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15701a33400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154c8e4d400000

Reported-by: syzbot+06283a66a648cd073885@syzkaller.appspotmail.com
Fixes: 4493b81bea24 ("bonding: initialize work-queues during creation of  
bond")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
