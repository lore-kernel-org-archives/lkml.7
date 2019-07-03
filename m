Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF61C5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 01:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E32321882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 01:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qo6dcN+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfGDBSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 21:18:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36234 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfGDBSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 21:18:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x641EI3V123328;
        Thu, 4 Jul 2019 01:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=McFjyxa5TN9dJj6AfIiEg6O5IDlY1x1JqP2XAQDDw6g=;
 b=qo6dcN+40a12F1kR8Pc1IkBdJPcYwDKknnPIgKtfiuGmzU2p2K4Eb4f0jTfVz0CUj0rS
 PC7utQ/o4BYKSi9UT/+e0CKeU6YvyzbepTAq8Y7yJ2ugbY5nVGiVGm7c8TV00jbv4TqO
 W3opOcMFJ0FKsCHT9yEsAqA/McoHGo5EXfJfkCzy1JaMPrVE+NldLKFjfWdAVGWw4CSa
 l2ydnTTst7Jr9A3fPc5OzQDTjNnDrl6HA8n2sd+9mOVT5jOiTAZftVkJNT0igsHC9rTS
 RO1re2EaseC+2n3tHWG0ry9aJ7+YS7k7Sz5ttwe97z06wSQLYlaPbsJbPZ/8kljOjz28 UA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2te5tbv6wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 01:18:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x641CZXK089761;
        Thu, 4 Jul 2019 01:16:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2tebkv5td0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 01:16:04 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x641G2u7032301;
        Thu, 4 Jul 2019 01:16:02 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jul 2019 18:16:02 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v5 2/4] x86: Add "nopv" parameter to disable PV extensions
Date:   Wed,  3 Jul 2019 09:19:36 +0800
Message-Id: <1562116778-5846-3-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562116778-5846-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1562116778-5846-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907040013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907040014
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
index 138f666..21e08af 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5268,6 +5268,11 @@
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
index 8c5aaba..00240b0 100644
--- a/arch/x86/include/asm/hypervisor.h
+++ b/arch/x86/include/asm/hypervisor.h
@@ -52,8 +52,12 @@ struct hypervisor_x86 {
 
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
index 479ca47..337ff07 100644
--- a/arch/x86/kernel/cpu/hypervisor.c
+++ b/arch/x86/kernel/cpu/hypervisor.c
@@ -54,6 +54,14 @@
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
@@ -61,6 +69,9 @@
 	uint32_t pri, max_pri = 0;
 
 	for (p = hypervisors; p < hypervisors + ARRAY_SIZE(hypervisors); p++) {
+		if (unlikely(nopv) && !(*p)->ignore_nopv)
+			continue;
+
 		pri = (*p)->detect();
 		if (pri > max_pri) {
 			max_pri = pri;
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 1b2ee55..c52c4105 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -217,4 +217,5 @@ static bool jailhouse_x2apic_available(void)
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

