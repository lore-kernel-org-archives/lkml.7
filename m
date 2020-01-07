Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1963CC33CA1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D910A2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431832;
	bh=1sDJJCskldaXVxSqJVNRGymPpRyy0DkfLUmehVr0vdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aXRWWbf8L8n1ktOwp+KoEqpjZ91ru4Pdr3o81kgyK5FQOyH4QFvUUt94h62FByz4n
	 Wn6GxsNmbg0Uj9cyy6/NN+5XFRFJwmxCWouX7bnTSMChV8mpQyT+H/UxL24XVMUFwc
	 9jRCfJiQORKir0aJopi1BeZIlQXXvSLz9BXudQFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgAGVGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:06:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:54424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbgAGVGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:06:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B8BB2077B;
        Tue,  7 Jan 2020 21:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431167;
        bh=1sDJJCskldaXVxSqJVNRGymPpRyy0DkfLUmehVr0vdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eILu/+m0s92Xep+bz2LCqdPPUfd4iPA76HGEByYPIS3aMJjB2swmlYZKe1Q3j5b7f
         0L9r4j8mjpF9QYQUSvngbPYWwf303tyXMlADGzxnd09OcvyCRX3ekjO6Z8rx+zqVDI
         WxTPHzF/mtJtcRu8GQBOnO9SFM6t/k0zFbO3kX9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 062/115] ata: ahci_brcm: Allow optional reset controller to be used
Date:   Tue,  7 Jan 2020 21:54:32 +0100
Message-Id: <20200107205303.355115454@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

commit 2b2c47d9e1fe90311b725125d6252a859ee87a79 upstream.

On BCM63138, we need to reset the AHCI core prior to start utilizing it,
grab the reset controller device cookie and do that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/ahci_brcm.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/string.h>
 
 #include "ahci.h"
@@ -94,6 +95,7 @@ struct brcm_ahci_priv {
 	u32 port_mask;
 	u32 quirks;
 	enum brcm_ahci_version version;
+	struct reset_control *rcdev;
 };
 
 static inline u32 brcm_sata_readreg(void __iomem *addr)
@@ -433,6 +435,11 @@ static int brcm_ahci_probe(struct platfo
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
+	/* Reset is optional depending on platform */
+	priv->rcdev = devm_reset_control_get(&pdev->dev, "ahci");
+	if (!IS_ERR_OR_NULL(priv->rcdev))
+		reset_control_deassert(priv->rcdev);
+
 	if ((priv->version == BRCM_SATA_BCM7425) ||
 		(priv->version == BRCM_SATA_NSP)) {
 		priv->quirks |= BRCM_AHCI_QUIRK_NO_NCQ;


