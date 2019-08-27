Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B5BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EEF21872
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfH0Fh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 01:37:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725811AbfH0Fh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 01:37:26 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7R5Zrg1025873
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 01:37:24 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umxgv016y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 01:37:24 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Tue, 27 Aug 2019 06:37:22 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Aug 2019 06:37:17 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7R5bGdc59703372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 05:37:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91858A405C;
        Tue, 27 Aug 2019 05:37:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EDFDA405F;
        Tue, 27 Aug 2019 05:37:16 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Aug 2019 05:37:16 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 63EB5A0279;
        Tue, 27 Aug 2019 15:37:14 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Qian Cai <cai@lca.pw>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: Don't manually decrement num_poisoned_pages
Date:   Tue, 27 Aug 2019 15:36:54 +1000
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827053656.32191-1-alastair@au1.ibm.com>
References: <20190827053656.32191-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19082705-0028-0000-0000-000003945B8A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082705-0029-0000-0000-000024569280
Message-Id: <20190827053656.32191-2-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=785 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908270062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

Use the function written to do it instead.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 mm/sparse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 72f010d9bff5..e41917a7e844 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -11,6 +11,8 @@
 #include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 
 #include "internal.h"
 #include <asm/dma.h>
@@ -898,7 +900,7 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 
 	for (i = 0; i < nr_pages; i++) {
 		if (PageHWPoison(&memmap[i])) {
-			atomic_long_sub(1, &num_poisoned_pages);
+			num_poisoned_pages_dec();
 			ClearPageHWPoison(&memmap[i]);
 		}
 	}
-- 
2.21.0

