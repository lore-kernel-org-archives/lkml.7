Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAE6C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 22:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8C320740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 22:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKYWhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 17:37:02 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:46791 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYWhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 17:37:02 -0500
Received: by mail-il1-f200.google.com with SMTP id i74so14951254ild.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 14:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KF2WjshW1BDTUg/k+IPUzgQidO5NFBNVVgPRIj2C55w=;
        b=OSUQ1wkQ005w1suvCOJLDcpIIR7HHq9GS6T0bsQtvPM5ifq9CqCvuK0PPiRxq7ykmj
         rRBx4DJo7akDmcGyyxmLQEuor3sj2TeGdS9xhp1ekjasI9gJ6l4Zb6C7+yNFXYlbNieW
         IdMNXB1FfMjBK4Jenru4COwLe+37SzO3/ZWro3vadLeHY6Wp8UAnaDAk3IEVhRrqddjJ
         +BNEafdl+I7sEDtcA83xWpdsOICc/kkZnDD6ruvW46z0d9WsuOCwKwrxpUYlkrDSoAgX
         O5w1YvLaNTwjLKTBOTIn9zVw3GCBHXvHWZxdJZ2kMyVmk3S77X60JM1u9As4b4Jmqnu9
         7sKg==
X-Gm-Message-State: APjAAAUZglhIIf/mv0yQ4F4Z4QWIRhjydPb30150h8UQjEaXEOd3F0KS
        +M8NIt6cjus1LKjnxbckAFCBxNHExWBscqjUYZZ1TUk6ELYM
X-Google-Smtp-Source: APXvYqwkBCex2KWBU45kzK7k9hy1eCU109ihsuTepJ0sQfsiJS80DmXhz/QeEsCiIwZ7ccJ1gnEjc/wJIBydu3gOime4bUB5ZGcg
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2181:: with SMTP id b1mr29243849iob.208.1574721421577;
 Mon, 25 Nov 2019 14:37:01 -0800 (PST)
Date:   Mon, 25 Nov 2019 14:37:01 -0800
In-Reply-To: <000000000000a52337056b065fb3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4160705983366e8@google.com>
Subject: Re: WARNING in md_ioctl
From:   syzbot <syzbot+1e46a0864c1a6e9bd3d8@syzkaller.appspotmail.com>
To:     airlied@linux.ie, chris@chris-wilson.co.uk,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        rafael.antognolli@intel.com, rodrigo.vivi@intel.com,
        shli@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 4b6ce6810a5dc0af387a238e8c852e0d3822381f
Author: Rafael Antognolli <rafael.antognolli@intel.com>
Date:   Mon Feb 5 23:33:30 2018 +0000

     drm/i915/cnl: WaPipeControlBefore3DStateSamplePattern

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13aeb522e00000
start commit:   c61a56ab Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=106eb522e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17aeb522e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4013180e7c7a9ff9
dashboard link: https://syzkaller.appspot.com/bug?extid=1e46a0864c1a6e9bd3d8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bca207800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14819a47800000

Reported-by: syzbot+1e46a0864c1a6e9bd3d8@syzkaller.appspotmail.com
Fixes: 4b6ce6810a5d ("drm/i915/cnl:  
WaPipeControlBefore3DStateSamplePattern")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
