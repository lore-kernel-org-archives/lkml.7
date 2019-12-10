Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EE8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41AA2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZQzknzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfLJUcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:32:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44384 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfLJUcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:32:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so9417664pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 12:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aJjh4TX7tIu5i+rCa4IwoPtzkcCu3DVe+AmQ4LsjGFE=;
        b=gZQzknzIqIApPvJCk1iRFQHzHlvudGFa4DkvphsH88qXsxvVZFHlomcdllkrTb27YN
         yUfG0AmPrk+30Tye1b5PugmQGyqJDdZqm3lInbKWgQX0ckY6j4kr0krsu9Sl+YtCGg/8
         Nl+mstS5YXfIlY74w+zEx6qGpzpz7tvHYtDiS5u0zk8wCbvCfswNmZzCnOAYUspw0DFb
         nOGUg6vMezl4ZafiDAMU8aAp8EhiyG/vR6ux/mAJbnxQ4Q/8lawY52cvRwL9tyuy6sHO
         EVDGTQC6kfmIBDfqJbS2sL1+9nuGYq+/3zmIy5OROU2Io97zdmX1ImU/BeTwYp5FZRtK
         RSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aJjh4TX7tIu5i+rCa4IwoPtzkcCu3DVe+AmQ4LsjGFE=;
        b=pUoUt18kG0paLS8Q8vORTWPK4gUWz9CoZgA6WiSDrwHiukue5hvFYnmFV1W3TIDHrh
         hWc/L4jPThDo1QvAPrhtFzZ1CS2hJBJn0v/kD9cyjaGZeGUPmSHl/Hjsa7LmydwtAfrx
         A/dFtkqHw5XeCTCnDWABfmBYkDKviT0/3zAC5bG8O54+fE2Wk22zjivrOf4rczI0vgcO
         8mUgDgW3o2dxZ0GprSvWuOnRcjFau106hxWKetNnGsAX2LHbYB43Xh8PbbU7niOfqyqj
         FkTHaQ+PxFnhgPveeSYR4KqQVL+pDw0BP68Lg5CZiAaKQkiRpXEB+5P9YkRYeZyBOSlM
         QATA==
X-Gm-Message-State: APjAAAVFLsVEL/2w0uFigCThYVtE2IyhONTNMHOvwWMr+sMKF2dXzb3R
        2zseilWrn/2SZ8FCIjH5c5w=
X-Google-Smtp-Source: APXvYqy9wb5VG/J8/gfbuJhrl2x731RJNVx5EKN7oDXSF1O1sSK9iEaSoweWjC42n/RNrAITMDlheg==
X-Received: by 2002:a63:4d1b:: with SMTP id a27mr17289782pgb.352.1576009922481;
        Tue, 10 Dec 2019 12:32:02 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id w6sm4839677pfq.99.2019.12.10.12.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 12:32:01 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        srinivas.kandagatla@linaro.org, vz@mleia.com, khilman@baylibre.com,
        mripard@kernel.org, wens@csie.org,
        andriy.shevchenko@linux.intel.com, mchehab+samsung@kernel.org,
        mans@mansr.com, treding@nvidia.com, suzuki.poulose@arm.com,
        bgolaszewski@baylibre.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 3/5] nvmem: meson-mx-efuse: convert to devm_platform_ioremap_resource
Date:   Tue, 10 Dec 2019 20:31:48 +0000
Message-Id: <20191210203149.7115-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210203149.7115-1-tiny.windzz@gmail.com>
References: <20191210203149.7115-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/nvmem/meson-mx-efuse.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 07c9f38c1c60..24c6e8b15987 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -194,7 +194,6 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 {
 	const struct meson_mx_efuse_platform_data *drvdata;
 	struct meson_mx_efuse *efuse;
-	struct resource *res;
 
 	drvdata = of_device_get_match_data(&pdev->dev);
 	if (!drvdata)
@@ -204,8 +203,7 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 	if (!efuse)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	efuse->base = devm_ioremap_resource(&pdev->dev, res);
+	efuse->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(efuse->base))
 		return PTR_ERR(efuse->base);
 
-- 
2.17.1

