Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4FAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530BA2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369373;
	bh=4y+3rfoCBxaqoST4IYSWbTx3D7pmQMcumL5vyvQPBJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q7+lXWxZpKc5I8r7R5zoIMAU4s3EuyWuhI8HNF2yMsh4B3ktcjjEQ2o7T9lwQ0GDE
	 TeuFg4zig6BJf+lBtRZTITSAP/RnhEne+eMVinlf3m+J3RaRCqIohf89FzvwgX9sQ3
	 WFSTHQ3bjnC7XMjFHe202dufDzq8SAg48F5Z/evM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbfDDJQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388002AbfDDJQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:16:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED2E520693;
        Thu,  4 Apr 2019 09:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369368;
        bh=4y+3rfoCBxaqoST4IYSWbTx3D7pmQMcumL5vyvQPBJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wiPEc7Jz0J1qW3nNlJ7+qN2QuOoF8/7MZ+qoN9H2eUFG8YHynghCLjXMA6ClwkV/L
         dUKMeJasOadJpU1w4ggS2ZDtFLi0JRSCACoFqko6UqS0RL7B3+8Ag0tpfFoW25am1a
         UIAqNXqhg+DZz1rb2Xf/HwUd86UVEig51TCoBptE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Axel Lin <axel.lin@ingics.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 197/246] regulator: mcp16502: Include linux/gpio/consumer.h to fix build error
Date:   Thu,  4 Apr 2019 10:48:17 +0200
Message-Id: <20190404084626.084801344@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f3c6a1a194317f3a31ee2b2067bb0a41de64bc8b ]

Fix below build error:
drivers/regulator/mcp16502.c: In function ‘mcp16502_gpio_set_mode’:
drivers/regulator/mcp16502.c:135:3: error: implicit declaration of function ‘gpiod_set_value’; did you mean ‘gpio_set_value’? [-Werror=implicit-function-declaration]
   gpiod_set_value(mcp->lpm, 0);
   ^~~~~~~~~~~~~~~
   gpio_set_value
drivers/regulator/mcp16502.c: In function ‘mcp16502_probe’:
drivers/regulator/mcp16502.c:486:13: error: implicit declaration of function ‘devm_gpiod_get’; did you mean ‘devm_gpio_free’? [-Werror=implicit-function-declaration]
  mcp->lpm = devm_gpiod_get(dev, "lpm", GPIOD_OUT_LOW);
             ^~~~~~~~~~~~~~
             devm_gpio_free
drivers/regulator/mcp16502.c:486:40: error: ‘GPIOD_OUT_LOW’ undeclared (first use in this function); did you mean ‘GPIOF_INIT_LOW’?
  mcp->lpm = devm_gpiod_get(dev, "lpm", GPIOD_OUT_LOW);
                                        ^~~~~~~~~~~~~
                                        GPIOF_INIT_LOW

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/mcp16502.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 3479ae009b0b..0fc4963bd5b0 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -17,6 +17,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/suspend.h>
+#include <linux/gpio/consumer.h>
 
 #define VDD_LOW_SEL 0x0D
 #define VDD_HIGH_SEL 0x3F
-- 
2.19.1



