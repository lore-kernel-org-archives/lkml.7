Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C94C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9370C20883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140551;
	bh=uN3Zv3u1ZJHVVSAYNsE85+TJ0fLZjKZ9Z6JTnL7QfYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1qSB4UqAUVskWZ1h/0NB2optzd2m7NnRKHU9GX4t2YXYTozGqUqzsTUex2rhu+wWc
	 EhoLw19gyGBw6zOgWI4l/ksSQGW0YBoIEQYQIiBI4R6beMVBiTvyN+/qpDBFmwAeVW
	 52Ooxe8s7lpuJwvehnMHVnPXsumoA9nzX2mEtVs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387933AbfDARgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:36:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388088AbfDARgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:36:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8481F2070B;
        Mon,  1 Apr 2019 17:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140212;
        bh=uN3Zv3u1ZJHVVSAYNsE85+TJ0fLZjKZ9Z6JTnL7QfYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWmQc07LH4JnL/VkwiJ3jKpAsCGmE3nBP2TyhvbIfrbnPS7ihTFWoK7JjuLZjgzCM
         VhEoOg8crlcimaoPMXVmypii/KOr9W4mIG5CGAtMu8QBt8jNG0r0PU/iNVOhz1T6UA
         EGoivwkPf1732Fqzr7tg8KgPRpWCOmza84vc77xo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rabin Vincent <rabin@rab.in>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 130/131] coresight: removing bind/unbind options from sysfs
Date:   Mon,  1 Apr 2019 19:03:20 +0200
Message-Id: <20190401170102.287991021@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b15f0fb657e040401d875d11ae13b269af8a16e0 ]

The coresight drivers have absolutely no control over bind and unbind
operations triggered from sysfs. The operations simply can't be
cancelled or denied event when one or several tracing sessions are
under way.  Since the memory associated to individual device is
invariably freed, the end result is a kernel crash when the path from
source to sink is travelled again as demonstrated here[1].

One solution could be to keep track of all the path (i.e tracing
session) that get created and iterate through the elements of those path
looking for the coresight device that is being removed.  This proposition
doesn't scale well since there is no upper bound on the amount of
concurrent trace session that can be created.

With the above in mind, this patch prevent devices from being unbounded
from their driver by using the driver->suppress_bind_attr option.  That way
trace sessions can be managed without fearing to loose devices.

Since device can't be removed anymore the xyz_remove() functions found in
each driver is also removed.

[1]. http://www.spinics.net/lists/arm-kernel/msg474952.html

Reported-by: Rabin Vincent <rabin@rab.in>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c    | 11 +----------
 drivers/hwtracing/coresight/coresight-etm3x.c    | 13 +------------
 drivers/hwtracing/coresight/coresight-etm4x.c    | 13 +------------
 drivers/hwtracing/coresight/coresight-funnel.c   | 10 +---------
 .../coresight/coresight-replicator-qcom.c        | 11 +----------
 .../hwtracing/coresight/coresight-replicator.c   | 16 +---------------
 drivers/hwtracing/coresight/coresight-tmc.c      | 15 +--------------
 drivers/hwtracing/coresight/coresight-tpiu.c     | 10 +---------
 8 files changed, 8 insertions(+), 91 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 77d0f9c1118d..92969dae739d 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -489,15 +489,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
