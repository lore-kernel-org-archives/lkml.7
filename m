Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0F5C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6BC276F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559396622;
	bh=53ok0bYmTt809hAnpG8NrkQv7x3hj2dYv3pMJurUqMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=msbzjAckL0k96V9DQbdaoGgTcJ//fPrCgdOA47LsZfJ28wCVAKXSq8LRoI50GUHlP
	 WP4hj5ryET0jkrBS9k02jTRVTOfRqY04kk6Ej5A081dDmYgC796ltnD1n8q7TmRo5r
	 dbhAUo5/o5WDU4NVMMFQlb4bkCBhVQx8Pkxh/2TQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfFANnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbfFANSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:18:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E92C2727A;
        Sat,  1 Jun 2019 13:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395084;
        bh=53ok0bYmTt809hAnpG8NrkQv7x3hj2dYv3pMJurUqMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z4p/Y5OqqSrQI45vYd/4inQqOCw4c/X/6i8zulwYslQYEptCrjVFeOIdG3+xA3Y7m
         HM4i7ufNLyan7qX+wLSLkG4QaCQDcnVYNJf2OuyLDiiSs3N/huOXxQlkYBMyt/1Xma
         1hSz2G6MyOzSKefdvOZvSLu7nyfvHKLF+YzfQU5o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiada Wang <jiada_wang@mentor.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 024/186] thermal: rcar_gen3_thermal: disable interrupt in .remove
Date:   Sat,  1 Jun 2019 09:14:00 -0400
Message-Id: <20190601131653.24205-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601131653.24205-1-sashal@kernel.org>
References: <20190601131653.24205-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

[ Upstream commit 63f55fcea50c25ae5ad45af92d08dae3b84534c2 ]

Currently IRQ remains enabled after .remove, later if device is probed,
IRQ is requested before .thermal_init, this may cause IRQ function be
called before device is initialized.

this patch disables interrupt in .remove, to ensure irq function
only be called after device is fully initialized.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/rcar_gen3_thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 88fa41cf16e83..0c9e7a5bacdf1 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -331,6 +331,9 @@ MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
 static int rcar_gen3_thermal_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
+
+	rcar_thermal_irq_set(priv, false);
 
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
-- 
2.20.1

