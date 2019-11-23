Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5204C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 23:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF6220679
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 23:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKWXDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 18:03:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10290 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726638AbfKWXDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 18:03:45 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xANN1wke104948;
        Sat, 23 Nov 2019 18:02:57 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wf0f59j7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Nov 2019 18:02:57 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xANN20J7105051;
        Sat, 23 Nov 2019 18:02:57 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wf0f59j75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Nov 2019 18:02:57 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xANN0KNF030698;
        Sat, 23 Nov 2019 23:02:56 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma05wdc.us.ibm.com with ESMTP id 2wevd6621f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Nov 2019 23:02:56 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xANN2tB346203274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Nov 2019 23:02:55 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB582112062;
        Sat, 23 Nov 2019 23:02:55 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B2F1112063;
        Sat, 23 Nov 2019 23:02:55 +0000 (GMT)
Received: from localhost (unknown [9.80.195.219])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 23 Nov 2019 23:02:55 +0000 (GMT)
From:   Gustavo Walbon <gwalbon@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        diana.craciun@nxp.com, gwalbon@linux.ibm.com, jkosina@suse.cz,
        jpoimboe@redhat.com, geert+renesas@glider.be, cmr@informatik.wtf,
        yuehaibing@huawei.com, linux-kernel@vger.kernel.org,
        maurosr@linux.ibm.com
Subject: [PATCH][v2] powerpc: Set right value of Speculation_Store_Bypass in /proc/<pid>/status
Date:   Sat, 23 Nov 2019 20:02:35 -0300
Message-Id: <20191123230235.11888-1-gwalbon@linux.ibm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-23_05:2019-11-21,2019-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1011 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911230198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue has showed the value of status of Speculation_Store_Bypass in the
/proc/<pid>/status as `unknown` for PowerPC systems.

The patch fix the checking of the mitigation status of Speculation, and
can be reported as "not vulnerable", "globally mitigated" or "vulnerable".

Link: https://github.com/linuxppc/issues/issues/255

Changelog:
Rebase on v5.4-rc8

Signed-off-by: Gustavo Walbon <gwalbon@linux.ibm.com>
---
 arch/powerpc/kernel/security.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 7d4b2080a658..04e566026bbc 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -14,7 +14,7 @@
 #include <asm/debugfs.h>
 #include <asm/security_features.h>
 #include <asm/setup.h>
-
+#include <linux/prctl.h>
 
 u64 powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
 
@@ -344,6 +344,29 @@ ssize_t cpu_show_spec_store_bypass(struct device *dev, struct device_attribute *
 	return sprintf(buf, "Vulnerable\n");
 }
 
+static int ssb_prctl_get(struct task_struct *task)
+{
+	if (stf_barrier) {
+		if (stf_enabled_flush_types == STF_BARRIER_NONE)
+			return PR_SPEC_NOT_AFFECTED;
+		else
+			return PR_SPEC_DISABLE;
+	} else
+		return PR_SPEC_DISABLE_NOEXEC;
+
+	return -EINVAL;
+}
+
+int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
+{
+	switch (which) {
+	case PR_SPEC_STORE_BYPASS:
+		return ssb_prctl_get(task);
+	default:
+		return -ENODEV;
+	}
+}
+
 #ifdef CONFIG_DEBUG_FS
 static int stf_barrier_set(void *data, u64 val)
 {
-- 
2.19.1

