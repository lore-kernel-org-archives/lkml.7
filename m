Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC611C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 18:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A895A20818
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 18:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfKJSWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 13:22:03 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:46593 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfKJSWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 13:22:03 -0500
Received: by mail-il1-f199.google.com with SMTP id i74so14673410ild.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 10:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6IYsbyGOlas2TYkBAA+OX3C+c+c7PZmkmS2Lj4e2olM=;
        b=sP/3ML5Fye3iddIIgWg59gsHljUSSIw1CEdofoRRs3NQ6EVEwM4dleC0sW5qeIKIY+
         /7PUshBLH7Xk7J+qrvU1bxaz36K+9F7B5IH3O44BSfwS+Z2qDwE2iG0fNQwKXHe9ywLm
         0hP9103pi3kRQUBt9RC4COtRT7elYI+AjNyhfJ9td5TwoCzA12xE7pmwz/ZXXShQNlQd
         rOUu/skTRlOPCunZyitChOuRXTbLIq1EJIklbgEg9cw1t5PJYnCZ3k+xXtndrl09JfY9
         +AXmZqw5Rc85HdIKotSMm0zsx58EuJULcPL+WZorxivcxVq0kfPAbTYb22OprdkYxfG3
         FfYw==
X-Gm-Message-State: APjAAAVTWQ4OjvxmFvBlbc/9zQw1HvOhZFZI8OvjT+DTjh9AmcMKZvCf
        S5vxs7RXpTJdJY9ncfN4DFrEpb2t/jFmF4FcMO0BK9RH2RvP
X-Google-Smtp-Source: APXvYqwMQzZ1opUlIK8pdiq3H2xsR+xRhM/WZ5LyKgYFGDDzAwpnulN1V5k5E71tn+RB6nDtjNGlfXgoCchmQxi7xESS5hCBRlUI
MIME-Version: 1.0
X-Received: by 2002:a92:48cf:: with SMTP id j76mr25098653ilg.189.1573410120472;
 Sun, 10 Nov 2019 10:22:00 -0800 (PST)
Date:   Sun, 10 Nov 2019 10:22:00 -0800
In-Reply-To: <000000000000be219705967f9963@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051218f059702171a@google.com>
Subject: Re: general protection fault in kvm_coalesced_mmio_init
From:   syzbot <syzbot+e27e7027eb2b80e44225@syzkaller.appspotmail.com>
To:     jmattson@google.com, junaids@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 9121923c457d1d8667a6e3a67302c29e5c5add6b
Author: Jim Mattson <jmattson@google.com>
Date:   Thu Oct 24 23:03:26 2019 +0000

     kvm: Allocate memslots and buses before calling kvm_arch_init_vm

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13eaf7ece00000
start commit:   00aff683 Merge tag 'for-5.4-rc6-tag' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=101af7ece00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17eaf7ece00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=896c87b73c6fcda6
dashboard link: https://syzkaller.appspot.com/bug?extid=e27e7027eb2b80e44225
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ed65aae00000

Reported-by: syzbot+e27e7027eb2b80e44225@syzkaller.appspotmail.com
Fixes: 9121923c457d ("kvm: Allocate memslots and buses before calling  
kvm_arch_init_vm")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
