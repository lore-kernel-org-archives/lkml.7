Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4D8C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 05:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8F720644
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 05:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfF0FYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 01:24:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:34801 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0FYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 01:24:01 -0400
Received: by mail-io1-f70.google.com with SMTP id m1so1310784iop.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 22:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KTLmlahqBmrHOIj7RbeMjFFVBD1WODkDi1wf0mxjsj4=;
        b=kE+CH5QDuBL4uMj9UU9tMLTusuTU7bGoVHJ9NRzbalqNb8Q6nwEeAtdSuoobWIpVk4
         OmiBlXhUsNiCwHmhYQjKa/2luHqR15Zdlzd5KBkE/SkL03hy7rePqLFpjq0m6hn/Ajm7
         gE8f7aF6BkxQvBeBbWbW/KPbPp5aQtHIz0qQDNcFjS/Za0ENNMjNbnVQUhF25WvFec+l
         QhJUj3kE+48GcMci0d0XJdV4NLEGi9FoYJSOgplFSqeLwLxrNaoPeMnuG6N7W/jceAAY
         ibsSfPKHaQd7YYJNIfpqGHG9DbRCoKQHDKXDqe5HVWmYYzMmt4Af1S/lVxMXAZJeReEX
         Xtlg==
X-Gm-Message-State: APjAAAWPw//avcHNOVcoUEO9Pml5punb2il4YmwHUvC4dKUaar29Qx7U
        XbPjUOvemZmkRR2JGokFzVUbc6i2KcZ76c6S66MKaj7PJqfE
X-Google-Smtp-Source: APXvYqwLxdaO1aqZn3NAO+28gDuNAkuDRNZ+nL2ivt8eHB6WZ7wyMTxoDYSySR2w00lCL6SEaEgSn6JyDAFAnddEBIqaHiFZN5Vh
MIME-Version: 1.0
X-Received: by 2002:a02:7121:: with SMTP id n33mr2217019jac.19.1561613040861;
 Wed, 26 Jun 2019 22:24:00 -0700 (PDT)
Date:   Wed, 26 Jun 2019 22:24:00 -0700
In-Reply-To: <000000000000d7bcbb058c3758a1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093c88d058c475e46@google.com>
Subject: Re: BUG: unable to handle kernel paging request in tls_prots
From:   syzbot <syzbot+4207c7f3a443366d8aa2@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, john.fastabend@gmail.com,
        kafai@fb.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148e8665a00000
start commit:   904d88d7 qmi_wwan: Fix out-of-bounds read
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=168e8665a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=128e8665a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=137ec2016ea3870d
dashboard link: https://syzkaller.appspot.com/bug?extid=4207c7f3a443366d8aa2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15576c71a00000

Reported-by: syzbot+4207c7f3a443366d8aa2@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
