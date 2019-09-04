Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F22C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50208233FF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620370;
	bh=/7KlZoP8hNzFiMv4BzL0iY/0QUqS+oK8r4POagI9Ndo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MAYgcK7xuHVa7cfKnVsLoGcjm1DT2adnqH3FnItKI9AJ3/HE91L77XET7C4QkksDG
	 hEjlb+H0FiGMAxK6452B3ZePBpQbWRDVg5qQA+S1xEwscLd+WvKyDJmEr9Tv1THQgc
	 zxwRWG2vExVd8nJ5pkSqZ35A/xVIFFrAnYKkX4ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389394AbfIDSGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:06:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389007AbfIDSGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:06:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B243206B8;
        Wed,  4 Sep 2019 18:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620366;
        bh=/7KlZoP8hNzFiMv4BzL0iY/0QUqS+oK8r4POagI9Ndo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDDQxr/tAD5tV+lK4212m5SOtVpGnxdK9Z6ZByyC1624sVy6UjS+kY6PO/8DlEi01
         T7v7z9+gn1Jbjx3pEq2d4TIihmXa8w3mAZc4Wwa2hjsQMVPZQt2jmejbGQZ956ORdM
         p3SuvcVP3MEE894HnMOyu/k2YZpq/8YsBdhszTls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 30/93] drm/tilcdc: Register cpufreq notifier after we have initialized crtc
Date:   Wed,  4 Sep 2019 19:53:32 +0200
Message-Id: <20190904175305.912604297@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 432973fd3a20102840d5f7e61af9f1a03c217a4c ]

Register cpufreq notifier after we have initialized the crtc and
unregister it before we remove the ctrc. Receiving a cpufreq notify
without crtc causes a crash.

Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 34 ++++++++++++++---------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 0fb300d41a09c..e1868776da252 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -184,6 +184,12 @@ static void tilcdc_fini(struct drm_device *dev)
 {
 	struct tilcdc_drm_private *priv = dev->dev_private;
 
+#ifdef CONFIG_CPU_FREQ
+	if (priv->freq_transition.notifier_call)
+		cpufreq_unregister_notifier(&priv->freq_transition,
+					    CPUFREQ_TRANSITION_NOTIFIER);
+#endif
+
 	if (priv->crtc)
 		tilcdc_crtc_shutdown(priv->crtc);
 
@@ -198,12 +204,6 @@ static void tilcdc_fini(struct drm_device *dev)
 	drm_mode_config_cleanup(dev);
 	tilcdc_remove_external_device(dev);
 
-#ifdef CONFIG_CPU_FREQ
-	if (priv->freq_transition.notifier_call)
-		cpufreq_unregister_notifier(&priv->freq_transition,
-					    CPUFREQ_TRANSITION_NOTIFIER);
-#endif
-
 	if (priv->clk)
 		clk_put(priv->clk);
 
@@ -274,17 +274,6 @@ static int tilcdc_init(struct drm_driver *ddrv, struct device *dev)
 		goto init_failed;
 	}
 
-#ifdef CONFIG_CPU_FREQ
-	priv->freq_transition.notifier_call = cpufreq_transition;
-	ret = cpufreq_register_notifier(&priv->freq_transition,
-			CPUFREQ_TRANSITION_NOTIFIER);
-	if (ret) {
-		dev_err(dev, "failed to register cpufreq notifier\n");
-		priv->freq_transition.notifier_call = NULL;
-		goto init_failed;
-	}
-#endif
-
 	if (of_property_read_u32(node, "max-bandwidth", &priv->max_bandwidth))
 		priv->max_bandwidth = TILCDC_DEFAULT_MAX_BANDWIDTH;
 
@@ -361,6 +350,17 @@ static int tilcdc_init(struct drm_driver *ddrv, struct device *dev)
 	}
 	modeset_init(ddev);
 
+#ifdef CONFIG_CPU_FREQ
+	priv->freq_transition.notifier_call = cpufreq_transition;
+	ret = cpufreq_register_notifier(&priv->freq_transition,
+			CPUFREQ_TRANSITION_NOTIFIER);
+	if (ret) {
+		dev_err(dev, "failed to register cpufreq notifier\n");
+		priv->freq_transition.notifier_call = NULL;
+		goto init_failed;
+	}
+#endif
+
 	if (priv->is_componentized) {
 		ret = component_bind_all(dev, ddev);
 		if (ret < 0)
-- 
2.20.1



