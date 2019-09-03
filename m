Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC58C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654A623697
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="macv1Uxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfICOaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:30:22 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:62499 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICOaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567521020; x=1599057020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Y3tldZVleS6/uO69vfM735Y3BEnG4rxL1Yj6ScUvmq0=;
  b=macv1UxwCGEVyvQfJR/io6n5m1vjtuHFrPWhHECa/ZdGpUPIS0QA2ctk
   T85FmjZn+0dGo4Qo4RwCIJbDz3LeyR8IA/rvBzrgMLQz3Z42kyNvEzEwr
   c5yv93W1wqcm4XmphBm6g2A7wt5j/Js+N54EGBRYMRXfPBgw/DiViqCOo
   0=;
X-IronPort-AV: E=Sophos;i="5.64,463,1559520000"; 
   d="scan'208";a="783035776"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 03 Sep 2019 14:30:18 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 25247221C0E;
        Tue,  3 Sep 2019 14:30:17 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Sep 2019 14:30:08 +0000
Received: from u79c5a0a55de558.ant.amazon.com (10.43.162.242) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Sep 2019 14:30:05 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <kvm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Sean Christopherson" <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/2] KVM: VMX: Disable posted interrupts for odd IRQs
Date:   Tue, 3 Sep 2019 16:29:53 +0200
Message-ID: <20190903142954.3429-2-graf@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142954.3429-1-graf@amazon.com>
References: <20190903142954.3429-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.242]
X-ClientProxiedBy: EX13D27UWA002.ant.amazon.com (10.43.160.30) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can easily route hardware interrupts directly into VM context when
they target the "Fixed" or "LowPriority" delivery modes.

However, on modes such as "SMI" or "Init", we need to go via KVM code
to actually put the vCPU into a different mode of operation, so we can
not post the interrupt

Add code in the VMX PI logic to explicitly refuse to establish posted
mappings for advanced IRQ deliver modes.

This fixes a bug I have with code which configures real hardware to
inject virtual SMIs into my guest.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 arch/x86/kvm/vmx/vmx.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 570a233e272b..d16c4ae8f685 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7401,6 +7401,28 @@ static int vmx_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
 			continue;
 		}
 
+		switch (irq.delivery_mode) {
+		case dest_Fixed:
+		case dest_LowestPrio:
+			break;
+		default:
+			/*
+			 * For non-trivial interrupt events, we need to go
+			 * through the full KVM IRQ code, so refuse to take
+			 * any direct PI assignments here.
+			 */
+
+			ret = irq_set_vcpu_affinity(host_irq, NULL);
+			if (ret < 0) {
+				printk(KERN_INFO
+				   "failed to back to remapped mode, irq: %u\n",
+				   host_irq);
+				goto out;
+			}
+
+			continue;
+		}
+
 		vcpu_info.pi_desc_addr = __pa(vcpu_to_pi_desc(vcpu));
 		vcpu_info.vector = irq.vector;
 
-- 
2.17.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Ralf Herbrich
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



