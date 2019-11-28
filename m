Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746DDC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D31E21771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="LBLkpB93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfK1O5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:57:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37401 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfK1O5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so20262812lfp.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xuBpN3zboz9lWIykWwJc5jpgUtQnVYVpKGpTSAHe1mY=;
        b=LBLkpB93pVGXgxOwmejvEDGNQ0wTX3sXVZAnOcyd8gmKFnbh6jMBjoDwjyb6YvDm4M
         XHCCmFN2eUGOVTINPAhI11+JlyAosCHBv2LK/vtsY+G2dWLFaEQSZ4Exo/mFOK5UMZLJ
         2LQB98mHBLqEsF/KxdOGUYnhPx8t8XlV/3yeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xuBpN3zboz9lWIykWwJc5jpgUtQnVYVpKGpTSAHe1mY=;
        b=Jsy3Y9R4+I1VmyfcF0YfI5a3r+xwkP8i0LrfiYfJSusbE9WvIVyMMPxNJWkPyWg2le
         WIf0ucs5s77PxZxfZ3KY4Hk7tObIpezPZVthhtiOklFrRZJV26z9TwNwtofYTfPMkQgz
         vwqHrxMHmuIBF1iIgVeqcgYoogy0eLlzyt0Vqf4D4zBjeksyCcLYn5L6LOTKhxr12Dgi
         BMEBeItpUHWdD4nHRZ0Gk6uCentgocpl0Ndz1CKLwY/82+MM/5eR9rw8EmiByUWzCapx
         uaPR3ApkhMLQmN+qOBqyyVZu4rAD6BpL7wtXK1JzpTk+flJk23iZdqSgscfK5ZyxNTmX
         DCMg==
X-Gm-Message-State: APjAAAXw6P7Sl/bh5JGVqyrYiBiaQfBBgqVDu9qcDz2zepn9dvwcGANn
        WmUhTO/DtPUgBAmKPxFA7K+yDA==
X-Google-Smtp-Source: APXvYqwT0EuyApqITA3lCeK5EuUs0sPJJq6so9cNaQVKnIZ5SJX2OXNZKYrUelwYNc4RA25bHCTp7w==
X-Received: by 2002:a19:e20b:: with SMTP id z11mr32438202lfg.171.1574953026680;
        Thu, 28 Nov 2019 06:57:06 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:06 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 02/49] soc: fsl: qe: drop volatile qualifier of struct qe_ic::regs
Date:   Thu, 28 Nov 2019 15:55:07 +0100
Message-Id: <20191128145554.1297-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual io accessors (e.g. in_be32) implicitly add a volatile
qualifier to their address argument. Remove volatile from the struct
definition and the qe_ic_(read/write) helpers, in preparation for
switching from the ppc-specific io accessors to generic ones.

Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 4 ++--
 drivers/soc/fsl/qe/qe_ic.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 9bac546998d3..791adcd121d1 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -171,12 +171,12 @@ static struct qe_ic_info qe_ic_info[] = {
 		},
 };
 
-static inline u32 qe_ic_read(volatile __be32  __iomem * base, unsigned int reg)
+static inline u32 qe_ic_read(__be32  __iomem *base, unsigned int reg)
 {
 	return in_be32(base + (reg >> 2));
 }
 
-static inline void qe_ic_write(volatile __be32  __iomem * base, unsigned int reg,
+static inline void qe_ic_write(__be32  __iomem *base, unsigned int reg,
 			       u32 value)
 {
 	out_be32(base + (reg >> 2), value);
diff --git a/drivers/soc/fsl/qe/qe_ic.h b/drivers/soc/fsl/qe/qe_ic.h
index 08c695672a03..9420378d9b6b 100644
--- a/drivers/soc/fsl/qe/qe_ic.h
+++ b/drivers/soc/fsl/qe/qe_ic.h
@@ -72,7 +72,7 @@
 
 struct qe_ic {
 	/* Control registers offset */
-	volatile u32 __iomem *regs;
+	u32 __iomem *regs;
 
 	/* The remapper for this QEIC */
 	struct irq_domain *irqhost;
-- 
2.23.0

