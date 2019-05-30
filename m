Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C862DC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A231525D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191868;
	bh=Xk/iLw49z1JCoFtls8/ow6PFTak0KhUDk4mdqxEWnqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HJU1UsVD2HlJWd0OYxq+jR1EMk9w9iN9L/bfKUm6uazlfkkmoK3R7epT9YuRuM8BX
	 BXzTK3pujOb+UZnaa7rdGYTbr3Mejc9edwwnoPmw9iZv2PbRwQERLzbY2g2yyrfn2W
	 wKqq3MVw8Ifcv0keBIRiTDxNeegoHNYmwBp5NRp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388997AbfE3EvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727636AbfE3DLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:00 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2A2B244C4;
        Thu, 30 May 2019 03:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185859;
        bh=Xk/iLw49z1JCoFtls8/ow6PFTak0KhUDk4mdqxEWnqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BshtIrXijfoZsukoXPLFXnLoKSTnlLPCyw4BhvQdyQq4ErKn/kfS6/Hj/p7A6Mf6N
         Uj7hUPWfgFCm+rCkbzPDOgpZzKmL8KNRxLPvXHqFo+wj9UQUDEY3z7jSMyY9Ub5iPQ
         DKEOPDQT4C0fL1+hZERXlilMycKl/CZm6inT84mo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 147/405] pinctrl: pistachio: fix leaked of_node references
Date:   Wed, 29 May 2019 20:02:25 -0700
Message-Id: <20190530030548.560333495@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 44a4455ac2c6b0981eace683a2b6eccf47689022 ]

The call to of_get_child_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/pinctrl/pinctrl-pistachio.c:1422:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1360, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-pistachio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-pistachio.c b/drivers/pinctrl/pinctrl-pistachio.c
index aa5f949ef219c..5b0678f310e52 100644
--- a/drivers/pinctrl/pinctrl-pistachio.c
+++ b/drivers/pinctrl/pinctrl-pistachio.c
@@ -1367,6 +1367,7 @@ static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
 		if (!of_find_property(child, "gpio-controller", NULL)) {
 			dev_err(pctl->dev,
 				"No gpio-controller property for bank %u\n", i);
+			of_node_put(child);
 			ret = -ENODEV;
 			goto err;
 		}
@@ -1374,6 +1375,7 @@ static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
 		irq = irq_of_parse_and_map(child, 0);
 		if (irq < 0) {
 			dev_err(pctl->dev, "No IRQ for bank %u: %d\n", i, irq);
+			of_node_put(child);
 			ret = irq;
 			goto err;
 		}
-- 
2.20.1



