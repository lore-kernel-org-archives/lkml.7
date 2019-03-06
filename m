Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C9CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B177A20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfCFWem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:34:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51011 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfCFWem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:34:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x26MYT1a1911782
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 6 Mar 2019 14:34:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x26MYSPg1911778;
        Wed, 6 Mar 2019 14:34:28 -0800
Date:   Wed, 6 Mar 2019 14:34:28 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kairui Song <tipbot@zytor.com>
Message-ID: <tip-179fb36abb097976997f50733d5b122a29158cba@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, vkuznets@redhat.com,
        bp@alien8.de, linux-kernel@vger.kernel.org, dyoung@redhat.com,
        kys@microsoft.com, haiyangz@microsoft.com, kasong@redhat.com,
        sthemmin@microsoft.com, sashal@kernel.org, hpa@zytor.com
Reply-To: dyoung@redhat.com, kys@microsoft.com, sthemmin@microsoft.com,
          sashal@kernel.org, hpa@zytor.com, haiyangz@microsoft.com,
          tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
          vkuznets@redhat.com, linux-kernel@vger.kernel.org,
          kasong@redhat.com
In-Reply-To: <20190306111827.14131-1-kasong@redhat.com>
References: <20190306111827.14131-1-kasong@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/hyperv: Fix kernel panic when kexec on HyperV
Git-Commit-ID: 179fb36abb097976997f50733d5b122a29158cba
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  179fb36abb097976997f50733d5b122a29158cba
Gitweb:     https://git.kernel.org/tip/179fb36abb097976997f50733d5b122a29158cba
Author:     Kairui Song <kasong@redhat.com>
AuthorDate: Wed, 6 Mar 2019 19:18:27 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Mar 2019 23:27:44 +0100

x86/hyperv: Fix kernel panic when kexec on HyperV

After commit 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments"),
kexec fails with a kernel panic:

kexec_core: Starting new kernel
BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v3.0 03/02/2018
RIP: 0010:0xffffc9000001d000

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

That happens if hypercall based IPIs are used because the hypercall page is
reset very early upon kexec reboot, but kexec sends IPIs to stop CPUs,
which invokes the hypercall and dereferences the unusable page.

To fix his, reset hv_hypercall_pg to NULL before the page is reset to avoid
any misuse, IPI sending will fall back to the non hypercall based
method. This only happens on kexec / kdump so just setting the pointer to
NULL is good enough.

Fixes: 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")
Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: devel@linuxdriverproject.org
Link: https://lkml.kernel.org/r/20190306111827.14131-1-kasong@redhat.com
---
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
