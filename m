Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66579C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A52920883
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCLL0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:26:19 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:53456 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726504AbfCLL0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:26:15 -0400
Received: from mr4.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2CBQEv4013449
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:26:14 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2CBQ9NS013645
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:26:14 -0400
Received: by mail-qk1-f197.google.com with SMTP id f70so1835294qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=TpQefdt0lzXk2W48fTvI4qjBnypEJQTELJXvmGPo0hA=;
        b=gpkvKkbocwfs67QL1KJbYnh1jviM/oSC8x1XEZoem9fknZ35AGHS0LsUdVshmcVjeA
         xYzMamIrahaEzPJmFj4B5mC60U/3SmJ2KOArbEbYL2qO8Z+VGMDtUMO7t6flHJ9pO12e
         4qL0nogkYehT0e63rHZArKTc5BYEm1nTIhjyd/UIZLA4Bp0S04pMJ1YdyHMl7pMnBDGE
         prXq+TE5iyrsKvDnt/1doouaDUwrj7kBC8W8Gos8lRiAMu5Q1Q8rDr1t0QlgbeHA5nS+
         5Mue59f9PEIVrT0R0Z8adbMT49jl3YNseyQfFrbL1Xpovs+bXodf3Fcn2yRC4biU2KjW
         wI6A==
X-Gm-Message-State: APjAAAWVj59OSLOpehOP2vVE/cjSexNJSuHr55JSlOMD9cex2HqRQWaR
        uQzjH1td2nATyx3FA+cFwKy6gjNSsNfMIOrQAjrSa1BfqMDX6wJao9YNIjfAQIfGPPL6V0wLfQD
        OKE62rFtZZz+P8/gy921VdX5SRg67u3iMdXs=
X-Received: by 2002:aed:3988:: with SMTP id m8mr30088822qte.177.1552389969177;
        Tue, 12 Mar 2019 04:26:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwHzJGfVKGRIM4BKeM6MPwGfgyGUpUwlKHq0at22SsHalDBFlJ7gMCPHeG7QQTqPMS4bi8xZw==
X-Received: by 2002:aed:3988:: with SMTP id m8mr30088799qte.177.1552389968789;
        Tue, 12 Mar 2019 04:26:08 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::3b7])
        by smtp.gmail.com with ESMTPSA id h8sm5661119qtc.29.2019.03.12.04.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 04:26:07 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     pali.rohar@gmail.com, Darren Hart <dvhart@infradead.org>
cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/platform/x86/dell-rbtn.c - add missing #include
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 12 Mar 2019 07:26:06 -0400
Message-ID: <17631.1552389966@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with W=1 complains:
  CC [M]  drivers/platform/x86/dell-rbtn.o
drivers/platform/x86/dell-rbtn.c:345:5: warning: no previous prototype for 'dell_rbtn_notifier_register' [-Wmissing-prototypes]
  345 | int dell_rbtn_notifier_register(struct notifier_block *nb)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/platform/x86/dell-rbtn.c:371:5: warning: no previous prototype for 'dell_rbtn_notifier_unregister' [-Wmissing-prototypes]
  371 | int dell_rbtn_notifier_unregister(struct notifier_block *nb)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
The real problem is a missing include. Add it to keep dell-rbtn.c and .h in sync

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/drivers/platform/x86/dell-rbtn.c b/drivers/platform/x86/dell-rbtn.c
index f3afe778001e..d50ca96d99f0 100644
--- a/drivers/platform/x86/dell-rbtn.c
+++ b/drivers/platform/x86/dell-rbtn.c
@@ -17,6 +17,7 @@
 #include <linux/acpi.h>
 #include <linux/rfkill.h>
 #include <linux/input.h>
+#include "dell-rbtn.h"
 
 enum rbtn_type {
 	RBTN_UNKNOWN,

