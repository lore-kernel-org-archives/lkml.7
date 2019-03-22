Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF402C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC8120883
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfCVOoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:44:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729279AbfCVOn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:43:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2MEd33b002566
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:43:58 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rd0984kv0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:43:58 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 22 Mar 2019 14:43:46 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Mar 2019 14:43:42 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2MEhpnX36110574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 14:43:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E46F44C04E;
        Fri, 22 Mar 2019 14:43:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 577FA4C046;
        Fri, 22 Mar 2019 14:43:50 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.145.173.187])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Mar 2019 14:43:50 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: [PATCH v6 1/7] s390: ap: kvm: add PQAP interception for AQIC
Date:   Fri, 22 Mar 2019 15:43:42 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032214-0020-0000-0000-000003266AE8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032214-0021-0000-0000-000021789779
Message-Id: <1553265828-27823-2-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903220108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We prepare the interception of the PQAP/AQIC instruction for
the case the AQIC facility is enabled in the guest.

First of all we do not want to change existing behavior when
intercepting AP instructions without the SIE allowing the guest
to use AP instructions.

In this patch we only handle the AQIC interception allowed by
facility 65 which will be enabled when the complete interception
infrastructure will be present.

We add a callback inside the KVM arch structure for s390 for
a VFIO driver to handle a specific response to the PQAP
instruction with the AQIC command and only this command.

But we want to be able to return a correct answer to the guest
even there is no VFIO AP driver in the kernel.
Therefor, we inject the correct exceptions from inside KVM for the
case the callback is not initialized, which happens when the vfio_ap
driver is not loaded.

We do consider the responsability of the driver to always initialize
the PQAP callback if it defines queues by initializing the CRYCB for
a guest.
If the callback has been setup we call it.
If not we setup an answer considering that no queue is available
for the guest when no callback has been setup.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h      |  8 ++++
 arch/s390/kvm/priv.c                  | 90 +++++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |  2 +
 3 files changed, 100 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index a496276..624460b 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -18,6 +18,7 @@
 #include <linux/kvm_host.h>
 #include <linux/kvm.h>
 #include <linux/seqlock.h>
+#include <linux/module.h>
 #include <asm/debug.h>
 #include <asm/cpu.h>
 #include <asm/fpu/api.h>
@@ -721,8 +722,15 @@ struct kvm_s390_cpu_model {
 	unsigned short ibc;
 };
 
+struct kvm_s390_module_hook {
+	int (*hook)(struct kvm_vcpu *vcpu);
+	void *data;
+	struct module *owner;
+};
+
 struct kvm_s390_crypto {
 	struct kvm_s390_crypto_cb *crycb;
+	struct kvm_s390_module_hook *pqap_hook;
 	__u32 crycbd;
 	__u8 aes_kw;
 	__u8 dea_kw;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 8679bd7..793e48a 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -27,6 +27,7 @@
 #include <asm/io.h>
 #include <asm/ptrace.h>
 #include <asm/sclp.h>
+#include <asm/ap.h>
 #include "gaccess.h"
 #include "kvm-s390.h"
 #include "trace.h"
@@ -592,6 +593,93 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
 	}
 }
 
+/*
+ * handle_pqap: Handling pqap interception
+ * @vcpu: the vcpu having issue the pqap instruction
+ *
+ * We now support PQAP/AQIC instructions and we need to correctly
+ * answer the guest even if no dedicated driver's hook is available.
+ *
+ * The intercepting code calls a dedicated callback for this instruction
+ * if a driver did register one in the CRYPTO satellite of the
+ * SIE block.
+ *
+ * For PQAP AQIC and TAPQ instructions, verify privilege and specifications.
+ *
+ * If no callback available, the queues are not available, return this to
+ * the caller.
+ * Else return the value returned by the callback.
+ */
+static int handle_pqap(struct kvm_vcpu *vcpu)
+{
+	struct ap_queue_status status = {};
+	unsigned long reg0;
+	int ret;
+	uint8_t fc;
+
+	/* Verify that the AP instruction are available */
+	if (!ap_instructions_available())
+		return -EOPNOTSUPP;
+	/* Verify that the guest is allowed to use AP instructions */
+	if (!(vcpu->arch.sie_block->eca & ECA_APIE))
+		return -EOPNOTSUPP;
+	/*
+	 * The only possibly intercepted instructions when AP instructions are
+	 * available for the guest are AQIC and TAPQ with the t bit set
+	 * since we do not set IC.3 (FIII) we currently will not intercept
+	 * TAPQ.
+	 * The following code will only treat AQIC function code.
+	 */
+	reg0 = vcpu->run->s.regs.gprs[0];
+	fc = reg0 >> 24;
+	if (fc != 0x03) {
+		pr_warn("%s: Unexpected interception code 0x%02x\n",
+			__func__, fc);
+		return -EOPNOTSUPP;
+	}
+	/* All PQAP instructions are allowed for guest kernel only */
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+	/*
+	 * Common tests for PQAP instructions to generate a specification
+	 * exception
+	 */
+	/* Zero bits overwrite produce a specification exception */
+	if (reg0 & 0x007f0000UL)
+		goto specification_except;
+	/* If APXA is not installed APQN is limited */
+	if (!(vcpu->kvm->arch.crypto.crycbd & 0x02))
+		if (reg0 & 0x000030f0UL)
+			goto specification_except;
+	/* AQIC needs facility 65 */
+	if (!test_kvm_facility(vcpu->kvm, 65))
+		goto specification_except;
+
+	/*
+	 * Verify that the hook callback is registered, lock the owner
+	 * and call the hook.
+	 */
+	if (vcpu->kvm->arch.crypto.pqap_hook) {
+		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
+			return -EOPNOTSUPP;
+		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
+		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
+		return ret;
+	}
+	/*
+	 * It is the duty of the vfio_driver to register a hook
+	 * If it does not and we get an exception on AQIC we must
+	 * guess that there is no vfio_ap_driver at all and no one
+	 * to handle the guests's CRYCB and the CRYCB is empty.
+	 */
+	status.response_code = 0x01;
+	memcpy(&vcpu->run->s.regs.gprs[1], &status, sizeof(status));
+	return 0;
+
+specification_except:
+	return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+}
+
 static int handle_stfl(struct kvm_vcpu *vcpu)
 {
 	int rc;
@@ -878,6 +966,8 @@ int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
 		return handle_sthyi(vcpu);
 	case 0x7d:
 		return handle_stsi(vcpu);
+	case 0xaf:
+		return handle_pqap(vcpu);
 	case 0xb1:
 		return handle_stfl(vcpu);
 	case 0xb2:
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 76b7f98..a910be1 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -16,6 +16,7 @@
 #include <linux/mdev.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/kvm_host.h>
 
 #include "ap_bus.h"
 
@@ -81,6 +82,7 @@ struct ap_matrix_mdev {
 	struct ap_matrix matrix;
 	struct notifier_block group_notifier;
 	struct kvm *kvm;
+	struct kvm_s390_module_hook pqap_hook;
 };
 
 extern int vfio_ap_mdev_register(void);
-- 
2.7.4

