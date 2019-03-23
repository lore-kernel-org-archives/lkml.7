Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C71C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E7020811
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfCWOOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:14:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42648 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfCWOOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:14:01 -0400
Received: by mail-io1-f71.google.com with SMTP id i1so4194863ioq.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 07:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PsYFp35cFHs+5EpxQdqt4DnROaY5BNIXaA5kW14ZkHM=;
        b=jUSY36j09f2c4Kl/vgIHgSrmLDqoKXBsTuTH84A++kWi+kL+weh9iI0BfWV8/MhQ+1
         pUS33NaMwbV3gme5CMsnDNVKn2DB67G7OSzbty+Q6RlX0V9vrQzXWu8JkhZngl6L7Q84
         8Rc38Sa3ulWPIl8Rv4ULBSmjhNa0oKKfRpoQgyg/Ooz/BgsTqqoJdnDXR0I2kJJFl55x
         zMk3qlFpuSFmFQ6dhBYSQ2rzjsAYvIxAss4iXsee8ZUovQbqbgUhM2TgXvriNVlq0HOJ
         xVAy+3pn5KU+IWadJvJKMomoN+mUnQRDm4MzXNQoH9HHkYK3wULgDOaXy7hiJR6X95qc
         SBAQ==
X-Gm-Message-State: APjAAAUc2Br9TMCJUinEX+eziGkEc3fKjREq63SOw+AIUPdRJgMW8bjv
        /QBfrY9wnSn0C51uKcrVll6NYJb86B8X+xmHKwnFdT222oUL
X-Google-Smtp-Source: APXvYqxrlhN7ZDSj5xzFZUOsZkR2w5UMagQnWSWyFsjEj1xFUpW9RSUHz2nSPn08J7oOQmE0yPfsE/xLggyWS6ZwEfvr/Ehy7Hk1
MIME-Version: 1.0
X-Received: by 2002:a02:8c2f:: with SMTP id l44mr10677090jak.46.1553350440469;
 Sat, 23 Mar 2019 07:14:00 -0700 (PDT)
Date:   Sat, 23 Mar 2019 07:14:00 -0700
In-Reply-To: <000000000000685dc805829e835c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003749360584c395ba@google.com>
Subject: Re: WARNING: bad unlock balance detected! (3)
From:   syzbot <syzbot+f3e3434787332dfc1c47@syzkaller.appspotmail.com>
To:     davem@davemloft.net, devicetree@vger.kernel.org,
        jbrunet@baylibre.com, khilman@baylibre.com, kuznet@ms2.inr.ac.ru,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, netdev@vger.kernel.org, robh+dt@kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit ec01fb69ac8034ad6e839b31f9df167a110f868b
Author: Jerome Brunet <jbrunet@baylibre.com>
Date:   Wed Jan 16 17:59:47 2019 +0000

     arm64: dts: meson: s400: fix emmc maximum rate

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10afb7cf200000
start commit:   065b6c4c Merge tag 'devicetree-for-5.1' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12afb7cf200000
console output: https://syzkaller.appspot.com/x/log.txt?x=14afb7cf200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea4067c9a08ae046
dashboard link: https://syzkaller.appspot.com/bug?extid=f3e3434787332dfc1c47
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a10577200000

Reported-by: syzbot+f3e3434787332dfc1c47@syzkaller.appspotmail.com
Fixes: ec01fb69ac80 ("arm64: dts: meson: s400: fix emmc maximum rate")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
