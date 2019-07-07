Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7D4C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3686020645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="21vUSpkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfGHJOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:14:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60738 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfGHJOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:14:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6899OlR045630;
        Mon, 8 Jul 2019 09:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=McFjyxa5TN9dJj6AfIiEg6O5IDlY1x1JqP2XAQDDw6g=;
 b=21vUSpkMsAe5ZhtskmJx17cM8H9Mdm4Fge2bNjJJdYI+Cm59Xwk5A3fa3AYHCflRGEa+
 ap5bgNr5INE/wvEiCfNNjXlWdeV6MvUX4VzmwoAQNKqm1P9hQbEsKd94fwGwZiDuOb1I
 O1dr6KclejiemY7eUW9N0rxc8xIKMuDSUj6qjdygrzLkTof76KJVZjZUCJmCrrkpYA3v
 cWBm/KVjkUX3zSLtFIeUjXz9EurM8M1HES9EmeF+0TeBC+Cah9LeKb33tkDhA9S9KUga
 PMru+tRx4twAk1hXT9+H62WVAJzuIr0JmZxmUudVujYsyaANuFX3xIzOIQhvt9Gta1Rz cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2tjkkpd87j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jul 2019 09:11:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6897t5P110914;
        Mon, 8 Jul 2019 09:11:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2tjkf23d9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jul 2019 09:11:35 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x689BYcS005110;
        Mon, 8 Jul 2019 09:11:34 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jul 2019 02:11:34 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v6 2/4] x86: Add "nopv" parameter to disable PV extensions
Date:   Sun,  7 Jul 2019 17:15:06 +0800
Message-Id: <1562490908-17882-3-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562490908-17882-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1562490908-17882-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907080120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907080121
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

