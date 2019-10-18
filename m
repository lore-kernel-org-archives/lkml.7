Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4665BCA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2B5222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="KFyP8ivf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410073AbfJRMww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:52:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33126 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410020AbfJRMwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:52:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id y127so4661302lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 05:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/kYsXKDEeEBcA1fCE+mpoBIaUoXu8b4ge6C0aEmGGA=;
        b=KFyP8ivfbpHtepeGzrcdL51yIH0E0bUb8X+4a2KH0HGN4QWsIwbhQQBDFzpw8B4QAS
         RbUd93jPl4MuGJetIgGZbsZyOKrmZfbazbh3U8W4NiWpzrx9at5H+K/9lL3NoBdPWnbx
         iTRZaQAOW1xXsH1h45p9Y3RpNKZaeJif7ZIvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/kYsXKDEeEBcA1fCE+mpoBIaUoXu8b4ge6C0aEmGGA=;
        b=Dwkgufu6xK3RkYSHOx/mTW0XOzcVDn2Vt/6WenHD4y7q7bBval+L5Ox3UFPppkEufK
         nCxZLkQx+yocgN68DuxzNIn42G/wRkDtwP4b6zJ+HxBKcUiFZD5K/pESEpX9uG8aQVoI
         S2mIYxW0pKOixETg7XMnLUE2nACvXfXhjukw05TPbrkGD/hG0kefh35l95cCme5cKqV3
         j60GuK32nuOmfG8QgqljjL32HGldaR/b0GaF1BjT8SqHXx/k4MkdeqgXfJl5BfIVqqUC
         Rs2eLXH5ApQTwwIJKiAacAzzLnWA2rrJA2cUUOtU/yObiKLus5j/yZ1OKK+GQOP7tdcp
         0Txg==
X-Gm-Message-State: APjAAAUmBIEeN2bzC0Enj0O0KqCah4rTg4DhDjmUXDD/OTHfe3QV+4ny
        2PWE/jTpquRGOPNDdqRYkWzzAQ==
X-Google-Smtp-Source: APXvYqwfp2OR81F0L53trJi7RZb+gW5SZ6EFdq5/LmCgN8KPrYOURZTPP/LvsMtj32ugvHQiRs800Q==
X-Received: by 2002:a05:6512:71:: with SMTP id i17mr5903293lfo.68.1571403163737;
        Fri, 18 Oct 2019 05:52:43 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m17sm7454792lje.0.2019.10.18.05.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:52:42 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] soc: fsl: qe: drop volatile qualifier of struct qe_ic::regs
Date:   Fri, 18 Oct 2019 14:52:29 +0200
Message-Id: <20191018125234.21825-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
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
index 9bac546998d3..9694569dcc76 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -171,12 +171,12 @@ static struct qe_ic_info qe_ic_info[] = {
 		},
 };
 
-static inline u32 qe_ic_read(volatile __be32  __iomem * base, unsigned int reg)
+static inline u32 qe_ic_read(__be32  __iomem * base, unsigned int reg)
 {
 	return in_be32(base + (reg >> 2));
 }
 
-static inline void qe_ic_write(volatile __be32  __iomem * base, unsigned int reg,
+static inline void qe_ic_write(__be32  __iomem * base, unsigned int reg,
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
2.20.1

