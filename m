Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FA2C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2452F20863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bh2AHFVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfGLMFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:05:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46936 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfGLMFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:05:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CC3mBq093615;
        Fri, 12 Jul 2019 12:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=7mSXW1AaKAj4lnksyNN8rOaqG9NBDQLiPAqjKyUrhew=;
 b=bh2AHFVKZnF9quE+D6y7wuHOHN5HvcKGkaq/HIvfD1KJzd8EVfZmeNZ9qYg8RLoHmYh0
 brWSLT88B0DzNpJOVjmznqnRD0JLPgx8imnK9lV+Wd3mPSljN7ALCraV11zaOdwhJ9mY
 8vgxPZMQl2M7OBkgcBtlr1gbEUj9VbBSCf/We2VadT9yyjXYYbOtDY9kNvFKxHwdP5qb
 GbkJpZQSPtjFmjLXT9ExJIoiadw5gwowzQXukD37a3CAl8PdMuxIM4c0i/Gj0W8exTg3
 g7kom/njDSVkGww/Wu5upIJqyZFUnBGraaDJ+wHnsgar3WFfy5K2PvBF4zAOzkRpbQnn Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2tjkkq572n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 12:04:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CC3TgJ175345;
        Fri, 12 Jul 2019 12:04:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2tmwgyr39k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 12:04:07 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6CC461N020739;
        Fri, 12 Jul 2019 12:04:06 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jul 2019 04:58:34 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v7 2/5] x86: Add "nopv" parameter to disable PV extensions
Date:   Thu, 11 Jul 2019 20:02:09 +0800
Message-Id: <1562846532-32152-3-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562846532-32152-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1562846532-32152-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In virtualization environment, PV extensions (drivers, interrupts,
timers, etc) are enabled in the majority of use cases which is the
best option.

However, in some cases (kexec not fully working, benchmarking)
we want to disable PV extensions. We have "xen_nopv" for that purpose
but only for XEN. For a consistent admin experience a common command
line parameter "nopv" set across all PV guest implementations is a
better choice.

There are guest types which just won't work without PV extensions,
like Xen PV, Xen PVH and jailhouse. add a "ignore_nopv" member to
struct hypervisor_x86 set to true for those guest types and call
the detect functions only if nopv is false or ignore_nopv is true.

Suggested-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 arch/x86/include/asm/hypervisor.h               |  4 ++++
 arch/x86/kernel/cpu/hypervisor.c                | 11 +++++++++++
 arch/x86/kernel/jailhouse.c                     |  1 +
 arch/x86/xen/enlighten_pv.c                     |  1 +
 5 files changed, 22 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1c433d..dbfe9c2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5271,6 +5271,11 @@
 			improve timer resolution at the expense of processing
 			more timer interrupts.
 
+	nopv=		[X86,XEN,KVM,HYPER_V,VMWARE]
+			Disables the PV optimizations forcing the guest to run
+			as generic guest with no PV drivers. Currently support
+			XEN HVM, KVM, HYPER_V and VMWARE guest.
+
 	xirc2ps_cs=	[NET,PCMCIA]
 			Format:
 			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hypervisor.h
index 50a30f6..f7b4c53 100644
--- a/arch/x86/include/asm/hypervisor.h
+++ b/arch/x86/include/asm/hypervisor.h
@@ -53,8 +53,12 @@ struct hypervisor_x86 {
 
 	/* runtime callbacks */
 	struct x86_hyper_runtime runtime;
+
+	/* ignore nopv parameter */
+	bool ignore_nopv;
 };
 
+extern bool nopv;
 extern enum x86_hypervisor_type x86_hyper_type;
 extern void init_hypervisor_platform(void);
 static inline bool hypervisor_is_type(enum x86_hypervisor_type type)
diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hypervisor.c
index 87e39ad..7eaad41 100644
--- a/arch/x86/kernel/cpu/hypervisor.c
+++ b/arch/x86/kernel/cpu/hypervisor.c
@@ -58,6 +58,14 @@
 enum x86_hypervisor_type x86_hyper_type;
 EXPORT_SYMBOL(x86_hyper_type);
 
+bool __initdata nopv;
+static __init int parse_nopv(char *arg)
+{
+	nopv = true;
+	return 0;
+}
+early_param("nopv", parse_nopv);
+
 static inline const struct hypervisor_x86 * __init
 detect_hypervisor_vendor(void)
 {
@@ -65,6 +73,9 @@
 	uint32_t pri, max_pri = 0;
 
 	for (p = hypervisors; p < hypervisors + ARRAY_SIZE(hypervisors); p++) {
+		if (unlikely(nopv) && !(*p)->ignore_nopv)
+			continue;
+
 		pri = (*p)->detect();
 		if (pri > max_pri) {
 			max_pri = pri;
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 6857b45..3ad34f0 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -217,4 +217,5 @@ static bool __init jailhouse_x2apic_available(void)
 	.detect			= jailhouse_detect,
 	.init.init_platform	= jailhouse_init_platform,
 	.init.x2apic_available	= jailhouse_x2apic_available,
+	.ignore_nopv		= true,
 };
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 4722ba2..5d16824 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1463,4 +1463,5 @@ static uint32_t __init xen_platform_pv(void)
 	.detect                 = xen_platform_pv,
 	.type			= X86_HYPER_XEN_PV,
 	.runtime.pin_vcpu       = xen_pin_vcpu,
+	.ignore_nopv		= true,
 };
-- 
1.8.3.1

