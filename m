Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199A8C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB11720731
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574401847;
	bh=5PXEbBylnnhAkoiwvd/bOD51FRWOQedouhurN35w0Hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tiX5a2bm5Thoy4lA/xk3E2fkPrrV5916QDNgJFPTEs2NdEu/wY2Qi9NaGPI0Sho70
	 ENdiyj3OKSMFJPNXFSX77pw8trS/JS+BWRy3Ai3YUQtwJBpzYFlYNW1FwIlaDd0Wg9
	 Fklc5dwNeapKHeebD1232ly5jpYfKgLM1C9N+rv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfKVFup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:50:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:55286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbfKVFui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:50:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB61B2071C;
        Fri, 22 Nov 2019 05:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401837;
        bh=5PXEbBylnnhAkoiwvd/bOD51FRWOQedouhurN35w0Hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SthQBrfiOcHXiyisTuX3ZoE8CR2BqRKJ4NBlYHi+BwJcW/o6rs9jf1C2CF88QEAo8
         f6O1PWHy9mZZiSot5c1WNCrEl4Bgk+ot2r0QdlJOdd7EJu/fvegQrbI4wmw++wQSLn
         mBBcUx99eD9xJvSWnTci29Py2po1uHjWdbTYHskI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 078/219] gpio: raspberrypi-exp: decrease refcount on firmware dt node
Date:   Fri, 22 Nov 2019 00:46:50 -0500
Message-Id: <20191122054911.1750-71-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

[ Upstream commit 85af74c474b21940e88483fd48f6094145c89d97 ]

We're getting a reference RPi's firmware node in order to be able to
communicate with it's driver. We should decrease the reference count on
the dt node after being done with it.

Fixes: a98d90e7d588 ("gpio: raspberrypi-exp: Driver for RPi3 GPIO expander via mailbox service")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-raspberrypi-exp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-raspberrypi-exp.c b/drivers/gpio/gpio-raspberrypi-exp.c
index d6d36d537e373..b77ea16ffa031 100644
--- a/drivers/gpio/gpio-raspberrypi-exp.c
+++ b/drivers/gpio/gpio-raspberrypi-exp.c
@@ -206,6 +206,7 @@ static int rpi_exp_gpio_probe(struct platform_device *pdev)
 	}
 
 	fw = rpi_firmware_get(fw_node);
+	of_node_put(fw_node);
 	if (!fw)
 		return -EPROBE_DEFER;
 
-- 
2.20.1

