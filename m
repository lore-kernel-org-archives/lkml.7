Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CD5C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 22:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE5C2147A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 22:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555195499;
	bh=2stfT+geA/JdXbolhmRocGFcWdKjcVzZ9oMU+o7Raiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ARqVl4E4QxlXnuNGOF+W/kx1Wcrsr3phajJZaprVq4YWp9nXhErQwr/jI1U/14wVX
	 lyfID9hh2B5fLqsHu5RMBMMS3x5UrmTPXdAvBoNwNPRDLSsmmWKBV7+fAdJpHMK2BA
	 f8xgw+NUa4nmbPmUcxnUs1F1Zs+o3XBZMe0TIHaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfDMWo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 18:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfDMWo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 18:44:57 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.159.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B349E2147A;
        Sat, 13 Apr 2019 22:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555195496;
        bh=2stfT+geA/JdXbolhmRocGFcWdKjcVzZ9oMU+o7Raiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EZQbqdctg+x5tSAyxe6iwEq0lgINx5BVIvsbOn4HgGV2zVhIAq2jbANNexqswbLfs
         ZY2Ef8P9Vokt0vHdEnyKQ3wKF3Uf5WkbetCnXoGAshXzpY4+GJsLd6gqFPmHlEUByw
         RmduZAyJXuUx9t8bvF76PBnOvMZwOMFKDHZmEeRc=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     josh@joshtriplett.org, keescook@chromium.org,
        Sinan Kaya <okaya@kernel.org>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org (open list:TENSILICA XTENSA PORT (xtensa))
Subject: [PATCH v5 4/5] xtensa: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC
Date:   Sat, 13 Apr 2019 22:44:37 +0000
Message-Id: <20190413224438.10802-5-okaya@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413224438.10802-1-okaya@kernel.org>
References: <20190413224438.10802-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_KERNEL should not impact code generation. Use the newly
defined CONFIG_DEBUG_MISC instead to keep the current code.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 arch/xtensa/include/asm/irqflags.h | 2 +-
 arch/xtensa/kernel/smp.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/include/asm/irqflags.h b/arch/xtensa/include/asm/irqflags.h
index 9b5e8526afe5..12890681587b 100644
--- a/arch/xtensa/include/asm/irqflags.h
+++ b/arch/xtensa/include/asm/irqflags.h
@@ -27,7 +27,7 @@ static inline unsigned long arch_local_irq_save(void)
 {
 	unsigned long flags;
 #if XTENSA_FAKE_NMI
-#if defined(CONFIG_DEBUG_KERNEL) && (LOCKLEVEL | TOPLEVEL) >= XCHAL_DEBUGLEVEL
+#if defined(CONFIG_DEBUG_MISC) && (LOCKLEVEL | TOPLEVEL) >= XCHAL_DEBUGLEVEL
 	unsigned long tmp;
 
 	asm volatile("rsr	%0, ps\t\n"
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 3699d6d3e479..83b244ce61ee 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -126,7 +126,7 @@ void secondary_start_kernel(void)
 
 	init_mmu();
 
-#ifdef CONFIG_DEBUG_KERNEL
+#ifdef CONFIG_DEBUG_MISC
 	if (boot_secondary_processors == 0) {
 		pr_debug("%s: boot_secondary_processors:%d; Hanging cpu:%d\n",
 			__func__, boot_secondary_processors, cpu);
-- 
2.21.0

