Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EC9C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058FD20833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDIVSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:18:01 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:39636 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfDIVSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:18:01 -0400
Received: by mail-it1-f197.google.com with SMTP id z125so252408itf.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 14:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GcWNpwOMRmzRIHtUaNeEDmKc6+Sx6+2uSa1vrLVLg2Y=;
        b=L5SjgWUXx/r20wQ2d1Zs7VYNBm0LSTsOYWPDbLLFV1uDrHbFn9svBfucmuODyInMI9
         PcCmKRm+bXtjEtgBPiu4Ycrh5jRF02f1VVM9R56/raP+3/U5Hqxwlm/i5+YviKTU/vEF
         ZT97jWGgYBcUQ54yoLzTUSU8JsVK1e10liH75q6x9J4esRpxjovI/JZcAcnV2Yo283E3
         +5+Iu2+rNr4FnJqMiCnMxPItobaycGklU3cnAQXup4XbMzZY8fSEsX/9F6/3pSjdntQb
         /cnoId4ZlW5Voc2vMKg5bxHtTEYM4azJTg5v1uDGT4++9CAJMgaHneO2Q2dxBNUmaloR
         llEg==
X-Gm-Message-State: APjAAAXbzLS7z46uqfSlqBwoNDdGgQwuSJQQk4k3IBk2RSedyH1I57N9
        VjojSB1XAHofYO0e4AMrine5hwEZQ7Dlr9Bf293euLgImSXq
X-Google-Smtp-Source: APXvYqzfUzNHgw11JRqNeHgonddxf/iovSkX6tWyo8AkaBFHSEOK0ur30I95250S7CJno4/AU9i5jyCxP04t/bmR5FVx4F56T9xL
MIME-Version: 1.0
X-Received: by 2002:a6b:e30e:: with SMTP id u14mr2859524ioc.13.1554844680361;
 Tue, 09 Apr 2019 14:18:00 -0700 (PDT)
Date:   Tue, 09 Apr 2019 14:18:00 -0700
In-Reply-To: <00000000000091818d05795d0f2f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da9f1505861f7cfb@google.com>
Subject: Re: KASAN: use-after-free Read in __vb2_perform_fileio
From:   syzbot <syzbot+4180ff9ca6810b06c1e9@syzkaller.appspotmail.com>
To:     hans.verkuil@cisco.com, helen.koike@collabora.com,
        hverkuil@xs4all.nl, kyungmin.park@samsung.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        mchehab@s-opensource.com, mhjungk@gmail.com, pawel@osciak.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit f2fe89061d79706eca5c47e4efdc09bbc171e74a
Author: Helen Koike <helen.koike@collabora.com>
Date:   Fri Apr 7 17:55:19 2017 +0000

     [media] vimc: Virtual Media Controller core, capture and sensor

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15fbb7a7200000
start commit:   38e7571c Merge tag 'io_uring-2019-03-06' of git://git.kern..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17fbb7a7200000
console output: https://syzkaller.appspot.com/x/log.txt?x=13fbb7a7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c9125b2c20e6dd4
dashboard link: https://syzkaller.appspot.com/bug?extid=4180ff9ca6810b06c1e9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101eda5f200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c465db200000

Reported-by: syzbot+4180ff9ca6810b06c1e9@syzkaller.appspotmail.com
Fixes: f2fe89061d79 ("[media] vimc: Virtual Media Controller core, capture  
and sensor")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
