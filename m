Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F389C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81D62086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394015AbfITV0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:26:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392265AbfITVZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 17:25:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A1707F743;
        Fri, 20 Sep 2019 21:25:13 +0000 (UTC)
Received: from mail (ovpn-120-159.rdu2.redhat.com [10.10.120.159])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49FD210013D9;
        Fri, 20 Sep 2019 21:25:13 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] KVM: monolithic: x86: inline more exit handlers in vmx.c
Date:   Fri, 20 Sep 2019 17:25:06 -0400
Message-Id: <20190920212509.2578-15-aarcange@redhat.com>
In-Reply-To: <20190920212509.2578-1-aarcange@redhat.com>
References: <20190920212509.2578-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Fri, 20 Sep 2019 21:25:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They can be called directly more efficiently, so we can as well mark
some of them inline in case gcc doesn't decide to inline them.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ff46008dc514..a6e597025011 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4588,7 +4588,7 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static int handle_external_interrupt(struct kvm_vcpu *vcpu)
+static __always_inline int handle_external_interrupt(struct kvm_vcpu *vcpu)
 {
 	++vcpu->stat.irq_exits;
 	return 1;
@@ -4860,7 +4860,7 @@ static void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
 	vmcs_writel(GUEST_DR7, val);
 }
 
-static int handle_cpuid(struct kvm_vcpu *vcpu)
+static __always_inline int handle_cpuid(struct kvm_vcpu *vcpu)
 {
 	return kvm_emulate_cpuid(vcpu);
 }
@@ -4891,7 +4891,7 @@ static int handle_interrupt_window(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static int handle_halt(struct kvm_vcpu *vcpu)
+static __always_inline int handle_halt(struct kvm_vcpu *vcpu)
 {
 	return kvm_emulate_halt(vcpu);
 }
