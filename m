Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201E9C4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39C2218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQs2b90e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfGDCgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 22:36:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41720 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGDCgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 22:36:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id q4so2146692pgj.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 19:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=calKg31YDJ74yDzQJN7XSSUBsHnK7/+Pchjehhl+BSk=;
        b=iQs2b90eTP+P2KlFVEZCLVMHWJNammzNFcmzkyKAhLlut/Ybw8o8K0xGKutmmk6NK9
         stKiMAYKREnsQ8jRQEsfNUpzFokHBOXHXckaEiZwyHVuu5OEGIR74xy8dZ22lPy2+oTO
         pqiR9Mt9yZbPg5INQQxUGYJrGxnD9oHO083RdgSoN36ZzQuIE09TTvIROkhWwOZEk3Tn
         aePttRcpNdP/IxDSZFticngv4IEZ0Csdlj9BJEHg4wVF7mO80l/H9U6rhwV4cl4W4+mA
         qyVP8deBLAhdCKvsgMMiddfHfssxZZ51wc+liQp2HOJvB6KTVEBT8NijJ/caa6NS8riB
         Sr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=calKg31YDJ74yDzQJN7XSSUBsHnK7/+Pchjehhl+BSk=;
        b=nPzbHtEuv5tn6tskLSg1NrFWLYf1fjXE1vrvRGo3NMBq/MryV7vlttiywEEtyfbMuZ
         Q+QuwYd/1m7IWnSrHRmG5wKv5e4rRecVZ7FdpyPqQcMwKqZeTSE/S+dqgV0ELHD32iHH
         qa6y3uUHHQlucqWrY9gO4U27FU/TGkKl3Rp7pZiElueLJUAtwC2zD9D9QuyX3PE9x73t
         pTWfXEjbvnBGxuTqYJAZ03CIK3W1ii2iPhYtI50OIb/zljxsZCeYSeNaSMl0tiskhTHl
         F5Z2rHdrIviFgoWMmNcuXZxcWeB2XlLrLwKnbrf08pW0knJLp3pYe5jTZ6k0F+2pY4Qn
         vvjw==
X-Gm-Message-State: APjAAAUABe+XLdv1W2kW3Yyh1Svd6T2/GMi0pXBkVd26NXrlUe3WIiDD
        Nv+0zrQzPaE60ru9A5iVL4U=
X-Google-Smtp-Source: APXvYqysTT1dJ+qo2p+TuEhYNUmmNz27UgpVXslH1JJ0TzquvDJbtGeKR1AwuVM/ccNZGP4PjGgeuA==
X-Received: by 2002:a17:90a:9a83:: with SMTP id e3mr16236570pjp.105.1562207764004;
        Wed, 03 Jul 2019 19:36:04 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id e10sm3921153pfi.173.2019.07.03.19.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 19:36:03 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [Patch v2 03/10] drm/omapdrm: using dev_get_drvdata directly
Date:   Thu,  4 Jul 2019 10:35:57 +0800
Message-Id: <20190704023557.4551-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several drivers cast a struct device pointer to a struct
platform_device pointer only to then call platform_get_drvdata().
To improve readability, these constructs can be simplified
by using dev_get_drvdata() directly.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Make the commit message more clearly.

 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 8edef8ef23b0..53240da139b1 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -407,8 +407,7 @@ static const struct backlight_ops dsicm_bl_ops = {
 static ssize_t dsicm_num_errors_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	struct omap_dss_device *src = ddata->src;
 	u8 errors = 0;
 	int r;
@@ -439,8 +438,7 @@ static ssize_t dsicm_num_errors_show(struct device *dev,
 static ssize_t dsicm_hw_revision_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	struct omap_dss_device *src = ddata->src;
 	u8 id1, id2, id3;
 	int r;
@@ -506,8 +504,7 @@ static ssize_t dsicm_show_ulps(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	unsigned int t;
 
 	mutex_lock(&ddata->lock);
@@ -521,8 +518,7 @@ static ssize_t dsicm_store_ulps_timeout(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	struct omap_dss_device *src = ddata->src;
 	unsigned long t;
 	int r;
@@ -553,8 +549,7 @@ static ssize_t dsicm_show_ulps_timeout(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	unsigned int t;
 
 	mutex_lock(&ddata->lock);
-- 
2.11.0

