Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B050EC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2922077C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfGQKFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:05:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:54403 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfGQKFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:05:01 -0400
Received: by mail-io1-f72.google.com with SMTP id n8so26530300ioo.21
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 03:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TTvRZwA8TDPGBK9TibJ6ly9VeeNnSU2IT+OU5u4KhhE=;
        b=Repsrl1ylE2lPGNa0TqE47Tumhi8+v1gK7d/XdwgrC8FXec5EHXS//VNiGA08vkn/G
         5dp2EQ6+OWPkfvWT0UsH7yysJlW9uFw21dgbGd28sT7aPdZeJfqSy8/QUo620IrovJYB
         nKOGB3Uw3Lt5Vj5NSTNf3nu8bw8aMLpigCjj26yGGhGr3qKL/0yAojS6y64pVRAl1S6s
         I6bgbaV/qqhGU3UxasBACUbyBvr6VRX+nKXGqnbbpfZN3bm5snHjYovAA8BOYpqys3wu
         NAfreCpRqsI8eoCrwHeB2L6UomzNjCTIXWuVtGgPvi+BE+CRaZsg1J4ys6X04jhc+xa4
         GJdg==
X-Gm-Message-State: APjAAAWvUaMvic9m2iwLxUz5/21fg/71t7uRVnUVpM4ZqHYQsswKm64N
        ZbCl+/8a/LqLSGkAfdZPoxRkdAc8Vg1BtzTm57U0aRtmlRqX
X-Google-Smtp-Source: APXvYqygQgdRgLCMVKgGwqYS2YzrTxrwtIneXoQQgmYGyvms+ow3F6cA2ozkKNBfmEvrb6Cbs/OgXfe3/5McPbETYvJRCUiZzHs9
MIME-Version: 1.0
X-Received: by 2002:a05:6638:281:: with SMTP id c1mr40048066jaq.43.1563357900838;
 Wed, 17 Jul 2019 03:05:00 -0700 (PDT)
Date:   Wed, 17 Jul 2019 03:05:00 -0700
In-Reply-To: <00000000000015d943058ddcb1b3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000561cd5058ddda0ce@google.com>
Subject: Re: WARNING: held lock freed in nr_release
From:   syzbot <syzbot+a34e5f3d0300163f0c87@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit c8c8218ec5af5d2598381883acbefbf604e56b5e
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Jun 27 21:30:58 2019 +0000

     netrom: fix a memory leak in nr_rx_frame()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14022e8fa00000
start commit:   a5b64700 fix: taprio: Change type of txtime-delay paramete..
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16022e8fa00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12022e8fa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87305c3ca9c25c70
dashboard link: https://syzkaller.appspot.com/bug?extid=a34e5f3d0300163f0c87
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1460b458600000

Reported-by: syzbot+a34e5f3d0300163f0c87@syzkaller.appspotmail.com
Fixes: c8c8218ec5af ("netrom: fix a memory leak in nr_rx_frame()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
