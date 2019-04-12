Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADB5C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199F621850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555033464;
	bh=sMXj6p0UiM9Amcwzg4iaYGcARDzEkA14Ho04H4a8mFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xhds8pLuD7U+kvpUado2WTTO/WvA7784cWb2uYTO1BzoG4Ub9aYbUlIUdAayWKUOk
	 rhxWJWW5FOiOJOF+dKss1MJx310QF38Myjmu2/HzhigAPTxSlQW3mWWQTj/PFY2KJi
	 R42ie83J9JtIxSyD24li9GzhgIk9wtVUg06vwiXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDLBoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfDLBoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:44:17 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [52.191.113.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22B452186A;
        Fri, 12 Apr 2019 01:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555033456;
        bh=sMXj6p0UiM9Amcwzg4iaYGcARDzEkA14Ho04H4a8mFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TsdtDNvdT3C7EcvjVvjp17ONlC1KylxwogEswxif5hVuRJ+1UG9V63IkUf2FgNsTX
         /93nMFsiYhlcMvGL1S1bGZ5tUY44w7wSTQP8j0P7G81DvAJPyIOBWX4uCp5EBBG2WD
         4exGn41FFO7xzAGC1Ut1EirJsAnEB62hi6dNhLn0=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     josh@joshtriplett.org, keescook@chromium.org,
        Sinan Kaya <okaya@kernel.org>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org (open list:TENSILICA XTENSA PORT (xtensa))
Subject: [PATCH v4 4/5] xtensa: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC
Date:   Fri, 12 Apr 2019 01:43:54 +0000
Message-Id: <20190412014355.25307-5-okaya@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412014355.25307-1-okaya@kernel.org>
References: <20190412014355.25307-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_KERNEL should not impact code generation. Use the newly
defined CONFIG_DEBUG_MISC instead to keep the current code.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
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

