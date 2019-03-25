Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64494C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC3F20879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfCYP5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:57:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfCYP5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:57:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80DA3356CE;
        Mon, 25 Mar 2019 15:57:29 +0000 (UTC)
Received: from llong.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC89D62997;
        Mon, 25 Mar 2019 15:57:22 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Juergen Gross <jgross@suse.com>,
        Alok Kataria <akataria@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] x86/paravirt: Guard against invalid cpu # in pv_vcpu_is_preempted()
Date:   Mon, 25 Mar 2019 11:57:06 -0400
Message-Id: <20190325155706.26987-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 25 Mar 2019 15:57:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that passing an invalid cpu number to pv_vcpu_is_preempted()
might panic the kernel in a VM guest. For example,

[    2.531077] Oops: 0000 [#1] SMP PTI
  :
[    2.532545] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[    2.533321] RIP: 0010:__raw_callee_save___kvm_vcpu_is_preempted+0x0/0x20

To guard against this kind of kernel panic, check is added to
pv_vcpu_is_preempted() to make sure that no invalid cpu number will
be used.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/include/asm/paravirt.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index c25c38a05c1c..4cfb465dcde4 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -671,6 +671,12 @@ static __always_inline void pv_kick(int cpu)
 
 static __always_inline bool pv_vcpu_is_preempted(long cpu)
 {
+	/*
+	 * Guard against invalid cpu number or the kernel might panic.
+	 */
+	if (WARN_ON_ONCE((unsigned long)cpu >= nr_cpu_ids))
+		return false;
+
 	return PVOP_CALLEE1(bool, lock.vcpu_is_preempted, cpu);
 }
 
-- 
2.18.1

