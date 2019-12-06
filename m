Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4793DC2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2885A2245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfLFKOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:14:02 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:49612 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfLFKOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:14:01 -0500
Received: by mail-io1-f72.google.com with SMTP id t3so4457408ioj.16
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 02:14:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Fa+DdxX+lo+lJe7dbFyW3kXCcKwv4MKa5Zg9OwBsWXc=;
        b=DltiisJo7kLzE1cpxqH7RfEEqSC02GG/XffTV8JlA7cw1J4JoEnDVdB5u9Dy5nGEyc
         OXCodX1RI/oEW+CX95HvDq1S9YZ0ZCJJx/HG7SDBa7aBZEfG0e9mk8bb1u1aMIYG8dr9
         v56Td856zrbmGcR2ZvS78eAcPpU1lB5Ig/joEhvwOvgW1LB9k0kFAL31DpBn8DFusvCK
         FH9lDYzwow1QP0kcQaZfXoCqvZaTCNS7CmKIutEbu7lHmX5T8eaHdH9gOLmWwgR/nu3Y
         boKAWmuAy3In88gKrp4UGZ77Qddx1vdAOO/Jp1/1rpYUsLl0vUDbefWIvSjNypaCBIJ9
         Ybmg==
X-Gm-Message-State: APjAAAWZQgCwYIaC5p9hidAT+ZERRAv++wpy+mkBQl7OoFLtk0W9xoB7
        DJBD4dP7UuLMz8qFRRvikDMMPbkISwPt//EHGg69ahovfQ4x
X-Google-Smtp-Source: APXvYqzGg5ZzkX9hHhaO+/fwV0I2Tn4tW8ji/5Qstkgv6wEgzMsaJk3DJuUegmXDOOmXieSunteRMIQPjKQJQu1fBDNzjI+1JDXN
MIME-Version: 1.0
X-Received: by 2002:a02:c6d5:: with SMTP id r21mr12524117jan.129.1575627240875;
 Fri, 06 Dec 2019 02:14:00 -0800 (PST)
Date:   Fri, 06 Dec 2019 02:14:00 -0800
In-Reply-To: <00000000000054cc6d05834c33d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdad650599064dc5@google.com>
Subject: Re: kernel BUG at include/linux/mm.h:LINE! (5)
From:   syzbot <syzbot+5013d47539cdd43e7098@syzkaller.appspotmail.com>
To:     ast@kernel.org, aviadye@mellanox.com, borisp@mellanox.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, davejwatson@fb.com,
        davem@davemloft.net, dirk.vandermerwe@netronome.com,
        edumazet@google.com, eranbe@mellanox.com, eric.dumazet@gmail.com,
        jakub.kicinski@netronome.com, john.fastabend@gmail.com,
        kafai@fb.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 9354544cbccf68da1b047f8fb7b47630e3c8a59d
Author: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Date:   Mon Jun 24 04:26:58 2019 +0000

     net/tls: fix page double free on TX cleanup

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ebd77ae00000
start commit:   9e9322e5 selftest/net: Remove duplicate header
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=47f2db597668ac40
dashboard link: https://syzkaller.appspot.com/bug?extid=5013d47539cdd43e7098
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148763eb200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1416ff3d200000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: net/tls: fix page double free on TX cleanup

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
