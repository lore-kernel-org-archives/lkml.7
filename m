Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE57C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BD120891
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="UVTics3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfKRLYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:24:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33722 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfKRLX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:23:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id w9so19020387wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fFt1ZLVVia10843rsyK8F6LgIm9rFapqPGOb1a1zZs=;
        b=UVTics3lL4qvxi3oisNP7w0QJ8T5szNsG1ROc5MisQWYc3ObAFu0rpCi1aJlci2gds
         3ltOHohbpQ1GBb+AkEOB/xMhLUt61gmR9I8uzbGKEHcBuFOAWSMIXaFnCUiygT8FuHJh
         mbBye4MDO/U9RS1YNe8F/V6sJn39y6c3lUahM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fFt1ZLVVia10843rsyK8F6LgIm9rFapqPGOb1a1zZs=;
        b=BHQWY1yR8qrpS65bRJlk1mpC/iZCuicF0BSPa5cHzCOFg6QY+QPDV+u3KDc00N2f7P
         yVROp4ZrPCVMkbdvgmc8jJMIuxxp+dDUlIsrZy2ZJKisDkc3hbs/kcfDwGkKAOjp+OKY
         ImuvASjEjtvdAgGD2n1twWcdvfjz2AXtyX8P97XTycocdEq4Oliju5Jq/rwrkzdc0Nbn
         +TT1XJ6AYH6rz4ma96+eV4KVhfYIAOqdusFsXbvGmze0QrGMzHNG38MCWYzNM4d76ZiN
         8PF1/jjEPNSh3DGwNGI+EQ9Jmr8rfFGi/l8aPsvjCRxCUrajmgPs5OtJCag+tZLmaogd
         +YAQ==
X-Gm-Message-State: APjAAAUrUa71O9A2N01wvc6BfWuk4F4PROOGZT6PgGJTiI8o921qbLH2
        VWcVxIF/fkDSVka/xZFDmrfhzg==
X-Google-Smtp-Source: APXvYqwu9bkesrQ20K07+PxU2ELWKQJv+iHHK665aXHnshdru6I4+DvpjJQitC+c3pUvnpjk1+MopA==
X-Received: by 2002:a5d:4585:: with SMTP id p5mr11457061wrq.134.1574076235447;
        Mon, 18 Nov 2019 03:23:55 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:23:54 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 19/48] soc: fsl: qe: make qe_ic_get_{low,high}_irq static
Date:   Mon, 18 Nov 2019 12:22:55 +0100
Message-Id: <20191118112324.22725-20-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are only called from within qe_ic.c, so make them static.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c |  4 ++--
 include/soc/fsl/qe/qe_ic.h | 10 ----------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 8f74bc6efd5c..23b457e884d8 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -283,7 +283,7 @@ static const struct irq_domain_ops qe_ic_host_ops = {
 };
 
 /* Return an interrupt vector or 0 if no interrupt is pending. */
-unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
+static unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 {
 	int irq;
 
@@ -299,7 +299,7 @@ unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 }
 
 /* Return an interrupt vector or 0 if no interrupt is pending. */
-unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
+static unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 {
 	int irq;
 
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index d47eb231519e..70bb5a0f6535 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -53,14 +53,4 @@ enum qe_ic_grp_id {
 	QE_IC_GRP_RISCB		/* QE interrupt controller RISC group B */
 };
 
-#ifdef CONFIG_QUICC_ENGINE
-unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic);
-unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic);
-#else
-static inline unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
-{ return 0; }
-static inline unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
-{ return 0; }
-#endif /* CONFIG_QUICC_ENGINE */
-
 #endif /* _ASM_POWERPC_QE_IC_H */
-- 
2.23.0

