Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B86ECA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 03:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B1D20862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 03:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfJaDyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 23:54:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726465AbfJaDyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 23:54:52 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9V3pZiw134105
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 23:54:51 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vyhywafu9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 23:54:50 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 31 Oct 2019 03:54:48 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Oct 2019 03:54:47 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9V3skxF46268646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 03:54:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1524C4C040;
        Thu, 31 Oct 2019 03:54:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 250B64C046;
        Thu, 31 Oct 2019 03:54:45 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.85.201.217])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Oct 2019 03:54:45 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] x86/ima: update IMA arch policy to support appended signatures
Date:   Wed, 30 Oct 2019 23:54:42 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19103103-0008-0000-0000-00000329563D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19103103-0009-0000-0000-00004A489F65
Message-Id: <1572494082-9208-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-31_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910310036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that IMA supports appended file signatures, this patch updates
the architecture specific kernel module rules to allow either
appended signatures or the original IMA signature stored as an
xattr.  The associated measurement rule template format is updated
as well.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 arch/x86/kernel/ima_arch.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index 4d4f5d9faac3..a58cf33d4386 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -78,10 +78,15 @@ static const char * const sb_arch_rules[] = {
 	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
 #endif /* CONFIG_KEXEC_SIG */
 	"measure func=KEXEC_KERNEL_CHECK",
-#if !IS_ENABLED(CONFIG_MODULE_SIG)
+#if !IS_ENABLED(CONFIG_MODULE_SIG_FORCE) && IS_ENABLED(CONFIG_MODULE_SIG)
+	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
+	"measure func=MODULE_CHECK template=ima-modsig",
+#elif !IS_ENABLED(CONFIG_MODULE_SIG)
 	"appraise func=MODULE_CHECK appraise_type=imasig",
-#endif
 	"measure func=MODULE_CHECK",
+#else
+	"measure func=MODULE_CHECK",
+#endif
 	NULL
 };
 
-- 
2.7.5

