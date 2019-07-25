Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7A3C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D142C22387
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b/vgNDFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389265AbfGYCkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 22:40:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44706 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389231AbfGYCkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:40:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P2dANN060256;
        Thu, 25 Jul 2019 02:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=X4pW0WBzhMJy4dgkexPh9ckOKMeErig/SG1EBztU1FM=;
 b=b/vgNDFH29B2+JKpLyhJ9tvs3j3Py6ijhmWHFh5NHDuKd9Ho0Cycv/uPDbakmuJUKTFr
 YTjckC8wVE9Hc7MosV7oDL+tDd6DsGy5Jck+ARTohaYa08PC2+aQljQSVAC73lPE/Bdq
 M5d2/ZGPRgSwDFZ0Tl1dV4xoTUvINiN5deMqOePUfFppgJCeaKfbJ7NfZngSKBRWja7B
 YKaoZ7ZJQ3CGkt+WoED2Gw2wJNmR99dz54Uc2CWt5bHQ1xxZw7FsN1c5ZEJ0wnz0qjRv
 pYsD2neDBWB4pS9bhkCvaevjC9PL3WtHVI1MylUwTOFrTGGHSSjdvJVrBiEXV0uQwWIF OA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2tx61c0uqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 02:39:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P2cA27058177;
        Thu, 25 Jul 2019 02:39:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2tx60y23k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 02:39:38 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6P2dZ1F021491;
        Thu, 25 Jul 2019 02:39:36 GMT
Received: from z2.cn.oracle.com (/10.182.71.205)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jul 2019 19:39:35 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH] perf/x86: Apply more accurate check on hypervisor platform
Date:   Thu, 25 Jul 2019 10:39:26 +0800
Message-Id: <1564022366-18293-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907250029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907250029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_msr is used to fix a bug report in guest where KVM doesn't support
LBR MSR and cause #GP.

The msr check is bypassed on real HW to workaround a false failure,
see commit d0e1a507bdc7 ("perf/x86/intel: Disable check_msr for real HW")

When running a guest with CONFIG_HYPERVISOR_GUEST not set or "nopv"
enabled, current check isn't enough and #GP could trigger.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/events/intel/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9e911a9..86f3656 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -20,7 +20,6 @@
 #include <asm/intel-family.h>
 #include <asm/apic.h>
 #include <asm/cpu_device_id.h>
-#include <asm/hypervisor.h>
 
 #include "../perf_event.h"
 
@@ -4053,7 +4052,7 @@ static bool check_msr(unsigned long msr, u64 mask)
 	 * Disable the check for real HW, so we don't
 	 * mess with potentionaly enabled registers:
 	 */
-	if (hypervisor_is_type(X86_HYPER_NATIVE))
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return true;
 
 	/*
-- 
1.8.3.1

