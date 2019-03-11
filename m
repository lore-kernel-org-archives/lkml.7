Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8A0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64768206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfCKN1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:27:05 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:33378 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbfCKN1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:27:02 -0400
Received: by mail-it1-f200.google.com with SMTP id a184so10591764itc.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QAEjwvSNvsXwz45SILwUA8McNEDI3b4+T32qJSZo6t4=;
        b=t4me7qguZakDxB17J1xBaagNUhqwOiixdH4QyRgGAfVfM1Fxps9Z/f/eelJSBkalVV
         02PmDwfTYaHD/r7+U3TcvlkgcAj3w77VXRKvJv8yCZOdxz1LEexGTHqvfDOTP7GyvsFP
         Hzs85DjZu0t1DdpCDlA7AuNEBgPgklUoXCYkMMmCsBnZRS7ZYsE5mLzEzM4i2eNbVscX
         EgKSeTnLJ3PHTSxjR7DbWxaM50kQb6jHmKXPySEfo1D46h4q+JylS11IpkkNF2XB42U0
         hZNugbVtqAEIQAi5lvGmMKEK08S23sNlrTq0VxRuWzOCcDualtVsYvcyArXRo7vT94rf
         KUYg==
X-Gm-Message-State: APjAAAWL4VoaQEIWpZ9Iu+1XQ92ZKGSC6kxsAwosviu+ux4xa3F9jtxN
        WVzRiWN/LzO2m17IiCLnnN+dtdrtswXliw4Z3KDXjWSA5B5m
X-Google-Smtp-Source: APXvYqySJ2vUY9fsO3cpV423PaaforTMa/MhVNeJG/6k/Mehz4ytFL30QprT3/2nEYuuRnY+25kK/3QnHiVgeUjvrLEpB8eq9OcF
MIME-Version: 1.0
X-Received: by 2002:a24:560e:: with SMTP id o14mr20518636itb.15.1552310821794;
 Mon, 11 Mar 2019 06:27:01 -0700 (PDT)
Date:   Mon, 11 Mar 2019 06:27:01 -0700
In-Reply-To: <00000000000086d87305801011c4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d3a060583d187dd@google.com>
Subject: Re: general protection fault in __bfs (2)
From:   syzbot <syzbot+c58fa3b1231d2ea0c4d3@syzkaller.appspotmail.com>
To:     andy.shevchenko@gmail.com, bgolaszewski@baylibre.com, bp@alien8.de,
        davem@davemloft.net, douly.fnst@cn.fujitsu.com, hpa@zytor.com,
        jon.maloy@ericsson.com, konrad.wilk@oracle.com,
        len.brown@intel.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org, puwen@hygon.cn,
        rppt@linux.vnet.ibm.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, tipc-discussion@lists.sourceforge.net,
        x86@kernel.org, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 2646b90de5c3492db2ead71337fd4c7d7f549ebe
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Fri Oct 26 08:41:22 2018 +0000

     gpio: Add global TODO file for GPIO

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12589f8d200000
start commit:   2646b90d gpio: Add global TODO file for GPIO
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11589f8d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=16589f8d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f00801d7b7c4fe6
dashboard link: https://syzkaller.appspot.com/bug?extid=c58fa3b1231d2ea0c4d3
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bab650c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a331df400000

Reported-by: syzbot+c58fa3b1231d2ea0c4d3@syzkaller.appspotmail.com
Fixes: 2646b90d ("gpio: Add global TODO file for GPIO")
