Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03B7C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA87A20856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="Tw+3dUk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbfETPGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:06:42 -0400
Received: from vps.xff.cz ([195.181.215.36]:54770 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732195AbfETPGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1558364800; bh=Jp2qNvMK98ELurd2YTl1GqZcvgQt1Q6332x0ej9quDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tw+3dUk9jK2N+LApBCGA0v+mYAaO6l36DQipEs80mGHXJYG6yk5TKKn1KYenZSiGd
         4iwulI3AZCWQM2uT/ddHSNYPp5WS/bSpNy/coo4vNhqfuqvFYtsDoXcZMwTj7qdS0g
         LlywseekDgX8++HiDHWoJIpWoE7XY/ZOlwPxXVtA=
From:   megous@megous.com
To:     Chen-Yu Tsai <wens@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 2/3] media: sun6i: Support A83T variant
Date:   Mon, 20 May 2019 17:06:36 +0200
Message-Id: <20190520150637.23557-3-megous@megous.com>
In-Reply-To: <20190520150637.23557-1-megous@megous.com>
References: <20190520150637.23557-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The A83T SoC has a camera sensor interface (known as CSI in Allwinner
lingo), which is similar to the one found on the A64 and H3. The only
difference seems to be that support of MIPI CSI through a connected
MIPI CSI-2 bridge.

Add support for this variant.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 4c79eb64a7a7..6e0e894154f4 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -924,6 +924,7 @@ static int sun6i_csi_remove(struct platform_device *pdev)
 
 static const struct of_device_id sun6i_csi_of_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-csi", },
+	{ .compatible = "allwinner,sun8i-a83t-csi", },
 	{ .compatible = "allwinner,sun8i-h3-csi", },
 	{ .compatible = "allwinner,sun8i-v3s-csi", },
 	{ .compatible = "allwinner,sun50i-a64-csi", },
-- 
2.21.0

