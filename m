Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060D1C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55E224A2E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186619;
	bh=MFuOwopmUXbAwpiLYlO/N3fbmfGOTPXUDbJEuT5tAu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=02fVhXA78WTGqAKoMaf+M2WkCGbWoS1B1Jct1sDAq0OnLKQ14+jkeeaJyqa6SNL9t
	 Vrfe4CuyoBnkxB/z6GRjupjZ57MLbHj7L8uHaAlvis7fPpaHGL0nUmqQ/AOeKpsAli
	 UJDeA2a49h6m/BUemupBooCq62AphpVxsQSkXL/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbfE3DXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:23:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731125AbfE3DR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:17:29 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 404742464B;
        Thu, 30 May 2019 03:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186248;
        bh=MFuOwopmUXbAwpiLYlO/N3fbmfGOTPXUDbJEuT5tAu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MUvAHyXTvDabfwcA6sw0d5JEWnN4rhhmBqCtAULLrnYvTb7//zjvf6HxZHfqGgaJ5
         YfgIk0b7VkoaezTey5ADYkHq+dH9qUDXyOp6VZ6MiKztRZ/XtjqAAmz0QbIpcPEwcO
         iiLFFLe3mWjaHTqrMAHiwOrAG2HgrKCs/b5OQ1cY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yinbo Zhu <yinbo.zhu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 165/276] mmc: sdhci-of-esdhc: add erratum eSDHC5 support
Date:   Wed, 29 May 2019 20:05:23 -0700
Message-Id: <20190530030535.753114499@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a46e42712596b51874f04c73f1cdf1017f88df52 ]

Software writing to the Transfer Type configuration register
(system clock domain) can cause a setup/hold violation in the
CRC flops (card clock domain), which can cause write accesses
to be sent with corrupt CRC values. This issue occurs only for
write preceded by read. this erratum is to fix this issue.

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index a7bf8515116fd..b2199d621b8c5 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -917,6 +917,9 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	if (esdhc->vendor_ver > VENDOR_V_22)
 		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
 
+	if (of_find_compatible_node(NULL, NULL, "fsl,p2020-esdhc"))
+		host->quirks2 |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
+
 	if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||
 	    of_device_is_compatible(np, "fsl,p5020-esdhc") ||
 	    of_device_is_compatible(np, "fsl,p4080-esdhc") ||
-- 
2.20.1



