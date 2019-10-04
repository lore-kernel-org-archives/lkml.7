Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6FCC32792
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B9820865
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktjoXLJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbfJDBUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 21:20:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46744 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732433AbfJDBUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 21:20:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id o18so4888204wrv.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 18:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pZK0w2b4erKd/e8ROSamoBX4PuMHp18vIxATYiudH00=;
        b=ktjoXLJh3whler9EKApcW1gsz2MSKZzvoGKH/tAZa72yLxqF3z/rOD/4rg562y/oZT
         JgdjFCmzZh60hL9PKvp0LX0HNpXaSGbJifteFnKvdm++55HB1g5qXyHQRF2deyQ6JfPj
         MNRAdfaBzdu02TjsKNa4trY/aJmokBTct5PB3axt+s2fvwp3k72iK9QsFqBeAg7PFC0i
         U78lNhc6oPkiFtYOuj+26QUSj9J03ABBds3BoJoLFolx29WkeuRYJqgwjf62FXlCauqA
         g5SpyHnue5Qdz7fY3QsPR57fm+zI3iuDMPGCaF6zx07p5jkD57odqji/RXWLh2aUdq3I
         ZUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZK0w2b4erKd/e8ROSamoBX4PuMHp18vIxATYiudH00=;
        b=W56DgXOwWNqEeH8PenkeVQg13DoS+0lIazHBH7+UBJk/abOL158w9S5jNDs2EpDKKe
         Or9MtK6+DAEoPyjw27zPEmABgMvXTZsShkFb+ebQlZZlgOWI1SiUQjSQV/iMiz+53mAN
         PIEZpAOfiQyLZeFNji3SLjm8N7X8gkfL32LsvK3CQpPqFWCKthg2L9pdqekzPMwL/npv
         q/M1SGCuvvM9J6BTUw56acddUaIqzyOIGWcXbw6evjhTZYzicXWVLUuLBLy7AjgcGy/f
         WQckRKWj6R6j94XtDxlKrUPX2JZBQ8siwnthjR1CN9UiUE8xNELbe0xR/4Wh9nu+wnst
         jb/g==
X-Gm-Message-State: APjAAAV2KinLqvQuFiPI+ajYdCv4m2A4/Hkart8Ot9vZ9ghmtPDt3Yb0
        kPbgzblrf+eWz9RxXc8tk169FnGOG61WiA==
X-Google-Smtp-Source: APXvYqz7ZTzM84THnELxFgDZJVEU+bOPCxEcvZVSr8zcKmuV7UxpzdrbdI/tU1+HR/CW8X5YZadoGg==
X-Received: by 2002:adf:ee05:: with SMTP id y5mr8846845wrn.291.1570152044620;
        Thu, 03 Oct 2019 18:20:44 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id a4sm4097404wmm.10.2019.10.03.18.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 18:20:44 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [RESEND PATCH v3 5/9] hacking: Move Oops into 'Lockups and Hangs'
Date:   Fri,  4 Oct 2019 09:20:06 +0800
Message-Id: <20191004012010.11287-6-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004012010.11287-1-changbin.du@gmail.com>
References: <20191004012010.11287-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are similar options so place them together.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 lib/Kconfig.debug | 58 +++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9911e5c6eafa..389876ee49d8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -775,7 +775,35 @@ config DEBUG_SHIRQ
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
@@ -933,34 +961,6 @@ config WQ_WATCHDOG
 
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

