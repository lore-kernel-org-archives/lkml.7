Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943BFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2372082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553677752;
	bh=mwmTBe11TAHGITkfDXH8v01IOyj6L5ru/mBWXbqn3TU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nYq67JXw+Cg83rtoHsow1sIhEzAPASTlQFkjB2Ct1izcxOWLoCQdYDd/dkd90ULhL
	 E9UMFiPUt/hOpRpkJmJhDga730e3oh1ph3YD1o9hnVtokuGssS6Ygu0gZT4lZyCNHY
	 6UEyYP4wjL4sIWvyQ/FI6gjr6JqxkXrk+Mm04s+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbfC0JJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfC0JJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:09:11 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 721A12075D;
        Wed, 27 Mar 2019 09:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553677750;
        bh=mwmTBe11TAHGITkfDXH8v01IOyj6L5ru/mBWXbqn3TU=;
        h=From:To:Cc:Subject:Date:From;
        b=yCK1Hfv/dX16A3xwY3Ier1Be6vjMf4bqX8vpoCOVFJBGTFlP/8AbYBud9eiKSCl0M
         IqqEEAKGuSKVKU8YD3TKoi63cvbUN5OBA/G3I3TsW2nCQEzCKh+Cqhz4s0QndIXwBe
         9jXxiRdemliTmdWef3nsrNv95BdoFiEGJC+VRsSc=
From:   Leon Romanovsky <leon@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v1] x86/apic: Reduce print level of CPU limit announcement
Date:   Wed, 27 Mar 2019 11:09:05 +0200
Message-Id: <20190327090905.5588-1-leon@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Kernel is booted with less possible CPUs (possible_cpus kernel boot
option) than available CPUs will have prints like this:

[    1.131039] APIC: NR_CPUS/possible_cpus limit of 8 reached. Processor 55/0x1f ignored.
[    1.132228] ACPI: Unable to map lapic to logical cpu number

Those warnings are printed for every not-enabled CPU and on the systems
with large number of such CPUs, we see a lot of those prints for default
print level.

Simple conversion of first line to be in debug level and removal of second line
which is redundant, will remove them while leaving the option to debug system.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
Changelog v0->v1:
 * Completely removed print from boot.c and updated commit message accordingly.
---
 arch/x86/kernel/acpi/boot.c | 4 +---
 arch/x86/kernel/apic/apic.c | 6 +++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 8dcbf6890714..baac0a40bc44 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -769,10 +769,8 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
 	int cpu;

 	cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
-	if (cpu < 0) {
-		pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
+	if (cpu < 0)
 		return cpu;
-	}

 	acpi_processor_set_pdc(handle);
 	acpi_map_cpu2node(handle, cpu, physid);
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b7bcdd781651..8c2a487b5216 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2305,9 +2305,9 @@ int generic_processor_info(int apicid, int version)
 	if (num_processors >= nr_cpu_ids) {
 		int thiscpu = max + disabled_cpus;

-		pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
-			   "reached. Processor %d/0x%x ignored.\n",
-			   max, thiscpu, apicid);
+		pr_debug(
+			"APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
+			max, thiscpu, apicid);

 		disabled_cpus++;
 		return -EINVAL;
--
2.20.1

