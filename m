Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B316DC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5DE2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfFZElC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 00:41:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:45481 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfFZElB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 00:41:01 -0400
Received: by mail-io1-f70.google.com with SMTP id b197so1113416iof.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 21:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jsPciA+puK9ooK4TlyjKh7gObZtMQdfgKm0QqLbpEs8=;
        b=om+gFkdDp4RlLZsE0kNlhH4LB/ZSif8FLPQTKgePQNvf8nj3fu+vBBYkqhQEPyffT0
         FPbHlXRoaIGJPk+i7QLSDwBsDvwFEatZDsmRa4jR4sSDzji9ZIuC1HdHjjcNYYOz5ict
         aSi9VrRjrsUaI7Nmk6clD87KhP8CEpL0bnPoxV9+SNC2n9Db4MySH/CXcTdSM20fiUWL
         MTcLDwTQ+RJ+ImWCOs9FPu+e0KeDqYO8kshg9yiwwwjbmgB9oIjicPVMq02nMskmorhR
         v5OCC+YK0KmIX403azQZcr2NLtJkEeOF/H+AoSkxfYEhWva/SHto9D8kbQlXzzfQPWm/
         hSKw==
X-Gm-Message-State: APjAAAUk8EbJD1iXB8QjL3G9do8Y+bF22Z3/WyCfbqXEUgxBfwi+LewU
        Hb2oJQv67+bQnHoi+t8nPFqtv1oBkACidKR9mD0RAdG0fF7O
X-Google-Smtp-Source: APXvYqyXfpl4H9vcElTo0RyNBNTKRr1zt/joRVze4f5+kmA0j1HSzuur+KvWjGLp4vBlUOXhsUCfd2sdQ0vWM9rH41vo5ex9cnt8
MIME-Version: 1.0
X-Received: by 2002:a02:54c1:: with SMTP id t184mr2597199jaa.10.1561524061066;
 Tue, 25 Jun 2019 21:41:01 -0700 (PDT)
Date:   Tue, 25 Jun 2019 21:41:01 -0700
In-Reply-To: <000000000000c7a272058c2cde21@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7df7e058c32a611@google.com>
Subject: Re: kernel panic: stack is corrupted in validate_chain
From:   syzbot <syzbot+6ba34346b252f2d497c7@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e9db4ef6bf4ca9894bb324c76e01b8f1a16b2650
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Sat Jun 30 13:17:47 2018 +0000

     bpf: sockhash fix omitted bucket lock in sock_close

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d4e129a00000
start commit:   249155c2 Merge branch 'parisc-5.2-4' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13d4e129a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15d4e129a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31528e58cc12e2
dashboard link: https://syzkaller.appspot.com/bug?extid=6ba34346b252f2d497c7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135e34eea00000

Reported-by: syzbot+6ba34346b252f2d497c7@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
