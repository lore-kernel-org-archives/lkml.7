Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE879CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9C92067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="UXSfxpHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbfKAMoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:44:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41995 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730710AbfKAMmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id z12so7135036lfj.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gmfKhQtUBCxwlUAlf/yXjWEx2pu0ns3cTlzrvt6tvNM=;
        b=UXSfxpHZDEqdEcznJJ01lBccn98ayqUFZZcnn4HjFFyx1fU3hgTEoyvXq4O6pG5ZZI
         U/w9LlPIsW1A1dAZRSyiuJJNlvZVau9/FsrlVowbQwFYlqiXCr9YcgR5M/iiQkXVMY1R
         LsP90oGXg+SPrPmXk/6D+n3hP+iz0NL7CdujM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmfKhQtUBCxwlUAlf/yXjWEx2pu0ns3cTlzrvt6tvNM=;
        b=TXoz+jYCkSHq9dnpuRhGw48D+uPk0/xh1VncDaIOmosvS46VYwh8zmKfxy2+zcurWt
         Tt9kSOfjzMDkWZCGC6OD8cKNU8/dI2wnDFVLo/qYJTtVrIOi+M2KHZEEOAaImHgL7w54
         BloCv8fFp9XuXsYrnqMzg9Hlnty8GP3Rx68gNClJdRWaOf1K2NNrVqJDNY1cYAcdbAWW
         zUtabsrGWVfajq/TB19GCC1KimFIJpT311wUMTL2XAlApqndohYq6gW4/b+CXDRO0aHA
         NkJGl2M/UYv3hwEDmT9IAE50E7RN1JSWi0efw8yWJmvepSCiqxSeaftKbuXXqo+VwEaJ
         fBng==
X-Gm-Message-State: APjAAAUQn8Y/yAYsFeE+Pk9xiZrppOfBDUA6nqHmj3wjv+3O2o+u4h8v
        w+iODLIGCF758eZSGZtN+C3C+Q==
X-Google-Smtp-Source: APXvYqzczthO3WgiTrJP30sDUF5olr6LOJxJupECp85CLX8rCXzFYzODyCv6KeCqqwbY17Ez6ShIsQ==
X-Received: by 2002:a05:6512:40e:: with SMTP id u14mr7239281lfk.73.1572612155926;
        Fri, 01 Nov 2019 05:42:35 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:35 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 16/36] soc: fsl: qe: rename qe_ic_cascade_low_mpic -> qe_ic_cascade_low
Date:   Fri,  1 Nov 2019 13:41:50 +0100
Message-Id: <20191101124210.14510-17-linux@rasmusvillemoes.dk>
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

The qe_ic_cascade_{low,high}_mpic functions are now used as handlers
both when the interrupt parent is mpic as well as ipic, so remove the
_mpic suffix.

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

