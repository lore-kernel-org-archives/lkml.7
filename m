Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCE7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A424205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370396;
	bh=6gw6qgPHhXt0ws2scJsuKUXROJKfce9yWzfLzmMwex8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ISDEzwa7f1ijJDoOFtB5KpQR2DfKpM791l4W8vwB5zMSWxo8FH+jPu78g/P6wQJjk
	 aJyx+8X8neJm/ckuJU+N+1pKPfk3JnfeCaPEaKh7qS8HyuJ3EjrkUxbUWB6J/0A/Qw
	 M7OJilgl87yejP0wGo0y6Q5Xn6WWGpD8VEQaV/Zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbfDDJdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732016AbfDDJIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:08:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FEF2218FE;
        Thu,  4 Apr 2019 09:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368903;
        bh=6gw6qgPHhXt0ws2scJsuKUXROJKfce9yWzfLzmMwex8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4jcjURGbv5KFrrKNomSBSj+VReOEGJBk6sGpfoUKuD4QzdB6uWD70iWtbTM3Eo+X
         Tf4724B7FgCtRCi65+52zMAdhqW3sqSv0JUrK5zBm3so/G+2USf82QTtKe7kgdjBpt
         zQKb1r7cHfnkfaSVDptlEWViH49tQ/pb+gwukLBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kairui Song <kasong@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Young <dyoung@redhat.com>, devel@linuxdriverproject.org
Subject: [PATCH 5.0 024/246] x86/hyperv: Fix kernel panic when kexec on HyperV
Date:   Thu,  4 Apr 2019 10:45:24 +0200
Message-Id: <20190404084619.972481659@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 179fb36abb097976997f50733d5b122a29158cba ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
-- 
2.19.1



