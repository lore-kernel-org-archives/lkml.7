Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060A6C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 15:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77E2205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 15:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKWP3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 10:29:03 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:46457 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfKWP3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 10:29:02 -0500
Received: by mail-il1-f200.google.com with SMTP id i74so9306658ild.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 07:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=iWEwDEb/a+W0LwDErZeV1TWmaFzTm+B32y2sBPFqXpk=;
        b=lm/YR/+Zw86wmeVK20HKEsQnyxHnOgMaUPzj5uqad1j02zYgERT7Ox2UQulFGPhANU
         nyb7bCJlJ33fyoyf3v6XCFdC2rrCekx5N8xPcUKm8Vf/OwB1VwVkSdYv+jZEdHFY2Xs2
         KbUoEaZm8kX1fH+9F3RFuY0Ur6Zthj2/8ti0URAxxa5XfSsGD25yx7cjibG8kOCj/GPN
         a+7Vh66WaIRLC6FFHxiNAR5RHWIc5PAf5vDhsJNb8hqlDJG9ZvtcEOKKsUFgnZNIKoZZ
         yK37wiwbds8IjHawH4VpjMdwxZy/1tTWrDj6GMoFqFur7Au6unT1VmP5P23Nxk0WKl2p
         /GgA==
X-Gm-Message-State: APjAAAVYylPE/jWsk6vRW7IeNdyjfxeXY4rYE2/BOSjLXNVETM6PdJAv
        GZxJcKYien6VzIVnMGoIyv8xV1SF35X9IwQEcITtl2nn9ea+
X-Google-Smtp-Source: APXvYqzR7IZ3ZU8hAUSstgRytaL4XuHPpFM7jal23gEyT0xSvDbcd0YQn0CiO0dsSMXH+yS4xQX/b0XtFOETy+C64+sWmMQUxIiu
MIME-Version: 1.0
X-Received: by 2002:a92:868f:: with SMTP id l15mr23646952ilh.199.1574522940544;
 Sat, 23 Nov 2019 07:29:00 -0800 (PST)
Date:   Sat, 23 Nov 2019 07:29:00 -0800
In-Reply-To: <00000000000009f9a305708faf46@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008fdf12059805304e@google.com>
Subject: Re: WARNING in cgroup_apply_control_enable
From:   syzbot <syzbot+5493b2a54d31d6aea629@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, davem@davemloft.net, guro@fb.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        lizefan@huawei.com, lizf@cn.fujitsu.com, menage@google.com,
        mingo@redhat.com, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 0d5936344f30aba0f6ddb92b030cb6a05168efe6
Author: Tejun Heo <tj@kernel.org>
Date:   Mon Sep 25 16:00:19 2017 +0000

     sched: Implement interface for cgroup unified hierarchy

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16142bd2e00000
start commit:   3a272031 Merge tag 'libnvdimm-fixes-4.19-rc8' of git://git..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15142bd2e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11142bd2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=5493b2a54d31d6aea629
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c890f6400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a94dd6400000

Reported-by: syzbot+5493b2a54d31d6aea629@syzkaller.appspotmail.com
Fixes: 0d5936344f30 ("sched: Implement interface for cgroup unified  
hierarchy")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
