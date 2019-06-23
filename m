Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1ABC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 09:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189AE20679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 09:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfFWJrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 05:47:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:35467 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfFWJrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 05:47:01 -0400
Received: by mail-io1-f70.google.com with SMTP id w17so17796654iom.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 02:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=//qCEHHwsKmQKJGq2sElU6h7rWpgyd394JCVN/Ky63Y=;
        b=KALjCk6FMbinth1gt0762WcnliBYQDkzxgKO4CO6g705kIh+i9bfPIFnzz+F7GVyEv
         Iyrer8j6oMe2KS1Ft05H1cMzW3iO4KRQdP2n3dqkrywLE9Xr2W/gy5YjDVc74n2a8S4C
         278XX0aTkKnWtsPqiniYYPOVXG4+BMUZgxypNn9YI6ErzWQnE8CCs7V73yE7wSvccdII
         44yxpGjIR+DubdqTSLgTEL2xhDOJU9rwLBxu8OJrvpTNPk/KvCCbexXjmYsSTGeZQoDa
         LCPX/QcVp7gEy2HM8NfnpsxbX+XY4LH27/43t/B4riMCAjSGHLo5yOuLufBtfyqfdxS1
         0gPQ==
X-Gm-Message-State: APjAAAW1/kmf6qqC1o5RCiDhIbF3cJ6zrtP3ty/AwNWJJl1/o8FDQDQ2
        PHoe6pkc7r+MBgby2JH5T9vFZ56FTl1NxKpEdfv0in5at1OJ
X-Google-Smtp-Source: APXvYqyGiLQ70dP6eFGnQ63Jed2MzJ0lmOsmDLwDerlbWSICxM7PikGk1Wtt/hUYnDo1CxkwarJk5FqD8R5xYTNQF8/oFlSwbHR+
MIME-Version: 1.0
X-Received: by 2002:a6b:6a01:: with SMTP id x1mr26057928iog.77.1561283220587;
 Sun, 23 Jun 2019 02:47:00 -0700 (PDT)
Date:   Sun, 23 Jun 2019 02:47:00 -0700
In-Reply-To: <00000000000090ae7a058bc12946@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1cb06058bfa9371@google.com>
Subject: Re: WARNING in debug_check_no_obj_freed
From:   syzbot <syzbot+b972214bb803a343f4fe@syzkaller.appspotmail.com>
To:     alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        andriy.shevchenko@linux.intel.com, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        dmitry.torokhov@gmail.com, f.fainelli@gmail.com,
        idosch@mellanox.com, jeffrey.t.kirsher@intel.com,
        jiri@mellanox.com, kafai@fb.com, kgraul@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tyhicks@canonical.com,
        ubraun@linux.ibm.com, wanghai26@huawei.com, yhs@fb.com,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 99182beed858a1bde22f60046602b9b223225f73
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Tue Apr 2 21:17:19 2019 +0000

     Merge branch 'bpf-selftest-clang-fixes'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12faf81aa00000
start commit:   bed3c0d8 Merge tag 'for-5.2-rc5-tag' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11faf81aa00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16faf81aa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ec3437a5394ee0
dashboard link: https://syzkaller.appspot.com/bug?extid=b972214bb803a343f4fe
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fcf0b2a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a22ad6a00000

Reported-by: syzbot+b972214bb803a343f4fe@syzkaller.appspotmail.com
Fixes: 99182beed858 ("Merge branch 'bpf-selftest-clang-fixes'")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
