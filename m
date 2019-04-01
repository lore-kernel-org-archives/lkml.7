Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86728C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A37320850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfDAKZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:25:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39446 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfDAKZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:25:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so10709858wmk.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 03:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YA6mAc0Au68DJdMDqx7hEe+T27gaRnoylOjAR55Xbw0=;
        b=QA0iiR9QexrsxA0FPTBqPtxMOpVwrDGcetPsdSDxYKSUN/uEBEuYzu7t9mRfh/qVTr
         +hcDTOMh0WTK4jbm+0FDqhgnSvlldkOfhiK+/9rPOpvGWZb85sWIfQtyLn+5T/ENZOQ5
         gZo8j5alWdI61v/pr9jw8eVEPEpB+keOD+bws3nVuBKMFbE0LGNVOFNggHJWZPAkUSw+
         1TdHrc+OazpB72eGRgk2rwG0qXRfIb74QqaGlXftAxMF5vfPi7QKC9GeanGE4vm8Ca2I
         4eP2TtUHk3ceSrks0c7afIlp8QHfCC6Ywsj9WnWGYu9W2iN1EKQ1NF9hnVXXYMF2xOql
         5tiA==
X-Gm-Message-State: APjAAAXEDdHtFBEAJfgrUF5o7jrvy0k63poem1KABUuoQCHfsZxiEkKY
        dVZicTh38nlhoRnUyKgLe5/u7Q==
X-Google-Smtp-Source: APXvYqypCfqtZqXqNHgHhlLBC8H8NEHyxH3Lfqq6WvpdrKUDVdTlVi6FxICmCv5WJnuij29iwE3+BQ==
X-Received: by 2002:a1c:be13:: with SMTP id o19mr11822939wmf.19.1554114321017;
        Mon, 01 Apr 2019 03:25:21 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-70-69-135.cust.vodafonedsl.it. [93.70.69.135])
        by smtp.gmail.com with ESMTPSA id o4sm22553246wmo.20.2019.04.01.03.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:25:20 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-sound@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/4] panic: use the aural error reporting framework to report panics
Date:   Mon,  1 Apr 2019 12:24:53 +0200
Message-Id: <20190401102456.11162-3-mcroce@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401102456.11162-1-mcroce@redhat.com>
References: <20190401102456.11162-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new aural error reporting framework to signal kernel panic. The
error sound is emitted between the stack dump and the kexec jump.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 kernel/panic.c    | 25 +++++++++++++++++++++++++
 lib/Kconfig.debug | 10 ++++++++++
 2 files changed, 35 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 0ae0d7332f12..360578e092e7 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -29,6 +29,7 @@
 #include <linux/bug.h>
 #include <linux/ratelimit.h>
 #include <linux/debugfs.h>
+#include <linux/play.h>
 #include <asm/sections.h>
 
 #define PANIC_TIMER_STEP 100
@@ -57,6 +58,29 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
 
 EXPORT_SYMBOL(panic_notifier_list);
 
+#ifdef CONFIG_AUDIBLE_PANIC
+static struct note panic_sound[] = {
+	{ 784, 400 },
+	{ 784, 400 },
+	{ 784, 400 },
+	{ 622, 300 },
+	{ 932, 100 },
+	{ 784, 400 },
+	{ 622, 300 },
+	{ 932, 100 },
+	{ 784, 800 },
+	{ 1174, 400 },
+	{ 1174, 400 },
+	{ 1174, 400 },
+	{ 1244, 300 },
+	{ 932, 100 },
+	{ 740, 400 },
+	{ 622, 300 },
+	{ 932, 100 },
+	{ 784, 800 },
+};
+#endif
+
 static long no_blink(int state)
 {
 	return 0;
@@ -213,6 +237,7 @@ void panic(const char *fmt, ...)
 	if (!test_taint(TAINT_DIE) && oops_in_progress <= 1)
 		dump_stack();
 #endif
+	play(panic_sound, ARRAY_SIZE(panic_sound));
 
 	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 10d04b266aef..e5d187dfc74a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -997,6 +997,16 @@ config PLAY_LIB
 	depends on HAVE_PCSPKR_PLATFORM
 	default n
 
+config AUDIBLE_PANIC
+	bool "Aural panic"
+	select PLAY_LIB
+	default n
+	help
+	  If you say Y here, kernel panics will play a sound just
+	  after the stacktrace and registers dump. The sound is played via
+	  the system buzzer and not via any soundcard.
+	  Not available on all platforms.
+
 config SCHED_DEBUG
 	bool "Collect scheduler debugging info"
 	depends on DEBUG_KERNEL && PROC_FS
-- 
2.20.1

