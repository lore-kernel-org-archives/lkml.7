Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEE9C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F8D21D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbfKGNmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:42:13 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:44353 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389205AbfKGNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:10 -0500
Received: by mail-il1-f198.google.com with SMTP id 13so2642967iln.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ZHlAkJvC4AzLYOgESJJjCrLwj1SC/DFrfw0gQTfFdTQ=;
        b=qKh2ZMGBPc5DpTDI2bgF6ITwLhvtz3Z7p7zdU2cvtUkypLO0eRGxh+XYaQGB0LtxD0
         0co0BJ7RTqp5qU6slRKvxXKkYlUJu9jcVnJZQiNrmwR3SwD/F5VyfeWL+2IiXX1CG42L
         Egd3YPB3smoME9Cp700bJ8g4FSKBBx+HQvuy8tJATr0dbyUT7iH5tBlT0epDhCn7Ms6z
         9RSoZvn/mmQStD9zK5MGaheoGa4o3HU2vfB+Jl5m4XvYuij2kTaPL8FP1Oqtfvi82/j1
         akItQRGcT8eUFylMKl7oonZT4o44u5iKkRix0UwiX9R19N7XuP08EdOH6HSVlgfc/1Nu
         mRAA==
X-Gm-Message-State: APjAAAUGX8YSmnIXm31bc7e5IClRFu0br2xE3+qQZgSmVvtj166p1GQ+
        +knhME3BMdRYx/1PtYnsj6XxoDSvc7i/DnMi3xQLHVhZzwe3
X-Google-Smtp-Source: APXvYqy98iNl1kKSai2jcmgSIkxjPCuJlUrj+Tm8vB/VRQBb354vs8ydYDcKDIM+Vg31Z/X164elRv8qzu3LjKXgEKIcBqJW11oo
MIME-Version: 1.0
X-Received: by 2002:a92:8681:: with SMTP id l1mr4407473ilh.94.1573134129675;
 Thu, 07 Nov 2019 05:42:09 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:09 -0800
In-Reply-To: <00000000000051ee78057cc4d98f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbc9650596c1d456@google.com>
Subject: Re: general protection fault in put_pid
From:   syzbot <syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aryabinin@virtuozzo.com, bp@alien8.de,
        cai@lca.pw, clm@fb.com, dan.carpenter@oracle.com,
        dave@stgolabs.net, dhowells@redhat.com, dsterba@suse.com,
        dsterba@suse.cz, dvyukov@google.com, ebiederm@xmission.com,
        glider@google.com, hpa@zytor.com, jbacik@fb.com,
        ktkhai@virtuozzo.com, ktsanaktsidis@zendesk.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, manfred@colorfullife.com, mhocko@suse.com,
        mingo@redhat.com, nborisov@suse.com,
        penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp, rppt@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, vdavydov.dev@gmail.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit a8e911d13540487942d53137c156bd7707f66e5d
Author: Qian Cai <cai@lca.pw>
Date:   Fri Feb 1 22:20:20 2019 +0000

     x86_64: increase stack size for KASAN_EXTRA

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10364f3c600000
start commit:   f5d58277 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=1145ec2e23165570c3ac
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16803afb400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: x86_64: increase stack size for KASAN_EXTRA

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
