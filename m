Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2576C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D9E2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbfCZRtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:49:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39629 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729800AbfCZRtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:49:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so4902616pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I/36I/sBQSfYQ3lZtoywK5bOl82kCXYlGgatLfZ9xzg=;
        b=iSy7nzEh3lqQcXwwqW2Vcngy56dgB6cZpNyD2jBEB8YU/XVF710qF74DKOJLjm8uRp
         sTMkZ2WW8FUsGlU1/jN/67BDlAdzXvjYQTfez1T8OTUAuWxKf7WBnUGwM7OITeOjpp6I
         k3e1Mwt7d6apQD4lnB/kH7whLxdq5MsVyh9sX1z5+Rn0sd3RO9XVhwEg1pgkF+XE2NrL
         yrQ6tEJ4P+45wh3wO7anPer1Uw7uNhaWh07DeoYDbNtV3CRb/K7J2ua5Ji/DjCLlD0C9
         wCG1PqxuKw2KywGyLmefqlr+vAI3OmyHIwcW8sjHfwRR/4jeLqlch2cKnEDRT8xwer5n
         3rmQ==
X-Gm-Message-State: APjAAAXvTJkT+ktQ7pX+N0HxUXujf+xVAlqHZTXFh/2R8LrI2/KhWkIB
        L/ZlZWFh36FFLs9+sO4FVM4=
X-Google-Smtp-Source: APXvYqw3TSdk1SBNbmrvNRFNJ2qRcNra2auhH0d+jVTnmzIzhPu5lcEka/XWAXijuXb7uEgWSBdkcg==
X-Received: by 2002:a63:5b64:: with SMTP id l36mr30776381pgm.182.1553622543681;
        Tue, 26 Mar 2019 10:49:03 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id b26sm22922766pgn.4.2019.03.26.10.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 10:49:03 -0700 (PDT)
Message-ID: <1553622542.118779.71.camel@acm.org>
Subject: Re: "cat /proc/lockdep" after "rmmod <some module>" when
 !debug_locks will crash the system
From:   Bart Van Assche <bvanassche@acm.org>
To:     shenghui <shhuiw@foxmail.com>, peterz@infradead.org,
        mingo@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org
Date:   Tue, 26 Mar 2019 10:49:02 -0700
In-Reply-To: <1553622255.118779.69.camel@acm.org>
References: <5c98a345.1c69fb81.21300.0be5SMTPIN_ADDED_BROKEN@mx.google.com>
         <1553527621.118779.2.camel@acm.org>
         <5c9973cc.1c69fb81.371e8.7b9fSMTPIN_ADDED_BROKEN@mx.google.com>
         <1553622255.118779.69.camel@acm.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-26 at 10:44 -0700, Bart Van Assche wrote:
+AD4 On Tue, 2019-03-26 at 08:35 +-0800, shenghui wrote:
+AD4 +AD4 My test steps:
+AD4 +AD4 --------------
+AD4 +AD4 1) bootup the system, and check the calltrace in dmesg. Just warning and ignore it.
+AD4 +AD4 2) cat /proc/lockdep   +ACM everything is well
+AD4 +AD4 3) rmmod some module which provides lock+AF8-class in lockdep
+AD4 +AD4    In my system, module bcache is used:  ('grep bcache /proc/lockdep' prints something)
+AD4 +AD4         +ACo stop bcache set
+AD4 +AD4         +ACo rmmod bcache
+AD4 +AD4    I have tried other module, e.g: rmmod iwldvm
+AD4 +AD4 4) cat /proc/lockdep   +ACM system crash
+AD4 
+AD4 Hi shenghui,
+AD4 
+AD4 Thank you for having shared your test steps. I ran a slightly different test
+AD4 myself:
+AD4 
+AD4 while true+ADs do cat /proc/lockdep +AD4-/dev/null+ADs done +ACY
+AD4 (cd blktests +ACYAJg while ./check -q+ADs do :+ADs done)

It seems like I hit +ACI-send+ACI too quickly. That test just triggered the following:

BUG: unable to handle kernel paging request at fffffbfff40ca448
+ACM-PF error: +AFs-normal kernel read fault+AF0
PGD 13bfde067 P4D 13bfde067 PUD 13bf7a067 PMD 1167d3067 PTE 0
Oops: 0000 +AFsAIw-1+AF0 PREEMPT SMP KASAN
CPU: 4 PID: 4529 Comm: cat Tainted: G    B   W  O      5.1.0-rc1-dbg+- +ACM-4
Hardware name: QEMU Standard PC (i440FX +- PIIX, 1996), BIOS 1.10.2-1 04/01/2014
RIP: 0010:+AF8AXw-asan+AF8-load1+-0x28/0x50
Call Trace:
 string+-0xac/0x180
 vsnprintf+-0x23e/0x820
 seq+AF8-vprintf+-0x82/0xc0
 seq+AF8-printf+-0x92/0xb0
 print+AF8-name+-0x34/0xb0
 l+AF8-show+-0x184/0x200
 seq+AF8-read+-0x59e/0x6c0
 proc+AF8-reg+AF8-read+-0x11f/0x170
 +AF8AXw-vfs+AF8-read+-0x4d/0x90
 vfs+AF8-read+-0xc5/0x1f0
 ksys+AF8-read+-0xab/0x130
 +AF8AXw-x64+AF8-sys+AF8-read+-0x43/0x50
 do+AF8-syscall+AF8-64+-0x71/0x210
 entry+AF8-SYSCALL+AF8-64+AF8-after+AF8-hwframe+-0x49/0xbe

I will have a closer look at this.

Bart.
