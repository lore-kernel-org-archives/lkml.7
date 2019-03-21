Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EAAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B23218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfCULDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:03:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:46576 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCULDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:03:01 -0400
Received: by mail-io1-f71.google.com with SMTP id k5so4786955ioh.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 04:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=q8UvnubDxxO9DO3DUNagSYkEtxKWhDCDMXRcxz5CJ4A=;
        b=Ch8XmWM7IHaJe36/SdP8N4wuNo7dYJ8Rm0v3sogMg32x2a3keHmv0Z7rVGo1dcqy50
         K9usTCQDlRzOVnqoTnzc3GyT6R/A16iRlcu8rFXWgD5maP3OE/sqXFkRpkBn5sH+YFjo
         b6XT71o/DL8eG1o/K+Y7n68pShxX/vcmAAoknAqOyKGJgNfrAQh66fbweCvKPd3/sbtN
         9K+nqssYIDqh5Nao3H7XosrII4Eh5F15ZJmRPM+WX3cJf3s5iPiCBCmvxCJuQotn8LfO
         gshPanPgXgX7yFQsemulcxArofWBj90PpYu0lhEK7D1mBxlFzcEqW8kVFeNHT4bfvUST
         8FCQ==
X-Gm-Message-State: APjAAAU9270/cFRcSowE/dTWYV36KWFl6hjhEdcppATJPeOgn34SWj7d
        YFxv/jmhkAolqfSGLumnZMmbororwqkvmEmGYS2Pxt/+risP
X-Google-Smtp-Source: APXvYqyEEQWUTL5D4/OQUqKK4+4StL8K1CC9DU0SidR0VQ8DLj2FIZeNv9AZ86BVlDfp2v8yWcBE9NFlLm5kuLlBlqTCOpsYmPeZ
MIME-Version: 1.0
X-Received: by 2002:a02:ab90:: with SMTP id t16mr2049777jan.135.1553166180248;
 Thu, 21 Mar 2019 04:03:00 -0700 (PDT)
Date:   Thu, 21 Mar 2019 04:03:00 -0700
In-Reply-To: <000000000000ec1b3805799d0a56@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000737c07058498aea1@google.com>
Subject: Re: general protection fault in delayed_uprobe_remove
From:   syzbot <syzbot+eab6e18f95a9fe69005e@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        namhyung@kernel.org, oleg@redhat.com, peterz@infradead.org,
        ravi.bangoria@linux.ibm.com, rostedt@goodmis.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit a6ca88b241d5e929e6e60b12ad8cd288f0ffa256
Author: Song Liu <songliubraving@fb.com>
Date:   Tue Oct 2 05:36:36 2018 +0000

     trace_uprobe: support reference counter in fd-based uprobe

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c86993200000
start commit:   a6ca88b2 trace_uprobe: support reference counter in fd-bas..
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11c86993200000
console output: https://syzkaller.appspot.com/x/log.txt?x=16c86993200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a22859d870756c1
dashboard link: https://syzkaller.appspot.com/bug?extid=eab6e18f95a9fe69005e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137174f5400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1278485d400000

Reported-by: syzbot+eab6e18f95a9fe69005e@syzkaller.appspotmail.com
Fixes: a6ca88b241d5 ("trace_uprobe: support reference counter in fd-based  
uprobe")
