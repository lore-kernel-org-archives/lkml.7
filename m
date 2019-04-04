Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A2AC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D15206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371617;
	bh=bZ9bLe04KQrD6HJQG1lTxqoBo83ACV2LEst1TRO0XCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PdbXP9Cppyg2eWOnGv8xXKCD+STMc4pR7ydfDHE4VxPC6MAzX1V1FE1bA7EuXLWJ9
	 3kZKDA7FtbspkixmiDAHj/3yO7OcdBrXgXooux9NkcH9O1AYTYk5JGxUwUu6JsyXaY
	 UIxx+2wvOUCVFUe4kved+Wx+V7+zFDZOFgX9gZQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfDDIxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729743AbfDDIxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:53:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2DFC20882;
        Thu,  4 Apr 2019 08:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367990;
        bh=bZ9bLe04KQrD6HJQG1lTxqoBo83ACV2LEst1TRO0XCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDmcRuG30+V0613jgIvV8nWEvC1xUl8XMBLATBaKmVjZGTd/E1CGOXZGD6W+ReCWD
         /nJyoctCAPK7iILcTei1cUHPEPHI5TRkZGWkEANjb+2j5r9to2mxHhTKx4zZCg5Mmt
         BsHZ/dHeC8Ixhrjz+7K8Yzwa7WMgFM5qsAz98CGQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        "Michael W. Bringmann" <mwb@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 73/91] powerpc/pseries: Perform full re-add of CPU for topology update post-migration
Date:   Thu,  4 Apr 2019 10:47:57 +0200
Message-Id: <20190404084539.674973415@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 81b61324922c67f73813d8a9c175f3c153f6a1c6 ]

On pseries systems, performing a partition migration can result in
altering the nodes a CPU is assigned to on the destination system. For
exampl, pre-migration on the source system CPUs are in node 1 and 3,
post-migration on the destination system CPUs are in nodes 2 and 3.

Handling the node change for a CPU can cause corruption in the slab
cache if we hit a timing where a CPUs node is changed while cache_reap()
is invoked. The corruption occurs because the slab cache code appears
to rely on the CPU and slab cache pages being on the same node.

The current dynamic updating of a CPUs node done in arch/powerpc/mm/numa.c
does not prevent us from hitting this scenario.

Changing the device tree property update notification handler that
recognizes an affinity change for a CPU to do a full DLPAR remove and
add of the CPU instead of dynamically changing its node resolves this
issue.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Signed-off-by: Michael W. Bringmann <mwb@linux.vnet.ibm.com>
Tested-by: Michael W. Bringmann <mwb@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/topology.h          |  2 ++
 arch/powerpc/mm/numa.c                       |  9 +--------
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 8b3b46b7b0f2..229c91bcf616 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -90,6 +90,8 @@ static inline int prrn_is_enabled(void)
 #define topology_sibling_cpumask(cpu)	(per_cpu(cpu_sibling_map, cpu))
 #define topology_core_cpumask(cpu)	(per_cpu(cpu_core_map, cpu))
 #define topology_core_id(cpu)		(cpu_to_core_id(cpu))
+
+int dlpar_cpu_readd(int cpu);
 #endif
 #endif
 
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 0ef83c274019..9cad2ed812ab 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1540,13 +1540,6 @@ static void reset_topology_timer(void)
 
 #ifdef CONFIG_SMP
 
-static void stage_topology_update(int core_id)
-{
-	cpumask_or(&cpu_associativity_changes_mask,
-		&cpu_associativity_changes_mask, cpu_sibling_mask(core_id));
-	reset_topology_timer();
-}
-
 static int dt_update_callback(struct notifier_block *nb,
 				unsigned long action, void *data)
 {
@@ -1559,7 +1552,7 @@ static int dt_update_callback(struct notifier_block *nb,
 		    !of_prop_cmp(update->prop->name, "ibm,associativity")) {
 			u32 core_id;
 			of_property_read_u32(update->dn, "reg", &core_id);
-			stage_topology_update(core_id);
+			rc = dlpar_cpu_readd(core_id);
 			rc = NOTIFY_OK;
 		}
 		break;
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index a1b63e00b2f7..7a2beedb9740 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -785,6 +785,25 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
 	return rc;
 }
 
+int dlpar_cpu_readd(int cpu)
+{
+	struct device_node *dn;
+	struct device *dev;
+	u32 drc_index;
+	int rc;
+
+	dev = get_cpu_device(cpu);
+	dn = dev->of_node;
+
+	rc = of_property_read_u32(dn, "ibm,my-drc-index", &drc_index);
+
+	rc = dlpar_cpu_remove_by_index(drc_index);
+	if (!rc)
+		rc = dlpar_cpu_add(drc_index);
+
+	return rc;
+}
+
 int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 {
 	u32 count, drc_index;
-- 
2.19.1



