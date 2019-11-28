Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031B4C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB882084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="G3K0t1nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfK1O5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:57:38 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38880 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfK1O5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id k8so18298410ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6RPbfdv0hDBEMr5jRu0991VlpKTzzf1sC9/XAmy4sgs=;
        b=G3K0t1nlzwA3d3jHn4yj1bqgPjSU7rkRn5xHQvlnCYStcAfU2EOLNyPlf58l/kRURv
         oxPucVu+N8o4zYJ1N5TlrwsqpubhOOPQAQvU5PVBJ6o8v2W27PBswbMNL7ah8jpFm1VU
         Tb/0CmRp1Xf8vt82JUTxMYMrxMphmZqJV9kew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6RPbfdv0hDBEMr5jRu0991VlpKTzzf1sC9/XAmy4sgs=;
        b=S0yuclAkYAj2FMCLW3f2yTSAZDqz2XB+jOKiYYCegZKKODlxgVk3OWkb9oALKdF04c
         4HND0Yvtuhbqe2itIFrsB21ATgPUPXI0wc5vdTAj9DJk1wwAF0zhzZzsRVYiARyvkO2A
         L20mw6ZRjgBSWjkrdtetgRp7srAdPqmEhfC4WNkcf5SiUD4qgH5wZ6FLwj3mG+4Vfs4A
         QvA4yNdxv8tVusJmOOUvR0UmbLtdLrynuex1pxE6+5wSQenMFomXapRqgXgFM6xbvoVE
         YeWpdzV5yV4ECpHASoYd9psjVQUIYkAEehmFb/lU30ij8Ll4tz96N9T8bD7DLAjI5hF7
         yzgQ==
X-Gm-Message-State: APjAAAWh6aBJVcGpL/2CcanC62XRYs0HE8ld9PzeVpZDh9ya+i3SOZnN
        lnzqEFkte8UNwW4o6pxp+CbAlw==
X-Google-Smtp-Source: APXvYqyaNUn/imdGbgT/de4umQQV6PAgT8adP8yacv3I5sC9GoOzbCwUDIiv5Pz0lPz4XRI0PSVjcA==
X-Received: by 2002:a2e:8855:: with SMTP id z21mr36009830ljj.212.1574953049771;
        Thu, 28 Nov 2019 06:57:29 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:29 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 19/49] soc: fsl: qe: make qe_ic_get_{low,high}_irq static
Date:   Thu, 28 Nov 2019 15:55:24 +0100
Message-Id: <20191128145554.1297-20-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are only called from within qe_ic.c, so make them static.

Reviewed-by: Timur Tabi <timur@kernel.org>
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

