Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1997C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C975B2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XxAq3iVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387687AbfJCSMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:12:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36948 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732980AbfJCSMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:12:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93HsYMW089402;
        Thu, 3 Oct 2019 18:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=bs57jL07nzAKqfhU6u+MUrWsx1PltL4Qn+aLCBDHeOE=;
 b=XxAq3iVAqPyJHd22CISPSL1FT5sD9yclaDy2qGzbWLn2FKLaYO3orGq48o4jUYx26bi0
 rwldv7VsCbThyxzi/aINlUpFALi3NGFLvJKb9dCJjHhkrzz44iCmCYDQngxbhA3WeAXE
 VO5x4N0QBn79AsRnz2yQXr1PQvA0L79mNNEur36yPLaeNRlm64q1SE9sf5Nrmz6YgGBM
 qW57b1hVKowS00UpHoea7j4aaMndKQJfOPuHtZI8ABg/fTxjhrsIpsVMrsOT19mENk7i
 QY/kxMF4qZuBXIh+kwP+uVbu4kF5M+lLsD4KGdWpa68aQ+pVmQ3gtVjorHNPJ4OuEXGf WQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2v9xxv658v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 18:12:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93Hwdqr074410;
        Thu, 3 Oct 2019 18:12:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vcx72wd3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 18:12:13 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x93ICCXt013176;
        Thu, 3 Oct 2019 18:12:12 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Oct 2019 11:12:12 -0700
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, james@dingwall.me.uk, jbeulich@suse.com
Subject: [PATCH v2] x86/xen: Return from panic notifier
Date:   Thu,  3 Oct 2019 14:12:03 -0400
Message-Id: <20191003181203.22405-1-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910030151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910030151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently execution of panic() continues until Xen's panic notifier
(xen_panic_event()) is called at which point we make a hypercall that
never returns.

This means that any notifier that is supposed to be called later as
well as significant part of panic() code (such as pstore writes from
kmsg_dump()) is never executed.

There is no reason for xen_panic_event() to be this last point in
execution since panic()'s emergency_restart() will call into
xen_emergency_restart() from where we can perform our hypercall.

Nevertheless, we will provide xen_legacy_crash boot option that will
preserve original behavior during crash. This option could be used,
for example, if running kernel dumper (which happens after panic
notifiers) is undesirable.

Reported-by: James Dingwall <james@dingwall.me.uk>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---

v2: Added xen_legacy_crash boot option to preserve current behaviour. My
earlier suggestion to create an external dumper (for Xen toolstack)
had some corner cases and dealing with them was becoming too much logic
for my taste.


 .../admin-guide/kernel-parameters.txt         |  4 +++
 arch/x86/xen/enlighten.c                      | 28 +++++++++++++++++--
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4c1971960afa..5ea005c9e2d6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5267,6 +5267,10 @@
 				the unplug protocol
 			never -- do not unplug even if version check succeeds
 
+	xen_legacy_crash	[X86,XEN]
+			Crash from Xen panic notifier, without executing late
+			panic() code such as dumping handler.
+
 	xen_nopvspin	[X86,XEN]
 			Disables the ticketlock slowpath using Xen PV
 			optimizations.
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 750f46ad018a..205b1176084f 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -269,19 +269,41 @@ void xen_reboot(int reason)
 		BUG();
 }
 
+static int reboot_reason = SHUTDOWN_reboot;
+static bool xen_legacy_crash;
 void xen_emergency_restart(void)
 {
-	xen_reboot(SHUTDOWN_reboot);
+	xen_reboot(reboot_reason);
 }
 
 static int
 xen_panic_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
-	if (!kexec_crash_loaded())
-		xen_reboot(SHUTDOWN_crash);
+	if (!kexec_crash_loaded()) {
+		if (xen_legacy_crash)
+			xen_reboot(SHUTDOWN_crash);
+
+		reboot_reason = SHUTDOWN_crash;
+
+		/*
+		 * If panic_timeout==0 then we are supposed to wait forever.
+		 * However, to preserve original dom0 behavior we have to drop
+		 * into hypervisor. (domU behavior is controlled by its
+		 * config file)
+		 */
+		if (panic_timeout == 0)
+			panic_timeout = -1;
+	}
 	return NOTIFY_DONE;
 }
 
+static int __init parse_xen_legacy_crash(char *arg)
+{
+	xen_legacy_crash = true;
+	return 0;
+}
+early_param("xen_legacy_crash", parse_xen_legacy_crash);
+
 static struct notifier_block xen_panic_block = {
 	.notifier_call = xen_panic_event,
 	.priority = INT_MIN
-- 
2.17.1

