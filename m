Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1044C43141
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0A12075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Sz+4aR+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfKRLXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:23:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43165 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfKRLXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:23:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id n1so18953216wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IwcdyWxRDO/TUjQjvqfZVlSTaDYPWlQZLs741mWfW6c=;
        b=Sz+4aR+XSGM2dxRcEf/Lg3e1F21fr0gSMF1utE9+uJ+WcwgrdO1piHtt7U8T3eCxvf
         r5gIQNG80QiL5t6F2XvYleE8csbrh3yEThvgdQl0DRkURhpxjUqL+dmgA/eRrtpXL1Xh
         ygKiD6Qbs7jiWktH6qrUK8fTXuMrpTyPJM4XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IwcdyWxRDO/TUjQjvqfZVlSTaDYPWlQZLs741mWfW6c=;
        b=KYsJpK/WGHb9bKh2O7TOrAReQ3UghOrpzCtkgP0WH+iyn7JAdrOvNHk79Hq31krE/T
         B+l5h8+sW2ftL1Y7tp6tmBJfP/zX534Yp/CjJuMlA7VYZYjIK1lFUNgigm7pEbWRM9j5
         FqIBLz0muyR+Q56pbohQIBrrw4xVG2jd5buWDi2vhjIoxOaYui3dswRrb/Q2u5Q+3qyn
         z0ly5I9H5o2fD7gpy6fytlYJQ0LpSiAWPCFgIUrPYAL5DVh0f3eg5tB3pxZfrw/IxB0u
         mTPToMzu8Em51FrWpkMUtwP/+EjpPfD3E3ChprRV+GnGvXfFVpA1wG7q5NyEe4c1EmRE
         53xg==
X-Gm-Message-State: APjAAAUUhQcTGNtelrPpNMcP+O8ZN+LuquCjxi+ssEjpsBI3DODAkJ4L
        GZBlwzTqgQ8Rz9N3WXBIkFx7yA==
X-Google-Smtp-Source: APXvYqwGk1A/LCVtv+NubsNAg/aIVMCi2DaFT991ms12iNqJyI5WUhwTMNywFG7BT5oVuXqpu44oVA==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr29933260wrv.247.1574076212866;
        Mon, 18 Nov 2019 03:23:32 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:23:32 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 02/48] soc: fsl: qe: drop volatile qualifier of struct qe_ic::regs
Date:   Mon, 18 Nov 2019 12:22:38 +0100
Message-Id: <20191118112324.22725-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
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

