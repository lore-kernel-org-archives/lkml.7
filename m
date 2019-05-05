Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A51C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1CA208C2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557069080;
	bh=29Ns3mM74Ky+ju6uxOaSJ/6kMwlQ1AH4JKwc3yBAeyc=;
	h=From:To:Subject:Date:List-ID:From;
	b=c2ACKtDJ4XA4cQzyZEHZIbxmWImIKTvu4Re3iYVXb5q7c49IhgNiAPqj0ED1806h4
	 QANpMs0yfyQs7x4kHgFag+7TLdubJLGL0PBT0gaAisYqf5FAgGFRY7KaNBKjZFO0e7
	 eTvP7Y05lNqLGXKbOrhpSEBdZDfqu9SgkOC47IV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfEEPLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 11:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbfEEPLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 11:11:19 -0400
Received: from localhost.localdomain (unknown [194.230.155.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F039B208C0;
        Sun,  5 May 2019 15:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557069078;
        bh=29Ns3mM74Ky+ju6uxOaSJ/6kMwlQ1AH4JKwc3yBAeyc=;
        h=From:To:Subject:Date:From;
        b=Nok77GAegvIzsoGdmcUM0seHVHAUwvH7B4J3o7SzHN9sUReol23cgELFgTcbzaO+M
         A8XRYai5Gn5ExqXsfz8GeCmb3DiGZ2poH+qpAdU4TI9RDKPGOvF+ADdqlN6aUTaOwU
         EZGNXtfB7pQLXTKXPdGUIWvEcfw3P1MKxiDyil60=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [media] exynos4-is: Add missing of_node_put to fix reference leaks
Date:   Sun,  5 May 2019 17:11:09 +0200
Message-Id: <20190505151109.4361-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the reference to "parallel-ports" and remote endpoint's parent
nodes obtained previously with of_get_child_by_name() and
of_get_parent() respectively.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/media/platform/exynos4-is/media-dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/exynos4-is/media-dev.c
index 463f2d84553e..d1d5041cdae5 100644
--- a/drivers/media/platform/exynos4-is/media-dev.c
+++ b/drivers/media/platform/exynos4-is/media-dev.c
@@ -449,6 +449,7 @@ static int fimc_md_parse_port_node(struct fimc_md *fmd,
 		pd->fimc_bus_type = FIMC_BUS_TYPE_ISP_WRITEBACK;
 	else
 		pd->fimc_bus_type = pd->sensor_bus_type;
+	of_node_put(np);
 
 	if (WARN_ON(index >= ARRAY_SIZE(fmd->sensor))) {
 		of_node_put(rem);
@@ -474,7 +475,8 @@ static int fimc_md_parse_port_node(struct fimc_md *fmd,
 static int fimc_md_register_sensor_entities(struct fimc_md *fmd)
 {
 	struct device_node *parent = fmd->pdev->dev.of_node;
-	struct device_node *node, *ports;
+	struct device_node *ports = NULL;
+	struct device_node *node;
 	int index = 0;
 	int ret;
 
@@ -523,12 +525,14 @@ static int fimc_md_register_sensor_entities(struct fimc_md *fmd)
 		}
 		index++;
 	}
+	of_node_put(ports);
 
 rpm_put:
 	pm_runtime_put(fmd->pmf);
 	return 0;
 
 cleanup:
+	of_node_put(ports);
 	v4l2_async_notifier_cleanup(&fmd->subdev_notifier);
 	pm_runtime_put(fmd->pmf);
 	return ret;
-- 
2.17.1

