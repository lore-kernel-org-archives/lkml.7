Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF631C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE43C2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfCLGv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:51:28 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:40190 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCLGv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:51:27 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1h3bFy-0007NL-7W from Jiada_Wang@mentor.com ; Mon, 11 Mar 2019 23:51:22 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 11 Mar 2019 23:51:18 -0700
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <rjw@rjwysocki.net>, <khilman@kernel.org>,
        <ulf.hansson@linaro.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <gregkh@linuxfoundation.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kuninori.morimoto.gx@renesas.com>, <geert@linux-m68k.org>,
        <jiada_wang@mentor.com>
Subject: [PATCH 1/1] PM / Domains: Avoid a potential deadlock
Date:   Tue, 12 Mar 2019 15:51:28 +0900
Message-ID: <20190312065128.24994-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SVR-ORW-MBX-09.mgc.mentorg.com (147.34.90.209) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/base/power/domain.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 500de1dee967..a00ca6b8117b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1467,12 +1467,12 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
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
@@ -1480,9 +1480,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 
- out:
 	genpd_unlock(genpd);
-
+ out:
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
 	else
@@ -1531,15 +1530,15 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
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
2.19.2

