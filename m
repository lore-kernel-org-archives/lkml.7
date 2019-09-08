Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E763C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161ED21744
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/Yjcm62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394081AbfIHB2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 21:28:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40832 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393727AbfIHB2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 21:28:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so6915084pfb.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 18:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=urmi4Jjz/uRufLZmaLcE3BglQ0DD0cc1VMqCt0fpCQI=;
        b=Q/Yjcm62vBpvToJCaL9oJSPU+9nuVDhscx0UkKdqcWHk6zXLMsVJNYYed5J0xt4iAe
         zpPj49fMc47TP7ULRWQj8dhXv2uaUFMzFth9bKu2sFV0wJIaF3SRRhcYNY1Woz11MTD7
         gWnk1UyqJDAu8+b2EbXFYNfu/TIEDgALnaC9RsqxSz0AJcODPmWHeT1cZu12o74nhGCv
         jWuZnAHHzmJnh8IO+6MdmlZlo/XVH3FGv3aoCuHIEO9yBLo/AAc5itmGwXYlIDpfcVR5
         LK4dIY1nx255/fgvbcoBaufAtMhrX56xgt/FptMXR7aXdPZ0afkpdnJ0UdZQh/3E4GWP
         qq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=urmi4Jjz/uRufLZmaLcE3BglQ0DD0cc1VMqCt0fpCQI=;
        b=OoD5G65yG/jqCYAB4dkLqZgPg0Rdvbd42ImjRD+erutduxYlsi5I43kk/28fyORPSJ
         AfMVhiFrDAeN84ktLt2Rc1QRBqZ4iQPtNAJizxu87BZtn2h5gVxOznJVAXQwbwbXJXF5
         yaNLbPXI6watyErLPmgH2Rin8hYqyddSI/FaYixGqNUiFcKyXNRw0LWz3NbUl6f1Fyjf
         fmmFic6sOQXvKLfj/npV034NoW3YAvoyMwUmKmgN9qd21wfLZKPP3BKOKExFBGMdPpWY
         fwUWmV/ZbW7vRNyb6E8dWTTMkt6tMjZfNLKyXC+eoT7k55gyku1Vxp4jwfmKpJ74D8ew
         L/Yw==
X-Gm-Message-State: APjAAAWcxsALcfjwfNlgtxMaHH+TRmbJv+3Gzh5ncbaZxFOYS3byB2Qq
        ZrIDw+X+0RZq5xKy09Fz4Aw=
X-Google-Smtp-Source: APXvYqwuDc1X1CM0dMaEwuFUDlbuWbVg0c1F9rZNzDfoc/ybsf6u6NEEg/IfgOAemx3OvmnaWYaVog==
X-Received: by 2002:a62:d143:: with SMTP id t3mr19933427pfl.213.1567906121094;
        Sat, 07 Sep 2019 18:28:41 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id s1sm18367884pjs.31.2019.09.07.18.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 18:28:40 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 5/8] kconfig/hacking: Move Oops into 'Lockups and Hangs'
Date:   Sun,  8 Sep 2019 09:27:57 +0800
Message-Id: <20190908012800.12979-6-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908012800.12979-1-changbin.du@gmail.com>
References: <20190908012800.12979-1-changbin.du@gmail.com>
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
index ca2083350178..99c6dbd64ce7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -792,7 +792,35 @@ config DEBUG_SHIRQ
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
@@ -950,34 +978,6 @@ config WQ_WATCHDOG
 
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

