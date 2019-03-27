Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10A6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DF821734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710135;
	bh=sHG9RJgV9laOErhdvwyunCcd9PEQTeWp9jbxFEPDUrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yZjCdBxHWMo4CH/V9a9gGaZ5kSzaz6XMWj43sRgVvBmAF0nwcrZj0cN+hmWMxc5lq
	 /Ckz6DB531cto06Hlp/f3deWsbktMlBHNX5NStoO+wsyK+HdiPWv+GlMVvZFnDZBtv
	 E8XEZWHN+Zc8RQXwjboFCtxSyphvc6JYJndczS5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388444AbfC0SIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:08:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387999AbfC0SIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:08:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FDC62177E;
        Wed, 27 Mar 2019 18:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710131;
        bh=sHG9RJgV9laOErhdvwyunCcd9PEQTeWp9jbxFEPDUrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qxDPH0bswQYMsiMP7ryNN7ldBLXg6dDThKVzOTK4AhvEUD0qhb9nQTvzde/9IeSil
         ZH0Pvl85XaOCVJ5A0lNYTJI+8dw/3QaVQhWWNRiCRQkEP1jAL7Dbbapz3h6ug3h/K1
         gEbD5/AeaxCIAY7rwckxSHqPBR7WlQmY/CRbWfd4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 209/262] regulator: mcp16502: Include linux/gpio/consumer.h to fix build error
Date:   Wed, 27 Mar 2019 14:01:04 -0400
Message-Id: <20190327180158.10245-209-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Axel Lin <axel.lin@ingics.com>

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

