Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F0FC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416EC2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cs4gH8Zr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbfI3MRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:17:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43684 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730659AbfI3MRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:17:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8UC8qaq186198;
        Mon, 30 Sep 2019 12:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=DdvgNs3YLQV/F83keoo2cERFaPN8mZU/K79AWrQUSyE=;
 b=cs4gH8ZrIfbujWSfT4CMbrCzSOmqoIW73qfCtZO1mzgj/etvb8+f4FZJ8XURrYNuBHOk
 bCCvkD2ontOJ815nwDAJBuah88y6o0djgBC4wShckR+t2RXpYTwNUYgND2mSxivuZ3sd
 ScdzBLltZhlg20Z4JCMXpeXmeu7W3EDXhr/zs+A3rrCosJmsH/aI7PjCvbFRno0viFzD
 NqtVwJ90Lo4ZeGOh4BrZaiZZn7cwwUIxKyHowdiBxjl2qeOtA9nZv7UuCsVwM4V0f4ZW
 G/oD9evV1Qv0Erp0A40k8MaaO6Aq3h/sce8vDcws26s6jJ09LS1WCuptYG0kh/UyOdvu kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2va05renyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 12:16:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8UC8jHo131773;
        Mon, 30 Sep 2019 12:16:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vah085mew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 12:16:37 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8UCGZFm023638;
        Mon, 30 Sep 2019 12:16:35 GMT
Received: from z2.cn.oracle.com (/10.182.71.205)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Sep 2019 05:16:35 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 3/3] x86/hyperv: Mark "hv_nopvspin" parameter obsolete and map it to "nopvspin"
Date:   Sun, 29 Sep 2019 20:21:06 +0800
Message-Id: <1569759666-26904-4-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569759666-26904-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1569759666-26904-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9395 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909300130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9395 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909300130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Included asm/hypervisor.h in order to reference x86_hyper_type.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 +++++-
 arch/x86/hyperv/hv_spinlock.c                   | 9 +++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1f0a62f..43f922c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1436,6 +1436,10 @@
 	hv_nopvspin	[X86,HYPER_V] Disables the paravirt spinlock optimizations
 				      which allow the hypervisor to 'idle' the
 				      guest on lock contention.
+				      This parameter is obsoleted by "nopvspin"
+				      parameter, which has equivalent effect for
+				      HYPER_V platform.
+
 
 	keep_bootcon	[KNL]
 			Do not unregister boot console at start. This is only
@@ -5331,7 +5335,7 @@
 			as generic guest with no PV drivers. Currently support
 			XEN HVM, KVM, HYPER_V and VMWARE guest.
 
-	nopvspin	[X86,XEN,KVM] Disables the qspinlock slow path
+	nopvspin	[X86,XEN,KVM,HYPER_V] Disables the qspinlock slow path
 			using PV optimizations which allow the hypervisor to
 			'idle' the guest on lock contention.
 
diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index 07f21a0..00c2902 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -12,12 +12,11 @@
 
 #include <linux/spinlock.h>
 
+#include <asm/hypervisor.h>
 #include <asm/mshyperv.h>
 #include <asm/paravirt.h>
 #include <asm/apic.h>
 
-static bool __initdata hv_pvspin = true;
-
 static void hv_qlock_kick(int cpu)
 {
 	apic->send_IPI(cpu, X86_PLATFORM_IPI_VECTOR);
@@ -64,7 +63,7 @@ __visible bool hv_vcpu_is_preempted(int vcpu)
 
 void __init hv_init_spinlocks(void)
 {
-	if (!hv_pvspin || !apic ||
+	if (!pvspin || !apic ||
 	    !(ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) ||
 	    !(ms_hyperv.features & HV_X64_MSR_GUEST_IDLE_AVAILABLE)) {
 		pr_info("PV spinlocks disabled\n");
@@ -82,7 +81,9 @@ void __init hv_init_spinlocks(void)
 
 static __init int hv_parse_nopvspin(char *arg)
 {
-	hv_pvspin = false;
+	pr_notice("\"hv_nopvspin\" is deprecated, please use \"nopvspin\" instead\n");
+	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
+		pvspin = false;
 	return 0;
 }
 early_param("hv_nopvspin", hv_parse_nopvspin);
-- 
1.8.3.1

