Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E90C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B362176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLRQVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:21:02 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:36721 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfLRQVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:21:01 -0500
Received: by mail-il1-f199.google.com with SMTP id t2so2176768ilp.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 08:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IuaTqXhxelJhKDHw5O7rzxkzTsdD5izns8/dKhJuhOU=;
        b=czhQQrLjVvznvrp+ndFDF2S8lZ+ny6rZmfATsZuDf5qKysPo6iK/9OvVUcIG8Z1j16
         TfxAZjEfc5yV9WFoPiqIWsf7rRCkaqQr4/IoL9wRJD2qE40kDfOgUqLxqwqumCCwTKOR
         /Jk8qvzeexLOLzZ0xhuF/oQAxRUgO3DWmOTdwBFABsL8EK3QiwMge0RNJswhei4KXg5S
         kreumvfG5BIxk8FIU0Q+9s9nzLtTFKJu5GfXqsWcitkqCgplMY4bGQoG5byAficHGfEM
         N8LKTviVqCyedtIc8vMeEQoCiBZW2REncGN9wvFp4ZY8cWJwwmJXMibu3bVVL30wj2Uj
         25tA==
X-Gm-Message-State: APjAAAUBWsc9v0CORXeqXeF5uWJGONgbr0BJTo9T1c2my4WB3Is4CNg/
        LW99FC+/DO/09jBGyy+PtWrr4hYGjVkZRZEhDb3chs6h9nqV
X-Google-Smtp-Source: APXvYqxlpQuOxZYicynxx6hVRSGFToWAMtcNMVHatrpxa6mopdSMqi85r6C8n0BH/LoOoq7aqqMM4kgR3L2zKnho69XDz0uvKC9k
MIME-Version: 1.0
X-Received: by 2002:a92:8dc3:: with SMTP id w64mr2462439ill.68.1576686061030;
 Wed, 18 Dec 2019 08:21:01 -0800 (PST)
Date:   Wed, 18 Dec 2019 08:21:01 -0800
In-Reply-To: <0000000000002df264056a35b16b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009716290599fcd496@google.com>
Subject: Re: kernel BUG at fs/buffer.c:LINE!
From:   syzbot <syzbot+cfed5b56649bddf80d6e@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bvanassche@acm.org, jaegeuk@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 5db470e229e22b7eda6e23b5566e532c96fb5bc3
Author: Jaegeuk Kim <jaegeuk@kernel.org>
Date:   Thu Jan 10 03:17:14 2019 +0000

     loop: drop caches if offset or block_size are changed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f3ca8ee00000
start commit:   2187f215 Merge tag 'for-5.5-rc2-tag' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=100bca8ee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17f3ca8ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcf10bf83926432a
dashboard link: https://syzkaller.appspot.com/bug?extid=cfed5b56649bddf80d6e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1171ba8ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107440aee00000

Reported-by: syzbot+cfed5b56649bddf80d6e@syzkaller.appspotmail.com
Fixes: 5db470e229e2 ("loop: drop caches if offset or block_size are  
changed")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
