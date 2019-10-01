Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B7CC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 20:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F263215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 20:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfJAUuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 16:50:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:27912 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfJAUuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 16:50:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 13:50:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="197979063"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2019 13:50:24 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/apic/x2apic: Fix a NULL pointer deref when handling a dying cpu
Date:   Tue,  1 Oct 2019 13:50:19 -0700
Message-Id: <20191001205019.5789-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that the per-cpu cluster mask pointer has been set prior to
clearing a dying cpu's bit.  The per-cpu pointer is not set until the
target cpu reaches smp_callin() during CPUHP_BRINGUP_CPU, whereas the
teardown function, x2apic_dead_cpu(), is associated with the earlier
CPUHP_X2APIC_PREPARE.  If an error occurs before the cpu is awakened,
e.g. if do_boot_cpu() itself fails, x2apic_dead_cpu() will dereference
the NULL pointer and cause a panic.

  smpboot: do_boot_cpu failed(-22) to wakeup CPU#1
  BUG: kernel NULL pointer dereference, address: 0000000000000008
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 0 P4D 0
  Oops: 0002 [#1] SMP PTI
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.2.0+ #120
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:x2apic_dead_cpu+0x1a/0x30
  Code: <f0> 48 0f b3 78 08 31 c0 c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00
  RSP: 0000:ffffc9000001be58 EFLAGS: 00010286
  RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
  RDX: ffff88817bb00000 RSI: 0000000000000027 RDI: 0000000000000001
  RBP: 0000000000000027 R08: 0000000000000000 R09: 0000000000000001
  R10: 0000000000000266 R11: 0000000000000002 R12: 0000000000000000
  R13: ffffffff81038c00 R14: 00000000fffffffb R15: 0000000000000000
  FS:  0000000000000000(0000) GS:ffff88817ba00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000008 CR3: 000000000500a001 CR4: 0000000000160ef0
  Call Trace:
   cpuhp_invoke_callback+0x9a/0x580
   _cpu_up+0x10d/0x140
   do_cpu_up+0x69/0xb0
   smp_init+0x63/0xa9
   kernel_init_freeable+0xd7/0x229
   ? rest_init+0xa0/0xa0
   kernel_init+0xa/0x100
   ret_from_fork+0x35/0x40

Fixes: 023a611748fd5 ("x86/apic/x2apic: Simplify cluster management")
Cc: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---

The do_boot_cpu() -EINVAL failure is due to unrelated code that isn't in
mainline, i.e. there is no underlying bug that needs to be investigated.

 arch/x86/kernel/apic/x2apic_cluster.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 45e92cba92f5..b0889c48a2ac 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -156,7 +156,8 @@ static int x2apic_dead_cpu(unsigned int dead_cpu)
 {
 	struct cluster_mask *cmsk = per_cpu(cluster_masks, dead_cpu);
 
-	cpumask_clear_cpu(dead_cpu, &cmsk->mask);
+	if (cmsk)
+		cpumask_clear_cpu(dead_cpu, &cmsk->mask);
 	free_cpumask_var(per_cpu(ipi_mask, dead_cpu));
 	return 0;
 }
-- 
2.22.0

