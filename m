Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD70C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 10:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656942085A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 10:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfCQKnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 06:43:03 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:44124 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfCQKnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 06:43:01 -0400
Received: by mail-it1-f200.google.com with SMTP id z190so2223702itc.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 03:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oi5XUX9Bfm0EZAFt9uWawkoY614hl8Ao0SeR1n2snTQ=;
        b=hXd7PdSNf6HLVa/f3JvrBs59JEuLh/+RtZ+pHBjFtfueQwMiplLx8cy3Q6xbJgBz+O
         roJU50y4fDyOoFIHtPww7VO3AEAlTaE6FlCMvasTZzYoedpKsq0c6zcktI25thprDh7i
         26itomDbepaKdKNqEBZXdnMFnYwxB8bfSwMLG3i1zOUU++4eIzoKC1nLljT1NJYvjXUX
         ZpUO+w4jlzJvmvtyFDit7QyFwA8IX8xtHHjMiLmyU1Mbz0KIcQbV03vGatZh33KpBPfC
         f69hVjofdBkG+55br4l0QP0yJ1fILW2b2zxarYiMcfEejdXOPPxU3ADYKLQPABg4UuzW
         T1Ag==
X-Gm-Message-State: APjAAAVJ5KVEjv7EjxCUHvCFv+DRh5wf2GRyPUpihu1t71G75xZUs0ge
        XvLiE0rV9xnzEgpbgmTu18j2pHiBGeske1G+UuljNn0d8q1F
X-Google-Smtp-Source: APXvYqylmbuGqfpklPa2WOK8fFaqmVHKcWlSaxz9jYcRgqrwSr1LD/ArXA8K6Cj5utQWqTSsOvlydZZB1OqrCHhJnLpJ6+hKJ/9B
MIME-Version: 1.0
X-Received: by 2002:a24:b007:: with SMTP id d7mr7096608itf.8.1552819380766;
 Sun, 17 Mar 2019 03:43:00 -0700 (PDT)
Date:   Sun, 17 Mar 2019 03:43:00 -0700
In-Reply-To: <000000000000696949057ee26e44@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000974cbc058447ef88@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hci_event_packet
From:   syzbot <syzbot+cec7a50c412a2c03f8f5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org, mmarek@suse.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit c470abd4fde40ea6a0846a2beab642a578c0b8cd
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Feb 19 22:34:00 2017 +0000

     Linux 4.10

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127bd0f7200000
start commit:   c470abd4 Linux 4.10
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d55557b516c45456
dashboard link: https://syzkaller.appspot.com/bug?extid=cec7a50c412a2c03f8f5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1643bfbf400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d6c8f7400000

Reported-by: syzbot+cec7a50c412a2c03f8f5@syzkaller.appspotmail.com
Fixes: c470abd4 ("Linux 4.10")
