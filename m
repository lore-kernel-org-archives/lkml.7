Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0F6C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7741206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLWKbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 05:31:03 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:39243 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfLWKbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 05:31:03 -0500
Received: by mail-il1-f197.google.com with SMTP id n6so14047150ile.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 02:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dqTElktPjJ2Vq8ttJgKuJA9Bl554Cdxgp9MbKD3t3zo=;
        b=R+asB4as90j8xADcuopzZg2JLrzbnG2FBeb2boU953GRxANc97GO/MduJi64D4+e9X
         t1LjIFNdxMSswx9y2MMsgN4LuZ/548BFLHwlc5pi0gDDTGPY4FfQcBn6NbGRRyAtVRLe
         LGAeCWMPE++x7te7gws3TyQuA2IYZO1P9XzQDH1Q2pwYLePdPD2q0V7GQwi6OOWlf8+m
         omwMBDX+c5dq7KMTMN0dgBKGAp7DBbSiyblZKIgSjbzsE+udIcvua4ydYWEpZuFTpyox
         glRG0Ms7EidqsnQOf8IcD9/3OuceYVcsoz85xcs7NjietfogPlXusYcw2i7McwY4xSDK
         fbAw==
X-Gm-Message-State: APjAAAXgQ9ozaVe7XXjyOOicNgGEsyZt9toLWmVvB3KMHtOruhHGbQGn
        bZAy3m+/0hZpRFVWYWeKpXyhDOY5bg7SA2kmiGdtVO8raiVJ
X-Google-Smtp-Source: APXvYqxEBMubw04vHq957mYKngz32+OjAQ3cw+9AYwNkakf/69ewcoi2c7rjqs7UBeIlpsKYjtAm+5xfxmOXI3E52HSsX0TrkLqS
MIME-Version: 1.0
X-Received: by 2002:a02:7086:: with SMTP id f128mr22175027jac.12.1577097061494;
 Mon, 23 Dec 2019 02:31:01 -0800 (PST)
Date:   Mon, 23 Dec 2019 02:31:01 -0800
In-Reply-To: <00000000000082b80f059a56da1f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002074ef059a5c86e2@google.com>
Subject: Re: INFO: task hung in fb_release
From:   syzbot <syzbot+d130c4a0890561cfac5b@syzkaller.appspotmail.com>
To:     Rex.Zhu@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, b.zolnierkie@samsung.com,
        christian.koenig@amd.com, daniel.vetter@ffwll.ch,
        david1.zhou@amd.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, rex.zhu@amd.com,
        sam@ravnborg.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e3933f26b657c341055443103bad331f4537b113
Author: Rex Zhu <Rex.Zhu@amd.com>
Date:   Tue Jan 16 10:35:15 2018 +0000

     drm/amd/pp: Add edit/commit/show OD clock/voltage support in sysfs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b5a799e00000
start commit:   c6017471 Merge tag 'xfs-5.5-fixes-2' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11b5a799e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b5a799e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f6119e2e3675a73
dashboard link: https://syzkaller.appspot.com/bug?extid=d130c4a0890561cfac5b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169b1925e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b9623ee00000

Reported-by: syzbot+d130c4a0890561cfac5b@syzkaller.appspotmail.com
Fixes: e3933f26b657 ("drm/amd/pp: Add edit/commit/show OD clock/voltage  
support in sysfs")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
