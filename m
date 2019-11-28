Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E063BC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B417A217BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="eSJlsgRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfK1O5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:57:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39256 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfK1O5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id e10so19657906ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=USinHcmv+ksGlMbxnbmLxuy0P66Q7HhR0AFEthjqY1w=;
        b=eSJlsgRoqTynoxnNeBVf+IkwM63Ac9ztMdfQvsjRq5txZGy2t6QSH9CnnZBD6OwU/1
         lTHMy3iujv02EGiXw6caHkTIq1GPRdwgs/vakISvyvy3Qg3GSi0krDWObXmh6NsbadOB
         8i55Z4UFd0jKdGfVl09SKBp5q/JKGOoPvK+tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=USinHcmv+ksGlMbxnbmLxuy0P66Q7HhR0AFEthjqY1w=;
        b=GoSxLSHN7NdWbUW2Ci8QG8v508sVOfC6udgnkz+qE/smVSKb7e8TB+VHM2RFccYb9J
         p/7IFGLUMgn5RZ/txpk32xIrmnVwZD0Rgo9Ub5W7uWNCNnNUMHwYiZYKhd1irQez6v/T
         cn4kApZSk0kmhmq+eQVvrFGVGFl7kW7m3Gr7EMnvF+VzmR8q+fJC7yDjKjGmTQFqugI8
         NRpRrjKcz6AmM48qpt5BmC3PLt23psiFbRsEHjiX8jwn1cdlSBgVlRfQYceMWjOUe0F4
         tz4Ia1oAaGtmn4RT5wzU/c4WYl8Y4UX/b7Xi0wsd06wxsUXD1PR8y3wyZBBjy8BCzmHK
         qbkQ==
X-Gm-Message-State: APjAAAXVJoAKWBp8yfNQ5V+E2Ws/LTeH2nOYnDhc8Sw6mAR9F+5Yq5uf
        EmuOKyLWBkGtypFCAmkMtJ90xg==
X-Google-Smtp-Source: APXvYqwWbKVLrkCPCqAQ45HonIHroFiKt/f5U++VVvIibHXJ05e3osalBaVmWBSGtrrlGbxRgN9fcw==
X-Received: by 2002:a2e:2a43:: with SMTP id q64mr35565201ljq.242.1574953050912;
        Thu, 28 Nov 2019 06:57:30 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:30 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 20/49] soc: fsl: qe: simplify qe_ic_init()
Date:   Thu, 28 Nov 2019 15:55:25 +0100
Message-Id: <20191128145554.1297-21-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qe_ic_init() takes a flags parameter, but all callers (including the
sole remaining one) have always passed 0. So remove that parameter and
simplify the body accordingly. We still explicitly initialize the
Interrupt Configuration Register (CICR) to its reset value of
all-zeroes, just in case the bootloader has played funny games.

Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 23b457e884d8..4832884da5bb 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -356,13 +356,13 @@ static void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
 	chip->irq_eoi(&desc->irq_data);
 }
 
-static void __init qe_ic_init(struct device_node *node, unsigned int flags)
+static void __init qe_ic_init(struct device_node *node)
 {
 	void (*low_handler)(struct irq_desc *desc);
 	void (*high_handler)(struct irq_desc *desc);
 	struct qe_ic *qe_ic;
 	struct resource res;
-	u32 temp = 0, ret;
+	u32 ret;
 
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret)
@@ -399,26 +399,7 @@ static void __init qe_ic_init(struct device_node *node, unsigned int flags)
 		high_handler = NULL;
 	}
 
-	/* default priority scheme is grouped. If spread mode is    */
-	/* required, configure cicr accordingly.                    */
-	if (flags & QE_IC_SPREADMODE_GRP_W)
-		temp |= CICR_GWCC;
-	if (flags & QE_IC_SPREADMODE_GRP_X)
-		temp |= CICR_GXCC;
-	if (flags & QE_IC_SPREADMODE_GRP_Y)
-		temp |= CICR_GYCC;
-	if (flags & QE_IC_SPREADMODE_GRP_Z)
-		temp |= CICR_GZCC;
-	if (flags & QE_IC_SPREADMODE_GRP_RISCA)
-		temp |= CICR_GRTA;
-	if (flags & QE_IC_SPREADMODE_GRP_RISCB)
-		temp |= CICR_GRTB;
-
-	/* choose destination signal for highest priority interrupt */
-	if (flags & QE_IC_HIGH_SIGNAL)
-		temp |= (SIGNAL_HIGH << CICR_HPIT_SHIFT);
-
-	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
+	qe_ic_write(qe_ic->regs, QEIC_CICR, 0);
 
 	irq_set_handler_data(qe_ic->virq_low, qe_ic);
 	irq_set_chained_handler(qe_ic->virq_low, low_handler);
@@ -439,7 +420,7 @@ static int __init qe_ic_of_init(void)
 		if (!np)
 			return -ENODEV;
 	}
-	qe_ic_init(np, 0);
+	qe_ic_init(np);
 	of_node_put(np);
 	return 0;
 }
-- 
2.23.0