-static int etb_remove(struct amba_device *adev)
-{
-	struct etb_drvdata *drvdata = amba_get_drvdata(adev);
-
-	misc_deregister(&drvdata->miscdev);
-	coresight_unregister(drvdata->csdev);
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int etb_runtime_suspend(struct device *dev)
 {
@@ -537,10 +528,10 @@ static struct amba_driver etb_driver = {
 		.name	= "coresight-etb10",
 		.owner	= THIS_MODULE,
 		.pm	= &etb_dev_pm_ops,
+		.suppress_bind_attrs = true,
 
 	},
 	.probe		= etb_probe,
-	.remove		= etb_remove,
 	.id_table	= etb_ids,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index d630b7ece735..5981fcc69960 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -1877,17 +1877,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
-static int etm_remove(struct amba_device *adev)
-{
-	struct etm_drvdata *drvdata = amba_get_drvdata(adev);
-
-	coresight_unregister(drvdata->csdev);
-	if (--etm_count == 0)
-		unregister_hotcpu_notifier(&etm_cpu_notifier);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int etm_runtime_suspend(struct device *dev)
 {
@@ -1948,9 +1937,9 @@ static struct amba_driver etm_driver = {
 		.name	= "coresight-etm3x",
 		.owner	= THIS_MODULE,
 		.pm	= &etm_dev_pm_ops,
+		.suppress_bind_attrs = true,
 	},
 	.probe		= etm_probe,
-	.remove		= etm_remove,
 	.id_table	= etm_ids,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 1ec6798b21e8..0edc10b44004 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -2684,17 +2684,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
-static int etm4_remove(struct amba_device *adev)
-{
-	struct etmv4_drvdata *drvdata = amba_get_drvdata(adev);
-
-	coresight_unregister(drvdata->csdev);
-	if (--etm4_count == 0)
-		unregister_hotcpu_notifier(&etm4_cpu_notifier);
-
-	return 0;
-}
-
 static struct amba_id etm4_ids[] = {
 	{       /* ETM 4.0 - Qualcomm */
 		.id	= 0x0003b95d,
@@ -2712,9 +2701,9 @@ static struct amba_id etm4_ids[] = {
 static struct amba_driver etm4x_driver = {
 	.drv = {
 		.name   = "coresight-etm4x",
+		.suppress_bind_attrs = true,
 	},
 	.probe		= etm4_probe,
-	.remove		= etm4_remove,
 	.id_table	= etm4_ids,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 2e36bde7fcb4..25e8ea140a09 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -226,14 +226,6 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
 	return 0;
 }
 
-static int funnel_remove(struct amba_device *adev)
-{
-	struct funnel_drvdata *drvdata = amba_get_drvdata(adev);
-
-	coresight_unregister(drvdata->csdev);
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int funnel_runtime_suspend(struct device *dev)
 {
@@ -273,9 +265,9 @@ static struct amba_driver funnel_driver = {
 		.name	= "coresight-funnel",
 		.owner	= THIS_MODULE,
 		.pm	= &funnel_dev_pm_ops,
+		.suppress_bind_attrs = true,
 	},
 	.probe		= funnel_probe,
-	.remove		= funnel_remove,
 	.id_table	= funnel_ids,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-replicator-qcom.c b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
index 584059e9e866..444815179460 100644
--- a/drivers/hwtracing/coresight/coresight-replicator-qcom.c
+++ b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
@@ -156,15 +156,6 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 	return 0;
 }
 
-static int replicator_remove(struct amba_device *adev)
-{
-	struct replicator_state *drvdata = amba_get_drvdata(adev);
-
-	pm_runtime_disable(&adev->dev);
-	coresight_unregister(drvdata->csdev);
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int replicator_runtime_suspend(struct device *dev)
 {
@@ -206,9 +197,9 @@ static struct amba_driver replicator_driver = {
 	.drv = {
 		.name	= "coresight-replicator-qcom",
 		.pm	= &replicator_dev_pm_ops,
+		.suppress_bind_attrs = true,
 	},
 	.probe		= replicator_probe,
-	.remove		= replicator_remove,
 	.id_table	= replicator_ids,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 963ac197c253..b77d700a3f0e 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -127,20 +127,6 @@ static int replicator_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int replicator_remove(struct platform_device *pdev)
-{
-	struct replicator_drvdata *drvdata = platform_get_drvdata(pdev);
-
-	coresight_unregister(drvdata->csdev);
-	pm_runtime_get_sync(&pdev->dev);
-	if (!IS_ERR(drvdata->atclk))
-		clk_disable_unprepare(drvdata->atclk);
-	pm_runtime_put_noidle(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int replicator_runtime_suspend(struct device *dev)
 {
@@ -175,11 +161,11 @@ static const struct of_device_id replicator_match[] = {
 
 static struct platform_driver replicator_driver = {
 	.probe          = replicator_probe,
-	.remove         = replicator_remove,
 	.driver         = {
 		.name   = "coresight-replicator",
 		.of_match_table = replicator_match,
 		.pm	= &replicator_dev_pm_ops,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 62f9d7372e3a..c4fa70ed14ce 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -770,19 +770,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
-static int tmc_remove(struct amba_device *adev)
-{
-	struct tmc_drvdata *drvdata = amba_get_drvdata(adev);
-
-	misc_deregister(&drvdata->miscdev);
-	coresight_unregister(drvdata->csdev);
-	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
-		dma_free_coherent(drvdata->dev, drvdata->size,
-				  &drvdata->paddr, GFP_KERNEL);
-
-	return 0;
-}
-
 static struct amba_id tmc_ids[] = {
 	{
 		.id     = 0x0003b961,
@@ -795,9 +782,9 @@ static struct amba_driver tmc_driver = {
 	.drv = {
 		.name   = "coresight-tmc",
 		.owner  = THIS_MODULE,
+		.suppress_bind_attrs = true,
 	},
 	.probe		= tmc_probe,
-	.remove		= tmc_remove,
 	.id_table	= tmc_ids,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index fe3a2b19a5db..105c192eb2c1 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -180,14 +180,6 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	return 0;
 }
 
-static int tpiu_remove(struct amba_device *adev)
-{
-	struct tpiu_drvdata *drvdata = amba_get_drvdata(adev);
-
-	coresight_unregister(drvdata->csdev);
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int tpiu_runtime_suspend(struct device *dev)
 {
@@ -231,9 +223,9 @@ static struct amba_driver tpiu_driver = {
 		.name	= "coresight-tpiu",
 		.owner	= THIS_MODULE,
 		.pm	= &tpiu_dev_pm_ops,
+		.suppress_bind_attrs = true,
 	},
 	.probe		= tpiu_probe,
-	.remove		= tpiu_remove,
 	.id_table	= tpiu_ids,
 };
 
-- 
2.19.1



