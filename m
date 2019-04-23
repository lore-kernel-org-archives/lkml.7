Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD7BC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B62218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="untjjzDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfDWXVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:21:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39134 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbfDWXVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id e92so6469955plb.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EYoqwtlhspVO6DfzyLClaQUxGfmShRm+XxIRhwBQn0I=;
        b=untjjzDTKcvx3+iaKnypN+M8KVcNEUpB4mwwFbgfwC7yJnVLUBuXEpWrZKIITqTcBN
         gVCMKZuU7x49a1EvydCQLYZ0v5weudYBbmFitR1K7Gh24cS8vTgajFK56tt7Hu+U48bE
         +w4OzV1FKl0FgVZHth0AEKFh/mDjlgqxlMNAyxjO9pXkUD2io8Y5+MQCESi7DzfOD8o+
         DhYLCwlN38AEvwfx6tQsucj4HusnSH7zA6DI4x2BvZmeeAHqpDk+2wjNAaNfLS/6u640
         AvHBbHkJcdxSBilkrUHaTcRf8S459B45aqIU5crH6Q4NTEN1NEQ86QgF0YXzfCgYlUsh
         6Cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EYoqwtlhspVO6DfzyLClaQUxGfmShRm+XxIRhwBQn0I=;
        b=kC5/3145JUU8JZ7zauKOA8gIBExGyaRe02qTwohKW/XggMOOAeiOX4dFRII3fzldB3
         XCTJzjaZx+Lh/gaoYXUt4gcAaqg90rogb5vduYxJFwpDtf8dYAp/v6OGHIcqWNq274Ie
         A2ZV3Yz/CSIpDD1dAhrYQiYMeNq3W+FB8nYvtPHv8f+3nYpIf5h9pgjnG240lUHIrPeJ
         ckWGUkcqut34niw35E8vRlYWjHd0uMUQnSbbUFjDR6zUaLbhfd2P4FQ6LfEMCB68bCcD
         PyzPRqjouoYKfwFAsj0CcZ2KeEojn0Sn2okeWzZY9dBTRm/D/31+AgOWk8Q+fXTMKKKv
         tWlg==
X-Gm-Message-State: APjAAAVU5YROB0s/k3tk/YXr/M0AGPiibn8HeUNDJ51U2oJlNShRNG3I
        x6ESXBWhTCYXNsbnE6stpSvO9D9rUZc=
X-Google-Smtp-Source: APXvYqwSsIHNNCSlSYPmHMjgWsENBgc+jn8ULcVY1CgFWt3IEmlE6/E3F36W0TwLmUHJ8AIgZE/Zyg==
X-Received: by 2002:a17:902:9898:: with SMTP id s24mr7893823plp.268.1556061691666;
        Tue, 23 Apr 2019 16:21:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:30 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 22/25] drm: kirin: Make driver_data variable non-global
Date:   Tue, 23 Apr 2019 16:20:53 -0700
Message-Id: <1556061656-1733-23-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch changes the driver_data
value to not be a global variable. Instead the driver_data value
is accessed via the of_device_get_match_data() when needed.

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: Reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 43 ++++++++++++++-----------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index a2938d4..634fd58 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -30,18 +30,9 @@
 
 #include "kirin_drm_drv.h"
 
-static struct kirin_drm_data *driver_data;
 
-static int kirin_drm_kms_cleanup(struct drm_device *dev)
-{
-	drm_kms_helper_poll_fini(dev);
-	driver_data->cleanup(to_platform_device(dev->dev));
-	drm_mode_config_cleanup(dev);
-
-	return 0;
-}
-
-static int kirin_drm_kms_init(struct drm_device *dev)
+static int kirin_drm_kms_init(struct drm_device *dev,
+				const struct kirin_drm_data *driver_data)
 {
 	int ret;
 
@@ -97,6 +88,21 @@ static int compare_of(struct device *dev, void *data)
 	return dev->of_node == data;
 }
 
+static int kirin_drm_kms_cleanup(struct drm_device *dev)
+{
+	const struct kirin_drm_data *driver_data;
+
+	drm_kms_helper_poll_fini(dev);
+
+	driver_data = of_device_get_match_data(dev->dev);
+	if (driver_data->cleanup)
+		driver_data->cleanup(to_platform_device(dev->dev));
+
+	drm_mode_config_cleanup(dev);
+
+	return 0;
+}
+
 static int kirin_drm_connectors_register(struct drm_device *dev)
 {
 	struct drm_connector *connector;
@@ -133,15 +139,21 @@ static int kirin_drm_connectors_register(struct drm_device *dev)
 
 static int kirin_drm_bind(struct device *dev)
 {
+	struct kirin_drm_data *driver_data;
 	struct drm_device *drm_dev;
 	int ret;
 
+	driver_data = (struct kirin_drm_data *)of_device_get_match_data(dev);
+	if (driver_data == NULL)
+		return -EINVAL;
+
 	drm_dev = drm_dev_alloc(driver_data->driver, dev);
 	if (IS_ERR(drm_dev))
 		return PTR_ERR(drm_dev);
 	dev_set_drvdata(dev, drm_dev);
 
-	ret = kirin_drm_kms_init(drm_dev);
+	/* display controller init */
+	ret = kirin_drm_kms_init(drm_dev, driver_data);
 	if (ret)
 		goto err_drm_dev_put;
 
@@ -191,12 +203,6 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
 	struct component_match *match = NULL;
 	struct device_node *remote;
 
-	driver_data = (struct kirin_drm_data *)of_device_get_match_data(dev);
-	if (!driver_data) {
-		DRM_ERROR("failed to get dt id data\n");
-		return -EINVAL;
-	}
-
 	remote = of_graph_get_remote_node(np, 0, 0);
 	if (!remote)
 		return -ENODEV;
@@ -210,7 +216,6 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
 static int kirin_drm_platform_remove(struct platform_device *pdev)
 {
 	component_master_del(&pdev->dev, &kirin_drm_ops);
-	driver_data = NULL;
 	return 0;
 }
 
-- 
2.7.4

