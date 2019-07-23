Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB2DC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77102218BE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eHzX/yue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390075AbfGWNHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:07:04 -0400
Received: from m12-16.163.com ([220.181.12.16]:37350 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728323AbfGWNHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=9lG6yT47F7RErrfkXD
        KOGZz0ZbIUfiaqrIASWyZ+lwE=; b=eHzX/yue41CF6cafpBHGIFp2fMUg1G3Wnv
        qK8d77YvZUJzgmDN3xYq1/DLQSr8RYHJMffwhnKZYe3QMH+DOivxPdB0VrjGSbLD
        xKSwrTXqcSUvXrz2rr5H9Rz9CHpmhNdeQEfh228TIhcAV/3oGp68q/trmBnxhaJb
        odUWH3cCc=
Received: from e69c04485.et15sqa.tbsite.net (unknown [106.11.237.219])
        by smtp12 (Coremail) with SMTP id EMCowABXyPFHBjdd7_GoCQ--.30018S2;
        Tue, 23 Jul 2019 21:06:19 +0800 (CST)
From:   luferry@163.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        luferry <luferry@163.com>
Subject: [PATCH] KVM: x86: init x2apic_enabled() once
Date:   Tue, 23 Jul 2019 21:06:08 +0800
Message-Id: <20190723130608.26528-1-luferry@163.com>
X-Mailer: git-send-email 2.14.1.40.g8e62ba1
X-CM-TRANSID: EMCowABXyPFHBjdd7_GoCQ--.30018S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryxKFW3AF4ruF48XF1kKrg_yoW8AFW7pr
        9FgwsYqr4DGr9Ig39rArW8uw13uan3KFWxCr4DWa1avw1YqFy3JFs3KryjyF18XFZYva13
        JF4jg3WDJw45JwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UmD7fUUUUU=
X-Originating-IP: [106.11.237.219]
X-CM-SenderInfo: poxiv2lu16il2tof0z/xtbBZgv6WlaD2sFWlgAAsD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luferry <luferry@163.com>

x2apic_eanbled() costs about 200 cycles
when guest trigger halt pretty high, pi ops in hotpath

Signed-off-by: luferry <luferry@163.com>
---
 arch/x86/kvm/vmx/vmx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d98eac371c0a..e17dbf011e47 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -186,6 +186,8 @@ static DEFINE_STATIC_KEY_FALSE(vmx_l1d_should_flush);
 static DEFINE_STATIC_KEY_FALSE(vmx_l1d_flush_cond);
 static DEFINE_MUTEX(vmx_l1d_flush_mutex);
 
+static int __read_mostly host_x2apic_enabled;
+
 /* Storage for pre module init parameter parsing */
 static enum vmx_l1d_flush_state __read_mostly vmentry_l1d_flush_param = VMENTER_L1D_FLUSH_AUTO;
 
@@ -1204,7 +1206,7 @@ static void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 
 		dest = cpu_physical_id(cpu);
 
-		if (x2apic_enabled())
+		if (host_x2apic_enabled)
 			new.ndst = dest;
 		else
 			new.ndst = (dest << 8) & 0xFF00;
@@ -7151,7 +7153,7 @@ static void __pi_post_block(struct kvm_vcpu *vcpu)
 
 		dest = cpu_physical_id(vcpu->cpu);
 
-		if (x2apic_enabled())
+		if (host_x2apic_enabled)
 			new.ndst = dest;
 		else
 			new.ndst = (dest << 8) & 0xFF00;
@@ -7221,7 +7223,7 @@ static int pi_pre_block(struct kvm_vcpu *vcpu)
 		 */
 		dest = cpu_physical_id(vcpu->pre_pcpu);
 
-		if (x2apic_enabled())
+		if (host_x2apic_enabled)
 			new.ndst = dest;
 		else
 			new.ndst = (dest << 8) & 0xFF00;
@@ -7804,6 +7806,8 @@ static int __init vmx_init(void)
 	}
 #endif
 
+	host_x2apic_enabled = x2apic_enabled();
+
 	r = kvm_init(&vmx_x86_ops, sizeof(struct vcpu_vmx),
 		     __alignof__(struct vcpu_vmx), THIS_MODULE);
 	if (r)
-- 
2.14.1.40.g8e62ba1


