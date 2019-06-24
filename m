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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F05C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC30208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xIAw4zPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbfFYMAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:00:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54916 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731509AbfFYMAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:00:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PBwkuP132922;
        Tue, 25 Jun 2019 12:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=iNQTvVUSmgNuLxw/E1kf9kiRXgGAedbtzYJ7h/7MhiM=;
 b=xIAw4zPPw23qdkXzzO7kIYWXxKfuSWEZME+9rRcJ1KvLaeHHFqrGGzTHONRNQHR7BvVZ
 iK/Wag51OR8USF4fgGFhHZ5vUQwTXO7LO8xhdrYFJjhRsgd51IIKWgto3cQmrs+kX1iB
 C5PUWNcg8xG3ReOM2UlG+VGrJaSp3A2yktkKQP6bydJ+7Nd8+hyXdMeuv7X5SN8805fl
 Etm7qGx+urDGi96IDdT9cOP1lnHDUiJUC8Be6ypgeuoJyuZ4lDJPECpRaL9udvR4pEai
 i9dIB1JcfOepxDS7yGP06jlhELtV3mRA8Wqx/52aQBiPJ3uJS0TyyvcLdC6iPIwbgA2D 8A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t9c9pkv6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 12:00:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PBxTnS064989;
        Tue, 25 Jun 2019 12:00:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t9acc2gnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 12:00:05 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5PC046Z027550;
        Tue, 25 Jun 2019 12:00:04 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 05:00:04 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, peterz@infradead.org,
        srinivas.eeda@oracle.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org
Subject: [PATCH v2 5/7] x86/xen: nopv parameter support for HVM guest
Date:   Mon, 24 Jun 2019 20:02:57 +0800
Message-Id: <1561377779-28036-6-git-send-email-zhenzhong.duan@oracle.com>
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

PVH guest needs PV extentions to work, so nopv parameter is ignored
for PVH but not for HVM guest.

In order for nopv parameter to take effect for HVM guest, we need to
distinguish between PVH and HVM guest early in hypervisor detection
code. By moving the detection of PVH in xen_platform_hvm(),
xen_pvh_domain() could be used for that purpose.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/xen/enlighten_hvm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 7fcb4ea..26939e7 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -25,6 +25,7 @@
 #include "mmu.h"
 #include "smp.h"
 
+extern bool nopv;
 static unsigned long shared_info_pfn;
 
 void xen_hvm_init_shared_info(void)
@@ -226,20 +227,24 @@ static uint32_t __init xen_platform_hvm(void)
 	if (xen_pv_domain())
 		return 0;
 
+#ifdef CONFIG_XEN_PVH
+	/* Test for PVH domain (PVH boot path taken overrides ACPI flags). */
+	if (!x86_platform.legacy.rtc && x86_platform.legacy.no_vga)
+		xen_pvh = true;
+#endif
+
+	if (!xen_pvh_domain() && nopv)
+		return 0;
+
 	return xen_cpuid_base();
 }
 
 static __init void xen_hvm_guest_late_init(void)
 {
 #ifdef CONFIG_XEN_PVH
-	/* Test for PVH domain (PVH boot path taken overrides ACPI flags). */
-	if (!xen_pvh &&
-	    (x86_platform.legacy.rtc || !x86_platform.legacy.no_vga))
+	if (!xen_pvh)
 		return;
 
-	/* PVH detected. */
-	xen_pvh = true;
-
 	/* Make sure we don't fall back to (default) ACPI_IRQ_MODEL_PIC. */
 	if (!nr_ioapics && acpi_irq_model == ACPI_IRQ_MODEL_PIC)
 		acpi_irq_model = ACPI_IRQ_MODEL_PLATFORM;
@@ -258,4 +263,5 @@ static __init void xen_hvm_guest_late_init(void)
 	.init.init_mem_mapping	= xen_hvm_init_mem_mapping,
 	.init.guest_late_init	= xen_hvm_guest_late_init,
 	.runtime.pin_vcpu       = xen_pin_vcpu,
+	.ignore_nopv            = true,
 };
-- 
1.8.3.1

