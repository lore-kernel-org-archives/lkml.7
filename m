Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED3CFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53CB20659
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="iMPvlmMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfKHNBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:01:47 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42828 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfKHNBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:01:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id n5so6122571ljc.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XBMri+/30LVPDwr/Z+UtZHm4sLSriiAUm4o/nxS90ZM=;
        b=iMPvlmMCvod0FN1nC9Xfoxe9VFeVCDr0/g0n1DjjJ5HKuIql2dY5TK/RIBodr7QFJs
         Ge4srl9274vy84VVa9W68VDsl5HRT/aXz0epnb7/pl/5sxWGOmiQgiFZDxKPPg/v3DMz
         VTs+/nLr5ZN2XdFAOiQVRTIUukU0xvF1sugEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XBMri+/30LVPDwr/Z+UtZHm4sLSriiAUm4o/nxS90ZM=;
        b=PHo9cYWlUgQox1vqLaBCTdumT5TZYFhGNUESu3Y6u6JZ87gRHQ67E9UHuPMJDlo3aX
         fjZedUWVmBf1PeKHSmVLHdCbIbrJ6I13zFmk23kypQo5HVgA+gfgmIH6yFmkHO8pVewr
         CUqSNBLEHI8E9EDz3aZWxIKnvE2xWuIzS5jb00+RRah/0GtcxLeewkh5+QinZ9vOsiz7
         J4lqIE8eBbM2Lq/Ak8Iy7JsiqB5N0UIG8yj1szZNwLXklCbpPDB12FtAlo9dw8PVJVFt
         Ddm5BRQvaPyc81kvbCPFKSLDF8Jsm/yPbHzWLvfsQ3oTzyBjhUOrubeqJj+GxnbRuaDz
         KR2w==
X-Gm-Message-State: APjAAAXPCm1Zm1zQq4k2wM/SZ4wIj0JSLCjym8hIwTFclnz9hiNJzA3s
        VQ1URm2/JqmmogkJCLjmob3+cg==
X-Google-Smtp-Source: APXvYqwZ07+4uYyzJDz1xwrMxLwZbohRXCN2asZuxugqVACf8ojTGp/E6vm7s7NPOAFmelQ3AyTRyw==
X-Received: by 2002:a2e:9712:: with SMTP id r18mr6970474lji.12.1573218101817;
        Fri, 08 Nov 2019 05:01:41 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:41 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 11/47] soc: fsl: qe: use qe_ic_cascade_{low,high}_mpic also on 83xx
Date:   Fri,  8 Nov 2019 14:00:47 +0100
Message-Id: <20191108130123.6839-12-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The *_ipic and *_mpic handlers are almost identical - the only
difference is that the latter end with an unconditional
chip->irq_eoi() call. Since IPIC does not have ->irq_eoi, we can
reduce some code duplication by calling irq_eoi conditionally.

This is similar to what is already done in mpc8xxx_gpio_irq_cascade().

This leaves the functions slightly misnamed, but that will be fixed in
a subsequent patch.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/platforms/83xx/misc.c |  2 +-
 include/soc/fsl/qe/qe_ic.h         | 24 ++++--------------------
 2 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index f46d7bf3b140..779791c0570f 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -100,7 +100,7 @@ void __init mpc83xx_qe_init_IRQ(void)
 		if (!np)
 			return;
 	}
-	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
+	qe_ic_init(np, 0, qe_ic_cascade_low_mpic, qe_ic_cascade_high_mpic);
 	of_node_put(np);
 }
 
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index 714a9b890d8d..bfaa233d8328 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -74,24 +74,6 @@ void qe_ic_set_highest_priority(unsigned int virq, int high);
 int qe_ic_set_priority(unsigned int virq, unsigned int priority);
 int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
 
-static inline void qe_ic_cascade_low_ipic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-}
-
-static inline void qe_ic_cascade_high_ipic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-}
-
 static inline void qe_ic_cascade_low_mpic(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
@@ -101,7 +83,8 @@ static inline void qe_ic_cascade_low_mpic(struct irq_desc *desc)
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 
-	chip->irq_eoi(&desc->irq_data);
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
 }
 
 static inline void qe_ic_cascade_high_mpic(struct irq_desc *desc)
@@ -113,7 +96,8 @@ static inline void qe_ic_cascade_high_mpic(struct irq_desc *desc)
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 
-	chip->irq_eoi(&desc->irq_data);
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
 }
 
 static inline void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
-- 
2.23.0

