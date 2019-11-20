Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5255CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32624222A2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfKTIRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:17:02 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:43790 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfKTIRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 03:17:01 -0500
Received: by mail-il1-f200.google.com with SMTP id d11so21853911ild.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 00:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8mSwAp6R3MTgLOZKJnTAwaNXJ5w5NU+vgObJ2uRrfts=;
        b=MUfgyxwqqzHxS1W3hwrMmNfkY0x5UpoYAM4Qd6FbU0jCpyjxFo6QcBoF85XX1BLgim
         zD5e3wAbv9d5d4AOSVOSTSkIpqBYtMjIFIWAtLcpcqunRBS/trEqtHPLNWav8xun0uzt
         4qJxNhGu0Zhiw4+WVnnLvewdtwrsdwYLNGRg47NeazU8r6nMz0JZPr39TIqOhImUYsT1
         8rXy/PcTIgXBukf/cAv0L2u1VB9LV6wSfoG3ssPlwI26LpZt2zuuGwg7VbG1YQTYT8hT
         OowOFtE2DfJ2j7OOlbprLJBnpQB0VM+cIw7tzwLHqg5qwGMxSfP1BGkfTkVecKfdqKA6
         Bzgw==
X-Gm-Message-State: APjAAAWY+lTJ7KQU+vhyvZkPwD5/dI3RASmGcGLU2kkr8rPUe/Or/xK4
        +3Caq01gNP+LZHiYUaf/GQniW5bE4p+4f0GZFW5TfnNjUYf6
X-Google-Smtp-Source: APXvYqwCzYvvimCpQnIkurj8fhX5J3q3D53GyZAwXBSf1oo7y427xoiTlVGgBhHSLunCtq6iq3GnJ7zDmnZNCJZ5Jw5P9OLzx/7i
MIME-Version: 1.0
X-Received: by 2002:a6b:f703:: with SMTP id k3mr991797iog.95.1574237821050;
 Wed, 20 Nov 2019 00:17:01 -0800 (PST)
Date:   Wed, 20 Nov 2019 00:17:01 -0800
In-Reply-To: <000000000000f921ae05757f567c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001da6b60597c2ce91@google.com>
Subject: Re: WARNING in kernfs_get
From:   syzbot <syzbot+3dcb532381f98c86aeb1@syzkaller.appspotmail.com>
To:     benh@kernel.crashing.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 726e41097920a73e4c7c33385dcc0debb1281e18
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Tue Jul 10 00:29:10 2018 +0000

     drivers: core: Remove glue dirs from sysfs earlier

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a101cee00000
start commit:   9a568276 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=146101cee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=106101cee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=3dcb532381f98c86aeb1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12657f0a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117728ae400000

Reported-by: syzbot+3dcb532381f98c86aeb1@syzkaller.appspotmail.com
Fixes: 726e41097920 ("drivers: core: Remove glue dirs from sysfs earlier")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
