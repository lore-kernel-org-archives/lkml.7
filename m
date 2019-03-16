Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA08CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF8D217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfCPOt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:49:29 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:38858 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfCPOtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:49:02 -0400
Received: by mail-it1-f198.google.com with SMTP id r136so10561741ith.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tKdFMkPQdgTBq0mw82dj+i9hybL5R21t7YUT6EeK8B8=;
        b=QqNwDUWu/S0fRCLNxUyru6vsSMmmzYmlt/EZxym92HrWgq6R8MGKA7Nw/oaWba7ihl
         INLkouJf5KlbbZtokMaga7Q13Vg5q4rZXviNQfuY5PQPKuWymdz7Hp6bzk2qsUXRLJ63
         qd4L/gSL0AkBOSJv9OHuPpY60JbincjsOrHMQ4a0jBmhDP+lQPNMBPljxWDDKqi/yqRu
         MDlrMkVcajb7hXMHxf4z1nkHM/Fj8sKtU2rfSWx5/xWWk4SCvJK9qsmI4haKJ0syAFmv
         1+3B/x9Zx7ih3Zr1IIGenvBmkEszgpMMkvrbJ2zMiIgpnK0RywYJ2w7pUKaqwS4r23to
         kddg==
X-Gm-Message-State: APjAAAV4RPC1QUfZBa2Lj8w18rrBYzdx77glUYmk3vEzsIWL5SP/IkFh
        BmaXvQTbK6W2YxscZ3ADnRGNNzF7RUt4xjSmZ4NmQDKI+jI0
X-Google-Smtp-Source: APXvYqzb0BISZrVvuixbyEcNUXcri+eqiTp3LxPN1PHjzd87oq2IQENWpcnVwAM4ReH5NCtT5GtcjxU1bhHCh8L0lApaYOu6bSuQ
MIME-Version: 1.0
X-Received: by 2002:a24:4503:: with SMTP id y3mr4809853ita.32.1552747741653;
 Sat, 16 Mar 2019 07:49:01 -0700 (PDT)
Date:   Sat, 16 Mar 2019 07:49:01 -0700
In-Reply-To: <000000000000675cea057e201cbb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091355e0584374181@google.com>
Subject: Re: BUG: unable to handle kernel paging request in slhc_free
From:   syzbot <syzbot+6c5d567447bfa30f78e2@syzkaller.appspotmail.com>
To:     akinobu.mita@gmail.com, akpm@linux-foundation.org,
        davem@davemloft.net, dvyukov@google.com,
        linux-kernel@vger.kernel.org, mhocko@kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tejaswit@codeaurora.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e41d58185f1444368873d4d7422f7664a68be61d
Author: Dmitry Vyukov <dvyukov@google.com>
Date:   Wed Jul 12 21:34:35 2017 +0000

     fault-inject: support systematic fault injection

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1415a8a3200000
start commit:   e41d5818 fault-inject: support systematic fault injection
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1615a8a3200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1215a8a3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d581260bae0899a
dashboard link: https://syzkaller.appspot.com/bug?extid=6c5d567447bfa30f78e2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136130fd400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1607c563400000

Reported-by: syzbot+6c5d567447bfa30f78e2@syzkaller.appspotmail.com
Fixes: e41d5818 ("fault-inject: support systematic fault injection")
