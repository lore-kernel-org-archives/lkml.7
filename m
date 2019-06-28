Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6AAC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDA12147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfF1LQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 07:16:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7671 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbfF1LQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:16:02 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0E03344E5B2ADD913F67;
        Fri, 28 Jun 2019 19:16:01 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 28 Jun 2019 19:15:51 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH RFC 3/3] arm64: Add CPU hotplug support
Date:   Fri, 28 Jun 2019 19:13:12 +0800
Message-ID: <1561720392-45907-4-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1561720392-45907-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1561720392-45907-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support CPU hotplug, we need to implement 'acpi_(un)map_cpu()' and
'arch_(un)register_cpu()' for ARM64. These functions are called in
'acpi_processor_hotadd_init()/acpi_processor_remove()' when the CPU is hot
added into or hot removed from the system.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 arch/arm64/kernel/acpi.c  | 22 ++++++++++++++++++++++
 arch/arm64/kernel/setup.c | 17 +++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index ed46dc1..0e7b4f5 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -28,6 +28,7 @@
 #include <linux/smp.h>
 #include <linux/serial_core.h>
 
+#include <acpi/processor.h>
 #include <asm/cputype.h>
 #include <asm/cpu_ops.h>
 #include <asm/pgtable.h>
@@ -257,3 +258,24 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
 		return __pgprot(PROT_NORMAL_NC);
 	return __pgprot(PROT_DEVICE_nGnRnE);
 }
+
+int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
+		 int *pcpu)
+{
+	int cpu;
+
+	cpu = acpi_map_cpuid(physid, acpi_id);
+	*pcpu = cpu;
+	set_cpu_present(cpu, true);
+
+	return 0;
+}
+EXPORT_SYMBOL(acpi_map_cpu);
+
+int acpi_unmap_cpu(int cpu)
+{
+	set_cpu_present(cpu, false);
+
+	return 0;
+}
+EXPORT_SYMBOL(acpi_unmap_cpu);
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index a82d0c2..7b1a675 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -429,3 +429,20 @@ static int __init register_kernel_offset_dumper(void)
 	return 0;
 }
 __initcall(register_kernel_offset_dumper);
+
+int arch_register_cpu(int num)
+{
+	struct cpu *cpu = &per_cpu(cpu_data.cpu, num);
+
+	cpu->hotpluggable = 1;
+	return register_cpu(cpu, num);
+}
+EXPORT_SYMBOL(arch_register_cpu);
+
+void arch_unregister_cpu(int num)
+{
+	struct cpu *cpu = &per_cpu(cpu_data.cpu, num);
+
+	unregister_cpu(cpu);
+}
+EXPORT_SYMBOL(arch_unregister_cpu);
-- 
1.7.12.4

