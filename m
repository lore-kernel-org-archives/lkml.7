Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8ABC072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F402173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfEUVIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 17:08:01 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:34945 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfEUVIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:08:01 -0400
Received: by mail-it1-f197.google.com with SMTP id m188so146589ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 14:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UzmPeUGaB8JKZJ9CS0AWltu9MikJ5xxP1GF6GVzJW6I=;
        b=I86J0ocY/mjclgGyscYp2BVQrrakOQVlQOYDIGEaB2oDHHZICAuUI0BsZ4ex5UAXfH
         BHptGQY4hD3TcHKvPgg3nFKxOP4Q5Y9rv8FkYve3vpTRdocJDFHRwv0mBZ7V5IIPO4cw
         4STyz36Srj13w6M0SKdSCzzTy8Pd/oqYnaeHDjZzAkqqFlDwueIdtyThFRnkbopKaXwY
         Lgrd8R0RIo/boKUOvd4lSBiCMjj0R/Chlw41+7Hj1viKdLUuV9/bXFOpwQ8n8ZtKkFP0
         69FC/7X9iLpOPZR4XzUo1lDz66MZk3gK/Sw6kOVYVB2H7u/ocqJMMVlWelosZe635/Si
         2lzg==
X-Gm-Message-State: APjAAAXyl02mfUfVA2GQ3NIQSTk268WQJ6ke3oidx+NNgnnA2gvBh9Vs
        gPbul2zwB1uZkYWBB4WJG5mbu/QXFPA7VLM+BDkmapj/L4RP
X-Google-Smtp-Source: APXvYqwtcVeO8IOlYtpHb+pYSw2wdqPB0c8EwcnSxnMt61P6oQuZ5TprV3iiiFbK3fSCqQiDaNir0ZBnxV+7ib/d+4hx9iNpXOLP
MIME-Version: 1.0
X-Received: by 2002:a24:7309:: with SMTP id y9mr5819441itb.162.1558472880669;
 Tue, 21 May 2019 14:08:00 -0700 (PDT)
Date:   Tue, 21 May 2019 14:08:00 -0700
In-Reply-To: <000000000000ac9447058924709c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071c8a105896c3ef2@google.com>
Subject: Re: WARNING: locking bug in rhashtable_walk_enter
From:   syzbot <syzbot+6440134c13554d3abfb0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, hujunwei4@huawei.com, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, wangxiaogang3@huawei.com,
        ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 7e27e8d6130c5e88fac9ddec4249f7f2337fe7f8
Author: Junwei Hu <hujunwei4@huawei.com>
Date:   Thu May 16 02:51:15 2019 +0000

     tipc: switch order of device registration to fix a crash

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1285d39ca00000
start commit:   f49aa1de Merge tag 'for-5.2-rc1-tag' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1185d39ca00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1685d39ca00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc045131472947d7
dashboard link: https://syzkaller.appspot.com/bug?extid=6440134c13554d3abfb0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c586bca00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14759fb2a00000

Reported-by: syzbot+6440134c13554d3abfb0@syzkaller.appspotmail.com
Fixes: 7e27e8d6130c ("tipc: switch order of device registration to fix a  
crash")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
