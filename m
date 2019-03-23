Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85964C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DB9218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfCWTxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 15:53:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:51380 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfCWTxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 15:53:01 -0400
Received: by mail-io1-f71.google.com with SMTP id y18so4632223ior.18
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 12:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hPCFZgSPwKo5tFQMJSrf7g8SCxJAS2Im00Nc2F8xtnU=;
        b=ta1encnzSSluU/YaM3ky21elBxybhOihU92qch1kAcHAey0Oq6aJRBo6b+Qx8CnfQ4
         KDnG/eI2NF92tGoEqmH01ewCdGkHQBiv5a6B+401jNJvNmLfJSDuOkqaWWE5S8sjkOFS
         Y7F+QarWVKpnF0AKYez7rE20f8nm8Zf2CTGD+sg4rDIWTcrjHePVSc2EK+xRMv77gbQ7
         QgS5MYvp78wOmLlDX/ou5Q8ybUxU6YfJ66LZr+X/TOiuD1dC2d0csoVqJAJilWp9Gj8v
         f4taxa0dZMajghCtYv7y3AUiGEs9liPibM44t427XPRJOkKpy0YYAtP4/HFIeHYR3BEe
         b0xQ==
X-Gm-Message-State: APjAAAWn3Wgkh2aDiWMZhPI+mSI9wvhHVvFdgksMplHNmF7q8007LxYW
        bxS5fCbS78emh6SZUdjKwZosvCcDqTBT6gIMpFw2iI8LO5KM
X-Google-Smtp-Source: APXvYqypf8qFV5zqJBj4N6WfHbfjOygBoblDN40vDXoQbuohQsDwDzun4fF/7rEFX/3iD0QjrfRjgEo/OWYijkKMuWyotiarjnm8
MIME-Version: 1.0
X-Received: by 2002:a05:660c:80b:: with SMTP id j11mr6177901itk.22.1553370780631;
 Sat, 23 Mar 2019 12:53:00 -0700 (PDT)
Date:   Sat, 23 Mar 2019 12:53:00 -0700
In-Reply-To: <00000000000071be120581ca41ed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000958aa50584c851b7@google.com>
Subject: Re: BUG: soft lockup in kvm_vm_release
From:   syzbot <syzbot+6349a512c2938b2ad058@syzkaller.appspotmail.com>
To:     andrea.parri@amarulasolutions.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@kernel.org,
        peterz@infradead.org, riel@surriel.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 80eb865768703c0f85a0603762742ae1dedf21f0
Author: Andrea Parri <andrea.parri@amarulasolutions.com>
Date:   Tue Nov 27 11:01:10 2018 +0000

     sched/fair: Clean up comment in nohz_idle_balance()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1362209b200000
start commit:   57902dc0 Merge tag 'riscv-for-linus-5.0-rc7' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10e2209b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1762209b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
dashboard link: https://syzkaller.appspot.com/bug?extid=6349a512c2938b2ad058
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14287e78c00000

Reported-by: syzbot+6349a512c2938b2ad058@syzkaller.appspotmail.com
Fixes: 80eb86576870 ("sched/fair: Clean up comment in nohz_idle_balance()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
