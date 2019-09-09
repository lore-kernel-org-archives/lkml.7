Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C59C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAE42086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiV0R0l7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbfIIOTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:19:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41584 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfIIOTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:19:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so9230666pfo.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d/AHpfqgPLf1YWnb3Rp5h86h74k5SWCtkf5nB4QsU3Q=;
        b=HiV0R0l7MX5KSirnc6nhAmvFvFG5jCcU9gkGxXQndKyFMXR+OVDg2n7PYt+54rW1Hi
         kB+qvkohDcASccOI6KwQUzkhJTbiH1jH2A/nwR5Mvy+JK4ZBdJ/xomZpPwG0tAb6rnWw
         P4ko5SuWy2yG7wcMke2A1wmI6tzNzouWURyi9SZoSeqHNRrkYWOgLiNp1ZPlytDvFBYz
         cj+0DsXZNtGcBrLvGIquFRuEch93hGXyXYQRwfBcp7PU0E9FBUVCz1+Q7Lfyl+xgMlTm
         8CnnbJGbkbVbHHnUCDjGftHCuLgql8fShnV8XFHFIM+x70zyOI/8vMV4bip2A0r7v9Rd
         exDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d/AHpfqgPLf1YWnb3Rp5h86h74k5SWCtkf5nB4QsU3Q=;
        b=UFatXCiFamENILTYA58e1ZMFMPDX9vB5kPMiEGZpo/UrCbO+VyrY0IqPiwdbdFlXG8
         FAxYxrnN4ns0xJ0GxsTPKXvss1vSBerEzf3ZjISUJUgOYxveuOtDQSYaeBvJR6vjh65K
         HmgE0e1X2cirAU/jJxQhEdvQJT0shJmzCPbJ+hLTlZDPQM5jQMuo/D8vrrkSzSvZG4WC
         QrMFedUPuUHRAJxQWDlZvlQpc8eIgeUlLBmZX+FwIvTsgErf9GAT263N1G3q1W9AXCCV
         lP6r/iyJ0ZFkBPmhuJ32qw46Ajczu7tZJDmNxoUX7wg4NxyUO39ic+NpLCjDTnfj4bpB
         jKBQ==
X-Gm-Message-State: APjAAAVyAnok7cdql2JCDz20RPCF0XGXzkpEYIenmQcL4FeEN6ZKT1xZ
        wO5/3ZBDrgLCDIlrKOBcWPo=
X-Google-Smtp-Source: APXvYqxV/lYZ7fob+xvcztFy0b3HBrXnpwukQBqAxJYZnFEVYhsxjZmOxb0kuRfnFhavKL50RlT6Ww==
X-Received: by 2002:a62:2b46:: with SMTP id r67mr28802143pfr.140.1568038745876;
        Mon, 09 Sep 2019 07:19:05 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id w6sm34574695pfw.84.2019.09.09.07.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:19:05 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 5/9] kconfig/hacking: Move Oops into 'Lockups and Hangs'
Date:   Mon,  9 Sep 2019 22:18:19 +0800
Message-Id: <20190909141823.8638-6-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909141823.8638-1-changbin.du@gmail.com>
References: <20190909141823.8638-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are similar options so place them together.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 lib/Kconfig.debug | 58 +++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7b3552531d02..1385e17122a1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -793,7 +793,35 @@ config DEBUG_SHIRQ
 	  Drivers ought to be able to handle interrupts coming in at those
 	  points; some don't and need to be caught.
 
-menu "Debug Lockups and Hangs"
+menu "Debug Oops, Lockups and Hangs"
+
+config PANIC_ON_OOPS
+	bool "Panic on Oops"
+	help
+	  Say Y here to enable the kernel to panic when it oopses. This
+	  has the same effect as setting oops=panic on the kernel command
+	  line.
+
+	  This feature is useful to ensure that the kernel does not do
+	  anything erroneous after an oops which could result in data
+	  corruption or other issues.
+
+	  Say N if unsure.
+
+config PANIC_ON_OOPS_VALUE
+	int
+	range 0 1
+	default 0 if !PANIC_ON_OOPS
+	default 1 if PANIC_ON_OOPS
+
+config PANIC_TIMEOUT
+	int "panic timeout"
+	default 0
+	help
+	  Set the timeout value (in seconds) until a reboot occurs when the
+	  the kernel panics. If n = 0, then we wait forever. A timeout
+	  value n > 0 will wait n seconds before rebooting, while a timeout
+	  value n < 0 will reboot immediately.
 
 config LOCKUP_DETECTOR
 	bool
@@ -951,34 +979,6 @@ config WQ_WATCHDOG
 
 endmenu # "Debug lockups and hangs"
 
-config PANIC_ON_OOPS
-	bool "Panic on Oops"
-	help
-	  Say Y here to enable the kernel to panic when it oopses. This
-	  has the same effect as setting oops=panic on the kernel command
-	  line.
-
-	  This feature is useful to ensure that the kernel does not do
-	  anything erroneous after an oops which could result in data
-	  corruption or other issues.
-
-	  Say N if unsure.
-
-config PANIC_ON_OOPS_VALUE
-	int
-	range 0 1
-	default 0 if !PANIC_ON_OOPS
-	default 1 if PANIC_ON_OOPS
-
-config PANIC_TIMEOUT
-	int "panic timeout"
-	default 0
-	help
-	  Set the timeout value (in seconds) until a reboot occurs when the
-	  the kernel panics. If n = 0, then we wait forever. A timeout
-	  value n > 0 will wait n seconds before rebooting, while a timeout
-	  value n < 0 will reboot immediately.
-
 config SCHED_DEBUG
 	bool "Collect scheduler debugging info"
 	depends on DEBUG_KERNEL && PROC_FS
-- 
2.20.1

