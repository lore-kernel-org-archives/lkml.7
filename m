Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67792C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE9320679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TxOpWlKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfFXDcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 23:32:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35815 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbfFXDcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:32:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5O3Spk8089796;
        Mon, 24 Jun 2019 03:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=A3YM+cC+Wq0vJZp4sQYiwht/JgO/4EqsOgjUe2E6whU=;
 b=TxOpWlKIsnVIPPJ5kkbrvBXIpgqsCreVVDXDNp4OmOfQMc37slpjNz1uOtLiLlDzWuqu
 +ohtQCwjzqAjnnnH7U6ytnTh0ZcepCtB9v21i60i9eeNfvCk7xkZoNgvpRJ9j21km0L0
 pDkQWMKTpu23rsuKD7OlIbtv/nL89oyNgqAvPaoQg9p6jLWHGAPSPL/YcAYGS7Is5XAw
 y0Yi+65kNHmKp3qQ6Dhp62zWQwfqe4vytQ4oArtVx7cDYx+ASkBClX4ycWqogwu6JCS3
 IM1kcg39neXmA0B+UMRNlLHibqDHOh+SNqoRNII583OBiCoBsDJccWxOTdT1U4mRIspw Cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t9brsuudb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 03:31:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5O3TnFJ082269;
        Mon, 24 Jun 2019 03:31:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t99f3201a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 03:31:44 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5O3Vb8g019004;
        Mon, 24 Jun 2019 03:31:39 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Jun 2019 20:31:37 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, jgross@suse.com, ndesaulniers@google.com,
        gregkh@linuxfoundation.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH] x86/speculation/mds: Avoid clearing CPU buffers in native machine with old microcode
Date:   Sun, 23 Jun 2019 11:35:03 +0800
Message-Id: <1561260904-29669-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=838
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=893 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 22dd8365088b ("x86/speculation/mds: Add mitigation mode VMWERV") add
an internal mitigation mode VWWERV which enables the invocation of the CPU
buffer clearing even if X86_FEATURE_MD_CLEAR is not set.

This wastes a few CPU cycles for native machine with an old microcode
unnecessorily. Avoid it by checking if it's running in native machine.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 arch/x86/kernel/cpu/bugs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 03b4cc0..03f5a77 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -233,7 +233,9 @@ static void x86_amd_ssb_disable(void)
 
 static void __init mds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off() ||
+	    (hypervisor_is_type(X86_HYPER_NATIVE) &&
+	    !boot_cpu_has(X86_FEATURE_MD_CLEAR))) {
 		mds_mitigation = MDS_MITIGATION_OFF;
 		return;
 	}
-- 
1.8.3.1

