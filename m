Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0567AC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C6D2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfFRE1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 00:27:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725826AbfFRE1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 00:27:52 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5I4RKPV103642
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:27:51 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t6r1jspfw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:27:51 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 18 Jun 2019 05:27:49 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Jun 2019 05:27:46 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5I4RjFr10682474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 04:27:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D55C11C058;
        Tue, 18 Jun 2019 04:27:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5226A11C04A;
        Tue, 18 Jun 2019 04:27:42 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.63.86])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jun 2019 04:27:42 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, mikey@neuling.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, christophe.leroy@c-s.fr,
        naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 2/5] Powerpc/hw-breakpoint: Refactor hw_breakpoint_arch_parse()
Date:   Tue, 18 Jun 2019 09:57:29 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618042732.5582-1-ravi.bangoria@linux.ibm.com>
References: <20190618042732.5582-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061804-0028-0000-0000-0000037B2FD1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061804-0029-0000-0000-0000243B3757
Message-Id: <20190618042732.5582-3-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906180035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move feature availability check at the start of the function.
Rearrange comment to it's associated code. Use hw->address and
hw->len in the 512 bytes boundary check(to write if statement
in a single line). Add spacing between code blocks.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/kernel/hw_breakpoint.c | 34 +++++++++++++++--------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 1908e4fcc132..36bcf705df65 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -133,10 +133,13 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 			     const struct perf_event_attr *attr,
 			     struct arch_hw_breakpoint *hw)
 {
-	int ret = -EINVAL, length_max;
+	int length_max;
+
+	if (!ppc_breakpoint_available())
+		return -ENODEV;
 
 	if (!bp)
-		return ret;
+		return -EINVAL;
 
 	hw->type = HW_BRK_TYPE_TRANSLATE;
 	if (attr->bp_type & HW_BREAKPOINT_R)
@@ -145,34 +148,33 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 		hw->type |= HW_BRK_TYPE_WRITE;
 	if (hw->type == HW_BRK_TYPE_TRANSLATE)
 		/* must set alteast read or write */
-		return ret;
+		return -EINVAL;
+
 	if (!attr->exclude_user)
 		hw->type |= HW_BRK_TYPE_USER;
 	if (!attr->exclude_kernel)
 		hw->type |= HW_BRK_TYPE_KERNEL;
 	if (!attr->exclude_hv)
 		hw->type |= HW_BRK_TYPE_HYP;
+
 	hw->address = attr->bp_addr;
 	hw->len = attr->bp_len;
 
-	/*
-	 * Since breakpoint length can be a maximum of HW_BREAKPOINT_LEN(8)
-	 * and breakpoint addresses are aligned to nearest double-word
-	 * HW_BREAKPOINT_ALIGN by rounding off to the lower address, the
-	 * 'symbolsize' should satisfy the check below.
-	 */
-	if (!ppc_breakpoint_available())
-		return -ENODEV;
 	length_max = 8; /* DABR */
 	if (dawr_enabled()) {
 		length_max = 512 ; /* 64 doublewords */
-		/* DAWR region can't cross 512 boundary */
-		if ((attr->bp_addr >> 9) !=
-		    ((attr->bp_addr + attr->bp_len - 1) >> 9))
+		/* DAWR region can't cross 512 bytes boundary */
+		if ((hw->address >> 9) != ((hw->address + hw->len - 1) >> 9))
 			return -EINVAL;
 	}
-	if (hw->len >
-	    (length_max - (hw->address & HW_BREAKPOINT_ALIGN)))
+
+	/*
+	 * Since breakpoint length can be a maximum of length_max and
+	 * breakpoint addresses are aligned to nearest double-word
+	 * HW_BREAKPOINT_ALIGN by rounding off to the lower address,
+	 * the 'symbolsize' should satisfy the check below.
+	 */
+	if (hw->len > (length_max - (hw->address & HW_BREAKPOINT_ALIGN)))
 		return -EINVAL;
 	return 0;
 }
-- 
2.20.1

