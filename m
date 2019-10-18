Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76CECA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9416520820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sjRzD+Gd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442084AbfJRFzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:55:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52746 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfJRFzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:55:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I3ieGR179119;
        Fri, 18 Oct 2019 03:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=oEQUIfo7AVvAUyWjcHqWo9vpZdzmoQJUFPQ9HRPDZF8=;
 b=sjRzD+GdAvTM5ClBJPlb4ur6Zax2NB8Zecn2BqrVLxi/WyAyGnRJHVCgDhJql+wrZN9S
 ywtcpKpl7K4BCmlHtmfaoK/em1SnnR0B3whJjkCpcMQDNwsRH9InJBQ88YpL0qSJbe1B
 SS29WhQDZo2OnIPiK1lF2221GAEWORJvPV+kPZmknEZ9S35FRzeoGCkRDTIQM+4U+tFX
 VMp/wsyHWXy2fMODbyCpEOXgpqP1KXBGwvgka8TQvQHimpafuO7dchq75BkaG5vTFWZ8
 D0C1ZHf6PRivow8Wa2JCZtlErrxxAFyikuXv5L+CpljwTCaWaZkoQBoUM9eTfq2RqIVq Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vq0q412t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 03:46:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I3hpff069398;
        Fri, 18 Oct 2019 03:46:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vq0evbatx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 03:46:03 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9I3jvLR003616;
        Fri, 18 Oct 2019 03:45:58 GMT
Received: from z2.cn.oracle.com (/10.182.70.159)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Oct 2019 03:45:57 +0000
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tim.c.chen@linux.intel.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH] x86: Don't use MWAIT if explicitly requested
Date:   Fri, 18 Oct 2019 11:45:54 +0800
Message-Id: <1571370354-17736-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'idle=nomwait' is specified or process matching what's in
processor_idle_dmi_table, we should't use MWAIT at bootup stage before
cpuidle driver loaded, even if it's preferred by default on Intel.

Add a check so that HALT instruction is used in those cases.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/kernel/process.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5e94c43..37fc577 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -667,6 +667,10 @@ static void amd_e400_idle(void)
  */
 static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 {
+	/* Don't use MWAIT-C1 if explicitly requested */
+	if (boot_option_idle_override == IDLE_NOMWAIT)
+		return 0;
+
 	if (c->x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-- 
1.8.3.1

