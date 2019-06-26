Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD86C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2D72146E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfFZGLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:11:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726648AbfFZGLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:11:48 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5Q67Irs164092
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 02:11:46 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tc19bbnus-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 02:11:46 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Wed, 26 Jun 2019 07:11:45 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Jun 2019 07:11:41 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5Q6BUwO37028112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 06:11:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 304F742041;
        Wed, 26 Jun 2019 06:11:40 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D07E94204B;
        Wed, 26 Jun 2019 06:11:39 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jun 2019 06:11:39 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B9ADCA0283;
        Wed, 26 Jun 2019 16:11:38 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, Qian Cai <cai@lca.pw>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 2/3] mm: don't hide potentially null memmap pointer in sparse_remove_one_section
Date:   Wed, 26 Jun 2019 16:11:22 +1000
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626061124.16013-1-alastair@au1.ibm.com>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062606-0008-0000-0000-000002F7145B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062606-0009-0000-0000-0000226447BA
Message-Id: <20190626061124.16013-3-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=626 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

By adding offset to memmap before passing it in to clear_hwpoisoned_pages,
we hide a potentially null memmap from the null check inside
clear_hwpoisoned_pages.

This patch passes the offset to clear_hwpoisoned_pages instead, allowing
memmap to successfully peform it's null check.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 mm/sparse.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 57a1a3d9c1cf..1ec32aef5590 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -753,7 +753,8 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
 #ifdef CONFIG_MEMORY_FAILURE
-static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
+static void clear_hwpoisoned_pages(struct page *memmap,
+		unsigned long start, unsigned long count)
 {
 	int i;
 
@@ -769,7 +770,7 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 	if (atomic_long_read(&num_poisoned_pages) == 0)
 		return;
 
-	for (i = 0; i < nr_pages; i++) {
+	for (i = start; i < start + count; i++) {
 		if (PageHWPoison(&memmap[i])) {
 			atomic_long_sub(1, &num_poisoned_pages);
 			ClearPageHWPoison(&memmap[i]);
@@ -777,7 +778,8 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 	}
 }
 #else
-static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
+static inline void clear_hwpoisoned_pages(struct page *memmap,
+		unsigned long start, unsigned long count)
 {
 }
 #endif
@@ -824,7 +826,7 @@ void sparse_remove_one_section(struct zone *zone, struct mem_section *ms,
 		ms->pageblock_flags = NULL;
 	}
 
-	clear_hwpoisoned_pages(memmap + map_offset,
+	clear_hwpoisoned_pages(memmap, map_offset,
 			PAGES_PER_SECTION - map_offset);
 	free_section_usemap(memmap, usemap, altmap);
 }
-- 
2.21.0

