Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681ECC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E37320856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbfCZFoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 01:44:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:50725 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfCZFoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 01:44:02 -0400
Received: by mail-io1-f69.google.com with SMTP id s24so9458249ioe.17
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 22:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1TkUpKsmlvatpbMPOJZlrVefntTX85Tjiz7qOFvWkTo=;
        b=sqHgHBcrWqoAzm71fRVhQTa7pYmwxwDXOcBEJFC+LqDI3aOjJOE9TA7DUYPUHN8oBb
         jQYIS5eC2+2SklBtryXL5zbHKJZNbhYwb6ki5mPxHoiAllpv8xk7UxIhMJ6CkK/kP/H8
         O1PZ+G+vcB39UKsIhkIveiVvwHCNZIR/PcZqykKFoPsKDVPcHdy+nTfyBiBSGESta6Fz
         lEbpqROZyOnevl4Clg/RMLMmqxpAue6a8CXOslaDCDUdJ3354hJTrMpn4mj19eYDPtQb
         2DQmJKCxttHSSxEV71PJ+mfP8Vajzh63/ANolPmJFY2fgMYNEdllo6L3DTfLoWvd0CkZ
         N/vQ==
X-Gm-Message-State: APjAAAV4h4DD/MrOYwzTAT5wLmC49vM359/KGubdpFHbQIxRg005DYQQ
        1l3JFVxuXZ6+HR9S8y1Qoveyndmco8+33RwsHWx3Wyqa8Syc
X-Google-Smtp-Source: APXvYqxGeQOIrT4dU49V/kZkgjboGzDUBvXSkPEKOjC+PMn9Q5Gck9hNeZJObC6GUP4HWmj2WnITCWJKCpJ5dQl81ipDBQ4tMqvP
MIME-Version: 1.0
X-Received: by 2002:a05:660c:381:: with SMTP id x1mr2340628itj.78.1553579041447;
 Mon, 25 Mar 2019 22:44:01 -0700 (PDT)
Date:   Mon, 25 Mar 2019 22:44:01 -0700
In-Reply-To: <000000000000b99324057af4dabb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e567590584f8cec6@google.com>
Subject: Re: BUG: unable to handle kernel paging request in bpf_prog_kallsyms_find
From:   syzbot <syzbot+66d6b1d3055f1d9ee4f3@syzkaller.appspotmail.com>
To:     ast@fb.com, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit f4d7e40a5b7157e1329c3c5b10f60d8289fc2941
Author: Alexei Starovoitov <ast@fb.com>
Date:   Fri Dec 15 01:55:06 2017 +0000

     bpf: introduce function calls (verification)

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b5a0cd200000
start commit:   592ee43f bpf: fix null pointer dereference on pointer offl..
git tree:       bpf-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1475a0cd200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1075a0cd200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e5cbc38ae27657e
dashboard link: https://syzkaller.appspot.com/bug?extid=66d6b1d3055f1d9ee4f3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e4ec25400000

Reported-by: syzbot+66d6b1d3055f1d9ee4f3@syzkaller.appspotmail.com
Fixes: f4d7e40a5b71 ("bpf: introduce function calls (verification)")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
