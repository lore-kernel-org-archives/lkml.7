Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8165AC2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE0F2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfLDRZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:25:01 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:51770 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfLDRZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:25:01 -0500
Received: by mail-il1-f198.google.com with SMTP id x2so234246ilk.18
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 09:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7EBHqRzY74ZGF4tFe8/2rCfanQYl+zaLWG2jjw2sqJU=;
        b=G/oPQdzY757+LZ4Xpn7DhN1rXuodH6vXsqFWaUD8yluXgOgpAHkX4lWEPDxDpxIn0B
         ItdBsObq/w0n5u095gK2TVydoewuI1/F84Dt2LHfsUBgnwQlE39x4kEdZTTnl83ug6jC
         59NwtX5d9I0blKYk0VNt/SD8SLVE/3aVrxp+qQcsoXZI2U+cCC5hwRL3+cETL5Q6j9M+
         w2CuhI5moSfEvSrlTiGbr+GCWHoAAMjBA5ldtOq6wDoRXfMXFTWhWnMj9HF2mzZmI8ei
         t7TuuqkYQ7id5PU2pctP0Hfaic5QxH++Ay0by67eRNYV7JNAJbQMNS3naCG6F7wv6TkG
         Xo6w==
X-Gm-Message-State: APjAAAVOjOOfeZnXcv19LhOQXaJGgVWCIJfzwkeS7nyxZrQetMczVnkB
        54uhChsTiRzm6n5YtUH10iAq7jM6PYF9SiWKuL8Wim/lsKAM
X-Google-Smtp-Source: APXvYqwbE8j0A1R4STA165xAE2o2CZhzCyPUxcpg0HmtPL7kxTLcb8QkM0tXoiQbRnp/I+pW3xAbBYhdXQBcSkEqCJmXhPMwQnNb
MIME-Version: 1.0
X-Received: by 2002:a05:6602:187:: with SMTP id m7mr3058050ioo.16.1575480300753;
 Wed, 04 Dec 2019 09:25:00 -0800 (PST)
Date:   Wed, 04 Dec 2019 09:25:00 -0800
In-Reply-To: <000000000000314c120598dc69bd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad595a0598e417a6@google.com>
Subject: Re: BUG: unable to handle kernel paging request in pcpu_alloc
From:   syzbot <syzbot+82e323920b78d54aaed5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andriin@fb.com, aryabinin@virtuozzo.com,
        ast@kernel.org, bpf@vger.kernel.org, christophe.leroy@c-s.fr,
        daniel@iogearbox.net, dja@axtens.net, dvyukov@google.com,
        glider@google.com, gor@linux.ibm.com, kafai@fb.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 0609ae011deb41c9629b7f5fd626dfa1ac9d16b0
Author: Daniel Axtens <dja@axtens.net>
Date:   Sun Dec 1 01:55:00 2019 +0000

     x86/kasan: support KASAN_VMALLOC

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166cf97ee00000
start commit:   1ab75b2e Add linux-next specific files for 20191203
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=156cf97ee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=116cf97ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de1505c727f0ec20
dashboard link: https://syzkaller.appspot.com/bug?extid=82e323920b78d54aaed5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156ef061e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11641edae00000

Reported-by: syzbot+82e323920b78d54aaed5@syzkaller.appspotmail.com
Fixes: 0609ae011deb ("x86/kasan: support KASAN_VMALLOC")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
