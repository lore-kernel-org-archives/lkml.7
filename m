Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D28AC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E36320714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfKVQ3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:29:03 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:33128 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKVQ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:29:02 -0500
Received: by mail-il1-f199.google.com with SMTP id s14so6548378ila.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 08:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HQ+aRmfLltcLkpVdgBFWiEzD/54gHAOvGypCxp4+zYk=;
        b=WCfCm41/YFCTqCRzG8JJW+ez6stqSshCXLITDdbhDfsFQOzq+ozE8TZ8GFPBD3jY1J
         lh8hA4Ck2E0sdCBl6rOL544VcSIrHtU/4nyTHT8PkGJqaJL+3Od7T+pez18TcXDHGVNN
         wWcc/72roYa8M9XS4sr6RD0AgMDfI7AiXwnLmCeXLvOwc7N0YSf9PxX+Jydv3URect55
         uGS+Z8orulWw1l4WvZLbvBiy4C6krr+vaXMNVeiRj45f082fhGLM+tRrjB6C48dkeiwl
         d+f3ZVl/kc8aCI47GATpqYfHlZPw4WYzeK3io7EZrXfcBv6/vMWGRRop5tQnxM/7ePpp
         V4nw==
X-Gm-Message-State: APjAAAVhcJ2H4rKRv8RPuuSZWI1XvEtBrNFlg9Cf0kWtkaZYG4fm3DKQ
        EKIoSkqGVe7ZBgXGjlDVfqxCRwZCkviJHF9HQ5a6I62gEaLd
X-Google-Smtp-Source: APXvYqzxrMGvf7icFZ2NFBhVDjuvmZrj/A7E7lxHtKF//lmGDl1QJg0ORRUPcDTAWeC4UuPvfnze+ZFibgvjjCCHfe9cdOLU2m99
MIME-Version: 1.0
X-Received: by 2002:a5d:9349:: with SMTP id i9mr13650191ioo.163.1574440140551;
 Fri, 22 Nov 2019 08:29:00 -0800 (PST)
Date:   Fri, 22 Nov 2019 08:29:00 -0800
In-Reply-To: <0000000000001282e1057e14848e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c40290597f1e91e@google.com>
Subject: Re: WARNING in perf_group_attach
From:   syzbot <syzbot+23fe48cbe532abffa52e@syzkaller.appspotmail.com>
To:     acme@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, daniel@iogearbox.net,
        davem@davemloft.net, jbacik@fb.com, jolsa@redhat.com,
        kernel-team@fb.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        rostedt@goodmis.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 33ea4b24277b06dbc55d7f5772a46f029600255e
Author: Song Liu <songliubraving@fb.com>
Date:   Wed Dec 6 22:45:16 2017 +0000

     perf/core: Implement the 'perf_uprobe' PMU

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1038fecae00000
start commit:   0072a0c1 Merge tag 'media/v4.20-4' of git://git.kernel.org..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1238fecae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1438fecae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9cc5a440391cbfd
dashboard link: https://syzkaller.appspot.com/bug?extid=23fe48cbe532abffa52e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135e93eb400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13189415400000

Reported-by: syzbot+23fe48cbe532abffa52e@syzkaller.appspotmail.com
Fixes: 33ea4b24277b ("perf/core: Implement the 'perf_uprobe' PMU")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
