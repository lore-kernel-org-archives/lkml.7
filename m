Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4951BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F5D21019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfCNSmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:42:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727859AbfCNSmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:42:08 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2EIfRBo110746
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 14:42:07 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r7stgyu51-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 14:42:06 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 14 Mar 2019 18:42:05 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Mar 2019 18:42:01 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2EIg0LW43122808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Mar 2019 18:42:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FAF542042;
        Thu, 14 Mar 2019 18:42:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0CF142045;
        Thu, 14 Mar 2019 18:41:59 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.108.186])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Mar 2019 18:41:59 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v4 4/8] selftests/kexec: define common logging functions
Date:   Thu, 14 Mar 2019 14:41:12 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1552588876-28481-1-git-send-email-zohar@linux.ibm.com>
References: <1552588876-28481-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19031418-0008-0000-0000-000002CD62F5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031418-0009-0000-0000-0000223966DC
Message-Id: <1552588876-28481-5-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=471 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define log_info, log_pass, log_fail, and log_skip functions.

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 tools/testing/selftests/kexec/kexec_common_lib.sh | 31 +++++++++++++++++++++++
 tools/testing/selftests/kexec/test_kexec_load.sh  | 19 ++++----------
 2 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kexec/kexec_common_lib.sh b/tools/testing/selftests/kexec/kexec_common_lib.sh
index 05376be6a6f7..d108ac538f14 100755
--- a/tools/testing/selftests/kexec/kexec_common_lib.sh
+++ b/tools/testing/selftests/kexec/kexec_common_lib.sh
@@ -1,5 +1,36 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
+#
+# Kselftest framework defines: ksft_pass=0, ksft_fail=1, ksft_skip=4
+
+VERBOSE="${VERBOSE:-1}"
+
+log_info()
+{
+	[ $VERBOSE -ne 0 ] && echo "[INFO] $1"
+}
+
+# The ksefltest framework requirement returns 0 for PASS.
+log_pass()
+{
+
+	[ $VERBOSE -ne 0 ] && echo "$1 [PASS]"
+	exit 0
+}
+
+# The ksefltest framework requirement returns 1 for FAIL.
+log_fail()
+{
+	[ $VERBOSE -ne 0 ] && echo "$1 [FAIL]"
+	exit 1
+}
+
+# The ksefltest framework requirement returns 4 for SKIP.
+log_skip()
+{
+	[ $VERBOSE -ne 0 ] && echo "$1"
+	exit 4
+}
 
 # Check efivar SecureBoot-$(the UUID) and SetupMode-$(the UUID).
 # The secure boot mode can be accessed either as the last integer
diff --git a/tools/testing/selftests/kexec/test_kexec_load.sh b/tools/testing/selftests/kexec/test_kexec_load.sh
index 86625c3f1e5d..cbf598a380d2 100755
--- a/tools/testing/selftests/kexec/test_kexec_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_load.sh
@@ -6,15 +6,10 @@
 
 TEST="$0"
 . ./kexec_common_lib.sh
-rc=0
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
 
 # kexec requires root privileges
 if [ $(id -ru) -ne 0 ]; then
-	echo "$TEST: requires root privileges" >&2
-	exit $ksft_skip
+	log_skip "requires root privileges"
 fi
 
 get_secureboot_mode
@@ -26,18 +21,14 @@ kexec --load $KERNEL_IMAGE > /dev/null 2>&1
 if [ $? -eq 0 ]; then
 	kexec --unload
 	if [ $secureboot -eq 1 ]; then
-		echo "$TEST: kexec_load succeeded [FAIL]"
-		rc=1
+		log_fail "kexec_load succeeded"
 	else
-		echo "$TEST: kexec_load succeeded [PASS]"
+		log_pass "kexec_load succeeded"
 	fi
 else
 	if [ $secureboot -eq 1 ]; then
-		echo "$TEST: kexec_load failed [PASS]"
+		log_pass "kexec_load failed"
 	else
-		echo "$TEST: kexec_load failed [FAIL]"
-		rc=1
+		log_fail "kexec_load failed"
 	fi
 fi
-
-exit $rc
-- 
2.7.5

