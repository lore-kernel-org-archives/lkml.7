Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8F5C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E28217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbfKFTw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:52:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:8750 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbfKFTwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:52:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 11:52:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="232995602"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2019 11:52:53 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/3] mei: me: mei_me_dev_init() use struct device instead of struct pci_dev.
Date:   Thu,  7 Nov 2019 00:38:39 +0200
Message-Id: <20191106223841.15802-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106223841.15802-1-tomas.winkler@intel.com>
References: <20191106223841.15802-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's enough to bind mei_device with associated 'struct device' instead
of actual 'struct pci_dev'. This is to allow working with mei devices
embedded within another pci device, usually via MFD framework,
where mei device is represented as a platform device.

Bump copyright year to 2019 on effected files.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me.c  | 10 +++++-----
 drivers/misc/mei/hw-me.h  |  4 ++--
 drivers/misc/mei/pci-me.c |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 5ef30c7c92b3..7d241c70e3e0 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2003-2018, Intel Corporation. All rights reserved.
+ * Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
@@ -1461,19 +1461,19 @@ const struct mei_cfg *mei_me_get_cfg(kernel_ulong_t idx)
 /**
  * mei_me_dev_init - allocates and initializes the mei device structure
  *
- * @pdev: The pci device structure
+ * @parent: device associated with physical device (pci/platform)
  * @cfg: per device generation config
  *
  * Return: The mei_device pointer on success, NULL on failure.
  */
-struct mei_device *mei_me_dev_init(struct pci_dev *pdev,
+struct mei_device *mei_me_dev_init(struct device *parent,
 				   const struct mei_cfg *cfg)
 {
 	struct mei_device *dev;
 	struct mei_me_hw *hw;
 	int i;
 
-	dev = devm_kzalloc(&pdev->dev, sizeof(struct mei_device) +
+	dev = devm_kzalloc(parent, sizeof(struct mei_device) +
 			   sizeof(struct mei_me_hw), GFP_KERNEL);
 	if (!dev)
 		return NULL;
@@ -1483,7 +1483,7 @@ struct mei_device *mei_me_dev_init(struct pci_dev *pdev,
 	for (i = 0; i < DMA_DSCR_NUM; i++)
 		dev->dr_dscr[i].size = cfg->dma_size[i];
 
-	mei_device_init(dev, &pdev->dev, &mei_me_hw_ops);
+	mei_device_init(dev, parent, &mei_me_hw_ops);
 	hw->cfg = cfg;
 
 	dev->fw_f_fw_ver_supported = cfg->fw_ver_supported;
diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
index 1d8794828cbc..b39347faadf5 100644
--- a/drivers/misc/mei/hw-me.h
+++ b/drivers/misc/mei/hw-me.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (c) 2012-2018, Intel Corporation. All rights reserved.
+ * Copyright (c) 2012-2019, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
@@ -91,7 +91,7 @@ enum mei_cfg_idx {
 
 const struct mei_cfg *mei_me_get_cfg(kernel_ulong_t idx);
 
-struct mei_device *mei_me_dev_init(struct pci_dev *pdev,
+struct mei_device *mei_me_dev_init(struct device *parent,
 				   const struct mei_cfg *cfg);
 
 int mei_me_pg_enter_sync(struct mei_device *dev);
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index ce43415a536c..e382ecca96d7 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -192,7 +192,7 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	/* allocates and initializes the mei dev structure */
-	dev = mei_me_dev_init(pdev, cfg);
+	dev = mei_me_dev_init(&pdev->dev, cfg);
 	if (!dev) {
 		err = -ENOMEM;
 		goto end;
-- 
2.21.0

