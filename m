Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A28C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D7F21951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YoaPlEPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389246AbfGYCjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 22:39:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52414 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389231AbfGYCjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:39:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P2d6IF144674;
        Thu, 25 Jul 2019 02:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=DoOlx7Bs8FWXcpT9rGgF3z2qAmuOUqP4xx6Szs32ofE=;
 b=YoaPlEPHQ0GAkXTDvnkBBp5WEhIr9KlWZGHsXtADch114Kx2Hyhq8QGqnQEL26dKbosy
 KyZEEQFMvogIvkooclwfIP/SmiDnCdGblvAyaE/aVpOluEUevuXb36MwB8wChzqqLuLR
 9v/i099w+/vzvLcVT5PfEsvtBVxVuHyBPMNalasQU/yrS0/wyqOQE8mnoRQfqZBv129x
 V2xW7OcNBxIC+sHKOd9vyPjtAx1oqGM+dhUHRqNBolKMNtwUg5SvPJhDQRAHcyr96V/S
 zRuCHo6qVazZ/ozWBgK0AShE7ibTBCP7kly6qsuioOb3zMqfj2ejKuuRQaWK4OQcJT2T TQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2tx61c0v6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 02:39:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P2cDUd172489;
        Thu, 25 Jul 2019 02:39:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2tx60xj3g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 02:39:19 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6P2dHnm017163;
        Thu, 25 Jul 2019 02:39:17 GMT
Received: from z2.cn.oracle.com (/10.182.71.205)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jul 2019 19:39:16 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH] x86/speculation/mds: Apply more accurate check on hypervisor platform
Date:   Thu, 25 Jul 2019 10:39:09 +0800
Message-Id: <1564022349-17338-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907250029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907250029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X86_HYPER_NATIVE isn't accurate for checking if running on native
platform, e.g. CONFIG_HYPERVISOR_GUEST isn't set or "nopv" is enabled.

Checking cpu flag X86_FEATURE_HYPERVISOR to determine if it's running
on native platform is more accurate.

This still doesn't consider the old platform where even
X86_FEATURE_HYPERVISOR is unsupported, e.g. vmware.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 66ca906..801ecd1 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1226,7 +1226,7 @@ static ssize_t l1tf_show_state(char *buf)
 
 static ssize_t mds_show_state(char *buf)
 {
-	if (!hypervisor_is_type(X86_HYPER_NATIVE)) {
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
 		return sprintf(buf, "%s; SMT Host state unknown\n",
 			       mds_strings[mds_mitigation]);
 	}
-- 
1.8.3.1

