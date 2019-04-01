Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF92C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648522086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="J7CZLbqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfDASnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:43:32 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:57398 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbfDASnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:43:32 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id C09B424E28DF;
        Mon,  1 Apr 2019 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1554144211; bh=/Sb7ii47xyMFrm/jOGOPlK+eRZjqEj1UcszpvGYSL8I=;
        h=From:To:Cc:Subject:Date:From;
        b=J7CZLbqCx4x40b0IM111kgO1xvCa3+eNV0vw9VEw4Mm4R+gH9uOj9ZyDyY8r297Si
         ZETjNFWMPNAvY89KyNw2HgiyxZe5wOUxqGE5WPnQMoF/AlmPKdIRMp6LVt7HNJqen8
         WqTsrKDOGZNLEiIvwJxQ0ZUrYnFCdRYIdlk4NPUgZJQ576UUeGaUpUPOSG+2Q7CR7Q
         +zPcx3ksdIieGe1Buv6zy7ReGn8pcAtQe/N0qbE/c/hou4YVTz1tbyqoEd36nwGeoE
         AVGOGd1KIefSdMD+mY+g5/zCgynBfA0EE/1ZEjUvd/4M1tT4l5oQmNrCalqE/et1yy
         NVRV4jJP/uKXA==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.106])
        by mailhost.synopsys.com (Postfix) with ESMTP id C4D20A005A;
        Mon,  1 Apr 2019 18:43:29 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH] ARC: fix memory nodes topology in case of highmem enabled
Date:   Mon,  1 Apr 2019 21:42:42 +0300
Message-Id: <20190401184242.7636-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tweak generic node topology in case of CONFIG_HIGHMEM enabled to
prioritize allocations from ZONE_HIGHMEM to avoid ZONE_NORMAL
pressure.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Tested on both NSIM and HSDK (require memory apertures remmaping and
device tree patching)

 arch/arc/include/asm/Kbuild     |  1 -
 arch/arc/include/asm/topology.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 arch/arc/include/asm/topology.h

diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index caa270261521..e64e0439baff 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -18,7 +18,6 @@ generic-y += msi.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
-generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += user.h
 generic-y += vga.h
diff --git a/arch/arc/include/asm/topology.h b/arch/arc/include/asm/topology.h
new file mode 100644
index 000000000000..c273506931c9
--- /dev/null
+++ b/arch/arc/include/asm/topology.h
@@ -0,0 +1,30 @@
+#ifndef _ASM_ARC_TOPOLOGY_H
+#define _ASM_ARC_TOPOLOGY_H
+
+/*
+ * On ARC (w/o PAE) HIGHMEM addresses are smaller (0x0 based) than addresses in
+ * NORMAL aka low memory (0x8000_0000 based).
+ * Thus HIGHMEM on ARC is imlemented with DISCONTIGMEM which requires multiple
+ * nodes. So here is memory node map depending on the CONFIG_HIGHMEM
+ * enabled/disabled:
+ *
+ * CONFIG_HIGHMEM disabled:
+ *  - node 0: ZONE_NORMAL memory only.
+ *
+ * CONFIG_HIGHMEM enabled:
+ *  - node 0: ZONE_NORMAL memory only.
+ *  - node 1: ZONE_HIGHMEM memory only.
+ *
+ * In case of CONFIG_HIGHMEM enabled we tweak generic node topology and mark
+ * node 1 as the closest to all CPUs to prioritize allocations from ZONE_HIGHMEM
+ * where it is possible to avoid ZONE_NORMAL pressure.
+ */
+#ifdef CONFIG_HIGHMEM
+#define cpu_to_node(cpu)	((void)(cpu), 1)
+#define cpu_to_mem(cpu)		((void)(cpu), 1)
+#define cpumask_of_node(node)	((node) == 1 ? cpu_online_mask : cpu_none_mask)
+#endif /* CONFIG_HIGHMEM */
+
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_ARC_TOPOLOGY_H */
-- 
2.14.5

