Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA4BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3EE20644
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfG2IQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:16:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41008 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfG2IQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:16:01 -0400
Received: by mail-io1-f72.google.com with SMTP id x17so66337871iog.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 01:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0rPakemNyIs9fbLrhB6s/ulRRU21c/3n0kSBtdCA0Eo=;
        b=olBX2UC5qaVKO9vhHcnEqug8nBQCGmFLwMEMebjgO9bfbr89AbjJDnITiYukfiseE0
         f57luSdAtKUUIJj1Hz4sm6LrVw/CG8K6RmvKE56mugLzEGzvR7de7EDWdiCKv5X0Ns7c
         f+NexgJDq5GI6kempG7/hhSbVX9/rfrZ3zMSXOUeAle7gCDSl4NvtK9c+ojjrdH6p7Mt
         D5oqtR8jTuuUj8Taia+rha+o/1Dl8o4cOTTkNHaytlXeIZvYU6lz+nXcUJ88N1IBRL42
         MxGXJjugyCjh6H89Lze/dPZ7b3RPSGOo6qoJTc7msLXg+pT9hcomHWRmJ3l7ZVRY/kUU
         +J9A==
X-Gm-Message-State: APjAAAUsg243K9i1FJxKKCTO1HVdPJgkU/hbVB3iEDRpkEsKoc6x27XB
        tlQwJ+Yc8vEIB+j+Brg5rBmksJCYie3VfJmbtmiaSaybdTOV
X-Google-Smtp-Source: APXvYqxSkxuHca0jLTiQmdMdnlp+TfywXlCfVmn/nxBSNrXe+PgHcKdxjXDq/A4yJcJjcL3n5aaCmQIspC/xzgAeN42nGa5pW21x
MIME-Version: 1.0
X-Received: by 2002:a5d:994b:: with SMTP id v11mr53971532ios.165.1564388160200;
 Mon, 29 Jul 2019 01:16:00 -0700 (PDT)
Date:   Mon, 29 Jul 2019 01:16:00 -0700
In-Reply-To: <0000000000005718ef058b3a0fcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094699a058ecd8017@google.com>
Subject: Re: memory leak in __nf_hook_entries_try_shrink
From:   syzbot <syzbot+c51f73e78e7e2ce3a31e@syzkaller.appspotmail.com>
To:     catalin.marinas@arm.com, coreteam@netfilter.org,
        davem@davemloft.net, deller@gmx.de, fw@strlen.de,
        jejb@parisc-linux.org, kadlec@blackhole.kfki.hu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit fc79168a7c75423047d60a033dc4844955ccae0b
Author: Helge Deller <deller@gmx.de>
Date:   Wed Apr 13 20:44:54 2016 +0000

     parisc: Add syscall tracepoint support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16ad2cd8600000
start commit:   b076173a Merge tag 'selinux-pr-20190612' of git://git.kern..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15ad2cd8600000
console output: https://syzkaller.appspot.com/x/log.txt?x=11ad2cd8600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb38d33cd06d8d48
dashboard link: https://syzkaller.appspot.com/bug?extid=c51f73e78e7e2ce3a31e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105a958ea00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103c758ea00000

Reported-by: syzbot+c51f73e78e7e2ce3a31e@syzkaller.appspotmail.com
Fixes: fc79168a7c75 ("parisc: Add syscall tracepoint support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
