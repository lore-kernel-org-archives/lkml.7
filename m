Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0951DC5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA26E21848
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbfKFTw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:52:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:8750 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbfKFTw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:52:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 11:52:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="232995613"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2019 11:52:54 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/3] mei: me: store irq number in the hw struct.
Date:   Thu,  7 Nov 2019 00:38:40 +0200
Message-Id: <20191106223841.15802-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106223841.15802-1-tomas.winkler@intel.com>
References: <20191106223841.15802-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Store irq number in hw struct to by used by synchronize_irq().
This is to allow working with mei devices
embedded within another pci devices, via MFD framework,
where mei device is represented as a platform device.

Bump the copyright year to 2019 on hw-me.c and hw-me.h

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me.c  | 4 ++--
 drivers/misc/mei/hw-me.h  | 2 ++
 drivers/misc/mei/pci-me.c | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 7d241c70e3e0..23606d0ddcd6 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -323,9 +323,9 @@ static void mei_me_intr_disable(struct mei_device *dev)
  */
 static void mei_me_synchronize_irq(struct mei_device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct mei_me_hw *hw = to_me_hw(dev);
 
-	synchronize_irq(pdev->irq);
+	synchronize_irq(hw->irq);
 }
 
 /**
diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
index b39347faadf5..c45b32a7cc46 100644
--- a/drivers/misc/mei/hw-me.h
+++ b/drivers/misc/mei/hw-me.h
@@ -42,6 +42,7 @@ struct mei_cfg {
  *
  * @cfg: per device generation config and ops
  * @mem_addr: io memory address
+ * @irq: irq number
  * @pg_state: power gating state
  * @d0i3_supported: di03 support
  * @hbuf_depth: depth of hardware host/write buffer in slots
@@ -49,6 +50,7 @@ struct mei_cfg {
 struct mei_me_hw {
 	const struct mei_cfg *cfg;
 	void __iomem *mem_addr;
+	int irq;
 	enum mei_pg_state pg_state;
 	bool d0i3_supported;
 	u8 hbuf_depth;
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index e382ecca96d7..6233b3ca1c1d 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -199,6 +199,7 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	hw = to_me_hw(dev);
 	hw->mem_addr = pcim_iomap_table(pdev)[0];
+	hw->irq = pdev->irq;
 
 	pci_enable_msi(pdev);
 
-- 
2.21.0

