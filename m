Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A28DECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0C62133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D7dJqcMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389493AbfJAPRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:17:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38908 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389175AbfJAPRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:17:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91FDk5A161443;
        Tue, 1 Oct 2019 15:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=Cl6NTVoaJaSBxqb2QcFNk13Sq3UWtVzalNOzurAnyF4=;
 b=D7dJqcMa/TH7rlsI4YA3nfkLmOEGuG6OjIc4axgqDw1FHCIBmQKLWjEzTOjp/DFTx6Eo
 ctOxQPyKguGydMvx2zKFl0zRbaMfIlpYe94hAsmOI5K38kdVUKxnqzNqLkUJ0+N4t2NS
 w68m/FwI73QiBcv+Kb6Qr+AQUFmyl889nJrPfFUOVAS3KX4EjrAt6YCxeYYKtRD3V106
 wi8geTLcDENErs6iwAZKvI8P+pSTCZyAko1Cmg4Y1osISuXFo5vHwVkDIYZ5q4RYGMmV
 aPWMSXidqQyOYB459e0fzrcJhIl25hNhTbSaU88pQ1wmIKnnBeIM3KcHGpATsOnEXTUe Xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2va05rpp81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 15:16:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91FEL6J127106;
        Tue, 1 Oct 2019 15:16:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vbmpysbdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 15:16:56 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x91FGs8p010956;
        Tue, 1 Oct 2019 15:16:55 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 08:16:54 -0700
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, james@dingwall.me.uk,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH] x86/xen: Return from panic notifier
Date:   Tue,  1 Oct 2019 11:16:33 -0400
Message-Id: <20191001151633.1659-1-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010137
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

Reported-by: James Dingwall <james@dingwall.me.uk>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/xen/enlighten.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 750f46ad018a..fd4f58cf51dc 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -269,16 +269,27 @@ void xen_reboot(int reason)
 		BUG();
 }
 
+static int reboot_reason = SHUTDOWN_reboot;
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
 
-- 
2.17.1

