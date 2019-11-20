Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE223C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8A522419
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfKTMBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:01:01 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:54314 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbfKTMBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:01:01 -0500
Received: by mail-il1-f198.google.com with SMTP id t67so22263425ill.21
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 04:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ukGeEFjZg7Kbee1zzEtl/Q1DuM+LvaagxRP8dEWk9kY=;
        b=h0iLyz+XuHL1R49EPmXLP0Mvb0O5YERjIkx0m8VnIqxHSxcV5KUvD4D8nY2losPwHE
         N7p0KcgUI4j5UYXnYkx4YMj2LovWctMcEfgfwensK6aGiaLYCqF2gkl1tNHWHTcWDcuc
         2xS5WzHxrqY5al1bN8bbSc5oYHiEQPXkaaMJ9PjooFihMUFTN2V23AQHzfc0e6sUKquy
         jqkgzBSaWpQvgIr8cVuRrymCvP0jjMOnaP4h0C37juXpmeoHjLXgBtQrihDtgXsPEQq3
         a4dxn4WxgZ81Yy29M4BB6KficwznMBAIvLK97YW8geJDOlpuPl+kwfMQGfKIiqwTaVGc
         Tu/g==
X-Gm-Message-State: APjAAAV59bb+evUSIbYbF+W1uOxlmq5/iS0XNEZ6MSkNZqLWBevEqFuS
        jld0sxu1jCodyt1ws0de8nbxkhxfUdmuSHx59WFhdsIfdmWJ
X-Google-Smtp-Source: APXvYqzEZF16qz+QeJoyw8OIWF/W+6iZXGY/pQaxuMo4inRh3rtqbw5coAxc5p3e6qtT1rQV7R3VziSrh7PkIvdMKmeoAWxAkumI
MIME-Version: 1.0
X-Received: by 2002:a92:dccd:: with SMTP id b13mr2778086ilr.160.1574251260647;
 Wed, 20 Nov 2019 04:01:00 -0800 (PST)
Date:   Wed, 20 Nov 2019 04:01:00 -0800
In-Reply-To: <0000000000006ad6030574fead2e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002da08e0597c5efbd@google.com>
Subject: Re: possible deadlock in mon_bin_vma_fault
From:   syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, jrdr.linux@gmail.com,
        keescook@chromium.org, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, zaitcev@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 46eb14a6e1585d99c1b9f58d0e7389082a5f466b
Author: Pete Zaitcev <zaitcev@redhat.com>
Date:   Mon Jan 8 21:46:41 2018 +0000

     USB: fix usbmon BUG trigger

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14deb012e00000
start commit:   58c3f14f Merge tag 'riscv-for-linus-4.19-rc2' of git://git..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16deb012e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12deb012e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
dashboard link: https://syzkaller.appspot.com/bug?extid=56f9673bb4cdcbeb0e92
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dca13e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17cbe492400000

Reported-by: syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com
Fixes: 46eb14a6e158 ("USB: fix usbmon BUG trigger")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
