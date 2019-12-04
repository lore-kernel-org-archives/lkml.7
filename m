Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF36DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8296120640
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfLDCpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 21:45:02 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:56947 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLDCpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 21:45:02 -0500
Received: by mail-il1-f200.google.com with SMTP id e5so4618834ile.23
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 18:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tCMUC5Ey7adRpUDsqcilcHQWuXQS9qiXWW1HvjkqOis=;
        b=swCC4ClbCQAyhxfDlzPWnktQAX+jGUgcNRvTA0pK+pw/gS7fz9tCKLfnlTaXP6diD2
         dPMjOgv6NR0ynVt3wDttch5l63PTdK8DgtURUBv8numxj5yjgmUQaFnghBxB9tQNfrXv
         /flrOAf00wytTAHqHzehoCNgQAwmnlUTlC3CXDygxToC2YpXwcG3beHseq/3wykQB4kG
         Pn4VQQSpQjeoB3zheCthclCGKsiT78i1HLYAhZvxonHfKQUYJeYaHizecoB744/6XX1l
         7NsJGo96e4535zknPu+ELjjHHR6FafS+YcSMj1sQBT+yBubVsYd2897Y9rv+ibnDlw0P
         9bbg==
X-Gm-Message-State: APjAAAXRxIC+cMaIkHRy9/QC/ahJhD/F8Hw73IwmN69z4c2w/B/6aAB2
        XgVkahqDaC1f3B8B9XZWb454EX0KshH3wMLUW1ikMj9AJhXA
X-Google-Smtp-Source: APXvYqyTpaCVnDPlSz0wClrWbfe+GR1eD78eZBnhUlXj8esJwkaZhmLdyNh5D6nMvOl+CrbF0oIsolfNn5+b3maERg4zP5CgEcgx
MIME-Version: 1.0
X-Received: by 2002:a05:6638:a4a:: with SMTP id 10mr1003754jap.44.1575427501287;
 Tue, 03 Dec 2019 18:45:01 -0800 (PST)
Date:   Tue, 03 Dec 2019 18:45:01 -0800
In-Reply-To: <000000000000dd04830598d50133@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009574da0598d7ccfa@google.com>
Subject: Re: KASAN: use-after-free Read in tty_open
From:   syzbot <syzbot+9af6d43c1beabec8fd05@syzkaller.appspotmail.com>
To:     gleb@kernel.org, gregkh@linuxfoundation.org,
        gwshan@linux.vnet.ibm.com, hpa@zytor.com, jslaby@suse.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, mpe@ellerman.id.au, pbonzini@redhat.com,
        ruscur@russell.cc, stewart@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 2de50e9674fc4ca3c6174b04477f69eb26b4ee31
Author: Russell Currey <ruscur@russell.cc>
Date:   Mon Feb 8 04:08:20 2016 +0000

     powerpc/powernv: Remove support for p5ioc2

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e5fc32e00000
start commit:   76bb8b05 Merge tag 'kbuild-v5.5' of git://git.kernel.org/p..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17e5fc32e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e5fc32e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd226651cb0f364b
dashboard link: https://syzkaller.appspot.com/bug?extid=9af6d43c1beabec8fd05
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d15061e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b69aeae00000

Reported-by: syzbot+9af6d43c1beabec8fd05@syzkaller.appspotmail.com
Fixes: 2de50e9674fc ("powerpc/powernv: Remove support for p5ioc2")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
