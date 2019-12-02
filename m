Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F55C43141
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87DF217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfLBTyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:54:03 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:53918 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbfLBTyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 14:54:01 -0500
Received: by mail-il1-f198.google.com with SMTP id d3so634131ilg.20
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 11:54:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sYedtpyaMKG5whWJkf6dyBRhk3jwnlp5j6dMs2CqDFU=;
        b=smTZ1gUqa4DIogj1fcAdL9sdXQ/v4JPt7EP1Dmunj3wYgQZDbqWYqijK6sgIDqZw1p
         9caG/QoAM8sjJ8rILQWq8vhhDKyqrZDj+OE46uu8wffpxzPNMaoNl6ajI4ImY4f8Budf
         lm6sRoRaymTh3CfIVR+B3dVq57w+xMmosMFN0UqYfOGOv2pxdfec/MrUShs738bJoMOE
         2qWNy+99/6d9MU316mTUXr7NAQDDx+H8NhGf8ruulc2zFsZNi8C09nAWDLcwA2HMIGue
         U3xhygZc66TI5nDvBepFhVY4GEGOZDd0OjzqN8nlqaaBtwDedG6miHqNX0aEGcjwUQLX
         S1Nw==
X-Gm-Message-State: APjAAAV9I/2bqG3z+tcRGyW5Qq3zJYsYLGEphbIbFURU45cqXH/CHC1x
        V3qf4mO82qhAhehLJNsXWmeRlwN7/TLVcED1qEFTXUBzKj5f
X-Google-Smtp-Source: APXvYqwCsGxdE1Q39uMe3w+N7P34H3tGUIGjHKavf2twfv9j9z6nDvvs/vMFI7BQnMa0/lyn5/xB48hDQosPeU+CdJaN0K7ha/dE
MIME-Version: 1.0
X-Received: by 2002:a02:b47:: with SMTP id 68mr1505294jad.49.1575316440400;
 Mon, 02 Dec 2019 11:54:00 -0800 (PST)
Date:   Mon, 02 Dec 2019 11:54:00 -0800
In-Reply-To: <000000000000a6324b0598b2eb59@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6c9870598bdf090@google.com>
Subject: Re: KASAN: slab-out-of-bounds Write in pipe_write
From:   syzbot <syzbot+838eb0878ffd51f27c41@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit a194dfe6e6f6f7205eea850a420f2bc6a1541209
Author: David Howells <dhowells@redhat.com>
Date:   Fri Sep 20 15:32:19 2019 +0000

     pipe: Rearrange sequence in pipe_write() to preallocate slot

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16085abce00000
start commit:   b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15085abce00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11085abce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
dashboard link: https://syzkaller.appspot.com/bug?extid=838eb0878ffd51f27c41
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146a9f86e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1791d82ae00000

Reported-by: syzbot+838eb0878ffd51f27c41@syzkaller.appspotmail.com
Fixes: a194dfe6e6f6 ("pipe: Rearrange sequence in pipe_write() to  
preallocate slot")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
