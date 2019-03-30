Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9548C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEDC218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907260;
	bh=Z1Q8D7zIjR/mIcuCnwXgI9rdto7h8zya3aEs688B2N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zStXknBLKbb6gc+zHqIXdGrdyR8n/3YS8C2o/KFJVx8E7qRfZaHx4NAhnPooYY7ue
	 vX5hi/zAqo8Zrd/Yapz4rfEfqzZrMVOVt2yZd/4SYR/1qfgkkwTMDOpnoeqSsOSLJW
	 qmblHSoEbHx1DNCgua2qe+vk8ByzXbrdFgqBg5wM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbfC3AyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731473AbfC3AyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:54:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0BEE218AC;
        Sat, 30 Mar 2019 00:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907255;
        bh=Z1Q8D7zIjR/mIcuCnwXgI9rdto7h8zya3aEs688B2N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OoeKosLNzrzjIygL2eXtpOyX46O3qfVlyPIYYcO0u9y5BU+yXn3O7TmHTIw9g2yO5
         Mzly/ir+ikhUVaI0Wjmta8OccAFbU07CoEvkYeqzI2yxpM6DY9or/2uaDDn0ODzD0D
         r58UbPzHo7dShrn1R2YvwJY/Tft9Ol6ayGMOMEb4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiada Wang <jiada_wang@mentor.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 39/52] PM / Domains: Avoid a potential deadlock
Date:   Fri, 29 Mar 2019 20:52:46 -0400
Message-Id: <20190330005301.26868-39-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005301.26868-1-sashal@kernel.org>
References: <20190330005301.26868-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

[ Upstream commit 2071ac985d37efe496782c34318dbead93beb02f ]

Lockdep warns that prepare_lock and genpd->mlock can cause a deadlock
the deadlock scenario is like following:
First thread is probing cs2000
cs2000_probe()
  clk_register()
    __clk_core_init()
      clk_prepare_lock()                            ----> acquires prepare_lock
        cs2000_recalc_rate()
          i2c_smbus_read_byte_data()
            rcar_i2c_master_xfer()
              dma_request_chan()
                rcar_dmac_of_xlate()
                  rcar_dmac_alloc_chan_resources()
                    pm_runtime_get_sync()
                      __pm_runtime_resume()
                        rpm_resume()
                          rpm_callback()
                            genpd_runtime_resume()   ----> acquires genpd->mlock

Second thread is attaching any device to the same PM domain
genpd_add_device()
  genpd_lock()                                       ----> acquires genpd->mlock
    cpg_mssr_attach_dev()
      of_clk_get_from_provider()
        __of_clk_get_from_provider()
          __clk_create_clk()
            clk_prepare_lock()                       ----> acquires prepare_lock

Since currently no PM provider access genpd's critical section
in .attach_dev, and .detach_dev callbacks, so there is no need to protect
these two callbacks with genpd->mlock.
This patch avoids a potential deadlock by moving out .attach_dev and .detach_dev
from genpd->mlock, so that genpd->mlock won't be held when prepare_lock is acquired
in .attach_dev and .detach_dev

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/domain.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4b5714199490..bf5be0bfaf77 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1388,12 +1388,12 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
-	genpd_lock(genpd);
-
 	ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
 	if (ret)
 		goto out;
 
+	genpd_lock(genpd);
+
 	dev_pm_domain_set(dev, &genpd->domain);
 
 	genpd->device_count++;
@@ -1401,9 +1401,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 
- out:
 	genpd_unlock(genpd);
-
+ out:
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
 	else
@@ -1452,15 +1451,15 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 	genpd->device_count--;
 	genpd->max_off_time_changed = true;
 
-	if (genpd->detach_dev)
-		genpd->detach_dev(genpd, dev);
-
 	dev_pm_domain_set(dev, NULL);
 
 	list_del_init(&pdd->list_node);
 
 	genpd_unlock(genpd);
 
+	if (genpd->detach_dev)
+		genpd->detach_dev(genpd, dev);
+
 	genpd_free_dev_data(dev, gpd_data);
 
 	return 0;
-- 
2.19.1

