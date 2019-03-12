Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4596CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CDE214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfCLI5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:57:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41681 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfCLI5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:57:01 -0400
Received: by mail-io1-f72.google.com with SMTP id p17so1280253ios.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zABCvLzwKBtQ5YERvb5D0oYfBZaKLzYYuJoXx1uIEFc=;
        b=hD49wmKRn+APzpr7MdcW5qQyvPEFk/wirxlqB4e+cxXU/CQs1GIPjMKpioGQW8wUq4
         3R/LPUkjY9s+L3JQJtfXdmDidckvIEt0fbjUyXZXTr9OUMaz/x5yUix0LYvI1hlnrWfA
         2vdev04kH4mikmWhp5azfXm9Rm8/Kmur4mI0QMrG1bLnpOBNcMKzr9Aqu1HAEEDmQJwh
         TMpz+80QZj1+0gc5BNUqnP/8hGvqIPWURHwT/wS+D6K87xx9u+MLEZfp0nQaU9dyPeA9
         7BIquD/WHB3iRargaj/Ljn09cejOyCh5Fjixzp0ZGStZBSev3xu44bqJju2KYD7FTZuO
         RPmg==
X-Gm-Message-State: APjAAAV6JR1AtOdXoqiU4v/ZsMqJoJNORNNeZgZKvFOgnya5YAHP3HQJ
        4Caz/bCT8WyzxfCg0Ny2vGEHf5UFEQultvh5Qp16vOoENr05
X-Google-Smtp-Source: APXvYqxT11vQtmaQ8rPeYfnws2sGLw1twNgVfZiI77NFg+AMRVn6ETEYm221Q85lEoZ3s7NGjtUqlJKmBbEJ4ShXKRHXB5i5xZRF
MIME-Version: 1.0
X-Received: by 2002:a24:29c5:: with SMTP id p188mr1308818itp.4.1552381020794;
 Tue, 12 Mar 2019 01:57:00 -0700 (PDT)
Date:   Tue, 12 Mar 2019 01:57:00 -0700
In-Reply-To: <0000000000009f94c1057e772431@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004cfa120583e1dfc3@google.com>
Subject: Re: WARNING in hsr_forward_skb
From:   syzbot <syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, axboe@fb.com, axboe@kernel.dk,
        davem@davemloft.net, hch@lst.de, linux-block@vger.kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mkl@pengutronix.de, netdev@vger.kernel.org,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit ab42f35d9cb5ac49b5a2a11f940e74f58f207280
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri May 26 11:53:19 2017 +0000

     blk-mq: merge bio into sw queue before plugging

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e68713200000
start commit:   ab42f35d blk-mq: merge bio into sw queue before plugging
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15e68713200000
console output: https://syzkaller.appspot.com/x/log.txt?x=11e68713200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
dashboard link: https://syzkaller.appspot.com/bug?extid=fdce8f2a8903f3ba0e6b
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f6d1fd400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17290fdd400000

Reported-by: syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com
Fixes: ab42f35d ("blk-mq: merge bio into sw queue before plugging")
