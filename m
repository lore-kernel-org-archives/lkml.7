Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173FDC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4D0205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NDatIQwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfG3VgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:36:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39710 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfG3VgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:36:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so26517621pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 14:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DUZPlbYVoulEBodKFy8iaUhaLKC523HNHPbS+STT7Mc=;
        b=NDatIQwzAhbsIPPbZ+NwYM9x/T5r4EH+yZVj9XqWB0o/mw2t7wYfsQ4O2P0lkJgQYp
         pzK3u7WiZ9/eDE8xR5H+8pwRseGJzzLEnU6PQada61bj8uEbwtoosO0e3ka+l1gKuTFp
         nEJZ8vrzdr6h435j2nPVD/R8R2trKRWU3GR3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DUZPlbYVoulEBodKFy8iaUhaLKC523HNHPbS+STT7Mc=;
        b=RjWn3gIkJgS4aZj5sbrChvfu0nmJqsQ6OXGKFMGEUR/Qugbx4ZYUwn50Ly6Gw4woFJ
         9EkVhwmLfix+WmJabLw9jo9lWgnDO1Q4YxpZ6qodWzyRHq4SD0jZH2ucKjg+RBvm7nAc
         K/F5lnnuRnYGTWS7RcaEX5aA3mNoPqGdxgD4/5mxRROZt7gbvblSWdOvRkwoCLZHgTS5
         KWaeHJSfUq+NIzd3+sTs0OzicJEjIkVhX48zV/LHHJtUZzIHm7n3X3SVCgqXSRL/DcNs
         oYcG7LYV5Urvuno7jSUeCkJ1haccnu87EqsKppv2IlpOMKCYvo/sSaEcKWGyKn7pDiPS
         Y1Ug==
X-Gm-Message-State: APjAAAViUbs8X19WOzkNa2ESaykSFgyQ8XLF/SFeDEfidMt0D9sdMcEe
        GJnIv+Jx+0CRRQCojKwk5COd3xVBv+SR0w==
X-Google-Smtp-Source: APXvYqywN/LMd0BIVi4A4sLVzB9NTdG4jbAYa+WXDgPmu1q0fk2kZNlBu/omvQitaQt0oJFecZsLfA==
X-Received: by 2002:a65:65c5:: with SMTP id y5mr109634193pgv.342.1564522569382;
        Tue, 30 Jul 2019 14:36:09 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p26sm14046937pgl.64.2019.07.30.14.36.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 14:36:08 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thierry Reding <treding@nvidia.com>, Li Yang <leoyang.li@nxp.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v7 1/2] soc: fsl: qbman: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 14:36:06 -0700
Message-Id: <20190730213607.171156-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730183503.GX7234@tuxbook-pro>
References: <20190730183503.GX7234@tuxbook-pro>
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

Cc: Thierry Reding <treding@nvidia.com>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/fsl/qbman/bman_portal.c | 4 +---
 drivers/soc/fsl/qbman/qman_portal.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

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
-- 
Sent by a computer through tubes

