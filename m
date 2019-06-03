Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9750C28CC5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF3727A61
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfFCBYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 21:24:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:20792 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfFCBYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 21:24:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jun 2019 18:24:00 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2019 18:23:56 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com,
        kevin.tian@intel.com, mika.westerberg@linux.intel.com,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 6/9] iommu/vt-d: Check whether device requires bounce buffer
Date:   Mon,  3 Jun 2019 09:16:17 +0800
Message-Id: <20190603011620.31999-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603011620.31999-1-baolu.lu@linux.intel.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a helper to check whether a device needs to
use bounce buffer. It also provides a boot time option
to disable the bounce buffer. Users can use this to
prevent the iommu driver from using the bounce buffer
for performance gain.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Xu Pengfei <pengfei.xu@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 drivers/iommu/intel-iommu.c                     | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 138f6664b2e2..65685c6e53e4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1728,6 +1728,11 @@
 			Note that using this option lowers the security
 			provided by tboot because it makes the system
 			vulnerable to DMA attacks.
+		nobounce [Default off]
+			Do not use the bounce buffer for untrusted devices like
+			the Thunderbolt devices. This will treat the untrusted
+			devices as the trusted ones, hence might expose security
+			risks of DMA attacks.
 
 	intel_idle.max_cstate=	[KNL,HW,ACPI,X86]
 			0	disables intel_idle and fall back on acpi_idle.
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 235837c50719..41439647f75d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -371,6 +371,7 @@ static int dmar_forcedac;
 static int intel_iommu_strict;
 static int intel_iommu_superpage = 1;
 static int iommu_identity_mapping;
+static int intel_no_bounce;
 
 #define IDENTMAP_ALL		1
 #define IDENTMAP_GFX		2
@@ -384,6 +385,8 @@ EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 static DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
 
+#define device_needs_bounce(d) (!intel_no_bounce && dev_is_untrusted(d))
+
 /*
  * Iterate over elements in device_domain_list and call the specified
  * callback @fn against each element.
@@ -466,6 +469,9 @@ static int __init intel_iommu_setup(char *str)
 			printk(KERN_INFO
 				"Intel-IOMMU: not forcing on after tboot. This could expose security risk for tboot\n");
 			intel_iommu_tboot_noforce = 1;
+		} else if (!strncmp(str, "nobounce", 8)) {
+			pr_info("Intel-IOMMU: No bounce buffer. This could expose security risks of DMA attacks\n");
+			intel_no_bounce = 1;
 		}
 
 		str += strcspn(str, ",");
-- 
2.17.1

