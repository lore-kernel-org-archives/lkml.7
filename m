Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9002C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F1F2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCTRIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:08:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:55309 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCTRIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:08:01 -0400
Received: by mail-io1-f69.google.com with SMTP id l10so2605405iob.22
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NS1NrcRUcS0tKKGgmb2skJ/xqucXk1o9rgiLaWhKW9w=;
        b=cy2jU2zIQypgBpthbzy/RrJjV/4LrdcEJaMHVJfP6Yapf2pbMhv2wemGMNk0V3EWQ+
         /tJODKHBa7jucxfxUnHyBX1nEZRi1px2PenRn0X5tGVLCuN2Kcngr6hAjmmJnBGKHgvB
         KPPrwCeEzN3qkgR5NNQTN3lb04jwAxqJ3h5eNUPsYvC68Rv7zaJ8Tcxyf/d1XsdadlLy
         jmd5reaiGAdbAd8p3pao9fXMbSl4M5mVAYe8uvMeKXRjoRHHiGLSyWXtM5btDov/F9kU
         iz3Jn2gjUfivohnhZN8EFxCTay8XwK2zlohRXPHWs515dwbi/+9EpMw3vUvUpOKRbmyJ
         DguQ==
X-Gm-Message-State: APjAAAWQc6+p3oakBQyy7pnbSph/P112nzMH/IEKuty1A3UL6IB2jeGQ
        bIaRINuemNaWV+DWqHaLpBAxT105TTsurj8tQTTT85R3lcHr
X-Google-Smtp-Source: APXvYqzaCUN8NCMDuAmWy3CxOottRizhhnZK3g4cK3QEZG+OovIPbAQa5sIQbwHyUxln7uuveFghYeQ1ldwBS5TpJshNRnz9EexJ
MIME-Version: 1.0
X-Received: by 2002:a5d:8b47:: with SMTP id c7mr17965228iot.21.1553101680918;
 Wed, 20 Mar 2019 10:08:00 -0700 (PDT)
Date:   Wed, 20 Mar 2019 10:08:00 -0700
In-Reply-To: <000000000000b5e346057af4da06@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdcb1d058489a91b@google.com>
Subject: Re: WARNING in enqueue_task_dl
From:   syzbot <syzbot+119ba87189432ead09b4@syzkaller.appspotmail.com>
To:     bp@alien8.de, bristot@redhat.com, dvhart@infradead.org,
        dvyukov@google.com, hpa@zytor.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        luto@kernel.org, mingo@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, torvalds@linux-foundation.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 7c80cfc99b7bfdc92cee26f8008859f326f4a37f
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Sat May 6 14:03:17 2017 +0000

     sched/fair: Clean up calc_cfs_shares()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=169d614d200000
start commit:   7c80cfc9 sched/fair: Clean up calc_cfs_shares()
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=159d614d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=119d614d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76d28549be7c27cf
dashboard link: https://syzkaller.appspot.com/bug?extid=119ba87189432ead09b4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10eb7ebf400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14156d77400000

Reported-by: syzbot+119ba87189432ead09b4@syzkaller.appspotmail.com
Fixes: 7c80cfc9 ("sched/fair: Clean up calc_cfs_shares()")
