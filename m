Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C22C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6DA2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfDLK1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:27:41 -0400
Received: from foss.arm.com ([217.140.101.70]:57392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfDLK1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:27:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0033815AB;
        Fri, 12 Apr 2019 03:27:40 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C9CAA3F718;
        Fri, 12 Apr 2019 03:27:39 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] kcov: improve CONFIG_ARCH_HAS_KCOV help text
Date:   Fri, 12 Apr 2019 11:27:33 +0100
Message-Id: <20190412102733.5154-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The help text for CONFIG_ARCH_HAS_KCOV is stale, and describes the
feature as being enabled only for x86_64, when it is now enabled for
several architectures, including arm, arm64, powerpc, and s390.

Let's remove that stale help text, and update it along the lines of hat
for ARCH_HAS_FORTIFY_SOURCE, better describing when an architecture
should select CONFIG_ARCH_HAS_KCOV.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Kees Cook <keescook@chromium.org>
---
 lib/Kconfig.debug | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0d9e81779e37..00dbcdbc9a0d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -753,9 +753,9 @@ endmenu # "Memory Debugging"
 config ARCH_HAS_KCOV
 	bool
 	help
-	  KCOV does not have any arch-specific code, but currently it is enabled
-	  only for x86_64. KCOV requires testing on other archs, and most likely
-	  disabling of instrumentation for some early boot code.
+	  An architecture should select this when it can successfully
+	  build and run with CONFIG_KCOV. This typically requires
+	  disabling instrumentation for some early boot code.
 
 config CC_HAS_SANCOV_TRACE_PC
 	def_bool $(cc-option,-fsanitize-coverage=trace-pc)
-- 
2.11.0

