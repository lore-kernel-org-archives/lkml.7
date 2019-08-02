Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A96C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193F420679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406601AbfHBNpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:45:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726340AbfHBNph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:45:37 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72Dgu0H069103;
        Fri, 2 Aug 2019 09:45:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u4p3r8kdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 09:45:01 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x72Dh5uF069804;
        Fri, 2 Aug 2019 09:44:54 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u4p3r8kc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 09:44:54 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x72De7aZ024476;
        Fri, 2 Aug 2019 13:44:53 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 2u0e874dkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 13:44:52 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x72DiqSw60096922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Aug 2019 13:44:52 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2290DBE051;
        Fri,  2 Aug 2019 13:44:52 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A41CBE053;
        Fri,  2 Aug 2019 13:44:49 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.18.235.147])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  2 Aug 2019 13:44:49 +0000 (GMT)
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/1] powerpc/pseries/hotplug-memory.c: Change rc variable to bool
Date:   Fri,  2 Aug 2019 10:39:15 -0300
Message-Id: <20190802133914.30413-1-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=945 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes the return variable to bool (as the return value) and
avoids doing a ternary operation before returning.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
Changes in v2:
  - Restore previous and-ing logic on rc.

 arch/powerpc/platforms/pseries/hotplug-memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 8e700390f3d6..c126b94d1943 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -338,7 +338,7 @@ static int pseries_remove_mem_node(struct device_node *np)
 static bool lmb_is_removable(struct drmem_lmb *lmb)
 {
 	int i, scns_per_block;
-	int rc = 1;
+	bool rc = true;
 	unsigned long pfn, block_sz;
 	u64 phys_addr;
 
@@ -363,11 +363,11 @@ static bool lmb_is_removable(struct drmem_lmb *lmb)
 		if (!pfn_present(pfn))
 			continue;
 
-		rc &= is_mem_section_removable(pfn, PAGES_PER_SECTION);
+		rc = rc && is_mem_section_removable(pfn, PAGES_PER_SECTION);
 		phys_addr += MIN_MEMORY_BLOCK_SIZE;
 	}
 
-	return rc ? true : false;
+	return rc;
 }
 
 static int dlpar_add_lmb(struct drmem_lmb *);
-- 
2.20.1

