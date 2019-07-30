Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDF1C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762E5216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oMDp9F2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbfG3SQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:16:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33566 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388055AbfG3SQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id f20so21249012pgj.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4L2lN0Z8KU32HMJkge7a1wqVzJB6Zb60x3LXU/IaFuw=;
        b=oMDp9F2OSRSbdCFkpJrPXgB4cSABEJoE/I65hGF2l4oq53a246hQl8ONKAPtn3adb4
         YMsBYqpJuLa9/3WWS+T9XZuntADnvjhy7VR/y8zxoFARDFHDnaSeMdeAxhzqNFXSGkTB
         EL9TONSClWnsgoFi7X8uOCMsNK+PvRElWHBlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4L2lN0Z8KU32HMJkge7a1wqVzJB6Zb60x3LXU/IaFuw=;
        b=CTK+Ic4c7iMbHrIW43mbZeFD6qmjhqYMC/mU79U0WnHj0A2hAJAnwa9dsYJEeU84z3
         HenTyYAM9wK61yVdjeJk+FVwvrCNrPqH6SHPOYp0XzrmG0Ky4ngNDSk7u19giNCyF5kg
         RGBhGH1WAwOjt+WRHOFHCHn2q47Vwj6M5VUjSxksJ+emg7DNJlO7SluoNFICkDvVnwTc
         qN0X9PihdigGu7Oc8RLHDrugO0RpNfTh7opuv7WGm/Pkhg1VuBIjr5Fa54GefKebEeaD
         73r44oiGhkJS8CXutBVTG133WlJdHsDwojyMa3/H9E5gGo0//PhbkK1Gd/POyv7r0cYA
         O7Ww==
X-Gm-Message-State: APjAAAUN4NYIz4IfutjgIcc9ezEXNVZQgUHblBvs/K69PHCat0IXgDef
        8anR3lmLylq5WEyLpe9RGykPNU2b2+V5vA==
X-Google-Smtp-Source: APXvYqy0LkS0kyalemVGhmnNpAa9W+NWMBxrnbUvfgs8zo6OSbbGFy0CXVWwfrGyptS8yy0opa7+8g==
X-Received: by 2002:a62:e315:: with SMTP id g21mr44397321pfh.225.1564510591912;
        Tue, 30 Jul 2019 11:16:31 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:31 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 40/57] soc: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:40 -0700
Message-Id: <20190730181557.90391-41-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Andy Gross <andy.gross@linaro.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/soc/fsl/qbman/bman_portal.c | 4 +---
 drivers/soc/fsl/qbman/qman_portal.c | 4 +---
 drivers/soc/qcom/smp2p.c            | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
index cf4f10d6f590..e4ef35abb508 100644
--- a/drivers/soc/fsl/qbman/bman_portal.c
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -135,10 +135,8 @@ static int bman_portal_probe(struct platform_device *pdev)
 	pcfg->cpu = -1;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "Can't get %pOF IRQ'\n", node);
+	if (irq <= 0)
 		goto err_ioremap1;
-	}
 	pcfg->irq = irq;
 
 	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index e2186b681d87..991c35a72e00 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -275,10 +275,8 @@ static int qman_portal_probe(struct platform_device *pdev)
 	pcfg->channel = val;
 	pcfg->cpu = -1;
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "Can't get %pOF IRQ\n", node);
+	if (irq <= 0)
 		goto err_ioremap1;
-	}
 	pcfg->irq = irq;
 
 	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index c7300d54e444..07183d731d74 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -474,10 +474,8 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
 		goto report_read_failure;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "unable to acquire smp2p interrupt\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	smp2p->mbox_client.dev = &pdev->dev;
 	smp2p->mbox_client.knows_txdone = true;
-- 
Sent by a computer through tubes

