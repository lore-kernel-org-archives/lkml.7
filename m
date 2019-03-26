Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3699C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A4420856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbfCZNfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:35:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731640AbfCZNf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:35:29 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QDZFBh073642
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:35:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfm7gk0a6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:35:27 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 26 Mar 2019 13:35:23 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 13:35:19 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QDZI0b61538350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 13:35:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78BC911C04C;
        Tue, 26 Mar 2019 13:35:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FE6B11C04A;
        Tue, 26 Mar 2019 13:35:17 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.109.68])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 13:35:16 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v5 8/9] selftests/kexec: check kexec_load and kexec_file_load are enabled
Date:   Tue, 26 Mar 2019 09:34:16 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
References: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032613-0016-0000-0000-000002674FDA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032613-0017-0000-0000-000032C285D9
Message-Id: <1553607257-18906-9-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip the kexec_load and kexec_file_load tests, if they aren't configured
in the kernel.  This change adds a new requirement that ikconfig is
configured in the kexec_load test.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tools/testing/selftests/kexec/test_kexec_file_load.sh | 5 +++++
 tools/testing/selftests/kexec/test_kexec_load.sh      | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
index 4603282dd8b6..fa7c24e8eefb 100755
--- a/tools/testing/selftests/kexec/test_kexec_file_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
@@ -163,6 +163,11 @@ require_root_privileges
 # get the kernel config
 get_kconfig
 
+kconfig_enabled "CONFIG_KEXEC_FILE=y" "kexec_file_load is enabled"
+if [ $? -eq 0 ]; then
+	log_skip "kexec_file_load is not enabled"
+fi
+
 # Determine which kernel config options are enabled
 kconfig_enabled "CONFIG_IMA_APPRAISE=y" "IMA enabled"
 ima_appraise=$?
diff --git a/tools/testing/selftests/kexec/test_kexec_load.sh b/tools/testing/selftests/kexec/test_kexec_load.sh
index afd440ee23cb..2a66c8897f55 100755
--- a/tools/testing/selftests/kexec/test_kexec_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_load.sh
@@ -10,6 +10,14 @@ TEST="$0"
 # kexec requires root privileges
 require_root_privileges
 
+# get the kernel config
+get_kconfig
+
+kconfig_enabled "CONFIG_KEXEC=y" "kexec_load is enabled"
+if [ $? -eq 0 ]; then
+	log_skip "kexec_load is not enabled"
+fi
+
 get_secureboot_mode
 secureboot=$?
 
-- 
2.7.5

