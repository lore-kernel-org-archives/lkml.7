Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A200C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13A720854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389449AbfJOTSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:18:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45674 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389407AbfJOTSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:44 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSL9-00067i-7Z; Tue, 15 Oct 2019 21:18:39 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 19/34] sparc: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:18:06 +0200
Message-Id: <20191015191821.11479-20-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the trap code over to use CONFIG_PREEMPTION.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: +Kconfig]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/sparc/Kconfig           | 2 +-
 arch/sparc/kernel/rtrap_64.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index fbc1aecf0f94c..9798d2074a265 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -278,7 +278,7 @@ config US3_MC
 config GENERIC_LOCKBREAK
 	bool
 	default y
-	depends on SPARC64 && SMP && PREEMPT
+	depends on SPARC64 && SMP && PREEMPTION
=20
 config NUMA
 	bool "NUMA support"
diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index 29aa34f11720c..c5fd4b450d9b6 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -310,7 +310,7 @@ kern_rtt:	rdpr			%canrestore, %g1
 		retry
=20
 to_kernel:
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 		ldsw			[%g6 + TI_PRE_COUNT], %l5
 		brnz			%l5, kern_fpucheck
 		 ldx			[%g6 + TI_FLAGS], %l5
--=20
2.23.0

