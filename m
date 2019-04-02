Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3C8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62372146E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbfDBNsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:48:17 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42964 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731241AbfDBNkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:03 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdw-0002nn-H9; Tue, 02 Apr 2019 14:40:00 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdv-0004tB-G6; Tue, 02 Apr 2019 14:39:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Marc Orr" <marcorr@google.com>,
        "Jim Mattson" <jmattson@google.com>,
        "Sean Christopherson" <sean.j.christopherson@intel.com>,
        "Liran Alon" <liran.alon@oracle.com>,
        "Peter Shier" <pshier@google.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.778562253@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 34/99] kvm: vmx: Set IA32_TSC_AUX for legacy mode guests
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>

commit 0023ef39dc35c773c436eaa46ca539a26b308b55 upstream.

RDTSCP is supported in legacy mode as well as long mode. The
IA32_TSC_AUX MSR should be set to the correct guest value before
entering any guest that supports RDTSCP.

Fixes: 4e47c7a6d714 ("KVM: VMX: Add instruction rdtscp support for guest")
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
Reviewed-by: Marc Orr <marcorr@google.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 3.16:
 - Keep testing vmx->rdtscp_enabled instead of guest_cpuid_has()
 - Adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/vmx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2077,9 +2077,6 @@ static void setup_msrs(struct vcpu_vmx *
 		index = __find_msr_index(vmx, MSR_CSTAR);
 		if (index >= 0)
 			move_msr_up(vmx, index, save_nmsrs++);
-		index = __find_msr_index(vmx, MSR_TSC_AUX);
-		if (index >= 0 && vmx->rdtscp_enabled)
-			move_msr_up(vmx, index, save_nmsrs++);
 		/*
 		 * MSR_STAR is only needed on long mode guests, and only
 		 * if efer.sce is enabled.
@@ -2092,6 +2089,9 @@ static void setup_msrs(struct vcpu_vmx *
 	index = __find_msr_index(vmx, MSR_EFER);
 	if (index >= 0 && update_transition_efer(vmx, index))
 		move_msr_up(vmx, index, save_nmsrs++);
+	index = __find_msr_index(vmx, MSR_TSC_AUX);
+	if (index >= 0 && vmx->rdtscp_enabled)
+		move_msr_up(vmx, index, save_nmsrs++);
 
 	vmx->save_nmsrs = save_nmsrs;
 

