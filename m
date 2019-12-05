Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBF6C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D2322525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfLENiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:38:02 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:46369 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbfLENiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:38:02 -0500
Received: by mail-io1-f71.google.com with SMTP id b186so2371870iof.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 05:38:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BPtd1lCkh28DO7EwzqWFu86aIj+E+y3RBRqfbiycXgU=;
        b=n4DzrEdLZmF5IXIy7ltt3HtMghmERg6RU8leVVRaAUqr00hFPyC/f3egFryJgKmnYC
         myDkJ9YbeYg49j2QUN83iPbr6hj2BhgfXM8CdXqGvVvQv9XQjvobOF3at81aVBKIAfJj
         9oVHYREZovqhC0pHzuIAOpKaqW3LbcD0Gxc9W+QTwNN9ADBQRLiMDLZezBzPhKPBeuic
         RByGWRizwSieTVrVpPvccJIR0ihP3J0F5IjkxP98dOIKwnF2RqdUunM4IdfjsDnANl81
         euTKXy7zxc/G6LwUtL0xHwLa7yxwKMcBWfobGSzzjEhYymLe0PoPm4xVOFGd0+WrGo5Y
         Zoog==
X-Gm-Message-State: APjAAAXBufpNolFAbWD/TIzsWPSyqV9/Z8ftS8uPhoKmUSADUVv0CNk2
        9VzT8st2ssjY5MLi+uCZJypFUd8TFZDZ1eEGHi34hd02/y4t
X-Google-Smtp-Source: APXvYqw0yUIbNh+pGaBmjTGn6QTdUeXaeQPr8IF42eCrt+4KQEhGY66Ikiv3nYhzewKgZfr/soR4DDYF3lXcnPKyIFcc/jNYBhWi
MIME-Version: 1.0
X-Received: by 2002:a92:3984:: with SMTP id h4mr8301330ilf.36.1575553081339;
 Thu, 05 Dec 2019 05:38:01 -0800 (PST)
Date:   Thu, 05 Dec 2019 05:38:01 -0800
In-Reply-To: <0000000000006dff110598d25a9b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bcf3bc0598f5090d@google.com>
Subject: Re: INFO: task hung in fb_open
From:   syzbot <syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com>
To:     airlied@linux.ie, ayan.halder@arm.com, b.zolnierkie@samsung.com,
        daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        kraxel@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        peda@axentia.se, sam@ravnborg.org, syzkaller-bugs@googlegroups.com,
        ville.syrjala@linux.intel.com, wens@csie.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 979c11ef39cee79d6f556091a357890962be2580
Author: Ayan Kumar Halder <ayan.halder@arm.com>
Date:   Tue Jul 17 17:13:46 2018 +0000

     drm/sun4i: Substitute sun4i_backend_format_is_yuv() with format->is_yuv

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d2f97ee00000
start commit:   596cf45c Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d2f97ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8ab2e0e09c2a82
dashboard link: https://syzkaller.appspot.com/bug?extid=a4ae1442ccc637162dc1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14273edae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e7677ae00000

Reported-by: syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com
Fixes: 979c11ef39ce ("drm/sun4i: Substitute sun4i_backend_format_is_yuv()  
with format->is_yuv")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
