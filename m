Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7AAC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACB822CB9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388888AbfGZPja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:39:30 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:46557 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387756AbfGZP0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:26:01 -0400
Received: by mail-io1-f69.google.com with SMTP id s83so59041520iod.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 08:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=iHIZY3n79tjWiqF4FrsxNYHlKLoyYYCqi0zeJqFjTkY=;
        b=ZdzuMOPigJG+/FpmeTQ+SXesmtBik+YcnBByR7qJxFHd2Xaihuy4qK09S7NEA2YSS6
         RVgCpQ38uXgP3GoIVw5Thi5GbzSioqGt4xjGP0EJiWrKn+KctsKPDsEZ3jRz5SUmRYbc
         4hLBgXlvEAy3nZVSz57PvidiTveDme7n4Lyvy0tngYj8O35tOiEkDlSfeAGbtlyveioJ
         C3jjW4J22hzdq0nVjshrqgRSEm6Xw+BYCEstx1EO6Xgph8xtcnCRWb2WML0B1SZB6iTY
         6WsBJPiiYvIYwrT5yB6DlxNMsvqfWx0YMzUbm3gnfAi9HgXaut7de88mbDLXeGgki5A6
         mk3w==
X-Gm-Message-State: APjAAAVLemrKBJv3/pXE0x60uJErVuHsNzPoWWK8Cq8r9M7YDOt6aHXz
        ML7l5+jPnzeOsuVzaNO7P403n/L37HPK9/rA3zQdyZYZlwE6
X-Google-Smtp-Source: APXvYqzHpk/vEMkIMKMtiMdg8PB4RYhne1o6pJ8WL+G6Degv9dbMalQiRsRdhyVuMJOgTkwheM+dhLdMfqp+YLyIul4ruGrn56Gi
MIME-Version: 1.0
X-Received: by 2002:a02:4484:: with SMTP id o126mr98783066jaa.34.1564154761082;
 Fri, 26 Jul 2019 08:26:01 -0700 (PDT)
Date:   Fri, 26 Jul 2019 08:26:01 -0700
In-Reply-To: <000000000000b4358f058e924c6d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e87d14058e9728d7@google.com>
Subject: Re: INFO: rcu detected stall in vhost_worker
From:   syzbot <syzbot+36e93b425cd6eb54fcc1@syzkaller.appspotmail.com>
To:     jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, mst@redhat.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        yamada.masahiro@socionext.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 0ecfebd2b52404ae0c54a878c872bb93363ada36
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Jul 7 22:41:56 2019 +0000

     Linux 5.2

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=118810bfa00000
start commit:   13bf6d6a Add linux-next specific files for 20190725
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ae987d803395886
dashboard link: https://syzkaller.appspot.com/bug?extid=36e93b425cd6eb54fcc1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15112f3fa00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131ab578600000

Reported-by: syzbot+36e93b425cd6eb54fcc1@syzkaller.appspotmail.com
Fixes: 0ecfebd2b524 ("Linux 5.2")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
