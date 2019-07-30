Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AE0C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAA4205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfG3HNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:13:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:40487 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfG3HNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:13:01 -0400
Received: by mail-io1-f72.google.com with SMTP id v11so70404334iop.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 00:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5NJsWs5rO4lIuS0ZgiXWXMUnUDOFAKxFplPhTBI+bqM=;
        b=f+EqCNhC74ZT/pA1E3yAIW9rvfwhJnEcNqy+MEpHHPvRc/5vVS9icEIh9Tng/YBD6L
         vWElENljTqrUC1brKC+cqqMVtSeRV6bNVbBjyjbjDeA+RNH199LVPtLz+4ao5k+6W7Q9
         QINEAXw04aIxDkdraFjqPhiFPujd81UonBWvqBd58cNuH4Uef5RJvRIqN3gUuCFldB6M
         LRQupkZBnRmmxDXT8rCasf8Ivgt2ElOPsADPmmqcTmd1Ho0Ut0t8phUdPvmOWK/4UG+O
         1rXvjFY5QLfh36+Yo0E+KN3nbkdxYi8cpIVLiVUTtxxR16wQHh/306o0SZr74ObnM5bA
         pi9Q==
X-Gm-Message-State: APjAAAWcF2odBXEeSZMvVvNcV5C8Bq897Rbe+elOzA33/uPAUT/oXESK
        72xxD6Tfv8yBIxPxvZtxV/Wb21r7GsRRJyavowk3IcPkr+uc
X-Google-Smtp-Source: APXvYqw5SXLkTuBMD92g5AbsXWj+a5igK5Vc68j3TXyjLS+D+UvsTA9bxtT6u0WCZTYI0I29O9xwwLMF8YW79WjQUXBUs5hDeJu+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:201:: with SMTP id e1mr36980524jaq.45.1564470780934;
 Tue, 30 Jul 2019 00:13:00 -0700 (PDT)
Date:   Tue, 30 Jul 2019 00:13:00 -0700
In-Reply-To: <000000000000df9d48058e9228cd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028c26d058ee0bd1a@google.com>
Subject: Re: KASAN: use-after-free Read in psi_task_change
From:   syzbot <syzbot+f17ba6f9b8d9cc0498d0@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f4840c600000
start commit:   bed38c3e Merge tag 'powerpc-5.3-2' of git://git.kernel.org..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12f4840c600000
console output: https://syzkaller.appspot.com/x/log.txt?x=14f4840c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9aec8cb13b5f7389
dashboard link: https://syzkaller.appspot.com/bug?extid=f17ba6f9b8d9cc0498d0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dc7b34600000

Reported-by: syzbot+f17ba6f9b8d9cc0498d0@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
