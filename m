Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A0DC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6FF2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfFFJVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:21:02 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:50363 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfFFJVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:21:01 -0400
Received: by mail-it1-f199.google.com with SMTP id o128so1289494ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 02:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=56G2RzBG0guHoTpwxKynlW+PNBbvgl4GPrCoRWxxM0U=;
        b=nx+Ng0Snx3NLslssHscKEHP+6cr5o/Q6Fw13OKdpPJ63Vo5T9xjUb5bvxT/P6h2fWa
         KE327G6tU70qJO7J+5ywLPf4U7fnZ8pKduQEGlbGR1Ae18nIJRUM22mXmFhAeqeKS9r+
         QEQzhc/aSp0ZNDkddhYMtJZx5eBlmNC+UneWlrr981NWTg6ySvP+sZlEKNwn0DUQIPcS
         /pwA/8SUjY1GWMQajQClqcn0oPxGQUugEKZhXVwS9EXeS671Eei02O9nlEjcbK7jmtAv
         MQFsN/YJcYE2U5YY+eK5MHh0p0BXzwK0XT2yeHmNURbeg/N26iUNfR3/hjP2QMuTYZqM
         2eiQ==
X-Gm-Message-State: APjAAAX+rccDd3+bTwRxMu5RbyK29nSvNBEr3Xyzwwp+GWJyFkIXzoAR
        /YCjGLiW5CPYnE18IBFhPtaAp5iq0WCt9B+M5F0bE59ytu8e
X-Google-Smtp-Source: APXvYqxIJibzbNxy8GOtzypAF+Oyb4w4yoUX0G2vgElVjB5zG1mUDMCfNHgGUYHjHFguEhuY8+0K3Y3HNEzzqU8WyYf5rcCq0vxQ
MIME-Version: 1.0
X-Received: by 2002:a24:9f86:: with SMTP id c128mr22407371ite.161.1559812861164;
 Thu, 06 Jun 2019 02:21:01 -0700 (PDT)
Date:   Thu, 06 Jun 2019 02:21:01 -0700
In-Reply-To: <0000000000008ab3c0057e8b747f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008181cc058aa43b82@google.com>
Subject: Re: general protection fault in rb_erase (2)
From:   syzbot <syzbot+e8c40862180d8949d624@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1644ea92a00000
start commit:   156c0591 Merge tag 'linux-kselftest-5.2-rc4' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1544ea92a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1144ea92a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60564cb52ab29d5b
dashboard link: https://syzkaller.appspot.com/bug?extid=e8c40862180d8949d624
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f031fea00000

Reported-by: syzbot+e8c40862180d8949d624@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
