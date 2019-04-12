Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0052CC282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7502084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfDLKuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:50:17 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58124 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfDLKuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:50:17 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D42E2000CE;
        Fri, 12 Apr 2019 12:50:15 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 910EA200006;
        Fri, 12 Apr 2019 12:50:15 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.13])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 343D120601;
        Fri, 12 Apr 2019 12:50:15 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     linuxppc-dev@lists.ozlabs.org, oss@buserror.net, mpe@ellerman.id.au
Cc:     linux-kernel@vger.kernel.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        stable@vger.kernel.org
Subject: [PATCH] powerpc/booke64: set RI in default MSR
Date:   Fri, 12 Apr 2019 13:50:09 +0300
Message-Id: <20190412105009.14221-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Set SI in the default kernel's MSR so that the architected way of
detecting unrecoverable machine check interrupts has a chance to work.
This is inline with the MSR setup of the rest of booke powerpc
architectures configured here.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: stable@vger.kernel.org
---
 arch/powerpc/include/asm/reg_booke.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index eb2a33d5df26..e382bd6ede84 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -41,7 +41,7 @@
 #if defined(CONFIG_PPC_BOOK3E_64)
 #define MSR_64BIT	MSR_CM
 
-#define MSR_		(MSR_ME | MSR_CE)
+#define MSR_		(MSR_ME | MSR_RI | MSR_CE)
 #define MSR_KERNEL	(MSR_ | MSR_64BIT)
 #define MSR_USER32	(MSR_ | MSR_PR | MSR_EE)
 #define MSR_USER64	(MSR_USER32 | MSR_64BIT)
-- 
2.17.1

