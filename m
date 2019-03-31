Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E798C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718F62183F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfCaJIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 05:08:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:38568 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfCaJIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 05:08:01 -0400
Received: by mail-io1-f69.google.com with SMTP id b16so5564069iot.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 02:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tx1OAzhjTHc3Nu1pcqSEtT3dtMgOaNwjkmTz7AZiiQ8=;
        b=YADe2JoeRbYTA9YdBxKZa4CAmJCGfZCDDRBHnwzKBSZlZTo8piWpYAX81gQAMPdGqt
         lXhxpMplnTF7hWp1FTkKB2WmfyeDJQnvc/lHs7sVPr8pyIaJpO1dMJU91dVHd0mQ/cyR
         +7J2NExNnqKDf34PnKEsO1PqNXy1a4GphGOip+xxxTe/2yg0cJbTkXBFjc/RMnTxWbFz
         mYP8/ufoY58qwQ9Y7JYQYLtrMhXyeTHuB/DxMTdROdaS4YNKtRRO2S2KNAyYZrIaWP4c
         boGNx29NyIPUXO79kEBXuDEHCUH+IA0RN6Xt+8ll8J/7om+kbyLse5yNgBez6/V/15kz
         1k1Q==
X-Gm-Message-State: APjAAAWMMbw5Dqwg6UpKecsvBpN3wJ8pq6em5uT7gE44v98uaRpW4h/B
        T4FUL1hDzsbB+ppE1twvIPsgm/J2p09onTNvw/C9Fb092PhV
X-Google-Smtp-Source: APXvYqzcK1GoqqsMk9UdERYYk2gzmbDzuRhAkLVJP90y42nMBZrg5Opb8lV+8rivpoo4uha/8BWviqeFEOqcpnux7Nszc9eHiFHd
MIME-Version: 1.0
X-Received: by 2002:a6b:c3c6:: with SMTP id t189mr8393694iof.0.1554023280762;
 Sun, 31 Mar 2019 02:08:00 -0700 (PDT)
Date:   Sun, 31 Mar 2019 02:08:00 -0700
In-Reply-To: <0000000000006af1a90573251240@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f67a70585603de2@google.com>
Subject: Re: general protection fault in kvm_lapic_hv_timer_in_use
From:   syzbot <syzbot+1c69d94fe42901b029c1@syzkaller.appspotmail.com>
To:     dvhart@infradead.org, hpa@zytor.com, jmattson@google.com,
        karahmed@amazon.de, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org, rkrcmar@redhat.com,
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127b4f43200000
start commit:   234b69e3 ocfs2: fix ocfs2 read block panic
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=117b4f43200000
console output: https://syzkaller.appspot.com/x/log.txt?x=167b4f43200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
dashboard link: https://syzkaller.appspot.com/bug?extid=1c69d94fe42901b029c1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e14956400000

Reported-by: syzbot+1c69d94fe42901b029c1@syzkaller.appspotmail.com
Fixes: 8fcc4b5923af ("kvm: nVMX: Introduce KVM_CAP_NESTED_STATE")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
