Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE90C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3307214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfCLIio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:38:44 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43246 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727173AbfCLIio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:38:44 -0400
Received: from mr5.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2C8cgkT004641
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:38:43 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2C8cbs6009693
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:38:42 -0400
Received: by mail-qk1-f199.google.com with SMTP id k21so1538646qkg.19
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=TgeF4oqRcod2YQ+Xa8OCJDubj36yvrlMOMplLOknM2s=;
        b=EdlJr4FnPFcCM3QR0lGvoh8ZNkWzkAOqxUfN1aGZDkHGJ6r5sSl6vXfVjoGynw3v/l
         qcapHpc1l76sl+Qyu3dULSZLDX8bTRBJpVvQ7jChl+1ilEiU3CyKS5L/N/MqBplyZzuZ
         ODBqT5rlLamFJyMz0lq+Lu6VdHnUcrfqxNjw9Mxb37rX0HDK/vaMas4GA/2sU+IdRjVw
         yndsZND6tg2xn6OD1BrB125UCMPlLzROMPiQZeIbwNUhdzUtKb7/Ud/F2ft0qfCTvwHi
         Hk7ayLHLI7f8kqw29KUq5tKt4emcK7HEzuECelLfwsjlCtCU0ObJ+5+pRKNv9INZtrze
         kPtA==
X-Gm-Message-State: APjAAAW4dRS1sgwdOoa4RNMu0TzU9zH4oY+zWgNuVGCy676MWjkIWYNS
        FWk2YDR/DGbksZ0Q6rYbxqSbqq8WIhQ9QdX2MtVr+5SkYb3yaBIml65Oo1r0/RmEdEX7XUig5lP
        uSjZOKSQZo1thgnO3yPrOnQUzpw8BwNKEdCA=
X-Received: by 2002:a05:620a:5e:: with SMTP id t30mr11076723qkt.193.1552379917778;
        Tue, 12 Mar 2019 01:38:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxldC1awGOjfVO10DtSx7g/9Jtp51IBAClBDuV08bNDhy1evHI4qZCcV7LSNkNsLeyPBlB5Lg==
X-Received: by 2002:a05:620a:5e:: with SMTP id t30mr11076715qkt.193.1552379917543;
        Tue, 12 Mar 2019 01:38:37 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::3b7])
        by smtp.gmail.com with ESMTPSA id p64sm4456232qkc.62.2019.03.12.01.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 01:38:36 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/time/jiffies.c - make variable static
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 12 Mar 2019 04:38:35 -0400
Message-ID: <32342.1552379915@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse complains:

  CHECK   kernel/time/jiffies.c
kernel/time/jiffies.c:92:20: warning: symbol 'refined_jiffies' was not declared. Should it be static?

__clocksource_register() is passed a pointer, and nothing else refers to it. Make it static.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index dc1b6f1929f9..ac9c03dd6c7d 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -89,7 +89,7 @@ struct clocksource * __init __weak clocksource_default_clock(void)
 	return &clocksource_jiffies;
 }
 
-struct clocksource refined_jiffies;
+static struct clocksource refined_jiffies;
 
 int register_refined_jiffies(long cycles_per_second)
 {

