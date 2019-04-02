Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E43C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C79207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHnkxw+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbfDBPpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:45:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35361 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730847AbfDBPpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:45:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so78008plp.2;
        Tue, 02 Apr 2019 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4uxe1E1Jb0575SpiiJ17Oop6Mb4b8piqz0TyUf0UhNE=;
        b=dHnkxw+zt1qMfDqgs5Tgi1zG8zRT3UXIBPWboHI+1N1IAar6nxyLJb7JMZkBHKbgsq
         cgwxqxcyNNiA9iTfVZzu9Murf/x/mgrQ83cRfJJ+nCx8Dhdp1anQu31oKAddiJHAzX4n
         RwWg9hxgpi2I9kKZezbnMqT9uaBRSv3e85Vwj/AiXUmQwAXberJyIejKszjOqMGUqIkh
         r2dcsoa8uZhw6od9Yl3L2PumO7TX/x9E2I7srErtZf/q0tkSH8wE9z+gYbDn+0OLfSOQ
         R+LAa1hcIJtr3JnngYNJikwSbirX+VodtBMnoL21kmNhWZYaTX5OLoSuuSsXB2OJFMje
         mJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4uxe1E1Jb0575SpiiJ17Oop6Mb4b8piqz0TyUf0UhNE=;
        b=ClA559EqVDMAGxVqzsQK+v+HYGmpQpPj40rzQxJfFsRsBJRVTK6og2wmvtgtHOre6I
         VsJeAzgIM1hp0gYws0qNsrOhJETwxMUFY3vA/yCdMdhRt/hagDIJr+ndoXdsU4qNiUa0
         UJM2et/embTHHR2FRbJiT/z5dNoC1M9q8HwAj+56nBBoXN+oIsUi4U3w3nMAPVO6gkBZ
         Z0iYRSiB2eazxIEO+UYj27WkEcPVCwMnV0hpVbPsXajGhdNM4UPKwgY1FN928BMR8p55
         E5PjjIx/PnD0/AtOGqFnGboxR+RIq/HVtVH8HsSKJtX3Hl1+W4Xuj98u3PPh9TvTnlbG
         OVnw==
X-Gm-Message-State: APjAAAXx9YbAUS1zLOtByE8Mhd2iD79rYCTG0ZHk4N+5knWTpzCxy3HY
        YuBU5OoTuCVPj+SJQ97/IW8ixCW40VE=
X-Google-Smtp-Source: APXvYqwgs9WaStI+ri79ooYvBjDhMOBr4FvLWlSmupOMhTUFD+Puuv9W9xTRVyCi5zTTk4spgd8e6Q==
X-Received: by 2002:a17:902:681:: with SMTP id 1mr72236656plh.31.1554219932029;
        Tue, 02 Apr 2019 08:45:32 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id y20sm1113222pfe.188.2019.04.02.08.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 08:45:31 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 5/5] nvmem: sunxi-sid: add support for H6's SID controller
Date:   Tue,  2 Apr 2019 11:45:14 -0400
Message-Id: <20190402154514.11284-6-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190402154514.11284-1-tiny.windzz@gmail.com>
References: <20190402154514.11284-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for H6's SID controller. It supports 4K-bit
EFUSE, bigger than before. And convert to use sunxi_sid_read_native
func.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/nvmem/sunxi_sid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 5b8a42f686cd..3c2b06140490 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -239,11 +239,18 @@ static const struct sunxi_sid_cfg sun50i_a64_cfg = {
 	.size = 0x100,
 };
 
+static const struct sunxi_sid_cfg sun50i_h6_cfg = {
+	.value_offset = 0x200,
+	.size = 0x200,
+	.native_endian = true,
+};
+
 static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-sid", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
 	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
 	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
+	{ .compatible = "allwinner,sun50i-h6-sid", .data = &sun50i_h6_cfg },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
-- 
2.17.0

