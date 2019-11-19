Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8197C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A5F22445
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JC0rFtKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfKSWKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:10:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35629 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfKSWKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:10:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id s10so12697689plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 14:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UdU3qNEOLTbKbi9NxQzz9fevQsI9LjR5PnwQlEv7eyI=;
        b=JC0rFtKe1fs+H4jK9vpJa8T4wkcPAoNeFQje6LwEljmB0Ip91xucB4LCJD73qMBQpY
         aRg/hmIOhHhB/cSbLUark8KKc4JM4qu8V1VD4hPSRMYIkSNodswm+sjCEMdvDHPXB/x8
         /QlKXdOiJb0VX+jTovyIFkbmJh5VVgE0PFrMPy50AnaFMJpkqokCi3Ul6Ml5bNSI1Teh
         6eWfmI9+BJ+YclDHqskvMQt+HbqsAgi9G7JfT41ERl+OeqkQFlWDqpc5IthrFak/pomV
         aUXM8fq6ns6boTLDKjYkkzvolTGiKRtmjvx/iXAn0V5dPPIj1sC6/LnNcXOu2ZQEBcMn
         yxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UdU3qNEOLTbKbi9NxQzz9fevQsI9LjR5PnwQlEv7eyI=;
        b=ahyBOoGtg1fGH6X0w/U05/QnFPvDGaiL4YQTFsmW5GWa5KuC8dCz3xDu7mD8/ZoX79
         9zDv0b7JRpqiuT0aU/8ZecTNikiU3G7URz4kkA+JhQ0FPedU/nyzXORAmxLHczU1DEeh
         JyuIN3tSdttpm0eZyX+/L0rEV7uhxLjROk1WiYYnO+JfpmhCwBDEFJAUTBVMawMiuAK9
         M7JxrooSLQAokjkGzBl0N+losS3UapSpfKx5P7Ig6A0rhIHJo3bICnFZQiWQx1Ts4Fb7
         oNPataJdOQFRl+oR7j+2kMvrPD+jU3icdZBMK8ly8X0sZS+e+URjU/Aq46OIQFGwQdHm
         hjQQ==
X-Gm-Message-State: APjAAAUSsxgNsXxPDxl6oOJqaLJ3x5EGmm4Ls5P4lLiNgABpNjb/U94y
        3mntvqXxzBWmyn9EM4Xjvu5WKQ==
X-Google-Smtp-Source: APXvYqzDYm4LzzWHaecTPAkUjtYvVUyNLSKCG2kbysLH0N+N3sIaEjPrCi6Qcaj4sSH/Jcopk6KLVQ==
X-Received: by 2002:a17:902:4a:: with SMTP id 68mr21435548pla.158.1574201410571;
        Tue, 19 Nov 2019 14:10:10 -0800 (PST)
Received: from xakep.corp.microsoft.com (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 193sm29270908pfv.18.2019.11.19.14.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 14:10:09 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com
Subject: [PATCH] arm64: kernel: memory corruptions due non-disabled PAN
Date:   Tue, 19 Nov 2019 17:10:06 -0500
Message-Id: <20191119221006.1021520-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userland access functions (__arch_clear_user, __arch_copy_from_user,
__arch_copy_in_user, __arch_copy_to_user), enable and disable PAN
for the duration of copy. However, when copy fails for some reason,
i.e. access violation the code is transferred to fixedup section,
where we do not disable PAN.

The bug is a security violation as the access to userland is still
open when it should be disabled, but it also causes memory corruptions
when software emulated PAN is used: CONFIG_ARM64_SW_TTBR0_PAN=y.

I was able to reproduce memory corruption problem on Broadcom's SoC
ARMv8-A like this:

Enable software perf-events with PERF_SAMPLE_CALLCHAIN so userland's
stack is accessed and copied.

The test program performed the following on every CPU and forking many
processes:

	unsigned long *map = mmap(NULL, PAGE_SIZE, PROT_READ|PROT_WRITE,
				  MAP_SHARED | MAP_ANONYMOUS, -1, 0);
	map[0] = getpid();
	sched_yield();
	if (map[0] != getpid()) {
		fprintf(stderr, "Corruption detected!");
	}
	munmap(map, PAGE_SIZE);

From time to time I was getting map[0] to contain pid for a different
process.

Fixes: 338d4f49d6f7114 ("arm64: kernel: Add support for Privileged...")

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/lib/clear_user.S     | 1 +
 arch/arm64/lib/copy_from_user.S | 1 +
 arch/arm64/lib/copy_in_user.S   | 1 +
 arch/arm64/lib/copy_to_user.S   | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm64/lib/clear_user.S b/arch/arm64/lib/clear_user.S
index 10415572e82f..322b55664cca 100644
--- a/arch/arm64/lib/clear_user.S
+++ b/arch/arm64/lib/clear_user.S
@@ -48,5 +48,6 @@ EXPORT_SYMBOL(__arch_clear_user)
 	.section .fixup,"ax"
 	.align	2
 9:	mov	x0, x2			// return the original size
+	uaccess_disable_not_uao x2, x3
 	ret
 	.previous
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 680e74409ff9..8472dc7798b3 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -66,5 +66,6 @@ EXPORT_SYMBOL(__arch_copy_from_user)
 	.section .fixup,"ax"
 	.align	2
 9998:	sub	x0, end, dst			// bytes not copied
+	uaccess_disable_not_uao x3, x4
 	ret
 	.previous
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index 0bedae3f3792..8e0355c1e318 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -68,5 +68,6 @@ EXPORT_SYMBOL(__arch_copy_in_user)
 	.section .fixup,"ax"
 	.align	2
 9998:	sub	x0, end, dst			// bytes not copied
+	uaccess_disable_not_uao x3, x4
 	ret
 	.previous
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 2d88c736e8f2..6085214654dc 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -65,5 +65,6 @@ EXPORT_SYMBOL(__arch_copy_to_user)
 	.section .fixup,"ax"
 	.align	2
 9998:	sub	x0, end, dst			// bytes not copied
+	uaccess_disable_not_uao x3, x4
 	ret
 	.previous
-- 
2.24.0

