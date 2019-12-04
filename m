Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CDEC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E32220865
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Ex89ONXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfLDQAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:00:48 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35134 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbfLDQAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:00:10 -0500
Received: by mail-qk1-f194.google.com with SMTP id v23so383869qkg.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 08:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dqtgvoRdMawEKh+xykZ1VqYMRicExyc/MR9wF15sbHw=;
        b=Ex89ONXqJCjErir/CSjvl4mBDjlt4VxRe8WcaAYsgMxni+4Rr3afXkK/SCnmpvCS+r
         CYrew3webB+wFVwwpeB0eVsnktSmlCCoNUSL2Pnnp0KjEe4oWMsL6no4bK6wo3DUInMA
         HE7gd3XjA51lMruvsscVz/TwtVLMWVOQMlcoyExnU/25fpveSdADWsJ+0VDpYAizwvsp
         Gv1nN3tZyoTkFwr/N58bbS/C3oHGE/kgeB/pxI95M3rcCAiJMLprGEN7zWUYK/Qq3Ax9
         cParO33UFyIsQpW5hSvZJRWf5fgppuQr986piZ8w9qPr7Ooo0TTQDuZ9448rRyZv7T4j
         acGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dqtgvoRdMawEKh+xykZ1VqYMRicExyc/MR9wF15sbHw=;
        b=YiZv502pxOi3nwC9muWIWTlwHjBjT6SJqrqV4aUYgvxPOYAHWtIjhpFMmJ8TDTX8DJ
         +DvosfFbxfVmZf2G7J2pkjO/oOk7MPbBnbtjJZiQ5HM/diKb6EpfHoMe7VkLgFwaPMYf
         6LE/WUgNwERl2oLYph5TTCzg7uwP0S9KCF7+1+d+eFHCmeMClhfTNpVTzv6TyaoZmvDz
         UBgLaCksCYOqwcEnOgP7bF2TT2eDUFvjDlCqPQLpeIAtut6CfMRM0KNAgeUoNUsESuBk
         ZNpy4fanLd3bp3y+zFwdL3R21NftVaAVL/nya2+IRcXVieJf0R9awg/WW2MsWeiD5M/V
         Y7Lg==
X-Gm-Message-State: APjAAAUtUQb8fPgbUOcg+qmCiR/U3lpeP53kqi6ZpAG93kdCIav7xysN
        FkIZs1duc8/lGUlTmxUy/dbthg==
X-Google-Smtp-Source: APXvYqwJuTv1+brNarCqrfi93wNDwS5RdOuPajdDtgQaRMjcuOxzMm2jiZSYAFlmf5mRNTazIaIUmA==
X-Received: by 2002:a37:4c8e:: with SMTP id z136mr3750671qka.177.1575475209021;
        Wed, 04 Dec 2019 08:00:09 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w21sm4177585qth.17.2019.12.04.08.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 08:00:08 -0800 (PST)
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
Subject: [PATCH v8 19/25] arm64: kexec: arm64_relocate_new_kernel don't use x0 as temp
Date:   Wed,  4 Dec 2019 10:59:32 -0500
Message-Id: <20191204155938.2279686-20-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
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
2.24.0

