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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B963DC388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7EC218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DCKrkSn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfI3MRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:17:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36194 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3MRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:17:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8UC8npM186687;
        Mon, 30 Sep 2019 12:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=KRxC1ekJ9kuFzpcxYi26uxQXMmgq8w7EPRqrYtQTgJU=;
 b=DCKrkSn8/uZBIBk7I9zZdVuil1YquyNuKBqmGqugBQ3FNT4InmhJlqj/aAwWOJGKQz0q
 Y+jHBi4BVbyOHFG5bb2HjwS/Nn48XiaIVP4poezXn7c2iJo3pVKiHjvk0JT5lDOIYTmq
 /V1JgzNSxp1VH7df2+73dEX6tEEc6i/pnSftMI4qJNAJC5BURno7gPUa6X+bJLdWl9EJ
 kUsfEe5QoFrRzRdoe+t/m2YD+nxP2C1OBlH2bei9uUCmpHXlNaVqp17D8VT4lmkAIPtw
 6yI7d9fB8wfAh5tL6ZoQ2Mp9aoE4Ji4neIqK6EaHe/HjCov9EibI0s2OpzUUjfRyNmay gQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2v9xxuernp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 12:16:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8UC8vjh152902;
        Mon, 30 Sep 2019 12:16:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vahngjd9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 12:16:36 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8UCGX9v027670;
        Mon, 30 Sep 2019 12:16:33 GMT
Received: from z2.cn.oracle.com (/10.182.71.205)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Sep 2019 05:16:32 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/3] xen: Mark "xen_nopvspin" parameter obsolete and map it to "nopvspin"
Date:   Sun, 29 Sep 2019 20:21:05 +0800
Message-Id: <1569759666-26904-3-git-send-email-zhenzhong.duan@oracle.com>
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

Fix stale description of "xen_nopvspin" as we use qspinlock now.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 ++++---
 arch/x86/xen/spinlock.c                         | 13 +++++++------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4b956d8..1f0a62f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5303,8 +5303,9 @@
 			never -- do not unplug even if version check succeeds
 
 	xen_nopvspin	[X86,XEN]
-			Disables the ticketlock slowpath using Xen PV
-			optimizations.
+			Disables the qspinlock slowpath using Xen PV optimizations.
+			This parameter is obsoleted by "nopvspin" parameter, which
+			has equivalent effect for XEN platform.
 
 	xen_nopv	[X86]
 			Disables the PV optimizations forcing the HVM guest to
@@ -5330,7 +5331,7 @@
 			as generic guest with no PV drivers. Currently support
 			XEN HVM, KVM, HYPER_V and VMWARE guest.
 
-	nopvspin	[X86,KVM] Disables the qspinlock slow path
+	nopvspin	[X86,XEN,KVM] Disables the qspinlock slow path
 			using PV optimizations which allow the hypervisor to
 			'idle' the guest on lock contention.
 
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 6deb490..092a53f 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -18,7 +18,6 @@
 static DEFINE_PER_CPU(int, lock_kicker_irq) = -1;
 static DEFINE_PER_CPU(char *, irq_name);
 static DEFINE_PER_CPU(atomic_t, xen_qlock_wait_nest);
-static bool xen_pvspin = true;
 
 static void xen_qlock_kick(int cpu)
 {
@@ -68,7 +67,7 @@ void xen_init_lock_cpu(int cpu)
 	int irq;
 	char *name;
 
-	if (!xen_pvspin)
+	if (!pvspin)
 		return;
 
 	WARN(per_cpu(lock_kicker_irq, cpu) >= 0, "spinlock on CPU%d exists on IRQ%d!\n",
@@ -93,7 +92,7 @@ void xen_init_lock_cpu(int cpu)
 
 void xen_uninit_lock_cpu(int cpu)
 {
-	if (!xen_pvspin)
+	if (!pvspin)
 		return;
 
 	unbind_from_irqhandler(per_cpu(lock_kicker_irq, cpu), NULL);
@@ -117,9 +116,9 @@ void __init xen_init_spinlocks(void)
 
 	/*  Don't need to use pvqspinlock code if there is only 1 vCPU. */
 	if (num_possible_cpus() == 1)
-		xen_pvspin = false;
+		pvspin = false;
 
-	if (!xen_pvspin) {
+	if (!pvspin) {
 		printk(KERN_DEBUG "xen: PV spinlocks disabled\n");
 		static_branch_disable(&virt_spin_lock_key);
 		return;
@@ -137,7 +136,9 @@ void __init xen_init_spinlocks(void)
 
 static __init int xen_parse_nopvspin(char *arg)
 {
-	xen_pvspin = false;
+	pr_notice("\"xen_nopvspin\" is deprecated, please use \"nopvspin\" instead\n");
+	if (xen_domain())
+		pvspin = false;
 	return 0;
 }
 early_param("xen_nopvspin", xen_parse_nopvspin);
-- 
1.8.3.1

