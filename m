Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF7AC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 06:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3F4206CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 06:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfLOGbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 01:31:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:46237 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfLOGbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 01:31:01 -0500
Received: by mail-il1-f198.google.com with SMTP id s85so3574818ild.13
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 22:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uPjooTBgtNtcDU16+HUh9j8DUTREFvIUsjeh8i5zb8c=;
        b=YJJ5ByfVGSIouiWGJyDgW3MEnx3Fk9M+UrEoFjYJXVtdQnNV2WbF4vnhWvYR0gVR7A
         x1TrRmGP2Sf3QNvUtm81bGnMUAOUWJxfJyGAaNxEcX4rj39nCie97LbvDDHDpigYDr3O
         OCRHb4iUWSE5v51mozuY5XbSFuRFEnoiw8nTB4GxwLupKndiSMFsJVN01BfHe2jJ98O8
         9iDLgdgVSflAQG9ki4tIQtO8+2on+PSyi4OMomljut6jQ9iKWMTS3kkjh9isbKfhVjKO
         t0/Q1Xpt2OJH05so8CzP1IlyXfM+i3g5MIBYBi/zDzub0QybfwmDSytJBHG+JpmjJoVS
         BtJQ==
X-Gm-Message-State: APjAAAXJ0Aq9aO+K4QRKsx0kAqPBQhGhSdkjz26lYeVMHdrvZK9cdaAw
        rA6Wc8tyQXpHvlhD3+NuTfsIbqoqPih0mgt8aJ+YLNpKpwW/
X-Google-Smtp-Source: APXvYqww0KZklP/HZPASxOh1ECBAek11I/mQkvDmtxWf0F+hizPdRYifxpJhSeQt7ZuoAXuoj1TH6U4YiqD2qQs428uaZ4+Q3wAV
MIME-Version: 1.0
X-Received: by 2002:a6b:16c5:: with SMTP id 188mr13807757iow.195.1576391461017;
 Sat, 14 Dec 2019 22:31:01 -0800 (PST)
Date:   Sat, 14 Dec 2019 22:31:01 -0800
In-Reply-To: <000000000000cd9e600599b051e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f9d220599b83d18@google.com>
Subject: Re: KASAN: vmalloc-out-of-bounds Read in compat_copy_entries
From:   syzbot <syzbot+f68108fed972453a0ad4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aryabinin@virtuozzo.com,
        bridge@lists.linux-foundation.org, coreteam@netfilter.org,
        davem@davemloft.net, dja@axtens.net, dvyukov@google.com,
        fw@strlen.de, kadlec@netfilter.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        nikolay@cumulusnetworks.com, pablo@netfilter.org,
        roopa@cumulusnetworks.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166d43dee00000
start commit:   e31736d9 Merge tag 'nios2-v5.5-rc2' of git://git.kernel.or..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=156d43dee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=116d43dee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=f68108fed972453a0ad4
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bc5946e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17302361e00000

Reported-by: syzbot+f68108fed972453a0ad4@syzkaller.appspotmail.com
Fixes: 0609ae011deb ("x86/kasan: support KASAN_VMALLOC")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
