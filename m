Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEC5C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260ED2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561683061;
	bh=iGM+N04dIDhh5RkQ96noqqT2oVPBuB+LrurzBOzOZGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0bItcO+jsKAeBP/LJsV3y/c4MesX0YTbcb/Jg/Jm7z9PgCr8RejVeyFDDi37DOF7e
	 eh/MLKbaV0jTohsR2greskOpDhBfeCsQNl4Ez0V0dAndmG15dOpvC8YpIlwwAM7rjJ
	 j/trfaciDiRcLEx37tUVgonUrjE8qCqHH16DtLys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfF1Aun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:50:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42891 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfF1Auk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:50:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so2191321plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 17:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nkaaEzcIJYAZk41zsKaeC42Zrk9r0yReMvWJ9xWRCd8=;
        b=cIoiOWBkD4QX41slmxn3ZUM1gMm91ZlrDmGcYFHwISO3lpPh1gGcaIxKP31mCjyxAV
         OfnLZWqn46iAxZYQYc6MdaGpZfG2lJLpycfUGh1zpGd97jIn6evgJ5531NdkcckgsHF6
         Tg0gTFVPrclnrl9k8S/SXsWdWCGwr8QvUI1wmVG9hffuLmx/FnBAmw1cAgVctglpsyeH
         8NlMh8Guff5mDzAZ4iyCi4ol/hTvBElDrOZMme+9Jnm+AU8Ezsly+dJ/G55AwAEhA8Gt
         exAIh3ZvZxZBGHnmry+3jOGLz5ghi0+oJMGWQ7zI2+7V09K3sqGgbwQTJPVZjrIt2k0a
         PxTA==
X-Gm-Message-State: APjAAAW3LPDy2yZrKFWcKVGw5s5/HnUUYYkmHsLULe9yi/V5sLHomu0/
        1F8yySEB/X4NU99wWN/UEfbfZ57zu8g=
X-Google-Smtp-Source: APXvYqwP9C+r2YU+Xoowvb1QAj83yRVxAx9ByV1g7c7Srq+OvMX1p5YaP10bzS9DeNUWccxbQo+eaw==
X-Received: by 2002:a17:902:54d:: with SMTP id 71mr7963274plf.140.1561683039698;
        Thu, 27 Jun 2019 17:50:39 -0700 (PDT)
Received: from localhost (c-76-21-109-208.hsd1.ca.comcast.net. [76.21.109.208])
        by smtp.gmail.com with ESMTPSA id j16sm339453pjz.31.2019.06.27.17.50.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 17:50:38 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>
Subject: [PATCH 11/15] fpga: dfl: afu: export __port_enable/disable function.
Date:   Thu, 27 Jun 2019 17:49:47 -0700
Message-Id: <20190628004951.6202-12-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628004951.6202-1-mdf@kernel.org>
References: <20190628004951.6202-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu Hao <hao.wu@intel.com>

As these two functions are used by other private features. e.g.
in error reporting private feature, it requires to check port status
and reset port for error clearing.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-afu-main.c | 25 ++++++++++++++-----------
 drivers/fpga/dfl-afu.h      |  3 +++
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 65b3e895e364..c8bc0b5d9c16 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -24,14 +24,16 @@
 #define DRV_VERSION	"0.8"
 
 /**
- * port_enable - enable a port
+ * __port_enable - enable a port
  * @pdev: port platform device.
  *
  * Enable Port by clear the port soft reset bit, which is set by default.
  * The AFU is unable to respond to any MMIO access while in reset.
- * port_enable function should only be used after port_disable function.
+ * __port_enable function should only be used after __port_disable function.
+ *
+ * The caller needs to hold lock for protection.
  */
-static void port_enable(struct platform_device *pdev)
+void __port_enable(struct platform_device *pdev)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	void __iomem *base;
@@ -54,13 +56,14 @@ static void port_enable(struct platform_device *pdev)
 #define RST_POLL_TIMEOUT 1000 /* us */
 
 /**
- * port_disable - disable a port
+ * __port_disable - disable a port
  * @pdev: port platform device.
  *
- * Disable Port by setting the port soft reset bit, it puts the port into
- * reset.
+ * Disable Port by setting the port soft reset bit, it puts the port into reset.
+ *
+ * The caller needs to hold lock for protection.
  */
-static int port_disable(struct platform_device *pdev)
+int __port_disable(struct platform_device *pdev)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	void __iomem *base;
@@ -106,9 +109,9 @@ static int __port_reset(struct platform_device *pdev)
 {
 	int ret;
 
-	ret = port_disable(pdev);
+	ret = __port_disable(pdev);
 	if (!ret)
-		port_enable(pdev);
+		__port_enable(pdev);
 
 	return ret;
 }
@@ -805,9 +808,9 @@ static int port_enable_set(struct platform_device *pdev, bool enable)
 
 	mutex_lock(&pdata->lock);
 	if (enable)
-		port_enable(pdev);
+		__port_enable(pdev);
 	else
-		ret = port_disable(pdev);
+		ret = __port_disable(pdev);
 	mutex_unlock(&pdata->lock);
 
 	return ret;
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
index 0c7630ae3cda..35e60c5859a4 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -79,6 +79,9 @@ struct dfl_afu {
 	struct dfl_feature_platform_data *pdata;
 };
 
+void __port_enable(struct platform_device *pdev);
+int __port_disable(struct platform_device *pdev);
+
 void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
 int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
 			u32 region_index, u64 region_size, u64 phys, u32 flags);
-- 
2.22.0

