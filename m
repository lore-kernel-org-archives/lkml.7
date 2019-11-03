Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BD0CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 04:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90711214D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 04:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfKCEgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 00:36:03 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:36843 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfKCEgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 00:36:03 -0400
Received: by mail-il1-f198.google.com with SMTP id y7so12616653ilb.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 21:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=M+1ZDFfcrH+VAQWLoZZHEEfvJgWEhhXd8OnHFWpRv3Y=;
        b=W2Y/LF/Oz2Xmgy2CPiQ3GXYBYL5ovx4njmVsZWNW765ymbFcw6i+th+MblRrEIfuE7
         0gJQMEkQ0SI82jzNJhXNOwZvjgUh6bWLJRhBc7NQjwQnZRNMl7H94FhcOp/QSgTY8nfJ
         iotrl97WkXp6TKb1Udpj7yS0t2EAe0tYP/moiaBY1JOqgmDbamYabllp/B5ajtmKMH1x
         x5p+Y/9tTb7HVrxejI7Q/frhEaEI2G55Fg8xS6pwVOz+ICVoxoZmuuThLJrgRwsnAHyG
         5Q6OqFQLlo6cGCXsAZNHeuUWUYDFVxNjBdTtV2VbjkogAx55kukk5Qo4PjNKxmzLuGq8
         rosQ==
X-Gm-Message-State: APjAAAVAri1Sl/uM3E8JpQKAuovfVYrCxOLlvjciMH+K0ZX5l9/3Ok87
        GaUVSWg2GusFQNNL+xZUrghpzk6vq647WfuGfBRufykrS2qP
X-Google-Smtp-Source: APXvYqxItIWYSpOcf1AXFMpH8Ub6pBbhUL7/Lcw2BhVvs92D6D18UI0J7DOxRBzc+z8rKFuUe7pN6yF0MfklBEJKCDLhBTRh49FR
MIME-Version: 1.0
X-Received: by 2002:a92:c525:: with SMTP id m5mr4523632ili.91.1572755761014;
 Sat, 02 Nov 2019 21:36:01 -0700 (PDT)
Date:   Sat, 02 Nov 2019 21:36:01 -0700
In-Reply-To: <000000000000bd85b40596657dfa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000742ddc059669bc92@google.com>
Subject: Re: WARNING: suspicious RCU usage in kvm_dev_ioctl
From:   syzbot <syzbot+75475908cd0910f141ee@syzkaller.appspotmail.com>
To:     jmattson@google.com, jsperbeck@google.com, junaids@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit a97b0e773e492ae319a7e981e98962a1060215f9
Author: Jim Mattson <jmattson@google.com>
Date:   Fri Oct 25 11:34:58 2019 +0000

     kvm: call kvm_arch_destroy_vm if vm creation fails

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f19914e00000
start commit:   9d234505 Merge tag 'hwmon-for-v5.4-rc6' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10099914e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17f19914e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbbed3e8d4eb64bf
dashboard link: https://syzkaller.appspot.com/bug?extid=75475908cd0910f141ee
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e20268e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15209b84e00000

Reported-by: syzbot+75475908cd0910f141ee@syzkaller.appspotmail.com
Fixes: a97b0e773e49 ("kvm: call kvm_arch_destroy_vm if vm creation fails")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
