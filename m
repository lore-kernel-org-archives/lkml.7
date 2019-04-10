Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691D2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1AD2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554876896;
	bh=TN1K9RGR1+wWzPP2736/+TBkHP7znLpQbK7GxgFpGks=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=m5Zq1JNRExi8TaG2+LiqzWjVwcvITM6GTPt25a4geRiPRsMKDW4vWAMUu5EprCC+Z
	 gEu6doAU4kxZMfepf38vtgTvuz2MCxY0MCVwMAYZxb5ga4SNYoxTynlKAZDJO+wike
	 zbyHlIOI3xtZRy/Pv4d5eehlOlvJij0vcXNK+o60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfDJGOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:14:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfDJGOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:14:54 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14AA520850;
        Wed, 10 Apr 2019 06:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554876893;
        bh=TN1K9RGR1+wWzPP2736/+TBkHP7znLpQbK7GxgFpGks=;
        h=From:To:Cc:Subject:Date:From;
        b=gNZqCeqqrvJSghMJGR7vt7B3VbOhCGUC6fv+TcmN3fXosVh0Ql0fzu+YfH2ieuPsO
         VCYFultffNkFFwtIkViRjzzIfVy4k8S/P9nu01NrsxTBHygSHwOtRYH6+jnNMCLWd2
         G6oXQ6oCkbhVk1UZ0U3XFvRQfmGFmtB/+3AM31V8=
From:   guoren@kernel.org
To:     arnd@arndb.de, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Mao Han <han_mao@c-sky.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V2] csky: Add perf_arch_fetch_caller_regs support
Date:   Wed, 10 Apr 2019 14:12:05 +0800
Message-Id: <1554876725-30455-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Han <han_mao@c-sky.com>

In trace events as tracepoints context are not able to
be retrieve with task_pt_regs. Without arch caller regs
support the pt_regs context will be all zero, perf can
not parsing the callchain and resolving the symbols
correctly, some time will even get into deadlock
while handling the page fault, eg:

perf kmem —page record ls

Changelog
 - Add test case cmd in comment
 - Use regs_fp(regs) which is defined in abi/regdef.h

Signed-off-by: Mao Han <han_mao@c-sky.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/abiv1/inc/abi/regdef.h   | 1 +
 arch/csky/abiv2/inc/abi/regdef.h   | 1 +
 arch/csky/include/asm/perf_event.h | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/arch/csky/abiv1/inc/abi/regdef.h b/arch/csky/abiv1/inc/abi/regdef.h
index 729b1c3..104707f 100644
--- a/arch/csky/abiv1/inc/abi/regdef.h
+++ b/arch/csky/abiv1/inc/abi/regdef.h
@@ -6,6 +6,7 @@
 
 #define syscallid	r1
 #define regs_syscallid(regs) regs->regs[9]
+#define regs_fp(regs) regs->regs[2]
 
 /*
  * PSR format:
diff --git a/arch/csky/abiv2/inc/abi/regdef.h b/arch/csky/abiv2/inc/abi/regdef.h
index 77cb178..d7328bb 100644
--- a/arch/csky/abiv2/inc/abi/regdef.h
+++ b/arch/csky/abiv2/inc/abi/regdef.h
@@ -6,6 +6,7 @@
 
 #define syscallid	r7
 #define regs_syscallid(regs) regs->regs[3]
+#define regs_fp(regs) regs->regs[4]
 
 /*
  * PSR format:
diff --git a/arch/csky/include/asm/perf_event.h b/arch/csky/include/asm/perf_event.h
index ea81931..572093e 100644
--- a/arch/csky/include/asm/perf_event.h
+++ b/arch/csky/include/asm/perf_event.h
@@ -4,4 +4,12 @@
 #ifndef __ASM_CSKY_PERF_EVENT_H
 #define __ASM_CSKY_PERF_EVENT_H
 
+#include <abi/regdef.h>
+
+#define perf_arch_fetch_caller_regs(regs, __ip) { \
+	(regs)->pc = (__ip); \
+	regs_fp(regs) = (unsigned long) __builtin_frame_address(0); \
+	asm volatile("mov %0, sp\n":"=r"((regs)->usp)); \
+}
+
 #endif /* __ASM_PERF_EVENT_ELF_H */
-- 
2.7.4

