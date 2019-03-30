Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513E5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 10:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21ABC218D3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 10:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfC3KdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 06:33:02 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:36573 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730537AbfC3KdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 06:33:01 -0400
Received: by mail-it1-f198.google.com with SMTP id l202so4767329ita.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 03:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CLEhrFzeXldrJLTtKqoJ5Vwt+ElN3iQheSQi0JPmlJk=;
        b=nfejn4KB0IymqKsGhV3ac6JqCZfrDLCDkTNL+/WZmQzxYIsHRCUC0tpiqDwNgcIzNv
         3iLjGTeBVXsCAj1YhDwpt3PIsaIEibB49evAtDUtpSV9ed1+/AB34axuQHq6431s2QK1
         V8D1dHjLeNy24qpUuZ5ooYOfu2RXqmyT62kCOSKOyPdrI2Mhb75yEwMZEko5BnxuBxud
         iaCgyZwv415z2djljtsKDlwbHXCByYmzOhYrhfAzQR6MkXNDY8pvw7XS8g5bx381Ayj9
         CSsf5A1LO55y7RgKMWHMVYkdZDk9gYfICAzczzz244kJGaw58wehzMuNJ7rBdV88jQRl
         qqEw==
X-Gm-Message-State: APjAAAWEbrWAAyBaBcl1KK6Ksdtk2J1P8C/5rQgm9dDUULFVIc1uG6LI
        qLFVR+s4Bqyos5JC8kFlIEmV0ZIB2OUBz/uo34KDq+VxaEZe
X-Google-Smtp-Source: APXvYqxKJdR2r0eDLki9V+vWdYnvHFtY8V1j3sdIT8XXATzd77h9tUTl6V0maAanHEUwWzZgtxU/6Wc6hP87Ele9KAP1eo6/GoA1
MIME-Version: 1.0
X-Received: by 2002:a24:3608:: with SMTP id l8mr3021352itl.35.1553941980955;
 Sat, 30 Mar 2019 03:33:00 -0700 (PDT)
Date:   Sat, 30 Mar 2019 03:33:00 -0700
In-Reply-To: <00000000000005dc880574b12567@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6c95105854d4f1d@google.com>
Subject: Re: WARNING in enter_vmx_operation
From:   syzbot <syzbot+ab5d7a5d0fc0c7518f6d@syzkaller.appspotmail.com>
To:     hpa@zytor.com, jmattson@google.com, karahmed@amazon.de,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 8fcc4b5923af5de58b80b53a069453b135693304
Author: Jim Mattson <jmattson@google.com>
Date:   Tue Jul 10 09:27:20 2018 +0000

     kvm: nVMX: Introduce KVM_CAP_NESTED_STATE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16dc157d200000
start commit:   3f16503b Merge branch 'fixes' of git://git.kernel.org/pub/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15dc157d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=11dc157d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=49927b422dcf0b29
dashboard link: https://syzkaller.appspot.com/bug?extid=ab5d7a5d0fc0c7518f6d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132365a6400000

Reported-by: syzbot+ab5d7a5d0fc0c7518f6d@syzkaller.appspotmail.com
Fixes: 8fcc4b5923af ("kvm: nVMX: Introduce KVM_CAP_NESTED_STATE")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
