Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40684C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 05:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F6D21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 05:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y00R8cDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfGBFTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 01:19:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40484 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfGBFTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 01:19:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x625IrkD133671;
        Tue, 2 Jul 2019 05:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=vqXCEfmZ5gQlOnpRYRTKWKl8oRG3faoP4WDFQ3/Z1bA=;
 b=y00R8cDBVawlt1rd9K/zEIkNa9LT9SrPzZqYsjBuqUker5GpmuTglloBjzkz9GBx2GU4
 8SYGMvKdvLy7XMgqOoHvtMPqRsF/YUN8jIrSIZ7OVI/pFxIGJSwpAIPaOUMfNiNrI8J5
 pzbs/XIBvGidT0LwvQHBLw402cPfCMe+MYI/dDPeMb3LRUKvUbteq9+AWk2egXnGpc2z
 hhH6EPZkSzEw3C/VVLzfe7aZiDj6LCb8mtlz1085R8Crq4ao1SNwJU708yDHrIdeFbSx
 Wcu5hh9b2xNseAoz3rEK4zGH7gD0N/J0C4zVEcUGnFqvCY31YxtpCVi+rAxUBzibYybV DQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2te61ps3vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 05:18:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x625Ccs1019349;
        Tue, 2 Jul 2019 05:16:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2tebku1uf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 05:16:52 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x625Gp9D010788;
        Tue, 2 Jul 2019 05:16:51 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 22:16:51 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v4 5/5] xen: Add 'xen_nopv' parameter back for backward compatibility
Date:   Mon,  1 Jul 2019 13:19:59 +0800
Message-Id: <1561958399-28906-6-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561958399-28906-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1561958399-28906-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map 'xen_nopv' to 'nopv' and mark 'xen_nopv' obsolete in
kernel-parameters.txt

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 arch/x86/xen/enlighten_hvm.c                    | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d5c3dcc..34eb323 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5264,6 +5264,12 @@
 			improve timer resolution at the expense of processing
 			more timer interrupts.
 
+	xen_nopv	[X86]
+			Disables the PV optimizations forcing the HVM guest to
+			run as generic HVM guest with no PV drivers.
+			This option is obsoleted by the "nopv" option, which
+			has equivalent effect for XEN platform.
+
 	nopv=		[X86,XEN,KVM,HYPER_V,VMWARE]
 			Disables the PV optimizations forcing the guest to run
 			as generic guest with no PV drivers. Currently support
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 340dff8..5cdd608 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -211,6 +211,13 @@ static void __init xen_hvm_guest_init(void)
 #endif
 }
 
+static __init int xen_parse_nopv(char *arg)
+{
+	nopv = true;
+	return 0;
+}
+early_param("xen_nopv", xen_parse_nopv);
+
 bool __init xen_hvm_need_lapic(void)
 {
 	if (xen_pv_domain())
-- 
1.8.3.1

