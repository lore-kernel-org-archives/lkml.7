Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A5CC06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 23:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD76D21721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 23:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfGAX1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 19:27:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:41574 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfGAX1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 19:27:02 -0400
Received: by mail-io1-f70.google.com with SMTP id x17so16675673iog.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 16:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=16MzlxsLoFahnav4RXFf2V4QcAW527kx82O9tJkyXRY=;
        b=U7vt/jv3zvyWPuyQCGubu9s7XltzcKn2WZbAZUybyB5kbZ8xucHNiXOyI+QTKm919r
         oMq6Qca1x5myIjMKhYM/n38BZtVAcsMLHWsU36KyH7pqVxYFw53gZ4VAHr59+O63cdou
         PnrPTQEJ0YxczHuvaDm/OwVwDcvvJGHTLuF/D9T1AxZv7aKfRgjbqde+O5S3CrL434rI
         oCPmdYoXaeX/FjZ9qf0ETef1mK2h57y1m0xFL8d9QGHy8s57pyOfToiMiQT7tA/rpUiS
         qWhKWaKXcIqdeUbKXZky0ST1cFUjp/LX0OmgaDWgnwi/8tHDu6uL+sfSVhvxd81b3t5y
         edeg==
X-Gm-Message-State: APjAAAWpljlupYkgjFh56l4Wn2kjW6nu+El3u2OfI4PvkXj3sqUrCnRy
        2qfFjEGzN0+zXo4NO1dDJ+F56aD4L+IRP5a+n/zcZN/776rS
X-Google-Smtp-Source: APXvYqw4/1btu4o4HeW4FhB45ddTChwJ7CLo1NPm8Ve4SzwndfeUaP71iUs3Tpz6mTqCEklpBP5PaEjdpGiQZAFQK7+3PA6sx7zE
MIME-Version: 1.0
X-Received: by 2002:a6b:6f09:: with SMTP id k9mr5684537ioc.223.1562023621055;
 Mon, 01 Jul 2019 16:27:01 -0700 (PDT)
Date:   Mon, 01 Jul 2019 16:27:01 -0700
In-Reply-To: <0000000000009b1944058ca3e4a8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000106b11058ca6f7f2@google.com>
Subject: Re: WARNING: refcount bug in kobject_add_internal
From:   syzbot <syzbot+32259bb9bc1a487ad206@syzkaller.appspotmail.com>
To:     benh@kernel.crashing.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=140d6739a00000
start commit:   6fbc7275 Linux 5.2-rc7
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=160d6739a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=120d6739a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bff6583efcfaed3f
dashboard link: https://syzkaller.appspot.com/bug?extid=32259bb9bc1a487ad206
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115bad39a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1241bdd5a00000

Reported-by: syzbot+32259bb9bc1a487ad206@syzkaller.appspotmail.com
Fixes: 726e41097920 ("drivers: core: Remove glue dirs from sysfs earlier")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
