Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FE8C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90292217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387980AbfG3SoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:44:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:48478 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387847AbfG3SoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:44:01 -0400
Received: by mail-io1-f71.google.com with SMTP id z19so72512611ioi.15
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fmJowBjHOviryjb2uUOgQ9a1aEAnn80EMfZUz4dp24E=;
        b=Is7srEe86fM1oHMvR9NiCGGN8yqP7N/7/O8UcjUerO0c7UEfBzIMvExyTZZC3w3fVa
         EROPPCLx1b83i7BOaSz/u0AaqLaUyQSUQxKtBlvrxCV92xtD2l1/XPS+A0BUNY9znuv3
         kkw+0lnh7JrZiQAv9fyOmd+URRxl6lEvSkwYNRK7/rPp66v6TrBRQrdjiWM7wfm8whM+
         O3qjug3Jd2jgiDKHDUSWgkDVzYIcaicOzRt3HLpops3fxwQGUuvf16xbsR5kDeZ/EXxO
         Uqt3xhbc262OOGxysGcmfx+EwiDJfNNTWb3UdGnt3YaSxhU3jRli6lLd2GlGVkcD/qOV
         wGeA==
X-Gm-Message-State: APjAAAWsUayshRisvMxHqMmFbw2O8gpJLL8ialNnYKqB3mOiUL4LvRur
        krRGxY3baOVWBr5JVHDW0DWBkeOqkuOoyN/q2L+nLcLsdlqc
X-Google-Smtp-Source: APXvYqzoNj4GkC6AvA/IixrfS8pKQM1y3yNNpmunmeiyXret+F6oMMDeESdIhA7JVKpU0ewJTz8RVY49EHSoE0rHng5ABCf8LyYm
MIME-Version: 1.0
X-Received: by 2002:a5d:8c81:: with SMTP id g1mr43882953ion.239.1564512240868;
 Tue, 30 Jul 2019 11:44:00 -0700 (PDT)
Date:   Tue, 30 Jul 2019 11:44:00 -0700
In-Reply-To: <00000000000057102e058e722bba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d23d0058eea64a6@google.com>
Subject: Re: INFO: task hung in perf_event_free_task
From:   syzbot <syzbot+7692cea7450c97fa2a0a@syzkaller.appspotmail.com>
To:     acme@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, eranian@google.com,
        jolsa@redhat.com, kafai@fb.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, netdev@vger.kernel.org, peterz@infradead.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        vincent.weaver@maine.edu, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 1cf8dfe8a661f0462925df943140e9f6d1ea5233
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Sat Jul 13 09:21:25 2019 +0000

     perf/core: Fix race between close() and fork()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1523f40c600000
start commit:   c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1723f40c600000
console output: https://syzkaller.appspot.com/x/log.txt?x=1323f40c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7937b718ddac333b
dashboard link: https://syzkaller.appspot.com/bug?extid=7692cea7450c97fa2a0a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e888cc600000

Reported-by: syzbot+7692cea7450c97fa2a0a@syzkaller.appspotmail.com
Fixes: 1cf8dfe8a661 ("perf/core: Fix race between close() and fork()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
