Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80785C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 15:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55673206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 15:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfLHPdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 10:33:02 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:48240 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfLHPdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 10:33:01 -0500
Received: by mail-io1-f72.google.com with SMTP id e15so8914115ioh.15
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 07:33:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Lmj397AtYaboU9SrRM6mvNMZseJISFAXIUWeSBZLfd0=;
        b=AmGNjJgABvAHQIuRtw7FJT4tmkIAMK7PibROUCs5BLS0wYk7RAR8GOXphZEI2wlz23
         SoLljSrYD+oPfgfUxukOHT+L4WD6xC7rB5lNU261GXgYs9LZnb+DqrI+zCiVO+Tq/MNW
         99Ya4wMy4fVixQerPs2UFENbE21z82FARDk+UmcmV3IU43czdU49AT4STaTV0i+G7GJr
         3r/QBtlPc9HZxTaNRaibtO2G8ceN8OVogDCvStpgYLzOQ96D4038/FkfAjUnQXLibsq9
         5+rRHjlNtS501LrlvMdKMuWbGrx6hXPISscDzzeFwNH1GPm/x6f0CLaYXz5QzHUwzz+t
         Zutw==
X-Gm-Message-State: APjAAAWlJRTPCRYDtquSDo26AZXrdhVJgNGT1jQQktX54nV9Lk6fhlz+
        qpolVfNnloy7y2q/gJoM9+feaTM63lVxLAaE0he+fQn/e84Z
X-Google-Smtp-Source: APXvYqxbS7lfNzblLzZ31TC1FyOr+aqaaNLTAS5q7MT1Vp0hbQHOC0Z3rDhO7VNujAaD+M5X0u3h7aofKIaswmolSK7jrPnj3Ohe
MIME-Version: 1.0
X-Received: by 2002:a5d:9c12:: with SMTP id 18mr17521320ioe.211.1575819180734;
 Sun, 08 Dec 2019 07:33:00 -0800 (PST)
Date:   Sun, 08 Dec 2019 07:33:00 -0800
In-Reply-To: <000000000000639f6a0584d11b82@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f8bf6059932fe10@google.com>
Subject: Re: WARNING in arch_install_hw_breakpoint
From:   syzbot <syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com>
To:     acme@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
        bp@alien8.de, bp@suse.de, christian@brauner.io, cyphar@cyphar.com,
        dhowells@redhat.com, dvyukov@google.com, ebiederm@xmission.com,
        frederic@kernel.org, gustavo@embeddedor.com, hpa@zytor.com,
        jannh@google.com, jolsa@redhat.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, mhiramat@kernel.org, mingo@kernel.org,
        mingo@redhat.com, mtk.manpages@gmail.com, namhyung@kernel.org,
        oleg@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit b3e5838252665ee4cfa76b82bdf1198dca81e5be
Author: Christian Brauner <christian@brauner.io>
Date:   Wed Mar 27 12:04:15 2019 +0000

     clone: add CLONE_PIDFD

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1268377ae00000
start commit:   fd1f297b Merge tag 'drm-fixes-2019-03-22' of git://anongit..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31fb246de2a622
dashboard link: https://syzkaller.appspot.com/bug?extid=370a6b0f11867bf13515
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d8bd93200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15439f27200000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: clone: add CLONE_PIDFD

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
