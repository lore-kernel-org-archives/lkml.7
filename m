Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0B3C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461442081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfECIpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:45:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:5536 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfECIpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811559"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:33 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 09/22] intel_th: Only report useful IRQs to subdevices
Date:   Fri,  3 May 2019 11:44:42 +0300
Message-Id: <20190503084455.23436-10-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only type of IRQ triggering event that is useful to us at the moment
is the "last block" interrupt of the MSU. This interrupt can only be
enabled via "MINTCTL" register that doesn't exist in earlier version of
the Intel TH.

Enumerate the presence of MINTCTL via per-device driver data structure
and only instantiate the IRQ resource for subdevices if this capability
is present.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/core.c     | 7 ++++++-
 drivers/hwtracing/intel_th/intel_th.h | 2 ++
 drivers/hwtracing/intel_th/pci.c      | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 750aa9d6f849..390031df3edf 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -639,7 +639,12 @@ intel_th_subdevice_alloc(struct intel_th *th,
 			dev_dbg(th->dev, "%s:%d @ %pR\n",
 				subdev->name, r, &res[r]);
 		} else if (res[r].flags & IORESOURCE_IRQ) {
-			res[r].start	= th->irq;
+			/*
+			 * Only pass on the IRQ if we have useful interrupts:
+			 * the ones that can be configured via MINTCTL.
+			 */
+			if (INTEL_TH_CAP(th, has_mintctl) && th->irq != -1)
+				res[r].start = th->irq;
 		}
 	}
 
diff --git a/drivers/hwtracing/intel_th/intel_th.h b/drivers/hwtracing/intel_th/intel_th.h
index 59038215489a..8b986ba160e4 100644
--- a/drivers/hwtracing/intel_th/intel_th.h
+++ b/drivers/hwtracing/intel_th/intel_th.h
@@ -44,10 +44,12 @@ struct intel_th_output {
 /**
  * struct intel_th_drvdata - describes hardware capabilities and quirks
  * @tscu_enable:	device needs SW to enable time stamping unit
+ * @has_mintctl:	device has interrupt control (MINTCTL) register
  * @host_mode_only:	device can only operate in 'host debugger' mode
  */
 struct intel_th_drvdata {
 	unsigned int	tscu_enable        : 1,
+			has_mintctl        : 1,
 			host_mode_only     : 1;
 };
 
diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index f5643444481b..5808dd4c104c 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -122,6 +122,7 @@ static void intel_th_pci_remove(struct pci_dev *pdev)
 
 static const struct intel_th_drvdata intel_th_2x = {
 	.tscu_enable	= 1,
+	.has_mintctl	= 1,
 };
 
 static const struct pci_device_id intel_th_pci_id_table[] = {
-- 
2.20.1

