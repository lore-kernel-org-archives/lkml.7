Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9989DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733D92070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbfCZRoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:44:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42883 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCZRoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:44:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id cv12so1980124plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xfE1mWZMTe2MUt3HB3oB5dCMGPVrq+8RT1AI4bTQq1I=;
        b=S3K4jdwTDJzeyzVgot0AoWXnLOJG3VrE+Rdlt18DixI87Cv6AswskOqAJ1PkuwT8cW
         kffC1ieqKuDe8DGF4CTtcYHKzV48d48XRxl2wg3H2sHYWalYqnP+BcCX6WOnfserXGAH
         sgCh2ZSP32r5w2OXBwYDr6IGC+gGlbc0v6/Ot726VSPHBafn7PXZID3cJGR24XeJq26w
         2uUSFOLQOZv7T31sNlhUzwIqw2GUOl/OHpK6GkFopOixxVYru9g79jQ00wAa/jxQtQr3
         +C+oy4cDLlVz2HHjCBhYeO093exAFSEv2w5oto8shw9jh5b1inQrap72GG86g43DLixb
         qczg==
X-Gm-Message-State: APjAAAXdb17a/PntE1Sf0WhqD+40lENn0KdeiYJIc+P7I/tP7d5l46A6
        Jb5fZrqDNipQvzbQDHNsP3o=
X-Google-Smtp-Source: APXvYqxVk7UONmgup1r7TdgfAQY3R6JUUg0cDW+m6TWZ04KcPSdhDkkDEv64P2m5u/W+tC0y0jZuXA==
X-Received: by 2002:a17:902:9043:: with SMTP id w3mr32126550plz.101.1553622258052;
        Tue, 26 Mar 2019 10:44:18 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z189sm27904596pfb.146.2019.03.26.10.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 10:44:16 -0700 (PDT)
Message-ID: <1553622255.118779.69.camel@acm.org>
Subject: Re: "cat /proc/lockdep" after "rmmod <some module>" when
 !debug_locks will crash the system
From:   Bart Van Assche <bvanassche@acm.org>
To:     shenghui <shhuiw@foxmail.com>, peterz@infradead.org,
        mingo@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org
Date:   Tue, 26 Mar 2019 10:44:15 -0700
In-Reply-To: <5c9973cc.1c69fb81.371e8.7b9fSMTPIN_ADDED_BROKEN@mx.google.com>
References: <5c98a345.1c69fb81.21300.0be5SMTPIN_ADDED_BROKEN@mx.google.com>
         <1553527621.118779.2.camel@acm.org>
         <5c9973cc.1c69fb81.371e8.7b9fSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-26 at 08:35 +-0800, shenghui wrote:
+AD4 My test steps:
+AD4 --------------
+AD4 1) bootup the system, and check the calltrace in dmesg. Just warning and ignore it.
+AD4 2) cat /proc/lockdep   +ACM everything is well
+AD4 3) rmmod some module which provides lock+AF8-class in lockdep
+AD4    In my system, module bcache is used:  ('grep bcache /proc/lockdep' prints something)
+AD4         +ACo stop bcache set
+AD4         +ACo rmmod bcache
+AD4    I have tried other module, e.g: rmmod iwldvm
+AD4 4) cat /proc/lockdep   +ACM system crash

Hi shenghui,

Thank you for having shared your test steps. I ran a slightly different test
myself:

while true+ADs do cat /proc/lockdep +AD4-/dev/null+ADs done +ACY
(cd blktests +ACYAJg while ./check -q+ADs do :+ADs done)

This test reads /proc/lockdep in a loop while running a test that stresses
lockdep and also that loads and unloads kernel modules. Since this test
passed on my setup I suggest that you have a close look at your setup. The
vboxdrv kernel driver or an out-of-tree patch may be what is making your
system unstable.

Bart.
