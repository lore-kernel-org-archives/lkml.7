Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2D3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8945C21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfCTRnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:43:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfCTRnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:43:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D33C930B24DE;
        Wed, 20 Mar 2019 17:43:23 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 89E875C22F;
        Wed, 20 Mar 2019 17:43:22 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: kvm: hyper-v: deal with buggy TLB flush requests from WS2012
Date:   Wed, 20 Mar 2019 18:43:20 +0100
Message-Id: <20190320174320.9459-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 20 Mar 2019 17:43:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that with some special Multi Processor Group configuration,
e.g:
 bcdedit.exe /set groupsize 1
 bcdedit.exe /set maxgroup on
 bcdedit.exe /set groupaware on
for a 16-vCPU guest WS2012 shows BSOD on boot when PV TLB flush mechanism
is in use.

Tracing kvm_hv_flush_tlb immediately reveals the issue:

 kvm_hv_flush_tlb: processor_mask 0x0 address_space 0x0 flags 0x2

The only flag set in this request is HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES,
however, processor_mask is 0x0 and no HV_FLUSH_ALL_PROCESSORS is specified.
We don't flush anything and apparently it's not what Windows expects.

TLFS doesn't say anything about such requests and newer Windows versions
seem to be unaffected. This all feels like a WS2012 bug, which is, however,
easy to workaround in KVM: let's flush everything when we see an empty
flush request, over-flushing doesn't hurt.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 421899f6ad7b..5887f7d22ac6 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1371,7 +1371,17 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 
 		valid_bank_mask = BIT_ULL(0);
 		sparse_banks[0] = flush.processor_mask;
-		all_cpus = flush.flags & HV_FLUSH_ALL_PROCESSORS;
+
+		/*
+		 * WS2012 seems to be buggy, under certain conditions it is
+		 * possible to observe requests with processor_mask = 0x0 and
+		 * no HV_FLUSH_ALL_PROCESSORS flag set. It also seems that
+		 * Windows actually expects us to flush something and crashes
+		 * otherwise. Let's treat processor_mask == 0 same as
+		 * HV_FLUSH_ALL_PROCESSORS.
+		 */
+		all_cpus = (flush.flags & HV_FLUSH_ALL_PROCESSORS) ||
+			(flush.processor_mask == 0);
 	} else {
 		if (unlikely(kvm_read_guest(kvm, ingpa, &flush_ex,
 					    sizeof(flush_ex))))
-- 
2.20.1

