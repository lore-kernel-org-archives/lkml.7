Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306C7C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF7021744
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbfHOIfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:35:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731070AbfHOIfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:35:43 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7F8WRFn049913
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 04:35:42 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ucybwqwxq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 04:35:42 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 15 Aug 2019 09:35:40 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 15 Aug 2019 09:35:37 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7F8ZaGx57344044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 08:35:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E298A4040;
        Thu, 15 Aug 2019 08:35:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02409A404D;
        Thu, 15 Aug 2019 08:35:35 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.59])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 15 Aug 2019 08:35:34 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 15 Aug 2019 11:35:34 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Richard Kuo <rkuo@codeaurora.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] hexagon: drop empty and unused free_initrd_mem
Date:   Thu, 15 Aug 2019 11:35:33 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19081508-0016-0000-0000-0000029EFDD6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081508-0017-0000-0000-000032FF1B5B
Message-Id: <1565858133-25852-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-15_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=881 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hexagon never reserves or initializes initrd and the only mention of it is
the empty free_initrd_mem() function.

As we have a generic implementation of free_initrd_mem(), there is no need
to define an empty stub for the hexagon implementation and it can be
dropped.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/hexagon/mm/init.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index f1f6ebd..c961773 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -71,19 +71,6 @@ void __init mem_init(void)
 	init_mm.context.ptbase = __pa(init_mm.pgd);
 }
 
-/*
- * free_initrd_mem - frees...  initrd memory.
- * @start - start of init memory
- * @end - end of init memory
- *
- * Apparently has to be passed the address of the initrd memory.
- *
- * Wrapped by #ifdef CONFIG_BLKDEV_INITRD
- */
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-}
-
 void sync_icache_dcache(pte_t pte)
 {
 	unsigned long addr;
-- 
2.7.4

