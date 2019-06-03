Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECD1C282DC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F7427A0A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfFCBXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 21:23:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:20792 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfFCBXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 21:23:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jun 2019 18:23:41 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2019 18:23:37 -0700
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
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 1/9] PCI: Add dev_is_untrusted helper
Date:   Mon,  3 Jun 2019 09:16:12 +0800
Message-Id: <20190603011620.31999-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603011620.31999-1-baolu.lu@linux.intel.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several places in the kernel where it is necessary to
check whether a device is a pci untrusted device. Add a helper
to simplify the callers.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4a5a84d7bdd4..0582d869923d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -979,6 +979,7 @@ void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type);
 void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
 #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
+#define dev_is_untrusted(d) ((dev_is_pci(d) ? to_pci_dev(d)->untrusted : false))
 
 /* Generic PCI functions exported to card drivers */
 
@@ -1707,6 +1708,7 @@ static inline struct pci_dev *pci_dev_get(struct pci_dev *dev) { return NULL; }
 
 #define dev_is_pci(d) (false)
 #define dev_is_pf(d) (false)
+#define dev_is_untrusted(d) (false)
 static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
 { return false; }
 static inline int pci_irqd_intx_xlate(struct irq_domain *d,
-- 
2.17.1

