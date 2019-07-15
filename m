Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839B9C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0402086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199642;
	bh=saUsBPT0BCHRm0hRpMbzuvQGyIftozJyXsesWObFiy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xlotwwnwte9mo6/aaiMGcJKB0PtRA6eCrI4ApvO2TUdsswgL3JOpLUt1ewuQ/eVqS
	 Sw6pXg0LBe7niB6HFBTxEcjncPrR/V+fTgLIZIIQXbIUisYYeIwAdoH5X5b7V5n04y
	 q/A3766wv62y7C8QCWqbycZzlGO0mMdiBFVkdrCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbfGOOHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388018AbfGOOHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:07:20 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 411602081C;
        Mon, 15 Jul 2019 14:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199639;
        bh=saUsBPT0BCHRm0hRpMbzuvQGyIftozJyXsesWObFiy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vIgCRfQ52mlELXioGdT7KN4Bc2Eg4+q9lolR9MyFzcrig2HRZ1RbBVH+jc9OgQZ+7
         aWtLwEd5oDu1TktIcr613aqoPyYF5nZIA7bgciiAu/AcBJyQgId0H/4cqQmRsUU7Ow
         PkzTOmOXZgKnocrP7EHuNlGdbiXTE0ZJvgzHyv6w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.1 059/219] media: imx7-mipi-csis: Propagate the error if clock enabling fails
Date:   Mon, 15 Jul 2019 10:01:00 -0400
Message-Id: <20190715140341.6443-59-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit 2b393f91c651c16d5c09f5c7aa689e58a79df34e ]

Currently the return value from clk_bulk_prepare_enable() is checked,
but it is not propagate it in the case of failure.

Fix it and also move the error message to the caller of
mipi_csis_clk_enable().

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/imx/imx7-mipi-csis.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
index 2ddcc42ab8ff..e9d621e19d6d 100644
--- a/drivers/staging/media/imx/imx7-mipi-csis.c
+++ b/drivers/staging/media/imx/imx7-mipi-csis.c
@@ -455,13 +455,9 @@ static void mipi_csis_set_params(struct csi_state *state)
 			MIPI_CSIS_CMN_CTRL_UPDATE_SHADOW_CTRL);
 }
 
-static void mipi_csis_clk_enable(struct csi_state *state)
+static int mipi_csis_clk_enable(struct csi_state *state)
 {
-	int ret;
-
-	ret = clk_bulk_prepare_enable(state->num_clks, state->clks);
-	if (ret < 0)
-		dev_err(state->dev, "failed to enable clocks\n");
+	return clk_bulk_prepare_enable(state->num_clks, state->clks);
 }
 
 static void mipi_csis_clk_disable(struct csi_state *state)
@@ -985,7 +981,11 @@ static int mipi_csis_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	mipi_csis_clk_enable(state);
+	ret = mipi_csis_clk_enable(state);
+	if (ret < 0) {
+		dev_err(state->dev, "failed to enable clocks: %d\n", ret);
+		return ret;
+	}
 
 	ret = devm_request_irq(dev, state->irq, mipi_csis_irq_handler,
 			       0, dev_name(dev), state);
-- 
2.20.1

