Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301A8C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35112467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfLTIOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:14:04 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:47132 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfLTIOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 03:14:03 -0500
Received: by mail-io1-f71.google.com with SMTP id 13so5538066iof.14
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 00:14:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HwhEudMPancjOLmNPDtIZH3YRpT3d3B5zGNbPpoAiF4=;
        b=LT4lsOrHrRiWbucfnYJN9LpGIZAf02kaIbebh+rrPRffdJ1v15VOnqFvrzNoqybMFd
         P02cXCE4Aa63ucZHT3hZiv2Tn+HQT7Q2hRMI6NLz5o7at4hHKdhzUAxeeoSyp9Nc5bWD
         Y/YUUrOfaCXtQ7IZJa4uST5Ijs2xJbGih1zzApYgyW+PbLDn3OHIZ+TQywwylJ7czBWV
         /j6y7Hr+DRVg43Mal311p73pOwEt3QhU5gFVYjILNf0DT2oULkj0Ezhx3d7mRZnwqJTV
         ywFW4TDAivL0HCKas2PGkVpU45vvXsy3lYPSZjCghjDHVQ7BnoLJBFTo/RJ/hgt+0You
         +5fg==
X-Gm-Message-State: APjAAAWnTo17ox3sNCrO6IswRvb/OZBw8jGb8xm+hdm0lLJqQvBbVhsq
        fJm66ySbZRywcsTkC8Bs7PTTx/6qTH+x+sdJ0DI7bJPvcM97
X-Google-Smtp-Source: APXvYqzzkxfg5ZzcJxfe+aBm7XwCcX7piKL4LgQ4AXtSuKltTsybPJGKOlhivpmRcgNnreZf3AbISv7B6MW6XbBdiVJfATCYynA1
MIME-Version: 1.0
X-Received: by 2002:a5e:8e4d:: with SMTP id r13mr8605992ioo.60.1576829641276;
 Fri, 20 Dec 2019 00:14:01 -0800 (PST)
Date:   Fri, 20 Dec 2019 00:14:01 -0800
In-Reply-To: <001a1143e62e6f71d20565bf329f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3c3ef059a1e4260@google.com>
Subject: Re: KASAN: stack-out-of-bounds Read in update_stack_state
From:   syzbot <syzbot+2990ca6e76c080858a9c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, glider@google.com, hpa@zytor.com,
        jpoimboe@redhat.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz, mhiramat@kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org, rostedt@goodmis.org,
        rppt@linux.ibm.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 4ee7c60de83ac01fa4c33c55937357601631e8ad
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Fri Mar 23 14:18:03 2018 +0000

     init, tracing: Add initcall trace events

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11ebd0aee00000
start commit:   0b6b8a3d Merge branch 'bpf-misc-selftest-improvements'
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=82a189bf69e089b5
dashboard link: https://syzkaller.appspot.com/bug?extid=2990ca6e76c080858a9c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11dde5b3800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1347b65d800000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: init, tracing: Add initcall trace events

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
