Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C399C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BA9204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429895;
	bh=xqhnROkAuFWOa9hoLUMsZoXHogbMEhZx5u0bQNKIWwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q0qkXhfj3T725LveKMjiH3k1hBQty+TC5V+tQzQpgL6WjH6Y1BhkiyTL6Gf0h7ReL
	 6fbf6DZkZVzA5CfVs9yyDZw5wa04q9fKiPD6RwBhWbB7zHoxa7eO8mekwxxjAlU93u
	 83yXq/+UQy6pIFVJ9LjxKnTJA93ZrIjkYppTje2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390793AbfG2Tve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:51:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390775AbfG2Tvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:51:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0676204EC;
        Mon, 29 Jul 2019 19:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429890;
        bh=xqhnROkAuFWOa9hoLUMsZoXHogbMEhZx5u0bQNKIWwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/HJtaq95Xw4+1sFxFvqbklIKcrHjz1jhHtzbG8J3R0HOOq37WnUnfhr9vO2OmCdr
         3bxObsphKf3NLo269tmphM9E1s6usDtB75cIz/JpE3DETEvlxxW/FU6gRxt71seQjy
         /uAVP0Pai8C+TB5GKcK/dfSbX+lU+lef3nxlSp6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 129/215] PCI: dwc: pci-dra7xx: Fix compilation when !CONFIG_GPIOLIB
Date:   Mon, 29 Jul 2019 21:22:05 +0200
Message-Id: <20190729190801.744441299@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 381ed79c8655a40268ee7391f716edd90c5c3a97 ]

If CONFIG_GPIOLIB is not selected the compilation results in the
following build errors:

drivers/pci/controller/dwc/pci-dra7xx.c:
 In function dra7xx_pcie_probe:
drivers/pci/controller/dwc/pci-dra7xx.c:777:10:
 error: implicit declaration of function devm_gpiod_get_optional;
 did you mean devm_regulator_get_optional? [-Werror=implicit-function-declaration]

  reset = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);

drivers/pci/controller/dwc/pci-dra7xx.c:778:45: error: ‘GPIOD_OUT_HIGH’
undeclared (first use in this function); did you mean ‘GPIOF_INIT_HIGH’?
  reset = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);
                                             ^~~~~~~~~~~~~~
                                             GPIOF_INIT_HIGH

Fix them by including the appropriate header file.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
[lorenzo.pieralisi@arm.com: commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 419451efd58c..4234ddb4722f 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -26,6 +26,7 @@
 #include <linux/types.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
 
 #include "../../pci.h"
 #include "pcie-designware.h"
-- 
2.20.1



