Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC07CC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917D42073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Fj3acjtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfLDQAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:00:53 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34563 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfLDQAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:00:07 -0500
Received: by mail-qt1-f195.google.com with SMTP id 5so261814qtz.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 08:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BVZcqc2Z6644/Az5ve2InTrOD+vzGwRmsPVnGeCmQZQ=;
        b=Fj3acjtI0vF/2X6yAmVOkmQPOiJyiV9R1DOf9Hh1yWS9xj0L6CWNj0ZtAnLVKoPhIs
         kr5rHc9BhzZ/NPjlNQXew0gPTqMzLA/+7Xhdea9q5VvzWwMNYEDlYxrk9aM8uMZJEzrG
         BW7fWabMXHQvQ1jTAKW0/oblb2GGkJ0omqgeJHeTMISryzpinMo8Z3RE2Hv5fpm5r2er
         OATbxcGcHrWxiXL+/9WEAcpxZ0/hNy+RgRLEPvSDsU6SU/8VfjRdcKjJodiit2Z48uj5
         X77AQQG5YgY7qWKZ3E49twAsmXWIVCUJibwk3iVT++AMRf8Eu7VGPuWmf3AuSJdsZkmD
         QpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BVZcqc2Z6644/Az5ve2InTrOD+vzGwRmsPVnGeCmQZQ=;
        b=DmIfK12cfuLWNPh8PQKOK8JiU6dPRdam6SsBzrUh8m2FgqDGaxkwrRP06AYQ3AAe4K
         KmsHa8XvWDVzJJckcVthz1KQR25ZuCGXdEHP+SxW/YdLEaKwDR2Xw9oNTs2WHJ4VX9MF
         bSKnK7/wJ3VOFh4KNOqcWBWsEws55Gx0o0yjqS7ozcINqoefLDVPorDVHNcXSSvJ68hW
         zEdJW72KFZUKcI+Is5vNkllZwxJ3aOJ9CafXwTYXZdE8Ypq1BZr2lKZ8q53gEhNGxBdn
         LAGPTVWgbiEf3LRPoa3B6yYmm+wU4B5LPxe9e5l+UKbDPbUVJ3vvmcBelPv9qBplmX6J
         OZCA==
X-Gm-Message-State: APjAAAXxbLWZbAcx7278pPVlqE1+Pa46gwi9UqxL68kcGiJ50APjbwXl
        WulHqJT3Mm2ZUJmCXRz6VyD0qQ==
X-Google-Smtp-Source: APXvYqzB+ZcjsuLUod5A2CrdZ5P4hqO77xakVo3euDVIPD3hBa71g2vCu7CIOGElQwxDhATyXOXEjA==
X-Received: by 2002:ac8:7443:: with SMTP id h3mr3298187qtr.202.1575475206050;
        Wed, 04 Dec 2019 08:00:06 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w21sm4177585qth.17.2019.12.04.08.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 08:00:05 -0800 (PST)
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
Subject: [PATCH v8 17/25] arm64: kexec: cpu_soft_restart change argument types
Date:   Wed,  4 Dec 2019 10:59:30 -0500
Message-Id: <20191204155938.2279686-18-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
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
2.24.0

