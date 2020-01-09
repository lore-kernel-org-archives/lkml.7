Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5969C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C619120673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgAIJVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:21:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729297AbgAIJVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:21:00 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0099DuY4014472
        for <linux-kernel@vger.kernel.org>; Thu, 9 Jan 2020 04:20:59 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xdv9t9ybn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 04:20:59 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bharata@linux.ibm.com>;
        Thu, 9 Jan 2020 09:20:57 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Jan 2020 09:20:55 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0099Ksag47906838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jan 2020 09:20:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A69CA4059;
        Thu,  9 Jan 2020 09:20:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC9BCA4051;
        Thu,  9 Jan 2020 09:20:52 +0000 (GMT)
Received: from bharata.in.ibm.com (unknown [9.124.35.110])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jan 2020 09:20:52 +0000 (GMT)
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     paulus@au1.ibm.com, cclaudio@linux.ibm.com, linuxram@us.ibm.com,
        sukadev@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.ibm.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] powerpc: Ultravisor: Fix the dependencies for CONFIG_PPC_UV
Date:   Thu,  9 Jan 2020 14:50:47 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010909-0028-0000-0000-000003CF9448
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010909-0029-0000-0000-00002493A933
Message-Id: <20200109092047.24043-1-bharata@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-08,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let PPC_UV depend only on DEVICE_PRIVATE which in turn
will satisfy all the other required dependencies

Fixes: 013a53f2d25a ("powerpc: Ultravisor: Add PPC_UV config option")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 arch/powerpc/Kconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1ec34e16ed65..e2a412113359 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -455,11 +455,7 @@ config PPC_TRANSACTIONAL_MEM
 config PPC_UV
 	bool "Ultravisor support"
 	depends on KVM_BOOK3S_HV_POSSIBLE
-	select ZONE_DEVICE
-	select DEV_PAGEMAP_OPS
-	select DEVICE_PRIVATE
-	select MEMORY_HOTPLUG
-	select MEMORY_HOTREMOVE
+	depends on DEVICE_PRIVATE
 	default n
 	help
 	  This option paravirtualizes the kernel to run in POWER platforms that
-- 
2.21.0

