Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFEEC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E5F21929
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfJBLpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 07:45:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:37090 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfJBLpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 07:45:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 840E4AF37;
        Wed,  2 Oct 2019 11:45:14 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     wahrenst@gmx.net, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "kernelci.org bot" <bot@kernelci.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dt: check MPIDR on MP devices built without SMP
Date:   Wed,  2 Oct 2019 13:45:08 +0200
Message-Id: <20191002114508.1089-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, in arm_dt_init_cpu_maps(), the hwid of the boot CPU is read
from MPIDR on SMP devices and set to 0 for non SMP. This value is then
matched with the DT cpu nodes' reg property in order to find the boot
CPU in DT.

On MP devices build without SMP the cpu DT node contains the expected
MPIDR yet the hwid is set to 0. With this the function fails to match
the cpus and uses the default CPU logical map. Making it impossible to
get the CPU's DT node further down the line. This causes issues with
cpufreq-dt, as it triggers warnings when not finding a suitable DT node
on CPU0.

Change the way we choose whether to get MPIDR or not. Instead of
depending on SMP check the number of CPUs defined in DT. Anything > 1
means MPIDR will be available.

This was seen on a Raspberry Pi 2 build with bcm2835_defconfig.

Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/kernel/devtree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 39c978698406..a924fda9abc8 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -74,7 +74,7 @@ void __init arm_dt_init_cpu_maps(void)
 	struct device_node *cpu, *cpus;
 	int found_method = 0;
 	u32 i, j, cpuidx = 1;
-	u32 mpidr = is_smp() ? read_cpuid_mpidr() & MPIDR_HWID_BITMASK : 0;
+	u32 mpidr = 0;
 
 	u32 tmp_map[NR_CPUS] = { [0 ... NR_CPUS-1] = MPIDR_INVALID };
 	bool bootcpu_valid = false;
@@ -83,6 +83,9 @@ void __init arm_dt_init_cpu_maps(void)
 	if (!cpus)
 		return;
 
+	if (is_smp() || of_get_child_count(cpus) > 1)
+		mpidr = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
+
 	for_each_of_cpu_node(cpu) {
 		const __be32 *cell;
 		int prop_bytes;
-- 
2.23.0

