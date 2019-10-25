Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B8ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 04:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DF821929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 04:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391021AbfJYEsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 00:48:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387990AbfJYEsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 00:48:53 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9P4lgDk097139
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 00:48:51 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vuqehvdbt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 00:48:51 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Fri, 25 Oct 2019 05:48:49 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Oct 2019 05:48:40 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9P4mdPE61210666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 04:48:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96CDB42047;
        Fri, 25 Oct 2019 04:48:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED78142041;
        Fri, 25 Oct 2019 04:48:38 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Oct 2019 04:48:38 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 41E23A0147;
        Fri, 25 Oct 2019 15:48:37 +1100 (AEDT)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: [PATCH 01/10] memory_hotplug: Add a bounds check to __add_pages
Date:   Fri, 25 Oct 2019 15:46:56 +1100
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025044721.16617-1-alastair@au1.ibm.com>
References: <20191025044721.16617-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102504-0016-0000-0000-000002BD3B45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102504-0017-0000-0000-0000331E830D
Message-Id: <20191025044721.16617-2-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250045
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
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index df570e5c71cc..2cecf07b396f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -278,6 +278,23 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
 	return 0;
 }
 
+static int check_hotplug_memory_addressable(unsigned long pfn,
+					    unsigned long nr_pages)
+{
+	const u64 max_addr = PFN_PHYS(pfn + nr_pages) - 1;
+
+	if (max_addr >> MAX_PHYSMEM_BITS) {
+		const u64 max_allowed = (1ull << (MAX_PHYSMEM_BITS + 1)) - 1;
+
+		WARN(1,
+		     "Hotplugged memory exceeds maximum addressable address, range=%#llx-%#llx, maximum=%#llx\n",
+		     PFN_PHYS(pfn), max_addr, max_allowed);
+		return -E2BIG;
+	}
+
+	return 0;
+}
+
 /*
  * Reasonably generic function for adding memory.  It is
  * expected that archs that support memory hotplug will
@@ -291,6 +308,10 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
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

