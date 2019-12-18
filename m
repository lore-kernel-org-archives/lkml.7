Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3573C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53DC2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfLRHGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:06:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:56293 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfLRHGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:06:01 -0500
Received: by mail-il1-f198.google.com with SMTP id p8so1014451ilp.22
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 23:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=G6GWGSCGYBM0pdmoLce8hCcVh4IRjkjoIvq92n6KsqA=;
        b=EXYRgiw1gk7ho7QIQxq5Xff1b7P5iyZSqM3iN/sHyvzxlV4evOfOWU1y+qcnYqiVfF
         GaxlhzDbdY28sK6UIaqjeSJCUlfG0WXqGUkZ+BlVzoSlPWV3/ewEINCR8+TQzPp1n44Z
         KA2gz/OGrnKM2EyzC8guk/L+a0NIs7WYu/wCJEvEV8aMHIZ10LyrIe6/GxcrmutGqBRq
         FrL4OJw3lIXoBLgT/hoJKGJM6cDHTHwBfyg1x1q46R5EzRKJg+jmqHgGyeWcOtbFwZlf
         kUdwJSMF9IBc4rR23FDAedCM78g0y0QwkeNqtmgPhK5/SVkSj3IFR95+XrIRh2IACljn
         AFOA==
X-Gm-Message-State: APjAAAUOrgQxmkVAJ6IhfHdvp8lKIJhSdQKFz9f3uniKAidHicIRyeSO
        hNC7OC0ZSBn8/6IiHf02BltsuEB0W6vIT4MYEhlmT9iZsOG2
X-Google-Smtp-Source: APXvYqy725bW+YQJ+KhlbU4uCwlb37sWXU+LVyGIf+hBtmotYyM03RfqBfzAwZnudC2KpWSUF9vy3+uzRWPHqx44bx/R0Vpqzhy5
MIME-Version: 1.0
X-Received: by 2002:a5d:9f51:: with SMTP id u17mr533695iot.258.1576652760916;
 Tue, 17 Dec 2019 23:06:00 -0800 (PST)
Date:   Tue, 17 Dec 2019 23:06:00 -0800
In-Reply-To: <00000000000024aa520599f4c933@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bfac3c0599f513fe@google.com>
Subject: Re: KASAN: slab-out-of-bounds Write in watch_queue_ioctl
From:   syzbot <syzbot+5a774ffe70862ca9ebc7@syzkaller.appspotmail.com>
To:     arnd@arndb.de, axboe@kernel.dk, corbet@lwn.net,
        derek.kiernan@xilinx.com, dhowells@redhat.com,
        dragan.cvetic@xilinx.com, ebiggers@google.com,
        gregkh@linuxfoundation.org, hare@suse.com, jaegeuk@kernel.org,
        james.morris@microsoft.com, jannh@google.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit fe78d401ca6b3639385cf7a9a1597b9cd48f64eb
Author: David Howells <dhowells@redhat.com>
Date:   Fri Oct 11 07:48:08 2019 +0000

     General notification queue with user mmap()'able ring buffer

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1163cafee00000
start commit:   fca4fe89 Add linux-next specific files for 20191217
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1363cafee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1563cafee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634b7ce01f79423d
dashboard link: https://syzkaller.appspot.com/bug?extid=5a774ffe70862ca9ebc7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13df92fee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1003cafee00000

Reported-by: syzbot+5a774ffe70862ca9ebc7@syzkaller.appspotmail.com
Fixes: fe78d401ca6b ("General notification queue with user mmap()'able ring  
buffer")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
