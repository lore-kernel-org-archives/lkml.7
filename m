Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B02C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02F321774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="i39lh9aW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfK1O5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:57:32 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44404 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfK1O52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19so1820996lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fm8vGKJ4TPWor/SrNM6rE461Gf1D2pmUecTv9capx2A=;
        b=i39lh9aWGpqjz9XI/OFfEnvTGPZ/LiEky1vlTemc4GbVU8oOBhimEDgTQM9P09m6O6
         ObJeoq+Tbxu8vuPW/WPjlrom7jcqajGns3DbLkvaoMUMSW2SLdVnLnossT4Iz0XqNKud
         NCte6uFdJbKUOLro5cdE0VeP2XQzQJmLJ3NL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fm8vGKJ4TPWor/SrNM6rE461Gf1D2pmUecTv9capx2A=;
        b=SSWX0TPwncYAEa1ZDfovN+rzohbWOxw9dSHhWQ+ZvLskre6lU7B2M3PQDlMFLPfLJ7
         CeNJOVSPUXW0RWSjEdOe/Xlxlq2oTQpQygUO6FYuZPjLRrtolM3/wkMjtJ2Mc+hxCR9H
         8iniOJhv4pURsIduWmH4OT4tx0L5E3MNIHHX5LMVaqD6zKJV84NlU2zkCfWhgC0Qm232
         l18FYJj10vak/Vi2DrCBwpLGL0s8BKddN2XApyb3K3sBUdR55nPeUXDJ5miViVPbMx55
         jFTtteaMrK5d78ijDKo3lrcuTxI3/vl2Y5+hZvc6MZDyu4wlVdhmMNc2YQvRWw9NCfcb
         7TwA==
X-Gm-Message-State: APjAAAVR3VvZYN6bzwuimspCjtF9wIZ5IEwWcUs9Vz5zZmU+70JfxPZa
        OxY29PQjNkgBRN+EPuSpjJxlRA==
X-Google-Smtp-Source: APXvYqzOH4CCR5V7oe5QpALAtS3/oGlBdApJLkD4j0pv6h8wj8vcXCUvjS7Un4muT3AhfCe2YXCDXA==
X-Received: by 2002:a2e:6e07:: with SMTP id j7mr3589919ljc.18.1574953046004;
        Thu, 28 Nov 2019 06:57:26 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:25 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 16/49] soc: fsl: qe: rename qe_ic_cascade_low_mpic -> qe_ic_cascade_low
Date:   Thu, 28 Nov 2019 15:55:21 +0100
Message-Id: <20191128145554.1297-17-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qe_ic_cascade_{low,high}_mpic functions are now used as handlers
both when the interrupt parent is mpic as well as ipic, so remove the
_mpic suffix.

Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 94ccbeeb1ad1..de2ca2e3a648 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -314,7 +314,7 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
 
-static void qe_ic_cascade_low_mpic(struct irq_desc *desc)
+static void qe_ic_cascade_low(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
@@ -327,7 +327,7 @@ static void qe_ic_cascade_low_mpic(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
 
-static void qe_ic_cascade_high_mpic(struct irq_desc *desc)
+static void qe_ic_cascade_high(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
@@ -392,8 +392,8 @@ static void __init qe_ic_init(struct device_node *node, unsigned int flags)
 		return;
 	}
 	if (qe_ic->virq_high != qe_ic->virq_low) {
-		low_handler = qe_ic_cascade_low_mpic;
-		high_handler = qe_ic_cascade_high_mpic;
+		low_handler = qe_ic_cascade_low;
+		high_handler = qe_ic_cascade_high;
 	} else {
 		low_handler = qe_ic_cascade_muxed_mpic;
 		high_handler = NULL;
-- 
2.23.0

