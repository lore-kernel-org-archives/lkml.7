Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28652C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C19208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfIMMMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 08:12:51 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:36084 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729760AbfIMMMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:12:50 -0400
X-IronPort-AV: E=Sophos;i="5.64,500,1559487600"; 
   d="scan'208";a="26532336"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 13 Sep 2019 21:12:48 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 870DE4007F39;
        Fri, 13 Sep 2019 21:12:47 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH 2/3] spi: dw: Add basic runtime PM support
Date:   Fri, 13 Sep 2019 13:11:59 +0100
Message-Id: <1568376720-7402-3-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com>
References: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

Enable runtime PM so that the clock used to access the registers in the
peripheral is turned on using a clock domain.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
---
 drivers/spi/spi-dw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 9a49e07..593bbb0 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 
@@ -497,6 +498,9 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	if (dws->set_cs)
 		master->set_cs = dws->set_cs;
 
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
 	/* Basic HW init */
 	spi_hw_init(dev, dws);
 
-- 
2.7.4

