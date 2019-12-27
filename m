Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FC7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 16:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4F220CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 16:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577464588;
	bh=vLaSTpW+zvXJSzqHa6YRxfz0UhXfnVZZ/YKoszrBy5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zC1jcU2yjHL2u/V1yd+nzMwZD8aNzjfui8CFlWdHhFgHDrdSyqPFl8YD7G2ViWKIZ
	 Ap9MDHLkPN8fnPt6MarZEvR5QFilaC6egU6IoHYIAq5g530f4+mETCHI+SIsdcYw42
	 OLEBjHOYXZ7xscPg2r4NRu8PcF56sXeGEiTLEEWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfL0Qg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 11:36:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfL0QgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 11:36:25 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4D2C21775;
        Fri, 27 Dec 2019 16:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577464585;
        bh=vLaSTpW+zvXJSzqHa6YRxfz0UhXfnVZZ/YKoszrBy5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LcfMwYLRuPSrv328SCJH+nZraP7qiUJzeC36eiW83W5fNVdGk9keYFqH4JwZ8kTRl
         BXdzQ3yOAQcF4jdNYHtitHUYa0TfwIs40VECTdxahz5kEReb/0TJ5hu2CyflkoqrHV
         FC8i6VNKkIrUbZF0VXX7DG95D5h24LAG1jmyKPYI=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 2/2] x86/context-tracking: Remove exception_enter/exit() from KVM_PV_REASON_PAGE_NOT_PRESENT async page fault
Date:   Fri, 27 Dec 2019 17:36:12 +0100
Message-Id: <20191227163612.10039-3-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191227163612.10039-1-frederic@kernel.org>
References: <20191227163612.10039-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a leftover. Page faults, just like most other exceptions,
are protected inside user_exit() / user_enter() calls in x86 entry code
when we fault from userspace. So this pair of calls is now useless.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kernel/kvm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 32ef1ee733b7..81045aabb6f4 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -245,17 +245,13 @@ NOKPROBE_SYMBOL(kvm_read_and_reset_pf_reason);
 dotraplinkage void
 do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
-	enum ctx_state prev_state;
-
 	switch (kvm_read_and_reset_pf_reason()) {
 	default:
 		do_page_fault(regs, error_code, address);
 		break;
 	case KVM_PV_REASON_PAGE_NOT_PRESENT:
 		/* page is swapped out by the host. */
-		prev_state = exception_enter();
 		kvm_async_pf_task_wait((u32)address, !user_mode(regs));
-		exception_exit(prev_state);
 		break;
 	case KVM_PV_REASON_PAGE_READY:
 		rcu_irq_enter();
-- 
2.23.0

