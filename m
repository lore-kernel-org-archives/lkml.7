Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F6BC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F095620863
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfEUEw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:52:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726047AbfEUEw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 00:52:26 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L4qJGn037995
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:52:25 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sm8rakhhe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:52:25 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 21 May 2019 05:52:24 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 May 2019 05:52:21 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4L4qJrQ10158396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 04:52:19 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B2DDC6057;
        Tue, 21 May 2019 04:52:19 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67EFEC605A;
        Tue, 21 May 2019 04:52:03 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.80.203.157])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 21 May 2019 04:52:01 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Alexey Kardashevskiy <aik@linux.ibm.com>
Subject: [PATCH 05/12] powerpc/pseries: Add and use LPPACA_SIZE constant
Date:   Tue, 21 May 2019 01:49:05 -0300
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521044912.1375-1-bauerman@linux.ibm.com>
References: <20190521044912.1375-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052104-8235-0000-0000-00000E9C0A2F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011134; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01206343; UDB=6.00633450; IPR=6.00987310;
 MB=3.00026980; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-21 04:52:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052104-8236-0000-0000-000045A84ADE
Message-Id: <20190521044912.1375-6-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helps document what the hard-coded number means.

Also take the opportunity to fix an #endif comment.

Suggested-by: Alexey Kardashevskiy <aik@linux.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/kernel/paca.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 9cc91d03ab62..854105db5cff 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -56,6 +56,8 @@ static void *__init alloc_paca_data(unsigned long size, unsigned long align,
 
 #ifdef CONFIG_PPC_PSERIES
 
+#define LPPACA_SIZE 0x400
+
 /*
  * See asm/lppaca.h for more detail.
  *
@@ -69,7 +71,7 @@ static inline void init_lppaca(struct lppaca *lppaca)
 
 	*lppaca = (struct lppaca) {
 		.desc = cpu_to_be32(0xd397d781),	/* "LpPa" */
-		.size = cpu_to_be16(0x400),
+		.size = cpu_to_be16(LPPACA_SIZE),
 		.fpregs_in_use = 1,
 		.slb_count = cpu_to_be16(64),
 		.vmxregs_in_use = 0,
@@ -79,19 +81,18 @@ static inline void init_lppaca(struct lppaca *lppaca)
 static struct lppaca * __init new_lppaca(int cpu, unsigned long limit)
 {
 	struct lppaca *lp;
-	size_t size = 0x400;
 
-	BUILD_BUG_ON(size < sizeof(struct lppaca));
+	BUILD_BUG_ON(sizeof(struct lppaca) > LPPACA_SIZE);
 
 	if (early_cpu_has_feature(CPU_FTR_HVMODE))
 		return NULL;
 
-	lp = alloc_paca_data(size, 0x400, limit, cpu);
+	lp = alloc_paca_data(LPPACA_SIZE, 0x400, limit, cpu);
 	init_lppaca(lp);
 
 	return lp;
 }
-#endif /* CONFIG_PPC_BOOK3S */
+#endif /* CONFIG_PPC_PSERIES */
 
 #ifdef CONFIG_PPC_BOOK3S_64
 

