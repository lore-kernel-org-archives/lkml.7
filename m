Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD69C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC74521906
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbfI3OhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:37:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731702AbfI3OhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:37:02 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2A2F4719A77CE6655499;
        Mon, 30 Sep 2019 22:36:58 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Mon, 30 Sep 2019 22:36:48 +0800
From:   John Garry <john.garry@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <robin.murphy@arm.com>,
        <mark.rutland@arm.com>, <will@kernel.org>
CC:     <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <nleeder@codeaurora.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH 1/6] ACPI/IORT: Set PMCG device parent
Date:   Mon, 30 Sep 2019 22:33:46 +0800
Message-ID: <1569854031-237636-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1569854031-237636-1-git-send-email-john.garry@huawei.com>
References: <1569854031-237636-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the IORT, a PMCG node includes a node reference to its associated
device.

Set the PMCG platform device parent device for future referencing.

For now, we only consider setting for when the associated component is an
SMMUv3.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/acpi/arm64/iort.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 8569b79e8b58..0b687520c3e7 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1455,7 +1455,7 @@ static __init const struct iort_dev_config *iort_get_dev_cfg(
  * Returns: 0 on success, <0 failure
  */
 static int __init iort_add_platform_device(struct acpi_iort_node *node,
-					   const struct iort_dev_config *ops)
+					   const struct iort_dev_config *ops, struct device *parent)
 {
 	struct fwnode_handle *fwnode;
 	struct platform_device *pdev;
@@ -1466,6 +1466,8 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 	if (!pdev)
 		return -ENOMEM;
 
+	pdev->dev.parent = parent;
+
 	if (ops->dev_set_proximity) {
 		ret = ops->dev_set_proximity(&pdev->dev, node);
 		if (ret)
@@ -1573,6 +1575,11 @@ static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
 static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
 #endif
 
+static int iort_fwnode_match(struct device *dev, const void *fwnode)
+{
+	return dev->fwnode == fwnode;
+}
+
 static void __init iort_init_platform_devices(void)
 {
 	struct acpi_iort_node *iort_node, *iort_end;
@@ -1594,11 +1601,34 @@ static void __init iort_init_platform_devices(void)
 				iort_table->length);
 
 	for (i = 0; i < iort->node_count; i++) {
+		struct device *parent = NULL;
+
 		if (iort_node >= iort_end) {
 			pr_err("iort node pointer overflows, bad table\n");
 			return;
 		}
 
+		/* Fixme: handle parent declared in IORT after PMCG */
+		if (iort_node->type == ACPI_IORT_NODE_PMCG) {
+			struct acpi_iort_node *iort_assoc_node;
+			struct acpi_iort_pmcg *pmcg;
+			u32 node_reference;
+
+			pmcg = (struct acpi_iort_pmcg *)iort_node->node_data;
+
+			node_reference = pmcg->node_reference;
+			iort_assoc_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
+				 node_reference);
+
+			if (iort_assoc_node->type == ACPI_IORT_NODE_SMMU_V3) {
+				struct fwnode_handle *assoc_fwnode;
+
+				assoc_fwnode = iort_get_fwnode(iort_assoc_node);
+
+				parent = bus_find_device(&platform_bus_type, NULL,
+				      assoc_fwnode, iort_fwnode_match);
+			}
+		}
 		iort_enable_acs(iort_node);
 
 		ops = iort_get_dev_cfg(iort_node);
@@ -1609,7 +1639,7 @@ static void __init iort_init_platform_devices(void)
 
 			iort_set_fwnode(iort_node, fwnode);
 
-			ret = iort_add_platform_device(iort_node, ops);
+			ret = iort_add_platform_device(iort_node, ops, parent);
 			if (ret) {
 				iort_delete_fwnode(iort_node);
 				acpi_free_fwnode_static(fwnode);
-- 
2.17.1

