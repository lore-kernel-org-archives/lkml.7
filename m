Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BD0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202A32171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfCLJd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:33:57 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:41772 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725767AbfCLJd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:33:56 -0400
Received: from mr5.cc.vt.edu (mr5.cc.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2C9Xt5I022678
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 05:33:55 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2C9XoOp026786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 05:33:55 -0400
Received: by mail-qt1-f199.google.com with SMTP id p40so1673626qtb.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=h2EUzRKNymAFYxMREUJkDmvCMy9QcNtYShMutgbFPqg=;
        b=cMG/pCAMwRO9lzPaKEEu/OP9cVxhsgYlLNjnG5TpkQwDanNkNCALOu558sB8DlYnKH
         hDMQKM2C92fsMxIQQPC+VaaFtrU/zc67fHQsmltcCaw6WKTIamXuHs+PvZr9WuO8rXrf
         /CFRuZglrw3CJJf9rzgwJYJrmOHXxUdt/tXsbGdg/OzKBtN49+JcC8f0Eja164imW+iO
         y/xR0SP1rtOmjbPLPlSRo2nl/LlxU1q2bWjLdwleyECWYLOx+Od9lIDLExRfYX3Gg6xW
         dc/U+yaCZUhfzGI7VQwm/2Iqh1zILdjtcdOzMtgFnMbLUjTzIcVeT2iECYjvoWmmlXE6
         gFmQ==
X-Gm-Message-State: APjAAAXfpotUl0eF8kiO3lTDOUixQTejjDG/bz7nOBQjvIBHNgwTNVbY
        xvra2v/dFVXEAugoqoiqn5W0eY8/f3x75vY6wmb+ftcnaP/L6zfvGus616Bvu7fYJ4sn6jUojzW
        TnE+dLXPVBzaBqKpmnhsEQ+dd9C0+uxkYpHM=
X-Received: by 2002:ae9:f809:: with SMTP id x9mr27937903qkh.84.1552383230533;
        Tue, 12 Mar 2019 02:33:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqygFHsD6RUqc7DNxwphlmq+omH2/x8pHh2K193LnLWG7H3nNArCqwZCpnrGekc3CpYpohLrmQ==
X-Received: by 2002:ae9:f809:: with SMTP id x9mr27937893qkh.84.1552383230292;
        Tue, 12 Mar 2019 02:33:50 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::3b7])
        by smtp.gmail.com with ESMTPSA id o71sm1734575qka.18.2019.03.12.02.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 02:33:49 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/watchdog.c - make variables static
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 12 Mar 2019 05:33:48 -0400
Message-ID: <7855.1552383228@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse complains:
  CHECK   kernel/watchdog.c
kernel/watchdog.c:45:19: warning: symbol 'nmi_watchdog_available' was not declared. Should it be static?
kernel/watchdog.c:47:16: warning: symbol 'watchdog_allowed_mask' was not declared. Should it be static?

They're not referenced by name from anyplace else, make them static.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 8fbfda94a67b..403c9bd90413 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -42,9 +42,9 @@ int __read_mostly watchdog_user_enabled = 1;
 int __read_mostly nmi_watchdog_user_enabled = NMI_WATCHDOG_DEFAULT;
 int __read_mostly soft_watchdog_user_enabled = 1;
 int __read_mostly watchdog_thresh = 10;
-int __read_mostly nmi_watchdog_available;
+static int __read_mostly nmi_watchdog_available;
 
-struct cpumask watchdog_allowed_mask __read_mostly;
+static struct cpumask watchdog_allowed_mask __read_mostly;
 
 struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);

