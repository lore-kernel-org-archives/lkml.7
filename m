Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ACAC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB9D217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfH0Fh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 01:37:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbfH0FhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 01:37:25 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7R5VvEU064756
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 01:37:24 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umu3059e2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 01:37:24 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Tue, 27 Aug 2019 06:37:21 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Aug 2019 06:37:18 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7R5bH8j48955528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 05:37:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D6814C046;
        Tue, 27 Aug 2019 05:37:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF0AF4C04A;
        Tue, 27 Aug 2019 05:37:16 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Aug 2019 05:37:16 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A2235A0300;
        Tue, 27 Aug 2019 15:37:15 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, Qian Cai <cai@lca.pw>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: don't hide potentially null memmap pointer in sparse_remove_section
Date:   Tue, 27 Aug 2019 15:36:55 +1000
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827053656.32191-1-alastair@au1.ibm.com>
References: <20190827053656.32191-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19082705-0016-0000-0000-000002A35CF4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082705-0017-0000-0000-00003303A5D6
Message-Id: <20190827053656.32191-3-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=838 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908270062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

By adding offset to memmap before passing it in to clear_hwpoisoned_pages,
we hide a theoretically null memmap from the null check inside
clear_hwpoisoned_pages.

This patch passes the offset to clear_hwpoisoned_pages instead, allowing
memmap to successfully perform it's null check.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 mm/sparse.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index e41917a7e844..3ff84e627e58 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -882,7 +882,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 }
 
 #ifdef CONFIG_MEMORY_FAILURE
-static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
+static void clear_hwpoisoned_pages(struct page *memmap, int start, int count)
 {
 	int i;
 
@@ -898,7 +898,7 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 	if (atomic_long_read(&num_poisoned_pages) == 0)
 		return;
 
-	for (i = 0; i < nr_pages; i++) {
+	for (i = start; i < start + count; i++) {
 		if (PageHWPoison(&memmap[i])) {
 			num_poisoned_pages_dec();
 			ClearPageHWPoison(&memmap[i]);
@@ -906,7 +906,8 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 	}
 }
 #else
-static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
+static inline void clear_hwpoisoned_pages(struct page *memmap, int start,
+		int count)
 {
 }
 #endif
@@ -915,7 +916,7 @@ void sparse_remove_section(struct mem_section *ms, unsigned long pfn,
 		unsigned long nr_pages, unsigned long map_offset,
 		struct vmem_altmap *altmap)
 {
-	clear_hwpoisoned_pages(pfn_to_page(pfn) + map_offset,
+	clear_hwpoisoned_pages(pfn_to_page(pfn), map_offset,
 			nr_pages - map_offset);
 	section_deactivate(pfn, nr_pages, altmap);
 }
-- 
2.21.0

