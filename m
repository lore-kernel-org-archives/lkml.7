Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E26BFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1909021D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="NDSNSaUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437023AbfJPUBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:01:38 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46008 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436931AbfJPUBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:01:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id c21so37943802qtj.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Sp+VstuavASlsN1G0FJ/FWHqH9Fozh8Uv4KMjFw0HxA=;
        b=NDSNSaUlA4y+6G85DRCykmRw6kEaoLE6jlhErSwZ96+UQ7KdR/bWgVQhBfyv0JKjA7
         H9GU2Ew1TthzvQmfly4miNmRwvWthsF688SunrQS1ZFWiURD8eW2vguIfwUStbfiU9qo
         F54lFdMP8zIzLX1y1TQSiBNfpyw/yjrSopnhEOsKDhd7quyUuCv+7gYSXjJ5iTlL4PxV
         4d9poZehRV7/Iw2BW4yl3DPMXZ+K8wyk4K4pWo8OTNlqOso2cR8MW96tEE7YcNBXLjq7
         urSQ8NQxcEUiZqJI24vETHgj8MoIdcsVfp5G3QCIJCfh6bGnCY/ndpJ5ICaxF0LE28eH
         hl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sp+VstuavASlsN1G0FJ/FWHqH9Fozh8Uv4KMjFw0HxA=;
        b=mkSPBOuFztfxlUdgs8B6FhIC7kT1LF++qMEXMThu+DjlMOo69C2RYBICpR5vbDVwmI
         3kOzYZszBnyahE6gYfb4ECaJFXqyA4oYhq0t54fW2NYtRAadf6LQZVFulG9Rirx2ewZM
         5eSztnDXEXzjHRRPfKfy32b0pabDF2glnOIRvLgkmbj1FtjRdPuB7MmbcYSeDIYsrnEb
         LxwWHq5iIJyeb80N4tKwX0YG3+TPKN++Pr7MRskeBf1Q31TVQkYtjz5bKc/IlzATwbVV
         +SPIx7tKibrDoujtpNjivr6BA9TlxQt3CM8wF+VpbdxYpxFdzmCz1DsF3v7HIliYtzoq
         fFng==
X-Gm-Message-State: APjAAAX2ttd3vr1pmQG1rXEflR5lGLSEAg2VQt3G0VcPX3xekHRbL5ni
        P3r2xMKi6qMjvyM47EKEVo5tWA==
X-Google-Smtp-Source: APXvYqw7/01BK2AK82CMWOt5K8aNWTlA5v03uhy/lj7bm5OhDkRgLGoZwMDY3iJtsa+WCiAtCNhtXA==
X-Received: by 2002:ac8:729a:: with SMTP id v26mr48203902qto.4.1571256067312;
        Wed, 16 Oct 2019 13:01:07 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c204sm13342030qkb.90.2019.10.16.13.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:01:06 -0700 (PDT)
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
Subject: [PATCH v7 19/25] arm64: kexec: arm64_relocate_new_kernel don't use x0 as temp
Date:   Wed, 16 Oct 2019 16:00:28 -0400
Message-Id: <20191016200034.1342308-20-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x0 will contain the only argument to arm64_relocate_new_kernel; don't
use it as a temp. Reassigned registers to free-up x0.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/relocate_kernel.S | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index e9c974ea4717..41f9c95fabe8 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -32,14 +32,14 @@ ENTRY(arm64_relocate_new_kernel)
 	mov	x14, xzr			/* x14 = entry ptr */
 	mov	x13, xzr			/* x13 = copy dest */
 	/* Clear the sctlr_el2 flags. */
-	mrs	x0, CurrentEL
-	cmp	x0, #CurrentEL_EL2
+	mrs	x2, CurrentEL
+	cmp	x2, #CurrentEL_EL2
 	b.ne	1f
-	mrs	x0, sctlr_el2
+	mrs	x2, sctlr_el2
 	ldr	x1, =SCTLR_ELx_FLAGS
-	bic	x0, x0, x1
+	bic	x2, x2, x1
 	pre_disable_mmu_workaround
-	msr	sctlr_el2, x0
+	msr	sctlr_el2, x2
 	isb
 1:	/* Check if the new image needs relocation. */
 	tbnz	x16, IND_DONE_BIT, .Ldone
@@ -51,17 +51,17 @@ ENTRY(arm64_relocate_new_kernel)
 	tbz	x16, IND_SOURCE_BIT, .Ltest_indirection
 
 	/* Invalidate dest page to PoC. */
-	mov     x0, x13
-	add     x20, x0, #PAGE_SIZE
+	mov     x2, x13
+	add     x20, x2, #PAGE_SIZE
 	sub     x1, x15, #1
-	bic     x0, x0, x1
-2:	dc      ivac, x0
-	add     x0, x0, x15
-	cmp     x0, x20
+	bic     x2, x2, x1
+2:	dc      ivac, x2
+	add     x2, x2, x15
+	cmp     x2, x20
 	b.lo    2b
 	dsb     sy
 
-	copy_page x13, x12, x0, x1, x2, x3, x4, x5, x6, x7
+	copy_page x13, x12, x1, x2, x3, x4, x5, x6, x7, x8
 	b	.Lnext
 .Ltest_indirection:
 	tbz	x16, IND_INDIRECTION_BIT, .Ltest_destination
-- 
2.23.0

