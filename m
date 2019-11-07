Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731DFC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4666E2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389518AbfKGNnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:43:24 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:48370 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389028AbfKGNmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:07 -0500
Received: by mail-io1-f70.google.com with SMTP id q84so1846653iod.15
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WTUaaUrmKVHorKvakIXCTTRuudk2YAQScGxgofVTkUI=;
        b=G6IPdsdpRVz2K2+cLV1gdo4Ga5H0HvY4fm1jADRnKFC2evfPKsT30kZUdd/t19Tz13
         tY7ZfsPfEvaWtkoxEJBF2Lzw46ipXr6Zh5gjQybC7yDbZW4Y6vJgXBfEAdMjY9Mkkle1
         UtYHJmW1RsdqOCmy3q8YB3xqTW2O2ILaygB0RG7XzolHY8NWIlav+1xwsNobu38OV3rf
         UTo1J7cTZTjR6DlvEfV9GxVkvGbTY8wu6UwTH+/z72uxRbtHdRhZ6d22G6peVdMwsMTs
         tYi9l3CtvNWg0PJ0JW4wv6w6Sr3l+orIbjNSw0H+foXczfoB58k09cVw5ObbtsVb9wCG
         pSzw==
X-Gm-Message-State: APjAAAU6Jr5sl3mVg3f09wUUzey5BwH88aZMGrTbFmKOwYglQ+XqcwNW
        0f12BHV4/ZWj8sL8Fiocxbo5CMOq/CdDQVWmx09pJXamEMcG
X-Google-Smtp-Source: APXvYqzOTbKLWUtJfV+eTnZAGIHCOihW1P53mf2MSnAtW+U2zup71yFaexRFHdR5rbJrPPIrMXY88woVwchxPC8nR165HI7yQ6Is
MIME-Version: 1.0
X-Received: by 2002:a5d:8c94:: with SMTP id g20mr3746490ion.13.1573134126988;
 Thu, 07 Nov 2019 05:42:06 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:06 -0800
In-Reply-To: <000000000000aa8703057a7ea0bb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2c94e0596c1d47b@google.com>
Subject: Re: WARNING in dma_buf_vunmap
From:   syzbot <syzbot+a9317fe7ad261fc76b88@syzkaller.appspotmail.com>
To:     andy@greyhouse.net, davem@davemloft.net,
        dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, j.vosburgh@gmail.com,
        kyungmin.park@samsung.com, linaro-mm-sig-owner@lists.linaro.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, m.szyprowski@samsung.com,
        maheshb@google.com, mchehab+samsung@kernel.org, mchehab@kernel.org,
        netdev@vger.kernel.org, pawel@osciak.com, sumit.semwal@linaro.org,
        syzkaller-bugs@googlegroups.com, tfiga@chromium.org,
        vfalico@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 62dcb4f41836bd3c44b5b651bb6df07ea4cb1551
Author: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date:   Thu Nov 8 12:23:37 2018 +0000

     media: vb2: check memory model for VIDIOC_CREATE_BUFS

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116af11c600000
start commit:   d41217aa Merge tag 'pci-v4.20-fixes-1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
dashboard link: https://syzkaller.appspot.com/bug?extid=a9317fe7ad261fc76b88
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f7b6f5400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105a2783400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: media: vb2: check memory model for VIDIOC_CREATE_BUFS

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
