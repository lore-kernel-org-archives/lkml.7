Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308D2C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18A620578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Ll7Xf50N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfEGTlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:41:16 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:33744 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGTlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1557258074; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=dDlIc1LhGttw6Zm+8qHMSGAIbRm2qsIU1NXuMH8CFM8=;
        b=Ll7Xf50N170tFv4iwPKFMDCMEvSrdJBTziEShjQek9JJ5vyLNn6R+PtjKhIhgp2RWsiJg8
        ito6YErP6gmhtMf1/1oLbXjJdom1NYo8h8mh937FflTbC5wX5cAbnkW2sMEAB+3bF53VIa
        hXJHMsuvpDanOR92PwkW+e2kyschFEM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     od@zcrc.me, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] MIPS: jz4740: Fix Ingenic SoCs sometimes reporting wrong ISA
Date:   Tue,  7 May 2019 21:41:01 +0200
Message-Id: <20190507194101.17112-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config0 register in the Xburst always reports a MIPS32r2
ISA, but not all of them support it.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/jz4740/setup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index 7e63c54eb8d2..2508c026bdfa 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -64,6 +64,7 @@ static unsigned long __init get_board_mach_type(const void *fdt)
 
 void __init plat_mem_setup(void)
 {
+	struct cpuinfo_mips *c = &current_cpu_data;
 	int offset;
 	void *dtb;
 
@@ -81,6 +82,18 @@ void __init plat_mem_setup(void)
 		jz4740_detect_mem();
 
 	mips_machtype = get_board_mach_type(dtb);
+
+	switch (mips_machtype) {
+	case MACH_INGENIC_JZ4740:
+		/*
+		 * The config0 register in the Xburst always reports a MIPS32r2
+		 * ISA, but not all of them support it.
+		 */
+		c->isa_level &= ~MIPS_CPU_ISA_M32R2;
+		break;
+	default:
+		break;
+	}
 }
 
 void __init device_tree_init(void)
-- 
2.21.0.593.g511ec345e18

