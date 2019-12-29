Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F00C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A7B20718
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641203;
	bh=GtEqOnwyIEsSAXZSYt0Y94oiVIavuM0u3h1Nu09IQHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tX8fDVyOO+VmL+409Xy0OaAHK0qUKg2uQ2QtiY6uFStBZx/Z38patrqOs2QrgzyDh
	 4AM+HFIujNHVLyL6qHdVH3J0MfFAj7bX40BWI2KoHC1Yz/GvktleuBVeB71NDYkUxo
	 Ui3p4Ll/T63nBFg6B4IobvrhL25vXhVW+CCmE3Fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbfL2Rj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:39:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbfL2RcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:32:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9B85207FF;
        Sun, 29 Dec 2019 17:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640738;
        bh=GtEqOnwyIEsSAXZSYt0Y94oiVIavuM0u3h1Nu09IQHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rAf6PNjIXBY7IGrEgjvvS9rYhuDvqgKKntQKoAb5Jh0bGd7UhDqndRAbtAqr+4cZ3
         vx3F2QABXNYPIdfCzGG3CaSOEo1l5nFptqVLN6a9yvrFuLc5SaZUAxqGVSoH2w5kEs
         0pxrHiHGfdtzeBsiVM2KKjkfEHuT+xCHhICr/hLo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 117/219] nvmem: imx-ocotp: reset error status on probe
Date:   Sun, 29 Dec 2019 18:18:39 +0100
Message-Id: <20191229162526.298007347@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit c33c585f1b3a99d53920bdac614aca461d8db06f ]

If software running before the OCOTP driver is loaded left the
controller with the error status pending, the driver will never
be able to complete the read timing setup. Reset the error status
on probe to make sure the controller is in usable state.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20191029114240.14905-6-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/imx-ocotp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index afb429a417fe..926d9cc080cf 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -466,6 +466,10 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
+	clk_prepare_enable(priv->clk);
+	imx_ocotp_clr_err_if_set(priv->base);
+	clk_disable_unprepare(priv->clk);
+
 	priv->params = of_device_get_match_data(&pdev->dev);
 	imx_ocotp_nvmem_config.size = 4 * priv->params->nregs;
 	imx_ocotp_nvmem_config.dev = dev;
-- 
2.20.1



