Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A04CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EB621897
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="EBWLnh2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfKAMmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:42:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38582 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfKAMmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id q28so7152307lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IwcdyWxRDO/TUjQjvqfZVlSTaDYPWlQZLs741mWfW6c=;
        b=EBWLnh2gewMrrOR7Ur4LtjqcL3qopz+JE1MaR/3SxQxLBmY2+j/GbFh12o1lOdzalc
         ZRBnxmxYZCyK/rBsgZu94RdJDHriGBjSx7Za5We9/D7NfeWht012JDaNZ7n9PZuuewps
         BAJRmnhCZcl0RMHcCXhFwHJnb4m8Sqwg157Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IwcdyWxRDO/TUjQjvqfZVlSTaDYPWlQZLs741mWfW6c=;
        b=HNUc5+nJjbvMNPbXwgbMrMxtcHkR62T1ZAscoxaCMsrccMNfs0OTiQ5v8XKTPE+cK4
         IzgPy54/UXNMTqnu03zdolh8xuXk2xqx4cJLJgz0cNjOQ/9UuypAfGVHXpUM5pb02Bpu
         ipP2QkPW5Wvj4Gt725hfrldvmOS+fhoLcm85xnZaQZnNSu1L3Qh38TYTvXTT7QqdSnNK
         jMI3Y5UVCUr/YPSdIKNVCb+Y1BLvz1UCoo3PN9sBuIgE7HSRh7H85xvy1g4rcy8tSYSU
         /LOBp+A8/RMt1gPqP+Z5kKlsDpqldnfqL67UkLipajvW+TBEjLrPcskGemFxiVdFWLzQ
         /ebg==
X-Gm-Message-State: APjAAAXajaw13zJaVtTujGb9r9EPp4Gu7VQiu6OdruHlUdA1qaXGlXh6
        jiuOZwLcLiav1e0BU89th+ejWQ==
X-Google-Smtp-Source: APXvYqxzoeTf3Ohah/Hpr41qNMeO2Vmhemx5HLuusE1IMFHrUr2Wo8tZj5QwdBFSwyhHAjtrni+Ssw==
X-Received: by 2002:ac2:5295:: with SMTP id q21mr7028523lfm.93.1572612137175;
        Fri, 01 Nov 2019 05:42:17 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:16 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 02/36] soc: fsl: qe: drop volatile qualifier of struct qe_ic::regs
Date:   Fri,  1 Nov 2019 13:41:36 +0100
Message-Id: <20191101124210.14510-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
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

