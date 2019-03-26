Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8300C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E8920830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553601743;
	bh=lN9HXpztWmVzrb6B9KmwzfZqFzm1rWoHvbwmpdpMwKA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CZQ7SG34q57Ljc0O8zEfknvKZhrCp8iQPhDK5/ppB4zqmI8oXO2yO8ZbxqHV2ErdQ
	 5R20dtH7FWAwoBspeOieUNxszlnLg3E32xBqmJsRQN+/5km4bG6iwtb98LGpU2k2N+
	 Osv78wuPQ7nXEItUBFgpiuocvx8FwcuxRQOJDQNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfCZMCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfCZMCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:02:21 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CC352075C;
        Tue, 26 Mar 2019 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553601741;
        bh=lN9HXpztWmVzrb6B9KmwzfZqFzm1rWoHvbwmpdpMwKA=;
        h=From:To:Cc:Subject:Date:From;
        b=GFVINhQhh+Wok76Jtm8an9BwMwydfOcHpzfqD7sq1heO+hWV0AJfQVGDG+awbST0+
         XPJVbmibTRO6ctw4c+pisulPRYQFLgurRCJ+sL+//iHmq89rAgNlu9Wi651gyUIUjq
         uGn7rLel2FZz/XGmGwMGEItl3Ld9+Fjrdgq1dzw0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] x86/apic: Reduce print level of CPU limit announcement
Date:   Tue, 26 Mar 2019 14:02:13 +0200
Message-Id: <20190326120213.28633-1-leon@kernel.org>
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

Simple conversion of those prints to be in debug level removes them
while leaving the option to debug system.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 arch/x86/kernel/acpi/boot.c | 2 +-
 arch/x86/kernel/apic/apic.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 8dcbf6890714..3ef8ab89c02d 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -770,7 +770,7 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,

 	cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
 	if (cpu < 0) {
-		pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
+		pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
 		return cpu;
 	}

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

