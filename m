Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F53C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606912087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfC0MzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:55:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:40164 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbfC0MzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:55:01 -0400
Received: by mail-io1-f69.google.com with SMTP id e72so12958151iof.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 05:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zdt2r52Uffvru9gxgpG6IO5wRYSwR+ymhr5Zg2FzhkM=;
        b=X9i8ENkRAg0703EQb34qWnzCvD6Pcawn1mS17fusgsOwuLEOGKaPS7OmePCVQfw+qM
         3zNKLdUPYB3Jf0+x7Vkcy+a+kkWA6Se5vNQGn9TdfGv9xHIZlM68sozga7ApNAwn3wC6
         Vuy8hwFuaSTuomdKMtr6ldR9XmXimTlXs1RWBnMOQfU+bkr+crK95US0jb3ED8k0yk+Y
         owuvqheWwuwIlfB1uq9fXpDq1rfA1KkemEMyBgsGai5ERygEIVo7NX9vmyNc6Gn0zGXZ
         bjiFPCSeI6v53vj5GTJs+mpqsvUF7e0W40N1+G+2OMd1zsnF0Il4fZMN9sFeOMacdNjo
         4Fbg==
X-Gm-Message-State: APjAAAUG6OeMZkiHZdntgtrh4ijIFvzOVncIA5Bn1nWK6MnWpHHPihGa
        Xp/zZ11izmfet5uJjldX4zDpkDljfUQ60y1aSU14+cyukyVs
X-Google-Smtp-Source: APXvYqwvm3+6iNYbVN3WEaWdTMcnI25DiObMgPtMAyEUyU/jLT02M6aQSm6LOJIYPy9Fw3Hhne2uj/gt15T2MvQgfg9s0/JXZ54w
MIME-Version: 1.0
X-Received: by 2002:a02:634a:: with SMTP id j71mr1582707jac.18.1553691300852;
 Wed, 27 Mar 2019 05:55:00 -0700 (PDT)
Date:   Wed, 27 Mar 2019 05:55:00 -0700
In-Reply-To: <0000000000001d985405783e8aee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000141efb058512f295@google.com>
Subject: Re: KASAN: use-after-free Read in bpf_prog_kallsyms_del
From:   syzbot <syzbot+10cffda23c81a3ff1088@syzkaller.appspotmail.com>
To:     ast@fb.com, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit f4d7e40a5b7157e1329c3c5b10f60d8289fc2941
Author: Alexei Starovoitov <ast@fb.com>
Date:   Fri Dec 15 01:55:06 2017 +0000

     bpf: introduce function calls (verification)

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14d1915d200000
start commit:   1ce80e0f Merge tag 'fsnotify_for_v4.20-rc3' of git://git.k..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16d1915d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=12d1915d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
dashboard link: https://syzkaller.appspot.com/bug?extid=10cffda23c81a3ff1088
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e0be2b400000

Reported-by: syzbot+10cffda23c81a3ff1088@syzkaller.appspotmail.com
Fixes: f4d7e40a5b71 ("bpf: introduce function calls (verification)")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
