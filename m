Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A04C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A912086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbfITVZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:25:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730149AbfITVZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 17:25:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80A1C18C4270;
        Fri, 20 Sep 2019 21:25:12 +0000 (UTC)
Received: from mail (ovpn-120-159.rdu2.redhat.com [10.10.120.159])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 239AA1001B2D;
        Fri, 20 Sep 2019 21:25:10 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/17] KVM: monolithic: x86: handle the request_immediate_exit variation
Date:   Fri, 20 Sep 2019 17:24:55 -0400
Message-Id: <20190920212509.2578-4-aarcange@redhat.com>
In-Reply-To: <20190920212509.2578-1-aarcange@redhat.com>
References: <20190920212509.2578-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Fri, 20 Sep 2019 21:25:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_immediate_exit is one of those few cases where the pointer to
function of the method isn't fixed at build time and it requires
special handling because hardware_setup() may override it at runtime.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 arch/x86/kvm/vmx/vmx_ops.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx_ops.c b/arch/x86/kvm/vmx/vmx_ops.c
index cdcad73935d9..25d441432901 100644
--- a/arch/x86/kvm/vmx/vmx_ops.c
+++ b/arch/x86/kvm/vmx/vmx_ops.c
@@ -498,7 +498,10 @@ int kvm_x86_ops_check_nested_events(struct kvm_vcpu *vcpu, bool external_intr)
 
 void kvm_x86_ops_request_immediate_exit(struct kvm_vcpu *vcpu)
 {
-	vmx_request_immediate_exit(vcpu);
+	if (likely(enable_preemption_timer))
+		vmx_request_immediate_exit(vcpu);
+	else
+		__kvm_request_immediate_exit(vcpu);
 }
 
 void kvm_x86_ops_sched_in(struct kvm_vcpu *kvm, int cpu)
