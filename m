Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046ADC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CBF216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520502;
	bh=zBEPaQqOj3fGcLAaqSuufXrZfsGV2qN2uatpayqbZSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ybhZXSSreLsp114KJxLU3lx6Ea186SVNDuYbhjsvYh2rPMwSu1Grm3QUfstVP/OEa
	 Mzaon8obpDQv1m3mNwHSFsSOmxSMQPS+z+XGxEqMAux1G0I3H/VMUaDEV0lHtAtJiO
	 SDfT5dsooKD1c4bVxRxWi3Re7Omdtwt3Ep9/FFEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfFZDll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfFZDlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:41:39 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-74.mobile.att.net [107.77.172.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F35F920659;
        Wed, 26 Jun 2019 03:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520498;
        bh=zBEPaQqOj3fGcLAaqSuufXrZfsGV2qN2uatpayqbZSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L94tbbewMH46tmZ3rMBTEslETwZ8lNcVAmaQFJ/BeLY2jFWw0I2hkwMBzbvRkEFN/
         M7pwZVTSUdDnqpcc/o40lLl5QBHnsva4DtzWf9CvlUzF9sMZPOFVlrymPn6XMhaRFc
         iAYlgohaMqJBoQaQ1SW86DHZi9z8br7lcI8+Qysw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.1 09/51] iommu/vt-d: Fix lock inversion between iommu->lock and device_domain_lock
Date:   Tue, 25 Jun 2019 23:40:25 -0400
Message-Id: <20190626034117.23247-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034117.23247-1-sashal@kernel.org>
References: <20190626034117.23247-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit 7560cc3ca7d9d11555f80c830544e463fcdb28b8 ]

Lockdep debug reported lock inversion related with the iommu code
caused by dmar_insert_one_dev_info() grabbing the iommu->lock and
the device_domain_lock out of order versus the code path in
iommu_flush_dev_iotlb(). Expanding the scope of the iommu->lock and
reversing the order of lock acquisition fixes the issue.

[   76.238180] dsa_bus wq0.0: dsa wq wq0.0 disabled
[   76.248706]
[   76.250486] ========================================================
[   76.257113] WARNING: possible irq lock inversion dependency detected
[   76.263736] 5.1.0-rc5+ #162 Not tainted
[   76.267854] --------------------------------------------------------
[   76.274485] systemd-journal/521 just changed the state of lock:
[   76.280685] 0000000055b330f5 (device_domain_lock){..-.}, at: iommu_flush_dev_iotlb.part.63+0x29/0x90
[   76.290099] but this lock took another, SOFTIRQ-unsafe lock in the past:
[   76.297093]  (&(&iommu->lock)->rlock){+.+.}
[   76.297094]
[   76.297094]
[   76.297094] and interrupts could create inverse lock ordering between them.
[   76.297094]
[   76.314257]
[   76.314257] other info that might help us debug this:
[   76.321448]  Possible interrupt unsafe locking scenario:
[   76.321448]
[   76.328907]        CPU0                    CPU1
[   76.333777]        ----                    ----
[   76.338642]   lock(&(&iommu->lock)->rlock);
[   76.343165]                                local_irq_disable();
[   76.349422]                                lock(device_domain_lock);
[   76.356116]                                lock(&(&iommu->lock)->rlock);
[   76.363154]   <Interrupt>
[   76.366134]     lock(device_domain_lock);
[   76.370548]
[   76.370548]  *** DEADLOCK ***

Fixes: 745f2586e78e ("iommu/vt-d: Simplify function get_domain_for_dev()")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0feb3f70da16..c82d5f1bd306 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2509,6 +2509,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		}
 	}
 
+	spin_lock(&iommu->lock);
 	spin_lock_irqsave(&device_domain_lock, flags);
 	if (dev)
 		found = find_domain(dev);
@@ -2524,17 +2525,16 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 
 	if (found) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
+		spin_unlock(&iommu->lock);
 		free_devinfo_mem(info);
 		/* Caller must free the original domain */
 		return found;
 	}
 
-	spin_lock(&iommu->lock);
 	ret = domain_attach_iommu(domain, iommu);
-	spin_unlock(&iommu->lock);
-
 	if (ret) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
+		spin_unlock(&iommu->lock);
 		free_devinfo_mem(info);
 		return NULL;
 	}
@@ -2544,6 +2544,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (dev)
 		dev->archdata.iommu = info;
 	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock(&iommu->lock);
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
 	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {
-- 
2.20.1

