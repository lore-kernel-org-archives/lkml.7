Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230A1C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EC521897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfH3MHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:07:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728155AbfH3MHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:07:23 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7UC348D083697
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:07:22 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uq0xcxdu1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:07:22 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.ibm.com>;
        Fri, 30 Aug 2019 13:07:20 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Aug 2019 13:07:17 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7UC7F0Z60686574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 12:07:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64B1842041;
        Fri, 30 Aug 2019 12:07:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 991B14204B;
        Fri, 30 Aug 2019 12:07:14 +0000 (GMT)
Received: from pomme.com (unknown [9.145.17.35])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Aug 2019 12:07:14 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        aneesh.kumar@linux.ibm.com, npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] powerpc/mm: Initialize the HPTE encoding values
Date:   Fri, 30 Aug 2019 14:07:10 +0200
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190830120712.22971-1-ldufour@linux.ibm.com>
References: <20190830120712.22971-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19083012-0012-0000-0000-00000344A064
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19083012-0013-0000-0000-0000217EE443
Message-Id: <20190830120712.22971-2-ldufour@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before reading the HPTE encoding values we initialize all of them to -1 (an
invalid value) to later being able to detect the initialized ones.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index c3bfef08dcf8..2039bc315459 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -408,7 +408,7 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 {
 	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
 	const __be32 *prop;
-	int size = 0;
+	int size = 0, idx, base_idx;
 
 	/* We are scanning "cpu" nodes only */
 	if (type == NULL || strcmp(type, "cpu") != 0)
@@ -418,6 +418,11 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 	if (!prop)
 		return 0;
 
+	/* Set all the penc values to invalid */
+	for (base_idx = 0; base_idx < MMU_PAGE_COUNT; base_idx++)
+		for (idx = 0; idx < MMU_PAGE_COUNT; idx++)
+			mmu_psize_defs[base_idx].penc[idx] = -1;
+
 	pr_info("Page sizes from device-tree:\n");
 	size /= 4;
 	cur_cpu_spec->mmu_features &= ~(MMU_FTR_16M_PAGE);
@@ -426,7 +431,6 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 		unsigned int slbenc = be32_to_cpu(prop[1]);
 		unsigned int lpnum = be32_to_cpu(prop[2]);
 		struct mmu_psize_def *def;
-		int idx, base_idx;
 
 		size -= 3; prop += 3;
 		base_idx = get_idx_from_shift(base_shift);
-- 
2.23.0

