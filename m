Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D65C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B26B2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Zbn0TqUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfKHNEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:04:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44271 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbfKHNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:01:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id g3so6103739ljl.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCPu9Gq+U2RPRhQiWL2MkNy7+uq9EAlYdyc3guVWBBY=;
        b=Zbn0TqUqcD96YghRBc/X/iOQIByImvq3b2H28LP6E3WW+L6HtOuQk199BV9LvKz/db
         Bpjx/GQAiq4IrmQChi7ORWA8wF6geONwz6VbNjMJZmFxnguPZi+6cWDfilXtwsGeOkTo
         6ZTAj+XUacs5EP1T4WFXCqrdnXAiLz+s4ibxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCPu9Gq+U2RPRhQiWL2MkNy7+uq9EAlYdyc3guVWBBY=;
        b=j2qVA10pgtuih6axFQL91kpRBPMSx1RMqU1IVVmNWkCZ97y3lAkWz5IigJX3F3r+cy
         0J+uTC5sNAlUdVMMPnRf9mZxP3ZqStIoVWeGHVi3YBK5U849J6nSJ7zMfzKNYv6Ka0td
         e6Afxf/pQpyeaYTf4+dY9ENC13jUPV9to9Gb8wgX5XDDbvMWqEubpsgqVVt/8mnDc6RF
         BIOJWmGTSWnxbcjzR8u5SWOHoXVYVuEMzGPt5RItS8V+Jtbd7lCSzhBgKLsLWUYT7an7
         S3f9YTT6PJX2goSWpVLDLfqsXexuJI9fHK2peoh0nrLG1xe1JfG/PeIzoROExy21BsDu
         w/sQ==
X-Gm-Message-State: APjAAAVtzukXXjPvDznpIlRrEPjpfUJ/OLeVREp71Nqs8GZCwVETKQ8U
        rIYOLCWJ4oL6JRT36x255Fgw1Q==
X-Google-Smtp-Source: APXvYqxwDPhHpkko9Bt/I2cILjd0+W6V/QCJlMsaEtYR7+B6IZRZpXjupVNQn9evCDrLDJvydWLhBw==
X-Received: by 2002:a2e:9216:: with SMTP id k22mr6887824ljg.157.1573218113677;
        Fri, 08 Nov 2019 05:01:53 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:53 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 20/47] soc: fsl: qe: simplify qe_ic_init()
Date:   Fri,  8 Nov 2019 14:00:56 +0100
Message-Id: <20191108130123.6839-21-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
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

