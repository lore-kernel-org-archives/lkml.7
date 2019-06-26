Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF8DC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B56206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZYB9sYgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfF0Ivz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:51:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45104 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfF0Ivz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:51:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R8mXkR135289;
        Thu, 27 Jun 2019 08:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=hUQwZ/Yt5oMGyNid41BWKaqAulxyvbzq7M/4Y2XpoHI=;
 b=ZYB9sYgZOOFCztrCFxMC8qGlQ5LSAKsYLGJelomFVY5CLrtIw9OyoZ6JcTauvZMfBGDN
 Hp1RjODNXhs9MIlXqYYRNz+3GcSAq5BgJ8AaPM7MCD+nL6CRwEtNzCRW1MGBTbaWH7Py
 2uzNjEDz32AhZCpOqfwhI1eHh7HYsqqMr4DGw71L9xKVSWK61nxEhxt6vptCwVummh9i
 MR3KE0itrFqEZL4i7GnKvSsXPKgV7pTJSJwDqWCHf2y8QkebjiV5eV3M1rPlaMTdq1Hz
 mDwA+/W5fe/EeHMuXVzQvrj9w+yjr2J5i8/tX30xxkDl8g4kUMslANzLCU9ttM9QYGtc wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t9brtf2hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 08:51:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R8nTZK068444;
        Thu, 27 Jun 2019 08:51:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tat7d8qd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 08:51:10 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5R8p9Yk002066;
        Thu, 27 Jun 2019 08:51:09 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 01:51:09 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        jailhouse-dev@googlegroups.com
Subject: [PATCH RESEND] x86/jailhouse: Mark jailhouse_x2apic_available as __init
Date:   Wed, 26 Jun 2019 16:54:49 +0800
Message-Id: <1561539289-29180-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=910
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=966 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.. as they are only called at early bootup stage.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: jailhouse-dev@googlegroups.com
---
 arch/x86/kernel/jailhouse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 1b2ee55..d96d563 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -203,7 +203,7 @@ bool jailhouse_paravirt(void)
 	return jailhouse_cpuid_base() != 0;
 }
 
-static bool jailhouse_x2apic_available(void)
+static bool __init jailhouse_x2apic_available(void)
 {
 	/*
 	 * The x2APIC is only available if the root cell enabled it. Jailhouse
-- 
1.8.3.1

