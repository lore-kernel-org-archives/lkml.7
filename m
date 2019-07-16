Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25519C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 04:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC64320651
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 04:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ePRMs8aw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfGQEXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 00:23:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50748 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQEXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 00:23:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H4IaAT156874;
        Wed, 17 Jul 2019 04:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=ZaTW46yy/IPS+Uj8SvYea4HIn3z7+WN7LtSK/DDihz4=;
 b=ePRMs8awd/lTWeMpgQbWKbolJaWrnLONgEEG0Q81rgZvlACcR/cwq4E4RBxuqXqGRAzI
 wr5uZVipjClnyYIpK/Eav4QlyhuTEFf2r4x4Z/MycjDjLo7v59hg5Oi+8cJwuaPBHeHa
 IJDPAxyB1QEOqd3OPgbmVAaV75TZGDnmgdeJOlTFixmjS42sBqJ3XsMFaUOlJlQPohZr
 +kxp3ZmaT9s1haWVZUs03TLvtW7CpBOW0KMMhtJJkc68xWEqp51zaQ5o/4duDmE6DlOJ
 RVURGIf5YC8iM+mZbCHPo9if0uR7jHElX/TG8ypGXoXsJ1prkPcAkcZ8Kcy9wcxuk1oD cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tq7xr004e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 04:22:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H4IY8e097456;
        Wed, 17 Jul 2019 04:22:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tsctwqsjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 04:22:31 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6H4MU9T010466;
        Wed, 17 Jul 2019 04:22:30 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 04:22:29 +0000
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v8 4/5] x86/paravirt: Remove const mark from x86_hyper_xen_hvm variable
Date:   Tue, 16 Jul 2019 12:26:08 +0800
Message-Id: <1563251169-30740-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170052
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.. as "nopv" support needs it to be changeable at boot up stage.

Checkpatch reports warning, so move variable declarations from
hypervisor.c to hypervisor.h

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 arch/x86/include/asm/hypervisor.h | 8 ++++++++
 arch/x86/kernel/cpu/hypervisor.c  | 8 --------
 arch/x86/xen/enlighten_hvm.c      | 2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hypervisor.h
index f7b4c53..e41cbf2 100644
--- a/arch/x86/include/asm/hypervisor.h
+++ b/arch/x86/include/asm/hypervisor.h
@@ -58,6 +58,14 @@ struct hypervisor_x86 {
 	bool ignore_nopv;
 };
 
+extern const struct hypervisor_x86 x86_hyper_vmware;
+extern const struct hypervisor_x86 x86_hyper_ms_hyperv;
+extern const struct hypervisor_x86 x86_hyper_xen_pv;
+extern const struct hypervisor_x86 x86_hyper_kvm;
+extern const struct hypervisor_x86 x86_hyper_jailhouse;
+extern const struct hypervisor_x86 x86_hyper_acrn;
+extern struct hypervisor_x86 x86_hyper_xen_hvm;
+
 extern bool nopv;
 extern enum x86_hypervisor_type x86_hyper_type;
 extern void init_hypervisor_platform(void);
diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hypervisor.c
index 7eaad41..553bfbf 100644
--- a/arch/x86/kernel/cpu/hypervisor.c
+++ b/arch/x86/kernel/cpu/hypervisor.c
@@ -26,14 +26,6 @@
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
 
-extern const struct hypervisor_x86 x86_hyper_vmware;
-extern const struct hypervisor_x86 x86_hyper_ms_hyperv;
-extern const struct hypervisor_x86 x86_hyper_xen_pv;
-extern const struct hypervisor_x86 x86_hyper_xen_hvm;
-extern const struct hypervisor_x86 x86_hyper_kvm;
-extern const struct hypervisor_x86 x86_hyper_jailhouse;
-extern const struct hypervisor_x86 x86_hyper_acrn;
-
 static const __initconst struct hypervisor_x86 * const hypervisors[] =
 {
 #ifdef CONFIG_XEN_PV
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 1756cf7..b671983 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -259,7 +259,7 @@ static __init void xen_hvm_guest_late_init(void)
 #endif
 }
 
-const __initconst struct hypervisor_x86 x86_hyper_xen_hvm = {
+struct hypervisor_x86 x86_hyper_xen_hvm __initdata = {
 	.name                   = "Xen HVM",
 	.detect                 = xen_platform_hvm,
 	.type			= X86_HYPER_XEN_HVM,
-- 
1.8.3.1

