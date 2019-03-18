Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6B1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28756217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552894461;
	bh=1t2iTow1jWWzEIUUmLUValaVq5HqCn9BcfMJ6B9N2So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ouypy/f2m02KMCqawMsNhf9kIVAUQgtXxNPqxp2GLr5E5TGhLV+LeYKNjs+1TfB+h
	 XLpg6IDzu6iPrYlLZ4ecgRn4MncXZHokpuyO/3y3ABjiUGpoAHU38EOTsmvmtyITIZ
	 RfN0jkASyHcD4M8ov+9VBMLTCc8SpbJ90cLfsf0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfCRHeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:34:20 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:40926 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbfCRHeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:34:16 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id 142AE5FF03; Mon, 18 Mar 2019 15:34:12 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] nvmem: sunxi_sid: Support SID on A83T and H5
Date:   Mon, 18 Mar 2019 15:33:53 +0800
Message-Id: <20190318073354.12151-6-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318073354.12151-1-wens@kernel.org>
References: <20190318073354.12151-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The device tree binding already lists compatible strings for these two
SoCs. They don't have the defect as seen on the H3, and the size and
register layout is the same as the A64. Furthermore, the driver does
not include nvmem cell definitions.

Add support for these two compatible strings, re-using the config for
the A64.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/nvmem/sunxi_sid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 14c114620ed6..e7936380ce89 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -200,8 +200,10 @@ static const struct sunxi_sid_cfg sun50i_a64_cfg = {
 static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-sid", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
+	{ .compatible = "allwinner,sun8i-a83t-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
 	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
+	{ .compatible = "allwinner,sun50i-h5-sid", .data = &sun50i_a64_cfg },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
-- 
2.20.1

