Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36386C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069552082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259087;
	bh=q9vXDCMmk46qkDRsY0YXqTDO21XzZ3AHPZY0DzRadHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p2yAXKK+15L10Y4Qbq3oTckDpgmLzaR5NwlBbyX8THArPg0USapd48c8wccz8239V
	 mcEhuZEg5kcBnlsxja9YYGrGv2uzCGyr6g9hyyviofa6X+KrBFsInd0VpYwnvMDI3x
	 AHa5usM9AK/LysKygxfzRnnSA56mhXpEzJWx/Sv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbfCVLyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733141AbfCVLyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:54:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B47421916;
        Fri, 22 Mar 2019 11:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255658;
        bh=q9vXDCMmk46qkDRsY0YXqTDO21XzZ3AHPZY0DzRadHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcO/KPY77Rz2MYFFGzHwzvrLG+RMdJhELOSGx1msB5ajaspls/f0Y2naqiAjW5cK/
         /f4ynTr29mYU/oBmYjSerymsJxXFW/jZHd2BUSqOXu/YQUT+KbPVMAwhRdK7q6l9sp
         35rFHVefL0WqzGQxRn5T10rOW8zgpxsvTjybYupk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 141/183] powerpc/83xx: Also save/restore SPRG4-7 during suspend
Date:   Fri, 22 Mar 2019 12:16:09 +0100
Message-Id: <20190322111251.976316124@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 36da5ff0bea2dc67298150ead8d8471575c54c7d upstream.

The 83xx has 8 SPRG registers and uses at least SPRG4
for DTLB handling LRU.

Fixes: 2319f1239592 ("powerpc/mm: e300c2/c3/c4 TLB errata workaround")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/83xx/suspend-asm.S |   34 +++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

--- a/arch/powerpc/platforms/83xx/suspend-asm.S
+++ b/arch/powerpc/platforms/83xx/suspend-asm.S
@@ -26,13 +26,13 @@
 #define SS_MSR		0x74
 #define SS_SDR1		0x78
 #define SS_LR		0x7c
-#define SS_SPRG		0x80 /* 4 SPRGs */
-#define SS_DBAT		0x90 /* 8 DBATs */
-#define SS_IBAT		0xd0 /* 8 IBATs */
-#define SS_TB		0x110
-#define SS_CR		0x118
-#define SS_GPREG	0x11c /* r12-r31 */
-#define STATE_SAVE_SIZE 0x16c
+#define SS_SPRG		0x80 /* 8 SPRGs */
+#define SS_DBAT		0xa0 /* 8 DBATs */
+#define SS_IBAT		0xe0 /* 8 IBATs */
+#define SS_TB		0x120
+#define SS_CR		0x128
+#define SS_GPREG	0x12c /* r12-r31 */
+#define STATE_SAVE_SIZE 0x17c
 
 	.section .data
 	.align	5
@@ -103,6 +103,16 @@ _GLOBAL(mpc83xx_enter_deep_sleep)
 	stw	r7, SS_SPRG+12(r3)
 	stw	r8, SS_SDR1(r3)
 
+	mfspr	r4, SPRN_SPRG4
+	mfspr	r5, SPRN_SPRG5
+	mfspr	r6, SPRN_SPRG6
+	mfspr	r7, SPRN_SPRG7
+
+	stw	r4, SS_SPRG+16(r3)
+	stw	r5, SS_SPRG+20(r3)
+	stw	r6, SS_SPRG+24(r3)
+	stw	r7, SS_SPRG+28(r3)
+
 	mfspr	r4, SPRN_DBAT0U
 	mfspr	r5, SPRN_DBAT0L
 	mfspr	r6, SPRN_DBAT1U
@@ -493,6 +503,16 @@ mpc83xx_deep_resume:
 	mtspr	SPRN_IBAT7U, r6
 	mtspr	SPRN_IBAT7L, r7
 
+	lwz	r4, SS_SPRG+16(r3)
+	lwz	r5, SS_SPRG+20(r3)
+	lwz	r6, SS_SPRG+24(r3)
+	lwz	r7, SS_SPRG+28(r3)
+
+	mtspr	SPRN_SPRG4, r4
+	mtspr	SPRN_SPRG5, r5
+	mtspr	SPRN_SPRG6, r6
+	mtspr	SPRN_SPRG7, r7
+
 	lwz	r4, SS_SPRG+0(r3)
 	lwz	r5, SS_SPRG+4(r3)
 	lwz	r6, SS_SPRG+8(r3)


