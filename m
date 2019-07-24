Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E096CC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C195421BF6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387537AbfGXOLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:11:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727358AbfGXOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:11:04 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6OE7J8H013736
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:11:03 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2txrpy8nx4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:11:03 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 24 Jul 2019 15:11:01 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Jul 2019 15:10:58 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6OEAvcY58458190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 14:10:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FFA4A4089;
        Wed, 24 Jul 2019 14:10:56 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23D54A4059;
        Wed, 24 Jul 2019 14:10:55 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.168])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Jul 2019 14:10:55 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 24 Jul 2019 17:10:54 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] xtensa: remove free_initrd_mem
Date:   Wed, 24 Jul 2019 17:10:32 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19072414-4275-0000-0000-000003502593
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072414-4276-0000-0000-000038604E10
Message-Id: <1563977432-8376-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-24_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=810 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907240158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xtensa free_initrd_mem() verifies that initrd is mapped and then
frees its memory using free_reserved_area().

The initrd is considered mapped when its memory was successfully reserved
with mem_reserve().

Resetting initrd_start to 0 in case of mem_reserve() failure allows to
switch to generic free_initrd_mem() implementation.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/xtensa/kernel/setup.c |  9 +++------
 arch/xtensa/mm/init.c      | 10 ----------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 5cb8a62..63c865b 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -61,7 +61,6 @@ struct screen_info screen_info = {
 #ifdef CONFIG_BLK_DEV_INITRD
 extern unsigned long initrd_start;
 extern unsigned long initrd_end;
-int initrd_is_mapped = 0;
 extern int initrd_below_start_ok;
 #endif
 
@@ -332,13 +331,11 @@ void __init setup_arch(char **cmdline_p)
 	/* Reserve some memory regions */
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start < initrd_end) {
-		initrd_is_mapped = mem_reserve(__pa(initrd_start),
-					       __pa(initrd_end)) == 0;
+	if (initrd_start < initrd_end &&
+	    !mem_reserve(__pa(initrd_start), __pa(initrd_end)))
 		initrd_below_start_ok = 1;
-	} else {
+	else
 		initrd_start = 0;
-	}
 #endif
 
 	mem_reserve(__pa(_stext), __pa(_end));
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index 79467c7..d898ed6 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -203,16 +203,6 @@ void __init mem_init(void)
 		(unsigned long)(__bss_stop - __bss_start) >> 10);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern int initrd_is_mapped;
-
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	if (initrd_is_mapped)
-		free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 static void __init parse_memmap_one(char *p)
 {
 	char *oldp;
-- 
2.7.4

