Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3133CC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1006E2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfK0NUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:20:03 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:44799 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfK0NUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:20:02 -0500
Received: by mail-il1-f198.google.com with SMTP id h4so1218224ilh.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 05:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Dieb0lQvqlt6xFxUKoKJqEpe6Eum8R1EEaj/3uLPMYk=;
        b=WEZroLyGi3eb3Mqgi4rYpkVSMDdstYVxpeExcwAXNIIjiwlRJ2Tgq42UhN5qigMqXV
         OJbYmeRZGPEls+iUftbwPBwSHRuCxe+iMndfELhnjXqCBUasBgPHHCMV1WWztP0Jnr1Q
         VvhKvK5u6/sbZOrcE+y2hEtl6zFyAp18bg/gPUw5i/hJ09Uz//34uxObMa+MYZcRzgDp
         xECMlv+c6UzopBvzGJW1qbkr4Y6kpWOp3wzE/f57pOTpELDIW/t9e+7vgfG19lnR6o6/
         lfBz8CpkvyJO6kDliBnw69ZDCgO4em2kTU5it/nxid+Nr8LpeaU04e5mjSRqgapzHQ9e
         nztA==
X-Gm-Message-State: APjAAAUdMMN0tmJ6U+9qIym25EB1e7D/2s6RDowJb6k3hsBb8JXHwLKu
        C708Xj89xfq8iexjXnj6sdI7H8w4NVSjHcSxJ37MZnlAR0ik
X-Google-Smtp-Source: APXvYqyLYMnPvrXLLHZp8gVP46nF3bGzrcXU111CNvKZooaehsGZ3tFx1Dz3uSdNW9AoXotiFgnLwnoRKF4IoeWFZEIVBi2ovtIo
MIME-Version: 1.0
X-Received: by 2002:a6b:c0c2:: with SMTP id q185mr2514112iof.280.1574860800376;
 Wed, 27 Nov 2019 05:20:00 -0800 (PST)
Date:   Wed, 27 Nov 2019 05:20:00 -0800
In-Reply-To: <001a11441b6c6cb96c0569120042@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093ca84059853da04@google.com>
Subject: Re: KASAN: use-after-free Read in ntfs_read_locked_inode
From:   syzbot <syzbot+19b469021157c136116a@syzkaller.appspotmail.com>
To:     anton@tuxera.com, deller@gmx.de, jejb@parisc-linux.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-parisc@vger.kernel.org,
        luto@amacapital.net, syzkaller-bugs@googlegroups.com,
        wad@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 910cd32e552ea09caa89cdbe328e468979b030dd
Author: Helge Deller <deller@gmx.de>
Date:   Wed Mar 30 12:14:31 2016 +0000

     parisc: Fix and enable seccomp filter support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=143090dee00000
start commit:   3e968c9f Merge tag 'ext4_for_linus' of git://git.kernel.or..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=163090dee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=123090dee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e8c053ac965e0dd
dashboard link: https://syzkaller.appspot.com/bug?extid=19b469021157c136116a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142d219b800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143029db800000

Reported-by: syzbot+19b469021157c136116a@syzkaller.appspotmail.com
Fixes: 910cd32e552e ("parisc: Fix and enable seccomp filter support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
