Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D30C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C089A216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LbeNXZ02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732502AbfFYMBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:01:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48280 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfFYMBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:01:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PBwx2x027209;
        Tue, 25 Jun 2019 12:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=IfwgKDnZi80buyiIPP86pHwWHIBnfojOW5Jty8tpEL8=;
 b=LbeNXZ028pNRVclBDTAhimcCvZP0x6jpoQoSNq3CtxBAwvZOqzDV6x2tqbj0gEguQZiW
 TZ3iK8fRJtTi6Er1ZDuJlbAt/uUpLKR1S/E3q2U2ReujVxUMTDTEEtr68mBnXNCILIfy
 LTdi8XWoSvfcnQ/cARthiW/9+Z8+80ouMvbmJQRS3RvpUirhVfZAeTqKnO0U6sQmZxLk
 5TH7T+dWN5VYdNOJ9Dtg4/Zz4uJulIl3XqgHMAoojpTYon8+QXBLi8WRAPm/bCHZeWFI
 CZ8p9y6vfsmhbxcW/hgvhZgNwqOlOXBa0/LSKFrV81NfT+UPbI6VJuejdo/MmDPUnw5n iA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t9brt3x5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 12:00:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PBxPw1002189;
        Tue, 25 Jun 2019 12:00:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tat7c6q7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 12:00:00 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5PBxw0s012082;
        Tue, 25 Jun 2019 11:59:58 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 04:59:57 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, peterz@infradead.org,
        srinivas.eeda@oracle.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH v2 3/7] x86: Add nopv parameter to disable PV extensions
Date:   Mon, 24 Jun 2019 20:02:55 +0800
Message-Id: <1561377779-28036-4-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561377779-28036-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1561377779-28036-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906250097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In virtualization environment, PV extensions (drivers, interrupts,
timers, etc) are enabled in the majority of use cases which is the
best option.

However, in some cases (kexec not fully working, benchmarking)
we want to disable PV extensions. As such introduce the
'nopv' parameter that will do it.

There are guest types which just won't work without PV extensions,
like Xen PV, Xen PVH and jailhouse. add a "ignore_nopv" member to
struct hypervisor_x86 set to true for those guest types and call
the detect functions only if nopv is false or ignore_nopv is true.

There is already 'xen_nopv' parameter for XEN platform but not for
others. 'xen_nopv' can then be removed with this change.

Suggested-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 arch/x86/include/asm/hypervisor.h               |  3 +++
 arch/x86/kernel/cpu/hypervisor.c                | 11 +++++++++++
 arch/x86/kernel/jailhouse.c                     |  1 +
 arch/x86/xen/enlighten_pv.c                     |  1 +
 5 files changed, 21 insertions(+)

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
index 8c5aaba..d75d2ea 100644
--- a/arch/x86/include/asm/hypervisor.h
+++ b/arch/x86/include/asm/hypervisor.h
@@ -52,6 +52,9 @@ struct hypervisor_x86 {
 
 	/* runtime callbacks */
 	struct x86_hyper_runtime runtime;
+
+	/* ignore nopv parameter */
+	bool ignore_nopv;
 };
 
 extern enum x86_hypervisor_type x86_hyper_type;
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
index d96d563..880329f 100644
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

