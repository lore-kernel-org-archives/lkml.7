Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146E9C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D206420661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfCFLTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:19:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54999 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfCFLTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:19:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 28A753082E0F;
        Wed,  6 Mar 2019 11:19:11 +0000 (UTC)
Received: from kasong-laptop-rh.nay.redhat.com (unknown [10.66.128.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A4DC60E3D;
        Wed,  6 Mar 2019 11:19:04 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Young <dyoung@redhat.com>, x86@kernel.org,
        devel@linuxdriverproject.org, Kairui Song <kasong@redhat.com>
Subject: [PATCH v3] x86, hyperv: fix kernel panic when kexec on HyperV
Date:   Wed,  6 Mar 2019 19:18:27 +0800
Message-Id: <20190306111827.14131-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 06 Mar 2019 11:19:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments"),
kexec will fail with a kernel panic like this:

kexec_core: Starting new kernel
BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
PGD 8000000057995067 P4D 8000000057995067 PUD 57990067 PMD 0
Oops: 0002 [#1] SMP PTI
CPU: 0 PID: 1016 Comm: kexec Not tainted 4.18.16-300.fc29.x86_64 #1
Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v3.0 03/02/2018
RIP: 0010:0xffffc9000001d000
Code: Bad RIP value.
RSP: 0018:ffffc9000495bcf0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffc9000001d000 RCX: 0000000000020015
RDX: 000000007f553000 RSI: 0000000000000000 RDI: ffffc9000495bd28
RBP: 0000000000000002 R08: 0000000000000000 R09: ffffffff8238aaf8
R10: ffffffff8238aae0 R11: 0000000000000000 R12: ffff88007f553008
R13: 0000000000000001 R14: ffff8800ff553000 R15: 0000000000000000
FS:  00007ff5c0e67b80(0000) GS:ffff880078e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000001cfd6 CR3: 000000004f678006 CR4: 00000000003606f0
Call Trace:
 ? __send_ipi_mask+0x1c6/0x2d0
 ? hv_send_ipi_mask_allbutself+0x6d/0xb0
 ? mp_save_irq+0x70/0x70
 ? __ioapic_read_entry+0x32/0x50
 ? ioapic_read_entry+0x39/0x50
 ? clear_IO_APIC_pin+0xb8/0x110
 ? native_stop_other_cpus+0x6e/0x170
 ? native_machine_shutdown+0x22/0x40
 ? kernel_kexec+0x136/0x156
 ? __do_sys_reboot+0x1be/0x210
 ? kmem_cache_free+0x1b1/0x1e0
 ? __dentry_kill+0x10b/0x160
 ? _cond_resched+0x15/0x30
 ? dentry_kill+0x47/0x170
 ? dput.part.34+0xc6/0x100
 ? __fput+0x147/0x220
 ? _cond_resched+0x15/0x30
 ? task_work_run+0x38/0xa0
 ? do_syscall_64+0x5b/0x160
 ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
Modules linked in: ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_nat ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables sunrpc vfat fat crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_rapl_perf hv_balloon joydev xfs libcrc32c hv_storvsc serio_raw scsi_transport_fc hv_netvsc hyperv_keyboard hyperv_fb hid_hyperv crc32c_intel hv_vmbus

That's because now we may use hypercall for sending IPI, the
hypercall page will be reset very early upon kexec reboot, but kexec
will need to send IPI for stopping CPUs, and it will reference this
no longer usable page, then kernel panics.

To fix it, simply reset hv_hypercall_pg to NULL before the page is
reset to avoid any misuse, IPI sending will fallback to use non
hypercall based method. This only happens on kexec / kdump so setting to
NULL should be good enough.

Fixes: 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")
Signed-off-by: Kairui Song <kasong@redhat.com>

---

Update from V2:
- The memory barrier is not needed, remove it.

Update from V1:
- Add comment for the wmb call.

 arch/x86/hyperv/hv_init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 7abb09e2eeb8..d3f42b6bbdac 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -406,6 +406,13 @@ void hyperv_cleanup(void)
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 
+	/*
+	 * Reset hypercall page reference before reset the page,
+	 * let hypercall operations fail safely rather than
+	 * panic the kernel for using invalid hypercall page
+	 */
+	hv_hypercall_pg = NULL;
+
 	/* Reset the hypercall page */
 	hypercall_msr.as_uint64 = 0;
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
-- 
2.20.1

