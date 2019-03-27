Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BDDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9ED32082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732672AbfC0DxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 23:53:02 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:52530 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbfC0DxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 23:53:02 -0400
Received: by mail-it1-f200.google.com with SMTP id 73so24402itl.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 20:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=kudxy8LgWOfYbiooThutQr1TsGbNOEe8MM9P8aspsJ0=;
        b=cPsaTT0b5pcG52D0kAwW309W2svREq1GyuLx1pR7YEUCqzoFOyoHp132s/9ZQFKGe7
         VABV6EuDrfeYT5rd1XFMzoCX73FxaNMg56cBGk26mNB4JTux47gAMKh6mAmP49sSFx0f
         AYq7QudSeXy08QHFojEosl2UMDtlwE/GVhrYCRrOcz8kxnRzWeW4jHjbjnSKH7Hmd+6g
         PSxUNYGDSic7BUNyEYhUYiZ+RdWFenvghPHZNX0DR2RG0vvucn2oWHbomzExZenRRL+2
         fG0raMlAtbJujRq5xBei2qSPBRB/+pbnCqcezUysGsw+JUt3eU35hYuqi3VEm/1nrp+Q
         FY8w==
X-Gm-Message-State: APjAAAXYGT8kpu0Im7ybVVEZ+7Cs2bgiSUZQTwnY7CS7ukJgmrP7Uvai
        wi12fx3vxbZvXx0tq+wF2SE2ktx40Qbek7wtbZpGTvAyf74a
X-Google-Smtp-Source: APXvYqzMAViz+gbznAG3X5seqGLgEVuRM2TmDaWEPJYGFtpqRw6nYhhe7Ynq7ysuixhWEGUT21de0fl5JaBFm8dOMymDeQqJY2GX
MIME-Version: 1.0
X-Received: by 2002:a02:e04:: with SMTP id 4mr25129203jae.75.1553658781438;
 Tue, 26 Mar 2019 20:53:01 -0700 (PDT)
Date:   Tue, 26 Mar 2019 20:53:01 -0700
In-Reply-To: <0000000000007dedf00576dd53eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c51f7505850b5f3e@google.com>
Subject: Re: possible deadlock in acct_pin_kill
From:   syzbot <syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mszeredi@redhat.com, oleg@redhat.com, paulmck@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e950564b97fd0f541b02eb207685d0746f5ecf29
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Tue Jul 24 13:01:55 2018 +0000

     vfs: don't evict uninitialized inode

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12123143200000
start commit:   da5322e6 Merge tag 'selinux-pr-20181115' of git://git.kern..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11123143200000
console output: https://syzkaller.appspot.com/x/log.txt?x=16123143200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
dashboard link: https://syzkaller.appspot.com/bug?extid=2a73a6ea9507b7112141
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12298533400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ff545d400000

Reported-by: syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com
Fixes: e950564b97fd ("vfs: don't evict uninitialized inode")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
