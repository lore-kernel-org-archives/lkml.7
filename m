Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAFFC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC0C2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SccOsDYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfFVGtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:49:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46463 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfFVGtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:49:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6nMNj2009890
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:49:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6nMNj2009890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561186162;
        bh=BL69RM8g2f23L0pRL/rFPGU06SBULa+QQgSoW/1w3W8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=SccOsDYIVz1y2vzTas/Pde66r59Y1WsPkP3RUxrP/Es0OQLZAD5Wi2KtAH3K84dQ1
         w9YkblcKQ/pqOgWav4MhImurEJNz55l2WaDEKoqB3NSTqDCyFDzD+iyZ1/tbvodxqU
         cAUgIEyPhlgcGSqFcbHR/WdJoBDAFy5KSkrqTyw1erMmJynYPvZEgCJrfamMb1Qa3r
         Z+ZwMatOFF5PVmzjRzsdF110S54jo9c3V+p0nx7MPJsrddmc0mlmJ02iAuDDhyNqOB
         i8oq66+8U3F5nTphE3QlxECDLXWFIFyQVabaCw6nuLPhQx+SS9QoYQ1TJ3bDV7vWfd
         N1LGPxHK8EHrg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6nLs72009887;
        Fri, 21 Jun 2019 23:49:21 -0700
Date:   Fri, 21 Jun 2019 23:49:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Florian Fainelli <tipbot@zytor.com>
Message-ID: <tip-1955c8cf5e26b1f70d674190ff9984dbfd531ee9@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, jakub.kicinski@netronome.com,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, peterz@infradead.org, namhyung@kernel.org,
        hpa@zytor.com, acme@redhat.com, mingo@kernel.org, sdf@google.com,
        quentin.monnet@netronome.com, alexey.budankov@linux.intel.com,
        tglx@linutronix.de
Reply-To: alexey.budankov@linux.intel.com, quentin.monnet@netronome.com,
          sdf@google.com, tglx@linutronix.de, mingo@kernel.org,
          acme@redhat.com, hpa@zytor.com, namhyung@kernel.org,
          peterz@infradead.org, jolsa@redhat.com, f.fainelli@gmail.com,
          alexander.shishkin@linux.intel.com, jakub.kicinski@netronome.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190614183949.5588-1-f.fainelli@gmail.com>
References: <20190614183949.5588-1-f.fainelli@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Don't hardcode host include path for
 libslang
Git-Commit-ID: 1955c8cf5e26b1f70d674190ff9984dbfd531ee9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1955c8cf5e26b1f70d674190ff9984dbfd531ee9
Gitweb:     https://git.kernel.org/tip/1955c8cf5e26b1f70d674190ff9984dbfd531ee9
Author:     Florian Fainelli <f.fainelli@gmail.com>
AuthorDate: Fri, 14 Jun 2019 11:39:47 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:20 -0300

perf tools: Don't hardcode host include path for libslang

Hardcoding /usr/include/slang is fundamentally incompatible with cross
compilation and will lead to the inability for a cross-compiled
environment to properly detect whether slang is available or not.

If /usr/include/slang is necessary that is a distribution specific
knowledge that could be solved with either a standard pkg-config .pc
file (which slang has) or simply overriding CFLAGS accordingly, but the
default perf Makefile should be clean of all of that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Stanislav Fomichev <sdf@google.com>
Fixes: ef7b93a11904 ("perf report: Librarize the annotation code and use it in the newt browser")
Link: http://lkml.kernel.org/r/20190614183949.5588-1-f.fainelli@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/Makefile | 2 +-
 tools/perf/Makefile.config   | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 523ee42db0c8..7ef7cf04a292 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -182,7 +182,7 @@ $(OUTPUT)test-libaudit.bin:
 	$(BUILD) -laudit
 
 $(OUTPUT)test-libslang.bin:
-	$(BUILD) -I/usr/include/slang -lslang
+	$(BUILD) -lslang
 
 $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5f16a20cae86..e04b7a81d221 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -648,7 +648,6 @@ ifndef NO_SLANG
     NO_SLANG := 1
   else
     # Fedora has /usr/include/slang/slang.h, but ubuntu /usr/include/slang.h
-    CFLAGS += -I/usr/include/slang
     CFLAGS += -DHAVE_SLANG_SUPPORT
     EXTLIBS += -lslang
     $(call detected,CONFIG_SLANG)
