Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9484C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEEF20675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611455;
	bh=bKqwVv9yjqHquJY/6k654Djzhp7VUy5HUN6yxtJ7BEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L+w2703ZUS73EH5rq/btKWVx3ZUFd7cvePN9mue9LnGkyGc4c5ue3Ly9Dg6hDgUS0
	 t/Ue9e7YUh/eu0EUUHk0O38iK8q69hdsLkkzLbnpvJflOdqRFKP6ZOT4keneU3iV7d
	 SFL8DzetrM8WJXHHGYRqatsoeRLG2TXEKmJm4gCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404274AbfDRSRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391686AbfDRSLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:11:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC20520652;
        Thu, 18 Apr 2019 18:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611076;
        bh=bKqwVv9yjqHquJY/6k654Djzhp7VUy5HUN6yxtJ7BEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yTVVh9sk5qBu+CWpNT9DBityvZ+KvTwkZPGR2PM8YSAQ5aKqlp0DdDDyToDkWlafu
         iGWwZkQVhDSOiee7XlWrhyw0i9zNNu/ydbv004n+5cJ5T/vjhh1/2XkrTdh13H72Q2
         rB6T4339mWyMwfsWPJcS2Eb7LUxjMrOlNU3tSm4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiada Wang <jiada_wang@mentor.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 50/93] PM / Domains: Avoid a potential deadlock
Date:   Thu, 18 Apr 2019 19:57:28 +0200
Message-Id: <20190418160442.790170632@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.19.1



