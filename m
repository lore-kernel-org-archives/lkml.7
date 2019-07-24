Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BBEC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124AD2190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUxjny5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfGXL1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:27:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41680 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfGXL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:27:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so10741760pgg.8;
        Wed, 24 Jul 2019 04:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OHyg+mW86vtE5E624Kaljg5itGZDkjiTyXIxt8GjT0=;
        b=IUxjny5bzsg0GFzArn9NrEWhBuMRxaIFuGc5WWoMglJOgtVB6gZdJ7j/lOfZS5wuXy
         uUNSYSNaVX6t4T0YourQagJzNMHuDEKnTIeD1tc2y1ccfaxZ0AXpJcmfysT6w2Bvgqs/
         XqrveQDEeogIAgT7vbw9Rt++8VxfJEJ7MhXWXDseinuZlE2PuxyjZyaYm5duuobFIw09
         z9oEp1Cc14VPI3MCBbu43k1U1O2VsCup2t8B1V0xjKrl/6lxBiHLeYZNU4k18ewNLWat
         zahJgZT8xk7kssuHB4bhwvPNmMHsuscb8DqIOn70vl9t7RM5nE4uBpqoOVHNBf1w/kdJ
         tfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OHyg+mW86vtE5E624Kaljg5itGZDkjiTyXIxt8GjT0=;
        b=Go/QMetoVE3HPl7iq5KDaz4TGg/AwlGzPwsiTqpoWQ6w2Zox5RKwkpGABbY4l+AR6O
         LNTro2hxOhWkKOumnEzXEIJ0GU6Ci2kWVdd33vwX3jWCfTajypIKciG8UxHk7asCT6LC
         J+7cH87XM4pu+9uDmzbOTX4byvtw3V9ZDV26mZd9fcAzAcHmx8ig6khRivFn3T0XMcC8
         bsMhNyEfTTyXF7gx+g1hUIfT2PR3c2FURzb+tTDh3US1xqQAk55pLWnIuDo8I+Xy7R6H
         25dU7bpk84QvtUWjwq77gWcMMttQ+nxjkOXc3P1AKsE9PSGRrmY0mxW3pbH/OFg2EOuM
         bU9g==
X-Gm-Message-State: APjAAAVxaiKPpsG2suFJn8vgpImOaOqypJO0RVLWT1A5h82dngj8BgpL
        7hy5FH8LyDwoUJM2+EYifmA=
X-Google-Smtp-Source: APXvYqwbGDAda63tr9hohztN44pArw2VtiEByJ+COC6iPWrHTiz1JsaOKt+NK0H5Afwb1GkNPuA81A==
X-Received: by 2002:a17:90a:1b0c:: with SMTP id q12mr87931324pjq.76.1563967632066;
        Wed, 24 Jul 2019 04:27:12 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id g18sm82714938pgm.9.2019.07.24.04.27.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 04:27:11 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Martin Habets <mhabets@solarflare.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH net-next 04/10] sfc-falcon: Use dev_get_drvdata where possible
Date:   Wed, 24 Jul 2019 19:27:06 +0800
Message-Id: <20190724112706.13295-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/net/ethernet/sfc/falcon/efx.c           | 6 +++---
 drivers/net/ethernet/sfc/falcon/falcon_boards.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index 9b15c39ac670..eecc348b1c32 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -2256,7 +2256,7 @@ static struct notifier_block ef4_netdev_notifier = {
 static ssize_t
 show_phy_type(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct ef4_nic *efx = pci_get_drvdata(to_pci_dev(dev));
+	struct ef4_nic *efx = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", efx->phy_type);
 }
 static DEVICE_ATTR(phy_type, 0444, show_phy_type, NULL);
@@ -2999,7 +2999,7 @@ static int ef4_pci_probe(struct pci_dev *pci_dev,
 
 static int ef4_pm_freeze(struct device *dev)
 {
-	struct ef4_nic *efx = pci_get_drvdata(to_pci_dev(dev));
+	struct ef4_nic *efx = dev_get_drvdata(dev);
 
 	rtnl_lock();
 
@@ -3020,7 +3020,7 @@ static int ef4_pm_freeze(struct device *dev)
 static int ef4_pm_thaw(struct device *dev)
 {
 	int rc;
-	struct ef4_nic *efx = pci_get_drvdata(to_pci_dev(dev));
+	struct ef4_nic *efx = dev_get_drvdata(dev);
 
 	rtnl_lock();
 
diff --git a/drivers/net/ethernet/sfc/falcon/falcon_boards.c b/drivers/net/ethernet/sfc/falcon/falcon_boards.c
index 839189dab98e..2d85d1386ed9 100644
--- a/drivers/net/ethernet/sfc/falcon/falcon_boards.c
+++ b/drivers/net/ethernet/sfc/falcon/falcon_boards.c
@@ -357,7 +357,7 @@ static int sfe4001_poweron(struct ef4_nic *efx)
 static ssize_t show_phy_flash_cfg(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	struct ef4_nic *efx = pci_get_drvdata(to_pci_dev(dev));
+	struct ef4_nic *efx = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", !!(efx->phy_mode & PHY_MODE_SPECIAL));
 }
 
@@ -365,7 +365,7 @@ static ssize_t set_phy_flash_cfg(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
 {
-	struct ef4_nic *efx = pci_get_drvdata(to_pci_dev(dev));
+	struct ef4_nic *efx = dev_get_drvdata(dev);
 	enum ef4_phy_mode old_mode, new_mode;
 	int err;
 
-- 
2.20.1

