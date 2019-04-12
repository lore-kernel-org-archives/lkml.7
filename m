Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B400C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713252083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfDLDVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:21:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52612 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfDLDVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 23:21:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D043215AD;
        Thu, 11 Apr 2019 20:21:10 -0700 (PDT)
Received: from a075553-lin.blr.arm.com (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 91E183F59C;
        Thu, 11 Apr 2019 20:21:06 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v9 4/5] KVM: arm64: Add capability to advertise ptrauth for guest
Date:   Fri, 12 Apr 2019 08:50:35 +0530
Message-Id: <1555039236-10608-5-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555039236-10608-1-git-send-email-amit.kachhap@arm.com>
References: <1555039236-10608-1-git-send-email-amit.kachhap@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch advertises the capability of two cpu feature called address
pointer authentication and generic pointer authentication. These
capabilities depend upon system support for pointer authentication and
VHE mode.

The current arm64 KVM partially implements pointer authentication and
support of address/generic authentication are tied together. However,
separate ABI requirements for both of them is added so that any future
isolated implementation will not require any ABI changes.

Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
---
Changes since v8:
*  Keep the capability check same for the 2 vcpu ptrauth features. [Dave Martin]

 Documentation/virtual/kvm/api.txt | 2 ++
 arch/arm64/kvm/reset.c            | 5 +++++
 include/uapi/linux/kvm.h          | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 9d202f4..56021d0 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2756,9 +2756,11 @@ Possible features:
 	- KVM_ARM_VCPU_PTRAUTH_ADDRESS: Enables Address Pointer authentication
 	  for the CPU and supported only on arm64 architecture.
 	  Must be requested if KVM_ARM_VCPU_PTRAUTH_GENERIC is also requested.
+	  Depends on KVM_CAP_ARM_PTRAUTH_ADDRESS.
 	- KVM_ARM_VCPU_PTRAUTH_GENERIC: Enables Generic Pointer authentication
 	  for the CPU and supported only on arm64 architecture.
 	  Must be requested if KVM_ARM_VCPU_PTRAUTH_ADDRESS is also requested.
+	  Depends on KVM_CAP_ARM_PTRAUTH_GENERIC.
 
 	- KVM_ARM_VCPU_SVE: Enables SVE for the CPU (arm64 only).
 	  Depends on KVM_CAP_ARM_SVE.
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index d13406b..be657f6 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -101,6 +101,11 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_SVE:
 		r = system_supports_sve();
 		break;
+	case KVM_CAP_ARM_PTRAUTH_ADDRESS:
+	case KVM_CAP_ARM_PTRAUTH_GENERIC:
+		r = has_vhe() && system_supports_address_auth() &&
+				system_supports_generic_auth();
+		break;
 	default:
 		r = 0;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 1d56444..4dc34f8 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -989,6 +989,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
 #define KVM_CAP_HYPERV_CPUID 167
 #define KVM_CAP_ARM_SVE 168
+#define KVM_CAP_ARM_PTRAUTH_ADDRESS 169
+#define KVM_CAP_ARM_PTRAUTH_GENERIC 170
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.7.4

