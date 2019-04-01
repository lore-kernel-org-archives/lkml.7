Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6B4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B20020857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZxcC7JJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfDBIpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:45:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43706 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbfDBIo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:44:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x328i2rv070105;
        Tue, 2 Apr 2019 08:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=ji/XM5dm1WLBN99//7ktuoMOtCFoI8SPH+ls6j0gCTc=;
 b=ZxcC7JJhxKhBal1uNN+hu06kvQDSeCXrjtTSjfvkCGT18mBaZLkUp/qckxI7WxDlJf+x
 s0tDCEiLM2EEyFku8WMgPj915ymQP97Ts8dSjW2UzKsx5jjGLYkwBm+t+X7as3mB094P
 4aSUbxgyblhDK/F5e/oBmVEVE+CrpyiQJbzOsiA+2GbgTB0zFHg5EuJ/lIe0NykZICFm
 38lX/p9qvgS5ar/RWY8YospVLcvlb5ODivWtI8JcMej/tIm5VYSwP0aHJOtuXtgCX1fK
 BoVAt8vNbaJW71Hn8CfknOdSyrQSMaWZcakSUSFIzYz32dDPWdpG2Q3SvVFr6GEYpgl6 gw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2rj13q3nf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 08:44:32 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x328iVpZ020046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 08:44:31 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x328iVQY014492;
        Tue, 2 Apr 2019 08:44:31 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Apr 2019 01:44:31 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: [PATCH] x86/microcode: Remove useless code after early microcode support added
Date:   Mon,  1 Apr 2019 16:46:52 +0800
Message-Id: <1554108412-22229-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9214 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904020064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After early microcode update was added, microcode couldn't be configured
as a module, microcode update happens at early bootup and cpu hotplug
stage. This made the microcode update code in module loading stage
useless.

This patch remove the useless code.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Srinivas Eeda <srinivas.eeda@oracle.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 5260185..7f05bcb 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -710,10 +710,6 @@ static enum ucode_state microcode_init_cpu(int cpu, bool refresh_fw)
 	if (collect_cpu_info(cpu))
 		return UCODE_ERROR;
 
-	/* --dimm. Trigger a delayed update? */
-	if (system_state != SYSTEM_RUNNING)
-		return UCODE_NFOUND;
-
 	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, refresh_fw);
 	if (ustate == UCODE_NEW) {
 		pr_debug("CPU%d updated upon init\n", cpu);
@@ -738,21 +734,14 @@ static enum ucode_state microcode_update_cpu(int cpu)
 
 static int mc_device_add(struct device *dev, struct subsys_interface *sif)
 {
-	int err, cpu = dev->id;
+	int cpu = dev->id;
 
 	if (!cpu_online(cpu))
 		return 0;
 
 	pr_debug("CPU%d added\n", cpu);
 
-	err = sysfs_create_group(&dev->kobj, &mc_attr_group);
-	if (err)
-		return err;
-
-	if (microcode_init_cpu(cpu, true) == UCODE_ERROR)
-		return -EINVAL;
-
-	return err;
+	return sysfs_create_group(&dev->kobj, &mc_attr_group);
 }
 
 static void mc_device_remove(struct device *dev, struct subsys_interface *sif)
-- 
1.8.3.1

