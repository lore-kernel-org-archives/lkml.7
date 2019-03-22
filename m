Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FB3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6293220830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfCVHOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:14:03 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:57449 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbfCVHOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:14:01 -0400
Received: by mail-it1-f197.google.com with SMTP id h82so1378235ita.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 00:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=kkthjFO2LoxdqDWlU8fzl2TfzJas6xfEmLfZna8RI+I=;
        b=dEb579uJOJgQoBOixEK0gS8iADjkIiyUB3q1+ylVB4O4NeNvR0+NfcMfDjXXnDnZjt
         sijwFzJg9ZIqu9dZpki2q1crlgI7b3kKPW2tvj7h/5B9oFSNOc9R4D4xTBjK9DAukXah
         OQp44me7rX91A/Tuz0FP0PE1UhbET3uAY/veWev5JKCiS8308F5cda6qHw+ViNEWBSin
         uEL+KFgeJM+ftVu9KksDN44nzdbGhsZj5Dke07axXutZ8VpRBtIFRbBQxv1D5Aae6qQE
         R20S0hysTCm5WJQJIA7x6FCKilQ/wsILmzH/kMKTR1RO6NOW8vmg0vStdpdq2zIdglVj
         lrZg==
X-Gm-Message-State: APjAAAWCz0Dofdb5yGIY+y/6ruMdKyREfZvUngTdh0eOn6w5fvW405hV
        uJ4YwFG4WALGsCHT4FegXcOFtAv6ZrfoQUfxgQg4Xi0nobox
X-Google-Smtp-Source: APXvYqwVeJkFj+kZRFeV0cGVLtKDGYWkBKqh9CQ7x6U3PJ8MA0Zgna957qEIe/qSuJtbGjgOHzvwAyudMuiHxp1UY6h7XvlmuFdp
MIME-Version: 1.0
X-Received: by 2002:a6b:ea19:: with SMTP id m25mr6518156ioc.291.1553238840994;
 Fri, 22 Mar 2019 00:14:00 -0700 (PDT)
Date:   Fri, 22 Mar 2019 00:14:00 -0700
In-Reply-To: <000000000000700cdc057935aa71@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e71740584a999d1@google.com>
Subject: Re: possible deadlock in userfaultfd_release
From:   syzbot <syzbot+53c0b767f7ca0dc0c451@syzkaller.appspotmail.com>
To:     adam.manzanares@wdc.com, avi@scylladb.com, bcrl@kvack.org,
        darrick.wong@oracle.com, hch@lst.de, jmoyer@redhat.com,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit bfe4037e722ec672c9dafd5730d9132afeeb76e9
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Jul 16 07:08:20 2018 +0000

     aio: implement IOCB_CMD_POLL

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1382985d200000
start commit:   bfe4037e aio: implement IOCB_CMD_POLL
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1042985d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1782985d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c0a49d2b5210087
dashboard link: https://syzkaller.appspot.com/bug?extid=53c0b767f7ca0dc0c451
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1111f2eb400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e874f5400000

Reported-by: syzbot+53c0b767f7ca0dc0c451@syzkaller.appspotmail.com
Fixes: bfe4037e722e ("aio: implement IOCB_CMD_POLL")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
