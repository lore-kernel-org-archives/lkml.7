Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FC9C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B038221872
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfGSQeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 12:34:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:47956 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfGSQeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:34:01 -0400
Received: by mail-io1-f71.google.com with SMTP id r27so35150097iob.14
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 09:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=K0tO5uO221nvtR7gnlqeSa9IqFZGmt58DDiOBmYEiu8=;
        b=r7zwFcIl0QxlJF5FdwWxa8IOGB4+FlblTKSlZ+9LR2CTkYLrekxXG1EwO22mdY88J+
         l2KLPZtDd9HNXliKSf95uMSCUnhi1+k4rokUA998pXEXW/yzK09bdqKgcnCUyf//xCuS
         WF/SsGrH6Iq9dE2rInuJtGFFZXweoFWmmmNB2fpfPw+aQGMqyTReRlkDDktnGTGAot8M
         6s/S/6mFd99rQsTGvywL791gpmjipw/Tlph12CRhnLLOofKfqNS0YTLqSj6efKsiS5JK
         hH4kV8Dc/dZ1xoWfTP14NjM83JeMrdP1phI+NE54ZDm0QfWvjIxJwBuP8oCwGHDyGoAg
         mbSA==
X-Gm-Message-State: APjAAAWgWxPGBcbV0waHH7iptC5GKnjDqtjGy2FzeJlPqNXupKIoUFLs
        c6PYJ5FNXU2LlQhhwmKfKJoC2fP0UvDnv3IrwQRt7NkOv+17
X-Google-Smtp-Source: APXvYqzXnjpSQV9iFQbyh8yurehonYeDVnnn919X9PLqsJYbWXJy2VpoCVH3ZDalQ76trhEOtpL1aMd4nm27xBBAS+sOD1mk8YpL
MIME-Version: 1.0
X-Received: by 2002:a5d:8c87:: with SMTP id g7mr47222471ion.85.1563554040200;
 Fri, 19 Jul 2019 09:34:00 -0700 (PDT)
Date:   Fri, 19 Jul 2019 09:34:00 -0700
In-Reply-To: <000000000000490679058e0245ee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027494e058e0b4b3f@google.com>
Subject: Re: KASAN: use-after-free Read in finish_task_switch (2)
From:   syzbot <syzbot+7f067c796eee2acbc57a@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jasowang@redhat.com,
        jglisse@redhat.com, keescook@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        mst@redhat.com, namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, wad@chromium.org,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 7f466032dc9e5a61217f22ea34b2df932786bbfc
Author: Jason Wang <jasowang@redhat.com>
Date:   Fri May 24 08:12:18 2019 +0000

     vhost: access vq metadata through kernel virtual address

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=123faf70600000
start commit:   22051d9c Merge tag 'platform-drivers-x86-v5.3-2' of git://..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=113faf70600000
console output: https://syzkaller.appspot.com/x/log.txt?x=163faf70600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=135cb826ac59d7fc
dashboard link: https://syzkaller.appspot.com/bug?extid=7f067c796eee2acbc57a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c1898fa00000

Reported-by: syzbot+7f067c796eee2acbc57a@syzkaller.appspotmail.com
Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual  
address")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
