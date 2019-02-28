Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D14C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379A8218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366522;
	bh=cw4OGKipxuRqn9X57N2bI5Rcp0Vej/g1VBKaYbSvMGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KN3F02jONg0/yP7uR8c/x0hwLmabZZjRh/WYbodGAoI7TPtXAwIh34Qb1+Ggo5SDl
	 QxYFmi5EkHGylPDfDJAfi+taEymrX7cRn+3Lf3+1I1YCQUHZqfzYV1e0KuMPpZXHcd
	 hZvv5xv6AMo9fnDDR5RzVQS0YN4zSeTlsfh5MoHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbfB1PIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:08:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733008AbfB1PIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DD45218C3;
        Thu, 28 Feb 2019 15:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366513;
        bh=cw4OGKipxuRqn9X57N2bI5Rcp0Vej/g1VBKaYbSvMGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TUoQnJaohyQWF492OB2eUtl1/tjQftKzhCTTTnBinDdGlSp8iReFZv9OBvf4dqOsz
         LagBKe74HBlutnzWeD1DuyU6G43dgFJOJ2oUzN5Sutix5t9K2Lsgl2FY4HUPX5p0LT
         QBmtlKufa3iJMW2Y3/x1fCOxbCLh34oGi8Jv4tbk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jason Kridner <jkridner@gmail.com>, Jason Kridner <jdk@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 13/81] pinctrl: mcp23s08: spi: Fix regmap allocation for mcp23s18
Date:   Thu, 28 Feb 2019 10:07:05 -0500
Message-Id: <20190228150813.10256-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Kridner <jkridner@gmail.com>

[ Upstream commit f165988b77ef849eb0c1aebd94fe778024f88314 ]

Fixes issue created by 9b3e4207661e67f04c72af15e29f74cd944f5964.

It wasn't possible for one_regmap_config to be non-NULL at the point
it was tested for mcp23s18 devices.

Applied the same pattern of allocating one_regmap_config using
devm_kmemdump() and then initializing the local regmap structure
from that.

Signed-off-by: Jason Kridner <jdk@ti.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-mcp23s08.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index b03481ef99a13..98905d4a79ca9 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -832,8 +832,13 @@ static int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 		break;
 
 	case MCP_TYPE_S18:
+		one_regmap_config =
+			devm_kmemdup(dev, &mcp23x17_regmap,
+				sizeof(struct regmap_config), GFP_KERNEL);
+		if (!one_regmap_config)
+			return -ENOMEM;
 		mcp->regmap = devm_regmap_init(dev, &mcp23sxx_spi_regmap, mcp,
-					       &mcp23x17_regmap);
+					       one_regmap_config);
 		mcp->reg_shift = 1;
 		mcp->chip.ngpio = 16;
 		mcp->chip.label = "mcp23s18";
-- 
2.19.1

