Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5818C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61482077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389698AbfKGNoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:44:22 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:39383 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbfKGNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:06 -0500
Received: by mail-il1-f197.google.com with SMTP id o11so2661982ilc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=e/bybNTyffzCSeOhQgOXo0fbtRLBZtaNhLVDBNJSTz0=;
        b=gHRdR70KzQ4kMP26H1gIHD2rafYj9z5rQCPjZDYOCX5N3neBeESkRsN19O4I8B7XMu
         WKaeXgzSHv+w7D3kkdXokLqy+TbBLzHxcGm4fpL1ecvphPaoHonbUvaRbsgmjWq5JIat
         XhMcHKGXj+42dBBm+8d1XF3BPuO1WF3PmoO8AsVzeJ0ZsBzeJS1rWJppWrAgh07vS/OB
         8URtWZrJPvdjlRHpdj5MJwtXawQ0REmOU8ElIl/PfftFXcwde5QX4DUw0u56JubfjDf0
         XojLnLJJuoKaxQKvYeyZfZtcoqfROI6Gi1teJITduqxnNq/7XffvSyOxoDNqrsj3fuTL
         PuJg==
X-Gm-Message-State: APjAAAWgJTgsWHG1qBj36W++7FzaeFCAImkfZdMAiv4oi7XE6vd911fh
        OvVUXMyrmWZ8M7tEPvBTew30zbF/0P2bdEbxyVfBDDtHPMIl
X-Google-Smtp-Source: APXvYqzWljQaJsrZ+AqWGAmWCefLJmmLOH1MlaUPlzVjJXSJlkdhW5pXAl9sPFgHpbd2qO0w4m10rxgCexPmWcK7myr9dWVLOdcX
MIME-Version: 1.0
X-Received: by 2002:a6b:8e8a:: with SMTP id q132mr3481485iod.94.1573134125252;
 Thu, 07 Nov 2019 05:42:05 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:05 -0800
In-Reply-To: <000000000000bc17b60571a60434@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8443c0596c1d480@google.com>
Subject: Re: INFO: task hung in fuse_reverse_inval_entry
From:   syzbot <syzbot+bb6d800770577a083f8c@syzkaller.appspotmail.com>
To:     dvyukov@google.com, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit c59fd85e4fd07fdf0ab523a5e9734f5338d6aa19
Author: Kirill Tkhai <ktkhai@virtuozzo.com>
Date:   Tue Sep 11 10:11:56 2018 +0000

     fuse: change interrupt requests allocation algorithm

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15518db2600000
start commit:   d72e90f3 Linux 4.18-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=68af3495408deac5
dashboard link: https://syzkaller.appspot.com/bug?extid=bb6d800770577a083f8c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11564d1c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fc570c400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: fuse: change interrupt requests allocation algorithm

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
