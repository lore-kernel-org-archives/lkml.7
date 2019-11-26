Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A32EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6EB2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfKZPrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:47:03 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:39804 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfKZPrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 10:47:02 -0500
Received: by mail-io1-f72.google.com with SMTP id u13so11212548iol.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 07:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NMIhDQ1/TzZzQjr2wWUncjr9UXV8W0Q6CWNH9QCoYyc=;
        b=KkFioigWia6dYcH6KyCfrwkhfOcC+uirunuzVVU0UW1ez9m2pPMrlbQ7MpUellbP9W
         TZSr47fdWMv8cGm/aVKz3a+y1T6OlelLoX0eJ8WBoSgaYYVSk4E+7oltZhd0FxvL0Bwf
         fjQExVCzg1AZ93c6ziyW+R1AImAB1es4vlB27sawsMlf8tt+y/mXIjreVeT0m35CQrNp
         dY+L2wn9M5d+cDLmj/YjXc9j55r45u+GKwI/5vO0OZpEn3h+KXjR1MQJuByT20uXJAmv
         KkcIEdQfPzkyl1vk9MrKo/27aB1glZVeeEwYOtyZji25zfOY9G84kAC8koVh+ENR6rD2
         i5CA==
X-Gm-Message-State: APjAAAXfws1+/rgF/1i03W53Z1xf6DRdW1AbpUaqGL6lXI9sPsqn8YpQ
        /7CmPO0VDeMUWogHanVPGMqG+mVlX8XCvNhDVCLZhOuN7y38
X-Google-Smtp-Source: APXvYqwGLVmd6lBzBXRckmAQHo5bBkT8ic7o+qm5KSqWVZbE1t3yqtpg3LGxYvDX6Q2q+YWCGwHbZNwPiZQhQ+pyU2BTIV7K7AFJ
MIME-Version: 1.0
X-Received: by 2002:a6b:3b06:: with SMTP id i6mr14691402ioa.185.1574783220874;
 Tue, 26 Nov 2019 07:47:00 -0800 (PST)
Date:   Tue, 26 Nov 2019 07:47:00 -0800
In-Reply-To: <94eb2c059ce0bca273056940d77d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a85c4059841ca66@google.com>
Subject: Re: INFO: task hung in do_ip_vs_set_ctl (2)
From:   syzbot <syzbot+7810ed2e0cb359580c17@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        horms@verge.net.au, ja@ssi.bg, kadlec@blackhole.kfki.hu,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvs-devel@vger.kernel.org, mmarek@suse.com, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        wensong@linux-vs.org, yamada.masahiro@socionext.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Jul 2 23:07:02 2017 +0000

     Linux 4.12

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11a2b78ce00000
start commit:   17dec0a9 Merge branch 'userns-linus' of git://git.kernel.o..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=da08d02b86752ade
dashboard link: https://syzkaller.appspot.com/bug?extid=7810ed2e0cb359580c17
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130abb47800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150a15bb800000

Reported-by: syzbot+7810ed2e0cb359580c17@syzkaller.appspotmail.com
Fixes: 6f7da290413b ("Linux 4.12")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
