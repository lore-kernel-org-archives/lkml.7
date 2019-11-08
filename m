Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC3EFC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A274B2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Il3DCL7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfKHNBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:01:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42797 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfKHNBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:01:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id n5so6121799ljc.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IwcdyWxRDO/TUjQjvqfZVlSTaDYPWlQZLs741mWfW6c=;
        b=Il3DCL7vnUfDWk2t/dT7/uKy401t+E+TEtTumQV7aGFBMSqoz6kukNHfbvmCHSIxMK
         /rjkT3HHQ6iR29tHP+WnfsMgbjiel7Xdx3fOgzUS6UsDe/1qYDJMkQYd0Q/dL26XEB28
         /roXQK+QbBY6A5W42j+SwAhdORazO7kdTzDWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IwcdyWxRDO/TUjQjvqfZVlSTaDYPWlQZLs741mWfW6c=;
        b=puqaUb6n+U3gK/MvfA30hermXx+Mjp+68zQ0UB+YKI8vq9kvsdcHhOEYRhACgMl0fd
         twvf3JByJEO2lCPMzmqVT6cv49R6KflI1RVegkDWVtPx+Nu0ixiOxn3Y7cg7Y29Oa35O
         FQYlQbcF+pEwGgqcXJKCHa5uYqdExPBVkbzQTrgEzL2rM5WFEYAvEtLNpC9Tmcs3FVG2
         l6cMf9luRQ1DuGdVSaKtEDCJaV4zl+FGIWRZ1+YnMUbAhHkf7XynBcNMk+i+1+qLN+lb
         19fUJguEKjwg3dzx95V7kWPDfx6pRWioDOnKom4+Hja/yIIZLY2ef0vkFjz++jTn2J9G
         bLlg==
X-Gm-Message-State: APjAAAVxUj7W6gFCLp5GneBdGV89dppRyq5Nfet9SIQJ+fsZHYS6OUsI
        GRHr9syDKmAIDIWfThHAGB1x4A==
X-Google-Smtp-Source: APXvYqwQjL+XRBKvPBVlIVCDZcxIlePYwv4P23TGc8rNS3Ec1QKm2jAO9MNSrExrOF8chImjosB07Q==
X-Received: by 2002:a2e:8601:: with SMTP id a1mr6905527lji.159.1573218090373;
        Fri, 08 Nov 2019 05:01:30 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:29 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 02/47] soc: fsl: qe: drop volatile qualifier of struct qe_ic::regs
Date:   Fri,  8 Nov 2019 14:00:38 +0100
Message-Id: <20191108130123.6839-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
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

