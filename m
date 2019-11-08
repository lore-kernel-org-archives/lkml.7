Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2FAC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23A02087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="R9nDo10U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfKHNB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:01:59 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36706 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfKHNB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:01:56 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15so6145263lja.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fFt1ZLVVia10843rsyK8F6LgIm9rFapqPGOb1a1zZs=;
        b=R9nDo10Ud+gNvAQJx2elWJ2ezKn4CYwaj9lzmRNdXz08cRh78MbVZXBE/b/1n9830H
         GTxAUYSWZutUrUKagsGjPC8/vcjW8kU/q7knuQiwKt2M/cK+vtRamqMJatpS1/Sa3gtc
         IR5Tc/3fEOCa/HsBcxU2W+UQQPA8VPCGGrF38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fFt1ZLVVia10843rsyK8F6LgIm9rFapqPGOb1a1zZs=;
        b=Qt3TAu1Iyvid5C+C8WRshZVfDR6AlmWqNdbK7jfmAQcWWrzthJp5Rq0FeFG6AUNf38
         JHt/2sjWXgL1Drr9+2XHEWqL0//QNUB0XlPQ7lyUUzG0Yd2XRIoJaSzU01rGqd3ZFKbu
         IygCc8Los5I0Fpb5Wecbxyhc/eFaTTjuO98/qbsEqIbI3T/n0Hw7SEsgaSwlM4Lap9nC
         HXlgDRYOUI8b03K1g6E39muKFAuY1KMtqzRomLUMUegTEi5AjNUx+nCb5g822UNGxOr1
         QRRz9CoDbq9o7KThYBUs7jIOOLPCDFXBWFpNUnszXIDkbqcCbRz54ylSxpkO/5k3Iwac
         Bxcw==
X-Gm-Message-State: APjAAAVdv4ox/CfwXkhzVTYtlGz7YsK3B8VsEaiHSnMuWQDpNEn3wzZ3
        QF5llkg/37nuCckXZH+D9tUckA==
X-Google-Smtp-Source: APXvYqyWkJ61oVgQyRyaemn/tR7SOVb1MBntplV1X66lNyC26HdXxpXW75kbtcBgtV0gvTyUHsBN/g==
X-Received: by 2002:a2e:9119:: with SMTP id m25mr6925324ljg.24.1573218112597;
        Fri, 08 Nov 2019 05:01:52 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:52 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 19/47] soc: fsl: qe: make qe_ic_get_{low,high}_irq static
Date:   Fri,  8 Nov 2019 14:00:55 +0100
Message-Id: <20191108130123.6839-20-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are only called from within qe_ic.c, so make them static.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c |  4 ++--
 include/soc/fsl/qe/qe_ic.h | 10 ----------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 8f74bc6efd5c..23b457e884d8 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -283,7 +283,7 @@ static const struct irq_domain_ops qe_ic_host_ops = {
 };
 
 /* Return an interrupt vector or 0 if no interrupt is pending. */
-unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
+static unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 {
 	int irq;
 
@@ -299,7 +299,7 @@ unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 }
 
 /* Return an interrupt vector or 0 if no interrupt is pending. */
-unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
+static unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 {
 	int irq;
 
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index d47eb231519e..70bb5a0f6535 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -53,14 +53,4 @@ enum qe_ic_grp_id {
 	QE_IC_GRP_RISCB		/* QE interrupt controller RISC group B */
 };
 
-#ifdef CONFIG_QUICC_ENGINE
-unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic);
-unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic);
-#else
-static inline unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
-{ return 0; }
-static inline unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
-{ return 0; }
-#endif /* CONFIG_QUICC_ENGINE */
-
 #endif /* _ASM_POWERPC_QE_IC_H */
-- 
2.23.0

