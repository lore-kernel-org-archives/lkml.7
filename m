Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBD1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D39921726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbfHVO3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:29:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:30737 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732001AbfHVO3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:29:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 07:29:49 -0700
X-IronPort-AV: E=Sophos;i="5.64,417,1559545200"; 
   d="scan'208";a="178873789"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.17])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 07:29:47 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        =?UTF-8?q?Micha=C5=82=20Wajdeczko?= <michal.wajdeczko@intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [RFC PATCH] iommu/vt-d: Fix IOMMU field not populated on device hot re-plug
Date:   Thu, 22 Aug 2019 16:29:22 +0200
Message-Id: <20190822142922.31526-1-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a perfectly working i915 device is hot unplugged (via sysfs) and
hot re-plugged again, its dev->archdata.iommu field is not populated
again with an IOMMU pointer.  As a result, the device probe fails on
DMA mapping error during scratch page setup.

It looks like that happens because devices are not detached from their
MMUIO bus before they are removed on device unplug.  Then, when an
already registered device/IOMMU association is identified by the
reinstantiated device's bus and function IDs on IOMMU bus re-attach
attempt, the device's archdata is not populated with IOMMU information
and the bad happens.

I'm not sure if this is a proper fix but it works for me so at least it
confirms correctness of my analysis results, I believe.  So far I
haven't been able to identify a good place where the possibly missing
IOMMU bus detach on device unplug operation could be added.

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 12d094d08c0a..7cdcd0595408 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2477,6 +2477,9 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		if (info2) {
 			found      = info2->domain;
 			info2->dev = dev;
+
+			if (dev && !dev->archdata.iommu)
+				dev->archdata.iommu = info2;
 		}
 	}
 
-- 
2.21.0

