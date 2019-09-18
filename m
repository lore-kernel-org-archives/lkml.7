Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C46DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC6F21906
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfIRIH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:07:59 -0400
Received: from foss.arm.com ([217.140.110.172]:36842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729621AbfIRIHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:07:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7968E28;
        Wed, 18 Sep 2019 01:07:52 -0700 (PDT)
Received: from entos-d05.shanghai.arm.com (entos-d05.shanghai.arm.com [10.169.40.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 61F643F59C;
        Wed, 18 Sep 2019 01:07:47 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     netdev@vger.kernel.org, yangbo.lu@nxp.com, john.stultz@linaro.org,
        tglx@linutronix.de, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, maz@kernel.org,
        richardcochran@gmail.com, Mark.Rutland@arm.com,
        Will.Deacon@arm.com, suzuki.poulose@arm.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Steve.Capper@arm.com, Kaly.Xin@arm.com, justin.he@arm.com,
        jianyong.wu@arm.com, nd@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v3 4/6] psci: Add hvc call service for ptp_kvm.
Date:   Wed, 18 Sep 2019 04:07:14 -0400
Message-Id: <20190918080716.64242-5-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190918080716.64242-1-jianyong.wu@arm.com>
References: <20190918080716.64242-1-jianyong.wu@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is the base of ptp_kvm for arm64.
ptp_kvm modules will call hvc to get this service.
The service offers real time and counter cycle of host for guest.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 include/linux/arm-smccc.h | 12 ++++++++++++
 virt/kvm/arm/psci.c       | 17 +++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index a6e4d3e3d10a..bc0cdad10f35 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -94,6 +94,7 @@
 
 /* KVM "vendor specific" services */
 #define ARM_SMCCC_KVM_FUNC_FEATURES		0
+#define ARM_SMCCC_KVM_PTP			1
 #define ARM_SMCCC_KVM_FUNC_FEATURES_2		127
 #define ARM_SMCCC_KVM_NUM_FUNCS			128
 
@@ -103,6 +104,17 @@
 			   ARM_SMCCC_OWNER_VENDOR_HYP,			\
 			   ARM_SMCCC_KVM_FUNC_FEATURES)
 
+/*
+ * This ID used for virtual ptp kvm clock and it will pass second value
+ * and nanosecond value of host real time and system counter by vcpu
+ * register to guest.
+ */
+#define ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   ARM_SMCCC_OWNER_VENDOR_HYP,			\
+			   ARM_SMCCC_KVM_PTP)
+
 #ifndef __ASSEMBLY__
 
 #include <linux/linkage.h>
diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
index 0debf49bf259..2c5d53817a28 100644
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -392,6 +392,8 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 	u32 func_id = smccc_get_function(vcpu);
 	u32 val[4] = {};
 	u32 option;
+	struct timespec *ts;
+	struct system_counterval_t sc;
 
 	val[0] = SMCCC_RET_NOT_SUPPORTED;
 
@@ -431,6 +433,21 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
 		val[0] = BIT(ARM_SMCCC_KVM_FUNC_FEATURES);
 		break;
+	/*
+	 * This will used for virtual ptp kvm clock. three
+	 * values will be passed back.
+	 * reg0 stores seconds of host real time;
+	 * reg1 stores nanoseconds of host real time;
+	 * reg2 stores system counter cycle value.
+	 */
+	case ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID:
+		getnstimeofday(ts);
+		get_current_counterval(&sc);
+		val[0] = ts->tv_sec;
+		val[1] = ts->tv_nsec;
+		val[2] = sc.cycles;
+		val[3] = 0;
+		break;
 	default:
 		return kvm_psci_call(vcpu);
 	}
-- 
2.17.1

