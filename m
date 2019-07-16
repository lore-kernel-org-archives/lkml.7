Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF95C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CCD2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="GGIQw/kg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388245AbfGPQ4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 12:56:52 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42512 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388036AbfGPQ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 12:56:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id h18so20282064qtm.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OHreDCpotkEUucxoE5EiEKrcc9yzecv+duVH9vOORKc=;
        b=GGIQw/kgAUl/eG3d2NKYO7rrigP3xCd6L3ITkDfbZyMEUnoEj0yVHLsV2LlbgRYbC+
         wxGDoUKvbsOD49xDxxVjVMA/cVW24Ta7j9hj3+wxoFsCV7bE/6zX1BcHliTfmRJa2HL6
         t1GMulrmuUdkYdtWJR3tWcDBbewttH11SYty1lYTYPi9/xqOKf63ADEYQ5vRWxW8OT6H
         VHjxbQVnM+5FFok1c8bap5vm+E40C8t2yYrwiy22m4L+k24TpV5SxJbfpoBHfRpCqzb2
         H6dm0a1hIjm8g/mZThetxdugoRf8Pcyv6ZduRuCZRIwQmu9srFbLpacSM3DPtY1OABO9
         4vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OHreDCpotkEUucxoE5EiEKrcc9yzecv+duVH9vOORKc=;
        b=pVta+Z08g+um9er2MzJshP/CHI0nimLQLT2jUxdz2HKwS/7BUdLw8kOonAFhrZhIJ9
         DWnLW7i8/QbWgTlqBC+EsJk4TrnV7Hb61RKQyU2C/1e+4aLzmQGEjYo6MVDE+0Y5P7PU
         SHTTgaG7ikmu5yo/LfWIdvMin9MXOD08gv19KJriB+Lf/HCegaC0wq8rixxqEURhWzYi
         PpI4mnUmWG6keosiYNgaNd15GYNZnIwCU/oSN8Kn7F/WteNJ8FumAZKUs7sdnCC5wtS8
         6uhohU6umVRCOMc/AHwtPegXWHBexplGCBoZm88o/xP+WfQW8tJCEZe5AMLC9jDepc3z
         k7PA==
X-Gm-Message-State: APjAAAXVB0kNfb9qrDXogZd72i0c6nbZ7KsqCwOqoJ0EuTaJmHpuy9Go
        mtYTkwWu76ddPANYcZsA5FY49X6v
X-Google-Smtp-Source: APXvYqwxJ0A/FHhU5OVW66jrPFnnHKm79duNOHFiKTe25GUCXmo7/DTY10UCE+L1XIgV2bRdwMnQ6w==
X-Received: by 2002:ac8:41d1:: with SMTP id o17mr23857397qtm.17.1563296207876;
        Tue, 16 Jul 2019 09:56:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id f20sm8519538qkh.15.2019.07.16.09.56.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 09:56:47 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC v1 4/4] arm64: Keep MMU on while kernel is being relocated
Date:   Tue, 16 Jul 2019 12:56:41 -0400
Message-Id: <20190716165641.6990-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190716165641.6990-1-pasha.tatashin@soleen.com>
References: <20190716165641.6990-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is inefficient to do kernel relocation with MMU disabled. This is
because if MMU is disabled,  dcache must also be disabled.

Now, that we have identity page table we can disable MMU after relocation
is completed.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/cpu-reset.S       |  8 -------
 arch/arm64/kernel/relocate_kernel.S | 36 ++++++++++++++++++-----------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 6ea337d464c4..d5cfc17b8e1f 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -30,14 +30,6 @@
  * flat identity mapping.
  */
 ENTRY(__cpu_soft_restart)
-	/* Clear sctlr_el1 flags. */
-	mrs	x12, sctlr_el1
-	ldr	x13, =SCTLR_ELx_FLAGS
-	bic	x12, x12, x13
-	pre_disable_mmu_workaround
-	msr	sctlr_el1, x12
-	isb
-
 	cbz	x0, 1f				// el2_switch?
 	mov	x0, #HVC_SOFT_RESTART
 	hvc	#0				// no return
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index c1d7db71a726..e2724fedd082 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -36,18 +36,6 @@ ENTRY(arm64_relocate_new_kernel)
 	mov	x14, xzr			/* x14 = entry ptr */
 	mov	x13, xzr			/* x13 = copy dest */
 
-	/* Clear the sctlr_el2 flags. */
-	mrs	x0, CurrentEL
-	cmp	x0, #CurrentEL_EL2
-	b.ne	1f
-	mrs	x0, sctlr_el2
-	ldr	x1, =SCTLR_ELx_FLAGS
-	bic	x0, x0, x1
-	pre_disable_mmu_workaround
-	msr	sctlr_el2, x0
-	isb
-1:
-
 	/* Check if the new image needs relocation. */
 	tbnz	x16, IND_DONE_BIT, .Ldone
 
@@ -63,10 +51,10 @@ ENTRY(arm64_relocate_new_kernel)
 	add     x20, x0, #PAGE_SIZE
 	sub     x1, x15, #1
 	bic     x0, x0, x1
-2:	dc      ivac, x0
+1:	dc      ivac, x0
 	add     x0, x0, x15
 	cmp     x0, x20
-	b.lo    2b
+	b.lo    1b
 	dsb     sy
 
 	mov x20, x13
@@ -104,6 +92,26 @@ ENTRY(arm64_relocate_new_kernel)
 	dsb	nsh
 	isb
 
+	/* Clear sctlr_el1 flags. */
+	mrs	x12, sctlr_el1
+	ldr	x13, =SCTLR_ELx_FLAGS
+	bic	x12, x12, x13
+	pre_disable_mmu_workaround
+	msr	sctlr_el1, x12
+	isb
+
+	/* Clear the sctlr_el2 flags. */
+	mrs	x0, CurrentEL
+	cmp	x0, #CurrentEL_EL2
+	b.ne	2f
+	mrs	x0, sctlr_el2
+	ldr	x1, =SCTLR_ELx_FLAGS
+	bic	x0, x0, x1
+	pre_disable_mmu_workaround
+	msr	sctlr_el2, x0
+	isb
+2:
+
 	/* Start new image. */
 	mov	x0, x18
 	mov	x1, xzr
-- 
2.22.0

