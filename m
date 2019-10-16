Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9456CFA372D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AD721D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fWcMHMde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436940AbfJPUBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:01:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44490 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436926AbfJPUBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:01:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id u40so37954617qth.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ADaPlgsxUTXDoToK9CJnC6JqPCrliOXSW+GZvxTqrfM=;
        b=fWcMHMdeRF61RXXgFbsSde0TUuD9iStZlRHqG/LFIDJV9kompUv7iirW+QMwSWacq4
         glwYmN0mLJqvl56lLSgUR0hi/113Jr7CRUAmkNwj/53dD8wDyz4Ktzv54yJTXzM/IvBb
         IjObZQ00IZjvNNnyyPoOufxxPcHrZLUqHHp9DP8qFOU3lA7py7Rb86VMbW7fE9d6kzsQ
         ri5vQnwoNik+8utdxKj8qvVZTOqS+ZAIQ8JCpMewuiQRK/yF4Zo/cOHUZs5jWzuIoX6o
         zASj7LGsGPsZak57aoUTxJanmeQNkP67QrmcjHHwC8ePUGZmqQk5Ata/sR17HULf7JVc
         jO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ADaPlgsxUTXDoToK9CJnC6JqPCrliOXSW+GZvxTqrfM=;
        b=PNuf9WjoiIijuIgGTr4S0n8Kq+mwuFaPbub7UpxIhaGoxDjZJOfFK4bxQBvwpLpttx
         ql9Pe1qu9XRLfz6c8rsaEaQif1gJby1UQX0CrywQyvo0UfmlWsFFSdLTQNjustJhL4w1
         ra3Noyki/yUO3tZO4KX8muE8yxpdjp7tU9oDbs0pLVxzpsdf/H4LgYoY0PNFxA3+4LSz
         8CQvC/RHf8GkDHpsg2VW2EyBJLPCo9oxRYkeR9TwSUqocKyGH16oi50yG7/GoWixdIqU
         eAqJCkvbm31G5BzWUYE5gK8dbCf0QrXi8ztbSEjGrX/0DbU8hq5f7ZG1wZmbbkBrj/XI
         3Sfg==
X-Gm-Message-State: APjAAAWrU4A6EbsvXD1K9Pl+Hx/TjqjeMK6j7p5n7Md3oji8/iOvzPtK
        6XgxHXTKcYiTvucgIzwzb2vUHA==
X-Google-Smtp-Source: APXvYqynGGdSXuDQaPwJSbR7snjT6dI3cQ574+9wJQuf+wqqsCeR4boU0L9zKxkcwuMKg89ls9wgtg==
X-Received: by 2002:ac8:1413:: with SMTP id k19mr47859620qtj.360.1571256064395;
        Wed, 16 Oct 2019 13:01:04 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c204sm13342030qkb.90.2019.10.16.13.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:01:03 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de
Subject: [PATCH v7 17/25] arm64: kexec: cpu_soft_restart change argument types
Date:   Wed, 16 Oct 2019 16:00:26 -0400
Message-Id: <20191016200034.1342308-18-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change argument types from unsigned long to a more descriptive
phys_addr_t.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/cpu-reset.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index ed50e9587ad8..3a54c4d987f3 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -10,17 +10,17 @@
 
 #include <asm/virt.h>
 
-void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
-	unsigned long arg0, unsigned long arg1, unsigned long arg2);
+void __cpu_soft_restart(phys_addr_t el2_switch, phys_addr_t entry,
+	phys_addr_t arg0, phys_addr_t arg1, phys_addr_t arg2);
 
-static inline void __noreturn cpu_soft_restart(unsigned long entry,
-					       unsigned long arg0,
-					       unsigned long arg1,
-					       unsigned long arg2)
+static inline void __noreturn cpu_soft_restart(phys_addr_t entry,
+					       phys_addr_t arg0,
+					       phys_addr_t arg1,
+					       phys_addr_t arg2)
 {
 	typeof(__cpu_soft_restart) *restart;
 
-	unsigned long el2_switch = !is_kernel_in_hyp_mode() &&
+	phys_addr_t el2_switch = !is_kernel_in_hyp_mode() &&
 		is_hyp_mode_available();
 	restart = (void *)__pa_symbol(__cpu_soft_restart);
 
-- 
2.23.0

