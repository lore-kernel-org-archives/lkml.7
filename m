Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394E8C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 08:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0348721924
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 08:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfKII7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 03:59:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5753 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726136AbfKII67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 03:58:59 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BC4DF26A8A0C9978897D;
        Sat,  9 Nov 2019 16:58:56 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sat, 9 Nov 2019
 16:58:49 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <sean.j.christopherson@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <linmiaohe@huawei.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH] KVM: X86: avoid unused setup_syscalls_segments call when SYSCALL check failed
Date:   Sat, 9 Nov 2019 16:58:54 +0800
Message-ID: <1573289934-14430-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.18]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

When SYSCALL/SYSENTER ability check failed, cs and ss is inited but
remain not used. Delay initializing cs and ss until SYSCALL/SYSENTER
ability check passed.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 arch/x86/kvm/emulate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 698efb8c3897..952d1a4f4d7e 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2770,11 +2770,10 @@ static int em_syscall(struct x86_emulate_ctxt *ctxt)
 		return emulate_ud(ctxt);
 
 	ops->get_msr(ctxt, MSR_EFER, &efer);
-	setup_syscalls_segments(ctxt, &cs, &ss);
-
 	if (!(efer & EFER_SCE))
 		return emulate_ud(ctxt);
 
+	setup_syscalls_segments(ctxt, &cs, &ss);
 	ops->get_msr(ctxt, MSR_STAR, &msr_data);
 	msr_data >>= 32;
 	cs_sel = (u16)(msr_data & 0xfffc);
@@ -2838,12 +2837,11 @@ static int em_sysenter(struct x86_emulate_ctxt *ctxt)
 	if (ctxt->mode == X86EMUL_MODE_PROT64)
 		return X86EMUL_UNHANDLEABLE;
 
-	setup_syscalls_segments(ctxt, &cs, &ss);
-
 	ops->get_msr(ctxt, MSR_IA32_SYSENTER_CS, &msr_data);
 	if ((msr_data & 0xfffc) == 0x0)
 		return emulate_gp(ctxt, 0);
 
+	setup_syscalls_segments(ctxt, &cs, &ss);
 	ctxt->eflags &= ~(X86_EFLAGS_VM | X86_EFLAGS_IF);
 	cs_sel = (u16)msr_data & ~SEGMENT_RPL_MASK;
 	ss_sel = cs_sel + 8;
-- 
2.19.1

