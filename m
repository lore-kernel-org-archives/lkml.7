Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72359C4360D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5210E222BF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391241AbfIZBeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 21:34:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388987AbfIZBea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:34:30 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8Q1Vqxa060174
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 21:34:29 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8hm7kxfu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 21:34:29 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Thu, 26 Sep 2019 02:34:27 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Sep 2019 02:34:24 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8Q1YOfM62128296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 01:34:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1A11AE051;
        Thu, 26 Sep 2019 01:34:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D6A9AE045;
        Thu, 26 Sep 2019 01:34:23 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Sep 2019 01:34:23 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2A085A0270;
        Thu, 26 Sep 2019 11:34:22 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] memory_hotplug: Add a bounds check to __add_pages
Date:   Thu, 26 Sep 2019 11:34:05 +1000
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926013406.16133-1-alastair@au1.ibm.com>
References: <20190926013406.16133-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19092601-0016-0000-0000-000002B0BE96
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092601-0017-0000-0000-0000331188F9
Message-Id: <20190926013406.16133-2-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909260016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

On PowerPC, the address ranges allocated to OpenCAPI LPC memory
are allocated from firmware. These address ranges may be higher
than what older kernels permit, as we increased the maximum
permissable address in commit 4ffe713b7587
("powerpc/mm: Increase the max addressable memory to 2PB"). It is
possible that the addressable range may change again in the
future.

In this scenario, we end up with a bogus section returned from
__section_nr (see the discussion on the thread "mm: Trigger bug on
if a section is not found in __section_nr").

Adding a check here means that we fail early and have an
opportunity to handle the error gracefully, rather than rumbling
on and potentially accessing an incorrect section.

Further discussion is also on the thread ("powerpc: Perform a bounds
check in arch_add_memory")
http://lkml.kernel.org/r/20190827052047.31547-1-alastair@au1.ibm.com

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 mm/memory_hotplug.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c73f09913165..212804c0f7f5 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -278,6 +278,22 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
 	return 0;
 }
 
+static int check_hotplug_memory_addressable(unsigned long pfn,
+					    unsigned long nr_pages)
+{
+	unsigned long max_addr = ((pfn + nr_pages) << PAGE_SHIFT) - 1;
+
+	if (max_addr >> MAX_PHYSMEM_BITS) {
+		WARN(1,
+		     "Hotplugged memory exceeds maximum addressable address, range=%#lx-%#lx, maximum=%#lx\n",
+		     pfn << PAGE_SHIFT, max_addr,
+		     (1ul << (MAX_PHYSMEM_BITS + 1)) - 1);
+		return -E2BIG;
+	}
+
+	return 0;
+}
+
 /*
  * Reasonably generic function for adding memory.  It is
  * expected that archs that support memory hotplug will
@@ -291,6 +307,10 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 	unsigned long nr, start_sec, end_sec;
 	struct vmem_altmap *altmap = restrictions->altmap;
 
+	err = check_hotplug_memory_addressable(pfn, nr_pages);
+	if (err)
+		return err;
+
 	if (altmap) {
 		/*
 		 * Validate altmap is within bounds of the total request
-- 
2.21.0

