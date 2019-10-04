Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF26C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3167222CA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390132AbfJDPwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:52:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:60432 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390089AbfJDPwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:52:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA9D7B1AE;
        Fri,  4 Oct 2019 15:52:42 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     wahrenst@gmx.net, f.fainelli@gmail.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "kernelci.org bot" <bot@kernelci.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] ARM: dt: check MPIDR on MP devices built without SMP
Date:   Fri,  4 Oct 2019 17:52:33 +0200
Message-Id: <20191004155232.17209-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SMP builds, in order to properly link CPU devices with their
respective DT nodes we start by matching the boot CPU. This is achieved
by comparing the 'reg' property on each of the CPU DT nodes with the
MPIDR. The association is necessary as to validate the whole CPU logical
map, which ultimately links CPU devices and their DT nodes.

On setups built without SMP, no MPIDR read is performed. The only thing
expected is for the 'reg' property in the CPU DT node to contain the
value 0x0.

This causes problems on MP setups built without SMP. As their boot CPU
DT node contains the relevant MPIDR as opposed to 0x0. No match is then
possible. This causes troubles further down the line as drivers are
unable to get the CPU's DT node.

Change the way we choose whether to get the MPIDR or not. On builds
without SMP check the number of CPUs defined in DT. Anything > 1 means
the MPIDR should be available and matched accordingly.

Note that if there was a rogue UP device exposing multiple active CPUs
in its DT the possible outcomes depend on the ARM series. For example
Cortex-A9 specifies that the MPIDR is returns 0x0 on UP devices. On the
other hand ARM1176JZ's TRM doesn't define a MPIDR register and specifies
that any unwarranted register access will raise an undefined exception.
Overall, given the bogus DT, a reasonable outcome.

This was originally seen on a Raspberry Pi 2 built with bcm2835_defconfig.

Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Stefan Wahren <wahrenst@gmx.net>

---

Changes since v1:
  - Rewrite patch description
  - Use of_get_available_child_count()

Note: kept Setfan's Tested-by as the changes only affect a corner case.

 arch/arm/kernel/devtree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 39c978698406..cd11742d9bc2 100644
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
 
+	if (is_smp() || of_get_available_child_count(cpus) > 1)
+		mpidr = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
+
 	for_each_of_cpu_node(cpu) {
 		const __be32 *cell;
 		int prop_bytes;
-- 
2.23.0

