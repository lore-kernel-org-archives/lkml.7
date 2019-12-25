Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA53C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 15:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B8020722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 15:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfLYP0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 10:26:03 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:40947 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfLYP0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 10:26:03 -0500
Received: by mail-il1-f198.google.com with SMTP id e4so7200989ilm.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 07:26:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=A7S/GOq+N1/RvV3BsEeeY8VJ+E23sie3htdgMTQ6zh8=;
        b=oFZd4dsioUr6Ednyc4BAER3m6XzjahGW6bzGM3rA+Vi0ZbfA9oD/4/N5Hk0q0ngDO9
         +38WGwvidkFWnNa4sogbz70C/mWIpqLGVSRgERci5tnhC6d57T6E6Rxed40p7miDAO2X
         J+K+my/CZAZ2nsbYGo3chi+pJjkinvMyRiXKvLyRnoyMHBEnJKH9zfql5dkCImTuDjq4
         K3NLbDGVm/017wUqjo07wJVQKYVgTO+lF/atEV37+NnUyda0KyOKZqAwK7NwKFv9svvQ
         D6N7RGVtK76RZz4e4waNFGgRvJbN6hWnGUGtjWzKxm865x7Xw0z9KdrkHb+hRuAmusNI
         ik5A==
X-Gm-Message-State: APjAAAXj5o1NGZQ7mw+23uaxWlNMsWDH88GSe2Fh4jlcpZYakI2lbFeC
        wBJaAE8IcyGdltpr5lhlfuqIYZmEHVURNmDyWF/G2DxxVgTj
X-Google-Smtp-Source: APXvYqxEW020KE83xrHw3Gxo/vfwdXNrRfv9mftoPAYZg1BkC/8zDOT3yGFgKCXd/lTwsoyQohVTwsOf+XKRQkf+Diz+b0SqoodX
MIME-Version: 1.0
X-Received: by 2002:a92:3996:: with SMTP id h22mr34246521ilf.129.1577287560911;
 Wed, 25 Dec 2019 07:26:00 -0800 (PST)
Date:   Wed, 25 Dec 2019 07:26:00 -0800
In-Reply-To: <0000000000001b2f4605991a4cc0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6e365059a88e032@google.com>
Subject: Re: KASAN: use-after-free Read in fb_mode_is_equal
From:   syzbot <syzbot+f11cda116c57db68c227@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        daniel.vetter@intel.com, dri-devel@lists.freedesktop.org,
        hdanton@sina.com, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mojha@codeaurora.org, sam@ravnborg.org,
        shile.zhang@linux.alibaba.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 13ff178ccd6d3b8074c542a911300b79c4eec255
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue May 28 09:02:53 2019 +0000

     fbcon: Call fbcon_mode_deleted/new_modelist directly

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1737c63ee00000
start commit:   46cf053e Linux 5.5-rc3
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14b7c63ee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10b7c63ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=f11cda116c57db68c227
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bf72c6e00000

Reported-by: syzbot+f11cda116c57db68c227@syzkaller.appspotmail.com
Fixes: 13ff178ccd6d ("fbcon: Call fbcon_mode_deleted/new_modelist directly")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
