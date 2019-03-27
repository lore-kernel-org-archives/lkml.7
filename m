Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0182EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C1A205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712480;
	bh=dvm1MwDIl90JCc5ujvjlWeJc7ji6CHHNqQ44o9pKmGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VjEq1aRs8XTlY2qejDCt9s7GXBKByWZ6HteMU+cBJmPwlxU0lldPgX0HZfIZh15cY
	 H5Ijfvr6wTnZAsknQHmobzrflDtmk0Del0rTBWfn0chQIGQcImtl8kDQLXFm7dVsig
	 pje7nUB+Cr8/R0kQhbJUSY5nZ2HQf4EpbaoiDvPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391055AbfC0Sr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389947AbfC0STo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:19:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BEBB2070B;
        Wed, 27 Mar 2019 18:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710783;
        bh=dvm1MwDIl90JCc5ujvjlWeJc7ji6CHHNqQ44o9pKmGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XLOPPKhVMH28FRsZZyJrwBf0qlaKnZGqf3rmoyum/oQGsE/UcslllKW3YC9J0EN/k
         VKsiMWhzcazeY1uK/YGWuvbLbBkbo20UtRl2WvOz1DNHYkNWQRitNMezV94FwHFvJ2
         v10NY7gd5CC7kF1nksWBW7xihqtW/UEmJYL9Gicc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        "Michael W . Bringmann" <mwb@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 098/123] powerpc/pseries: Perform full re-add of CPU for topology update post-migration
Date:   Wed, 27 Mar 2019 14:16:02 -0400
Message-Id: <20190327181628.15899-98-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Fontenot <nfont@linux.vnet.ibm.com>

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
index 66c72b356ac0..e6b185b4b3b1 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -117,6 +117,8 @@ static inline int prrn_is_enabled(void)
 #define topology_sibling_cpumask(cpu)	(per_cpu(cpu_sibling_map, cpu))
 #define topology_core_cpumask(cpu)	(per_cpu(cpu_core_map, cpu))
 #define topology_core_id(cpu)		(cpu_to_core_id(cpu))
+
+int dlpar_cpu_readd(int cpu);
 #endif
 #endif
 
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 40fb9a8835fe..0a02c73a27b3 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1527,13 +1527,6 @@ static void reset_topology_timer(void)
 
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
@@ -1546,7 +1539,7 @@ static int dt_update_callback(struct notifier_block *nb,
 		    !of_prop_cmp(update->prop->name, "ibm,associativity")) {
 			u32 core_id;
 			of_property_read_u32(update->dn, "reg", &core_id);
-			stage_topology_update(core_id);
+			rc = dlpar_cpu_readd(core_id);
 			rc = NOTIFY_OK;
 		}
 		break;
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index b1ac8ac38434..0baaaa6b0929 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -799,6 +799,25 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
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

