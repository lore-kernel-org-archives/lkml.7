Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805D8C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1D220651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEBVJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:09:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725962AbfEBVJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:09:22 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42L6hhM054525
        for <linux-kernel@vger.kernel.org>; Thu, 2 May 2019 17:09:21 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s871djh1r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 17:09:21 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gwalbon@linux.vnet.ibm.com>;
        Thu, 2 May 2019 22:09:20 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 22:09:15 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x42L9E1U13172758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 21:09:15 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D711DAC05E;
        Thu,  2 May 2019 21:09:14 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A79A8AC05B;
        Thu,  2 May 2019 21:09:14 +0000 (GMT)
Received: from localhost (unknown [9.86.229.253])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  2 May 2019 21:09:14 +0000 (GMT)
From:   Gustavo Walbon <gwalbon@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     gwalbon@linux.vnet.ibm.com, maurosr@linux.vnet.ibm.com,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        diana.craciun@nxp.com, msuchanek@suse.de, mikey@neuling.org,
        npiggin@gmail.com, leitao@debian.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix wrong message when RFI Flush is disable
Date:   Thu,  2 May 2019 18:09:07 -0300
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050221-0052-0000-0000-000003B73498
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011037; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01197667; UDB=6.00628187; IPR=6.00978522;
 MB=3.00026704; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-02 21:09:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050221-0053-0000-0000-000060BA5F91
Message-Id: <20190502210907.42375-1-gwalbon@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo L. F. Walbon" <gwalbon@linux.ibm.com>

The issue was showing "Mitigation" message via sysfs whatever the state of
"RFI Flush", but it should show "Vulnerable" when it is disabled.

If you have "L1D private" feature enabled and not "RFI Flush" you are
vulnerable to meltdown attacks.

"RFI Flush" is the key feature to mitigate the meltdown whatever the
"L1D private" state.

SEC_FTR_L1D_THREAD_PRIV is a feature for Power9 only.

So the message should be as the truth table shows.
CPU | L1D private | RFI Flush |                   sysfs               |
----| ----------- | --------- | ------------------------------------- |
 P9 |    False    |   False   | Vulnerable
 P9 |    False    |   True    | Mitigation: RFI Flush
 P9 |    True     |   False   | Vulnerable: L1D private per thread
 P9 |    True     |   True    | Mitigation: RFI Flush, L1D private per
    |             |           | thread
 P8 |    False    |   False   | Vulnerable
 P8 |    False    |   True    | Mitigation: RFI Flush

Output before this fix:
 # cat /sys/devices/system/cpu/vulnerabilities/meltdown
 Mitigation: RFI Flush, L1D private per thread
 # echo 0 > /sys/kernel/debug/powerpc/rfi_flush
 # cat /sys/devices/system/cpu/vulnerabilities/meltdown
 Mitigation: L1D private per thread

Output after fix:
 # cat /sys/devices/system/cpu/vulnerabilities/meltdown
 Mitigation: RFI Flush, L1D private per thread
 # echo 0 > /sys/kernel/debug/powerpc/rfi_flush
 # cat /sys/devices/system/cpu/vulnerabilities/meltdown
 Vulnerable: L1D private per thread

Link: https://github.com/linuxppc/issues/issues/243

Signed-off-by: Gustavo L. F. Walbon <gwalbon@linux.ibm.com>
Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/security.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index b33bafb8fcea..e08b81ef43b8 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -130,26 +130,22 @@ ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, cha
 
 	thread_priv = security_ftr_enabled(SEC_FTR_L1D_THREAD_PRIV);
 
-	if (rfi_flush || thread_priv) {
+	if (rfi_flush) {
 		struct seq_buf s;
 		seq_buf_init(&s, buf, PAGE_SIZE - 1);
 
-		seq_buf_printf(&s, "Mitigation: ");
-
-		if (rfi_flush)
-			seq_buf_printf(&s, "RFI Flush");
-
-		if (rfi_flush && thread_priv)
-			seq_buf_printf(&s, ", ");
-
+		seq_buf_printf(&s, "Mitigation: RFI Flush");
 		if (thread_priv)
-			seq_buf_printf(&s, "L1D private per thread");
+			seq_buf_printf(&s, ", L1D private per thread");
 
 		seq_buf_printf(&s, "\n");
 
 		return s.len;
 	}
 
+	if (thread_priv)
+		return sprintf(buf, "Vulnerable: L1D private per thread\n");
+
 	if (!security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV) &&
 	    !security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR))
 		return sprintf(buf, "Not affected\n");
-- 
2.19.1

