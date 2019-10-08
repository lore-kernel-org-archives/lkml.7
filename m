Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B53C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35882206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="KEIs7fz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbfJHKXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:23:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39102 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730051AbfJHKXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:23:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so18761492wrj.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 03:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=g7fXgZf3sylfsqbC4Vml0nDVX0Bd1HMUoZkfjzbLY44=;
        b=KEIs7fz26KXQvcO4nYX9mH2OZ1rF6DKMhPmqjkVdTjycsqv/M7bQM94g6Zi/LFsg+8
         HbHK6U9hc5aejggrugk21r8N5Xrui/6+DBQSd9JQFZ87XazWhVJn+kVAf1fHCct1rbpm
         mTaP1NfV15rcYQgORXil4UMAfYLgIhMWm6yed/ZUGoKb6NNyuFHHOx7txIwmUJN/cSlS
         MSbKJmR7JNoK5R8afy5sx/IwNrOU17xz9CTvrRGlqchl10KgFg/L4SBMjwxv2tsctBlB
         IaoPG1RL9hBOU2ASmMMJcMlYKkRBZ0Zryzpmhi6y3iZ7E/w8iT5ZM4fJ3lIWBP2GanRf
         UG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=g7fXgZf3sylfsqbC4Vml0nDVX0Bd1HMUoZkfjzbLY44=;
        b=hKojwSKKxqqvil4eMkOblwiqqWEj2drLn8XQylzUxCJgAlvXxgAQhXcaEY/mGkPXJ+
         Qj9g15HNXu+KDlgorvr4T+GyvaABtPzqBR89PxgB36QCzru7p5WcoFg12NyJsb3AJzAe
         HDYoQapJCyQpuiueOWZUh24dG5o550K/cInNtneEaIbHprpq+1M6HR4d3XgPjAzsrAoN
         aBR1eki/U6sePSA4C2EY66dlXB4vaZJfRczEYxgMRbLZ3ZxAE+hUr/qVoksQtWBBrrq6
         EUcHBARRFGU4DsKWe0ybyJbMCwfcjspLzg16dEEdtVlroNPEgCUZp3W1RP4T+wM+VcYO
         N4CA==
X-Gm-Message-State: APjAAAWlxAlgWqUyEe4t0N2VQANwg484rysxJGmL5pbcNq8OAlo7PcvR
        o3Ddid//sHW7tr+0heXEJKnZCor+OW6AGR9U
X-Google-Smtp-Source: APXvYqyGROHMHPAQzuYLzs6qlNJjTa+iYwaDNKvItbR+6tKd+mAgCT0nAMs+jzK+zCxVTlhOrAuTjw==
X-Received: by 2002:adf:bd93:: with SMTP id l19mr10355605wrh.160.1570530209529;
        Tue, 08 Oct 2019 03:23:29 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id f20sm2182671wmb.6.2019.10.08.03.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 03:23:28 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Mubin Sayyed <mubinusm@xilinx.com>
Subject: [PATCH] microblaze: Enable SPARSE_IRQ
Date:   Tue,  8 Oct 2019 12:23:27 +0200
Message-Id: <7cc15bed9291453500502df60668c8bb396d500f.1570530202.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling SPARSE_IRQ to use dynamically allocated irq descriptors.

Signed-off-by: Mubin Sayyed <mubinusm@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/Kconfig           | 1 +
 arch/microblaze/include/asm/irq.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index c9c4be822456..a75896f18e58 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -46,6 +46,7 @@ config MICROBLAZE
 	select VIRT_TO_BUS
 	select CPU_NO_EFFICIENT_FFS
 	select MMU_GATHER_NO_RANGE if MMU
+	select SPARSE_IRQ
 
 # Endianness selection
 choice
diff --git a/arch/microblaze/include/asm/irq.h b/arch/microblaze/include/asm/irq.h
index d785defeeed5..eac2fb4b3fb9 100644
--- a/arch/microblaze/include/asm/irq.h
+++ b/arch/microblaze/include/asm/irq.h
@@ -9,7 +9,6 @@
 #ifndef _ASM_MICROBLAZE_IRQ_H
 #define _ASM_MICROBLAZE_IRQ_H
 
-#define NR_IRQS		(32 + 1)
 #include <asm-generic/irq.h>
 
 struct pt_regs;
-- 
2.17.1

