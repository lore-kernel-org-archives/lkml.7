Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BEDC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB14214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NureEy4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfLJSzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:55:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46502 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfLJSzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:55:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so21220754wrl.13;
        Tue, 10 Dec 2019 10:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s1fMKJYeDRkS8mQe3Jpqn4jz2RPyPG0Miaq4LKZSo5Y=;
        b=NureEy4RXepPmeiCNA+IWXrd2xrjGKS457ZRGvhm7qc1GpMVSspDUwDxT3k7azOz89
         3einWRWtVW6KGpuAfWcoaP1N39F2kZZ1ict3lmMS1iYQj4fikzN1l/3InH7pdLTq1Xzu
         kn6+DwsWO86S6G9oaOxFoRf9KBeVuKCBjyGanrObE5bFbx+gW3G7AHFgfaEOuNJfATNb
         m8CelNnXa6Mwg8BqM2N2s035n14P0epNb+TkXokcYuqB0G8g5FMHoM2ZDWKh9WSgSFJJ
         KSa/x1Hai/9j9WEP8nfuNjtqc6I5tHr60QlA22S0CdAZCzHMGCJ225q7Evzgq0za9uAT
         y5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s1fMKJYeDRkS8mQe3Jpqn4jz2RPyPG0Miaq4LKZSo5Y=;
        b=eA2Az/cRSFgCQjDc6BPJ071walvUq+N31BWK3uD7tZNrB0Y5VrqqAClRMePw4LG+d9
         ZAVgNjXJ0lm8Wbs9CAvP01OL2MxPyCyMWziIxNCxtd55K0xREjVIMM+76Egiy8PAkY92
         uAmH/bUr+yqQV4N74SxJnHsFwaJQ8t4XPkkjpVJO6OVVd9Zc5iP9mxJm2h0oB/xFJA/x
         R2ZvgmOORh78EJhCKGsA2GJw/witn4/gsswZ4E3YgcblghPk397T1z1yxXPZd7C3Q2Ll
         emm5crGytqW88OrySS2xN+q/ieEKf79NzAX+cCdH3OlFoaXUpCfIfd+2CaOCW0znD+sF
         1NlA==
X-Gm-Message-State: APjAAAVI4Qnz2nyzzx+WyAx0l3VtP/blkHoLMoelwBYxqqlHmnpFVZTC
        S11qjR4BVbfm9zi4zRG/0VEZF6yo
X-Google-Smtp-Source: APXvYqzb9ajCJrYWQ65SYlqBPbFLj+5zV+rFqFiIDQ+KjVD3cQLWN0KqrajUkZMQwHQyoc7YWXVh3Q==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr4743038wrw.327.1576004134858;
        Tue, 10 Dec 2019 10:55:34 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e6sm4213536wru.44.2019.12.10.10.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:55:34 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 8/8] ata: ahci_brcm: Support BCM7216 reset controller name
Date:   Tue, 10 Dec 2019 10:53:51 -0800
Message-Id: <20191210185351.14825-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210185351.14825-1-f.fainelli@gmail.com>
References: <20191210185351.14825-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM7216 uses a different reset controller name which is "rescal" instead
of "ahci", match the compatible string to account for that minor
difference, the reset is otherwise identical to how other generations of
SATA controllers work.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 58e1a6e5478d..13ceca687104 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -73,6 +73,7 @@ enum brcm_ahci_version {
 	BRCM_SATA_BCM7425 = 1,
 	BRCM_SATA_BCM7445,
 	BRCM_SATA_NSP,
+	BRCM_SATA_BCM7216,
 };
 
 enum brcm_ahci_quirks {
@@ -415,6 +416,7 @@ static const struct of_device_id ahci_of_match[] = {
 	{.compatible = "brcm,bcm7445-ahci", .data = (void *)BRCM_SATA_BCM7445},
 	{.compatible = "brcm,bcm63138-ahci", .data = (void *)BRCM_SATA_BCM7445},
 	{.compatible = "brcm,bcm-nsp-ahci", .data = (void *)BRCM_SATA_NSP},
+	{.compatible = "brcm,bcm7216-ahci", .data = (void *)BRCM_SATA_BCM7216},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
@@ -423,6 +425,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
+	const char *reset_name = NULL;
 	struct brcm_ahci_priv *priv;
 	struct ahci_host_priv *hpriv;
 	struct resource *res;
@@ -444,8 +447,13 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
-	/* Reset is optional depending on platform */
-	priv->rcdev = devm_reset_control_get(&pdev->dev, "ahci");
+	/* Reset is optional depending on platform and named differently */
+	if (priv->version == BRCM_SATA_BCM7216)
+		reset_name = "rescal";
+	else
+		reset_name = "ahci";
+
+	priv->rcdev = devm_reset_control_get(&pdev->dev, reset_name);
 	if (!IS_ERR_OR_NULL(priv->rcdev))
 		reset_control_deassert(priv->rcdev);
 
-- 
2.17.1

