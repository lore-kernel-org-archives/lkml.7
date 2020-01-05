Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8C9C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 13:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD719207FD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 13:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgAEN6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 08:58:05 -0500
Received: from mx60.baidu.com ([61.135.168.60]:17204 "EHLO
        tc-sys-mailedm04.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726192AbgAEN6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 08:58:05 -0500
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm04.tc.baidu.com (Postfix) with ESMTP id 6A8A7236C003;
        Sun,  5 Jan 2020 21:57:47 +0800 (CST)
From:   jimyan <jimyan@baidu.com>
To:     joro@8bytes.org, jsnitsel@redhat.com, baolu.lu@linux.intel.com,
        roland@purestorage.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jimyan@baidu.com
Subject: [PATCH v2] iommu/vt-d: Don't reject nvme host due to scope mismatch
Date:   Sun,  5 Jan 2020 21:57:48 +0800
Message-Id: <1578232668-2696-1-git-send-email-jimyan@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a system with an Intel PCIe port configured as a nvme host device, iommu
initialization fails with

    DMAR: Device scope type does not match for 0000:80:00.0

This is because the DMAR table reports this device as having scope 2
(ACPI_DMAR_SCOPE_TYPE_BRIDGE):

but the device has a type 0 PCI header:
80:00.0 Class 0600: Device 8086:2020 (rev 06)
00: 86 80 20 20 47 05 10 00 06 00 00 06 10 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
30: 00 00 00 00 90 00 00 00 00 00 00 00 00 01 00 00

VT-d works perfectly on this system, so there's no reason to bail out
on initialization due to this apparent scope mismatch. Add the class
0x06 ("PCI_BASE_CLASS_BRIDGE") as a heuristic for allowing DMAR
initialization for non-bridge PCI devices listed with scope bridge.

Signed-off-by: jimyan <jimyan@baidu.com>
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index eecd6a421667..50c92eb23ee4 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -244,7 +244,7 @@ int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
 		     info->dev->hdr_type != PCI_HEADER_TYPE_NORMAL) ||
 		    (scope->entry_type == ACPI_DMAR_SCOPE_TYPE_BRIDGE &&
 		     (info->dev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
-		      info->dev->class >> 8 != PCI_CLASS_BRIDGE_OTHER))) {
+		      info->dev->class >> 16 != PCI_BASE_CLASS_BRIDGE))) {
 			pr_warn("Device scope type does not match for %s\n",
 				pci_name(info->dev));
 			return -EINVAL;
-- 
2.11.0

