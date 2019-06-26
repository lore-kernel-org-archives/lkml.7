Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5805C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A31E2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfFZXzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:55:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:44911 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfFZXzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 19:55:01 -0400
Received: by mail-io1-f72.google.com with SMTP id i133so439353ioa.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 16:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=c5MKxKpL1LGme09OnNwDQjsqqlS3JWAbrh2sxWujAk8=;
        b=ViYPzYvMH2k8QQmawbU90rQRJ2sIyhtstVsaEW6S1OOU1T/gslHQdqFe+o7Yj7nuzG
         2lxqJ/NdAbnUc3qhY0q1KXK0KQflQIbxndTAQ33ML9ezcsTRYnh7oz1FFREfpcOiFm0c
         iO2pLDpmN2xZ5zldJoGNjfRCohpWWt5Anu0t0Rf2wn4AN7TN7XNJLt8hPm+wcWIUQbEA
         pUQc1NeDJg998jPzcci2Vc0t4hlN6cUNKQkwyZybCO+3vVRsmV4nOQwaMzeW7/Fxpp65
         tstFEMIKfeKtuld2R37RlGsbY+8ZNbQlW7OhDsPiFkXcq1azGnwpgU8srmzsAb2FuS6E
         dwKA==
X-Gm-Message-State: APjAAAXYZxxILh1jYCmiybdQK91KpCN/V+phbXIDx5d36zNp+rOiSuwm
        iDOxzTKZhBXVC93piCy1kg7vm5wlvpLWv4cm/P+lPxGy3d4T
X-Google-Smtp-Source: APXvYqw0rSeais3gd71d3pKztVwreFghQwPf0ciLriAei8/ydZP7gcjOnDii1dtoOGd1VNJ94dAGeH2zX3nwhBEDVLqHtbiTYrsV
MIME-Version: 1.0
X-Received: by 2002:a5d:885a:: with SMTP id t26mr1029660ios.218.1561593301141;
 Wed, 26 Jun 2019 16:55:01 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:55:01 -0700
In-Reply-To: <000000000000f4f847058c387616@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff8f15058c42c5fa@google.com>
Subject: Re: KASAN: use-after-free Read in corrupted (3)
From:   syzbot <syzbot+8a821b383523654227bf@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, akpm@linux-foundation.org, ast@kernel.org,
        christian@brauner.io, daniel@iogearbox.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, john.fastabend@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, netdev@vger.kernel.org, peterz@infradead.org,
        riel@surriel.com, syzkaller-bugs@googlegroups.com, wad@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e9db4ef6bf4ca9894bb324c76e01b8f1a16b2650
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Sat Jun 30 13:17:47 2018 +0000

     bpf: sockhash fix omitted bucket lock in sock_close

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11bb4e3da00000
start commit:   045df37e Merge branch 'cxgb4-Reference-count-MPS-TCAM-entr..
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13bb4e3da00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15bb4e3da00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd16b8dc9d0d210c
dashboard link: https://syzkaller.appspot.com/bug?extid=8a821b383523654227bf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1389f5b5a00000

Reported-by: syzbot+8a821b383523654227bf@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
