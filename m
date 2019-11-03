Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F518C47E49
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 12:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76306214D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 12:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfKCMLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 07:11:01 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:56561 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKCMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 07:11:01 -0500
Received: by mail-io1-f70.google.com with SMTP id o2so11080098ioa.23
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 04:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Xwpp1TpBnHfvp2xyxP9sGt3bT4ULRP3XGkhH7PJ6jAk=;
        b=nJw029I4Hwvg1D3o47/NtoYqkSvLb76OeBjc3Viyy8Q7/sAVQh1HqFsuOXoO+LGBzx
         INWYzfDExWagDjqH+JTzQA38eWWGTvHGxtiM4GJ/3mWSZjQiao1X3ZYeuFYXWeYfCYu2
         PKe2PZ3Dyyd9tum6sLLX8m7vxAptT0Qfoe2BR1FAW+nMThFPRjTrU9yLNJXOHXLznVIf
         3qJlJZtV/jSQez8zEdVvU8FLKq+7RqmfTyStVUpH1Djt9POmYCI5Y9kqZoaYR0hgvmS9
         +rEuZpKPS6WUZjQemKGYzdac2wR+LAOsZL+Tjouczsts1AKYF7iZvUOL8X28VZAeJ3o4
         r+dw==
X-Gm-Message-State: APjAAAVxYcs+a/OPNr7PTfdnuHAs1hO3wG+eOkSzs25Q7YmdgyJhJ8+j
        o5K89i5jmFFNEeVxuugjjTeFEG99+dgcRuZPRkhOzdKqpL/j
X-Google-Smtp-Source: APXvYqx324ib1pU4r9irwayKJOfblhDSkACmPuLheadxHDJ3/934Bk8/0s2wIFbkvhgpGWnUhpc83GCO/s2Ut414yZgxr1V+W8Ix
MIME-Version: 1.0
X-Received: by 2002:a5e:d90c:: with SMTP id n12mr18996926iop.140.1572783060398;
 Sun, 03 Nov 2019 04:11:00 -0800 (PST)
Date:   Sun, 03 Nov 2019 04:11:00 -0800
In-Reply-To: <000000000000251bba05966d7473@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fb83d05967017a0@google.com>
Subject: Re: INFO: task hung in synchronize_rcu
From:   syzbot <syzbot+89a8060879fa0bd2db4f@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        junaids@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b34f5ce00000
start commit:   9d234505 Merge tag 'hwmon-for-v5.4-rc6' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16b34f5ce00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12b34f5ce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbbed3e8d4eb64bf
dashboard link: https://syzkaller.appspot.com/bug?extid=89a8060879fa0bd2db4f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13509b84e00000

Reported-by: syzbot+89a8060879fa0bd2db4f@syzkaller.appspotmail.com
Fixes: 9121923c457d ("kvm: Allocate memslots and buses before calling  
kvm_arch_init_vm")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
