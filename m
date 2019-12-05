Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8942C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE1E20707
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfLEU0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:26:01 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:44890 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbfLEU0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:26:01 -0500
Received: by mail-il1-f198.google.com with SMTP id h87so3446251ild.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 12:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=AMndx8hKdrf5iaXiiQjZKFNKn0Vs2y02qLzZazcs3CU=;
        b=hthHIRZ/cAoR3aUxiQeVEgYG+vQkn2BK84S/LBjSNpuft1Pt50arj3XoavtkYTQQGp
         TtM1ggHYFyymuxgwQgNX1alFGUiW2/UlDlrTIy2JM9ZhGXGo86iR6ltOAh7r450XMadM
         yQd3fi4GCS+j4x/B7Ejntxi2lMch53BYfTvOlECTYOgQIBt/ezqlrQWSrXg+pG18k8Dl
         vxJptcBnzyWtpEJr1QaRGo/fD+lX2c/0dZlyxAfUxzNCxnQPZp70VrtuInhqvSLU+sOF
         ypj2+pIJ1h1QwwH9W3lMO2OvMzB2nNKbwKQa2TueKLQRy6/IpzOZYys2KFBaEsbKJmX0
         FHEA==
X-Gm-Message-State: APjAAAW/M+y2M2Fa/ddltTdLQrdGiW6ELdd/XpZjz6AgoZkaewMQyS/6
        fIayzJKdlzoyAeaEQto2uTAxOHydwvcgQwjVjtp2k6I5uLQQ
X-Google-Smtp-Source: APXvYqwiSIAto3Fuczl3Mloud2GJhz4nWhZmFjdSE7R2+4HUud1uZ12DR1iX6fOWVWwSNwnDp6A3S3YOROzLJiWU36yLPucT+7Cj
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2541:: with SMTP id j1mr7805807ioe.239.1575577560491;
 Thu, 05 Dec 2019 12:26:00 -0800 (PST)
Date:   Thu, 05 Dec 2019 12:26:00 -0800
In-Reply-To: <000000000000675cea057e201cbb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf2c140598fabc5c@google.com>
Subject: Re: BUG: unable to handle kernel paging request in slhc_free
From:   syzbot <syzbot+6c5d567447bfa30f78e2@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akinobu.mita@gmail.com,
        akpm@linux-foundation.org, ben@decadent.org.uk,
        davem@davemloft.net, dvyukov@google.com,
        linux-kernel@vger.kernel.org, mhocko@kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tejaswit@codeaurora.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit baf76f0c58aec435a3a864075b8f6d8ee5d1f17e
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Apr 25 23:13:58 2019 +0000

     slip: make slhc_free() silently accept an error pointer

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=114af97ee00000
start commit:   8fe28cb5 Linux 4.20
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d581260bae0899a
dashboard link: https://syzkaller.appspot.com/bug?extid=6c5d567447bfa30f78e2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136130fd400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1607c563400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: slip: make slhc_free() silently accept an error pointer

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
