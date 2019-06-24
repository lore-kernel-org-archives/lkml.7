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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE35C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FCD21670
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EERSTOpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbfFYMBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:01:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55484 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfFYMBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:01:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PBwcBb132878;
        Tue, 25 Jun 2019 11:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=hUQwZ/Yt5oMGyNid41BWKaqAulxyvbzq7M/4Y2XpoHI=;
 b=EERSTOpWa9xrrpTInBtn/ArkzEul+heFi0ub7jRdysEG8UOI/I6M9bJm33G27ESaiILC
 ZiUjGnF8CFiOspcraJI2Pw5SkCmPGMvlUeAW0DTjjKclDs481WCH6F0GfY0esT0wPONi
 MBs4+5wGmMVEaJ1BLLNoWpULlPTAiiauzt/zaIHyioiPyB7obEQYeUbcdqi4Hp65xP62
 wuMQnzksSnyyNH4ttH8zr7amPiVI+5rUpmTr/F6nZ/FU7P3KglRTjiWkYGuccEV5KtXt
 AcgBySGTzwRrIHnHzKlilLyk6KHJyzZ4IilvMQLyZ6RoISHiyEQjvLCDP9r3aeXuXamG Mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2t9c9pkv5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 11:59:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PBwiOM130304;
        Tue, 25 Jun 2019 11:59:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t9p6u5143-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 11:59:58 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5PBxsgP012043;
        Tue, 25 Jun 2019 11:59:54 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 04:59:54 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, peterz@infradead.org,
        srinivas.eeda@oracle.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Ingo Molnar <mingo@redhat.com>, jailhouse-dev@googlegroups.com
Subject: [PATCH v2 2/7] x86/jailhouse: Mark jailhouse_x2apic_available as __init
Date:   Mon, 24 Jun 2019 20:02:54 +0800
Message-Id: <1561377779-28036-3-git-send-email-zhenzhong.duan@oracle.com>
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

