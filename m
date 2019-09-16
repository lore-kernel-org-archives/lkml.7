Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61366C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 06:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEBD2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 06:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbfIPGIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 02:08:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32652 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729398AbfIPGIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 02:08:22 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8G67htq090655
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 02:08:18 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v0u12q98b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 02:08:17 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Mon, 16 Sep 2019 07:08:14 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Sep 2019 07:08:09 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8G688Rs42205210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 06:08:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F23542056;
        Mon, 16 Sep 2019 06:08:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEFA242049;
        Mon, 16 Sep 2019 06:08:07 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 Sep 2019 06:08:07 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 40AC8A01B5;
        Mon, 16 Sep 2019 16:08:06 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] memory_hotplug: Add a bounds check to check_hotplug_memory_range()
Date:   Mon, 16 Sep 2019 16:05:39 +1000
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916060544.21824-1-alastair@au1.ibm.com>
References: <20190916060544.21824-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091606-0028-0000-0000-0000039D63F7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091606-0029-0000-0000-0000245FD760
Message-Id: <20190916060544.21824-2-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909160067
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
check in arch_add_memory").

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 include/linux/memory_hotplug.h |  1 +
 mm/memory_hotplug.c            | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index f46ea71b4ffd..bc477e98a310 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -110,6 +110,7 @@ extern void __online_page_increment_counters(struct page *page);
 extern void __online_page_free(struct page *page);
 
 extern int try_online_node(int nid);
+int check_hotplug_memory_addressable(u64 start, u64 size);
 
 extern int arch_add_memory(int nid, u64 start, u64 size,
 			struct mhp_restrictions *restrictions);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c73f09913165..02cb9a74f561 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1030,6 +1030,17 @@ int try_online_node(int nid)
 	return ret;
 }
 
+int check_hotplug_memory_addressable(u64 start, u64 size)
+{
+#ifdef MAX_PHYSMEM_BITS
+	if ((start + size - 1) >> MAX_PHYSMEM_BITS)
+		return -E2BIG;
+#endif
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(check_hotplug_memory_addressable);
+
 static int check_hotplug_memory_range(u64 start, u64 size)
 {
 	/* memory range must be block size aligned */
@@ -1040,7 +1051,7 @@ static int check_hotplug_memory_range(u64 start, u64 size)
 		return -EINVAL;
 	}
 
-	return 0;
+	return check_hotplug_memory_addressable(start, size);
 }
 
 static int online_memory_block(struct memory_block *mem, void *arg)
-- 
2.21.0

