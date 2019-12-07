Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2277FC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 01:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F362D2173E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 01:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfLGBaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 20:30:01 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:49393 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfLGBaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 20:30:01 -0500
Received: by mail-io1-f72.google.com with SMTP id t3so6108083ioj.16
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 17:30:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HNhXiE6HePkhSCnwQ3V/NPWMZ1Hpm58RJpGnE6ed2EU=;
        b=qKIZiHOW1D2ErzigRZFn6uxA735SbXi4zVI8aLE62SPB2jZPG9CB5xxUrUmiphHr5b
         ROnqKALHDmM+pMxhHEZy6Q+1mh3d5QSRLZR/kpowUsMBJNA9Mx3CTPq0njTcQos3ltxI
         Z8/lDBbbXcKwvT2WzRRsrbKidjzWrvWhsVxBHZfjLknDFDeWT1K4ENvcPGOYoHLxHUsh
         u30aphUpNkkYxSJzuD7f397KOI82FZRFe54LZ3vqanu05VrKmON9/GGH1Oz5CykIQ+fR
         TskUDlUEQIoUKXN0AAS9b8jjUTI6wnzQXgbNq5xtvfqHLUUcOlOhp2UVbg0UiDZuCZZI
         IBWg==
X-Gm-Message-State: APjAAAVBE6+kvXCcH1DuVEDC2J6hQQBTXQCCH8nBFF2pL8IXl1NntTZJ
        wnw+5txO/npl0Fy953Wbr2E3dYks5HZuadGC+P6xWIl40gaX
X-Google-Smtp-Source: APXvYqxz9KBPD51VM3KJ5gnxGMtw4DWz8VDuRdv+40oCBMIhFEk1AOET+26mMuYYk8RExBPPeHQ+h/6hZNb57eiZ5RaZKKFaaCCq
MIME-Version: 1.0
X-Received: by 2002:a92:9f9c:: with SMTP id z28mr17483689ilk.239.1575682200860;
 Fri, 06 Dec 2019 17:30:00 -0800 (PST)
Date:   Fri, 06 Dec 2019 17:30:00 -0800
In-Reply-To: <00000000000057e614057a9abcd3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc7fc70599131995@google.com>
Subject: Re: KASAN: null-ptr-deref Read in refcount_sub_and_test_checked (2)
From:   syzbot <syzbot+0468b73bdbb243217224@syzkaller.appspotmail.com>
To:     hverkuil-cisco@xs4all.nl, kyungmin.park@samsung.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        m.szyprowski@samsung.com, mchehab+samsung@kernel.org,
        mchehab@kernel.org, pawel@osciak.com,
        syzkaller-bugs@googlegroups.com, tfiga@chromium.org
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14972e41e00000
start commit:   ccda4af0 Linux 4.20-rc2
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
dashboard link: https://syzkaller.appspot.com/bug?extid=0468b73bdbb243217224
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d20893400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118f5a2b400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: media: vb2: check memory model for VIDIOC_CREATE_BUFS

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
