Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2697C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C52E20883
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfCVTgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:36:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726472AbfCVTgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:36:37 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2MJYcVP059669
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 15:36:36 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rd5x008qy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 15:36:35 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 22 Mar 2019 19:36:25 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Mar 2019 19:36:22 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2MJaUNU37355676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 19:36:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E77242041;
        Fri, 22 Mar 2019 19:36:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3400D42042;
        Fri, 22 Mar 2019 19:36:29 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Mar 2019 19:36:29 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v4a 1/2] selftests/kexec: make tests independent of IMA being enabled
Date:   Fri, 22 Mar 2019 15:35:50 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19032219-4275-0000-0000-0000031E2F76
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032219-4276-0000-0000-0000382CBC96
Message-Id: <1553283351-6310-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=6 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=991 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903220139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verify IMA is enabled before failing tests or emitting irrelevant
messages.  Also, don't skip the test if signatures are not required.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Dave, if this patch resolves the outstanding issues, I can fold these
changes into the original patches. (Reminder, these patches will need to
be updated to support the "lockdown" patch set.)

 .../selftests/kexec/test_kexec_file_load.sh        | 27 ++++++++++++++--------
 tools/testing/selftests/kexec/test_kexec_load.sh   | 24 ++++++++++++-------
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
index 1d2e5e799523..57b636792086 100755
--- a/tools/testing/selftests/kexec/test_kexec_file_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
@@ -110,11 +110,20 @@ kexec_file_load_test()
 			log_fail "$succeed_msg (missing IMA sig)"
 		fi
 
-		if [ $pe_sig_required -eq 0 ] && [ $ima_sig_required -eq 0 ] \
-		    && [ $ima_read_policy -eq 0 ] && [ $ima_signed -eq 0 ]; then
+		if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
+		    && [ $ima_sig_required -eq 0 ] && [ $ima_signed -eq 0 ] \
+	            && [ $ima_read_policy -eq 0 ]; then
 			log_fail "$succeed_msg (possibly missing IMA sig)"
 		fi
 
+		if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 0 ]; then
+			log_info "No signature verification required"
+		elif [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
+		    && [ $ima_sig_required -eq 0 ] && [ $ima_signed -eq 0 ] \
+	            && [ $ima_read_policy -eq 1 ]; then
+			log_info "No signature verification required"
+		fi
+
 		log_pass "$succeed_msg"
 	fi
 
@@ -136,8 +145,9 @@ kexec_file_load_test()
 		log_pass "$failed_msg (missing IMA sig)"
 	fi
 
-	if [ $pe_sig_required -eq 0 ] && [ $ima_sig_required -eq 0 ] \
-	    && [ $ima_read_policy -eq 0 ] && [ $ima_signed -eq 0 ]; then
+	if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
+	    && [ $ima_sig_required -eq 0 ] && [ $ima_read_policy -eq 0 ] \
+	    && [ $ima_signed -eq 0 ]; then
 		log_pass "$failed_msg (possibly missing IMA sig)"
 	fi
 
@@ -157,6 +167,9 @@ if [ $? -eq 0 ]; then
 fi
 
 # Determine which kernel config options are enabled
+kconfig_enabled "CONFIG_IMA_APPRAISE=y" "IMA enabled"
+ima_appraise=$?
+
 kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
 	"architecture specific policy enabled"
 arch_policy=$?
@@ -178,12 +191,6 @@ ima_sig_required=$?
 get_secureboot_mode
 secureboot=$?
 
-if [ $secureboot -eq 0 ] && [ $arch_policy -eq 0 ] && \
-   [ $pe_sig_required -eq 0 ] && [ $ima_sig_required -eq 0 ] && \
-   [ $ima_read_policy -eq 1 ]; then
-	log_skip "No signature verification required"
-fi
-
 # Are there pe and ima signatures
 check_for_pesig
 pe_signed=$?
diff --git a/tools/testing/selftests/kexec/test_kexec_load.sh b/tools/testing/selftests/kexec/test_kexec_load.sh
index 2a66c8897f55..49c6aa929137 100755
--- a/tools/testing/selftests/kexec/test_kexec_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_load.sh
@@ -1,8 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# Loading a kernel image via the kexec_load syscall should fail
-# when the kernel is CONFIG_KEXEC_VERIFY_SIG enabled and the system
-# is booted in secureboot mode.
+#
+# Prevent loading a kernel image via the kexec_load syscall when
+# signatures are required.  (Dependent on CONFIG_IMA_ARCH_POLICY.)
 
 TEST="$0"
 . ./kexec_common_lib.sh
@@ -18,20 +18,28 @@ if [ $? -eq 0 ]; then
 	log_skip "kexec_load is not enabled"
 fi
 
+kconfig_enabled "CONFIG_IMA_APPRAISE=y" "IMA enabled"
+ima_appraise=$?
+
+kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
+	"IMA architecture specific policy enabled"
+arch_policy=$?
+
 get_secureboot_mode
 secureboot=$?
 
-# kexec_load should fail in secure boot mode
+# kexec_load should fail in secure boot mode and CONFIG_IMA_ARCH_POLICY enabled
 kexec --load $KERNEL_IMAGE > /dev/null 2>&1
 if [ $? -eq 0 ]; then
 	kexec --unload
-	if [ $secureboot -eq 1 ]; then
+	if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ]; then
 		log_fail "kexec_load succeeded"
-	else
-		log_pass "kexec_load succeeded"
+	elif [ $ima_appraise -eq 0 -o $arch_policy -eq 0 ]; then
+		log_info "Either IMA or the IMA arch policy is not enabled"
 	fi
+	log_pass "kexec_load succeeded"
 else
-	if [ $secureboot -eq 1 ]; then
+	if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ] ; then
 		log_pass "kexec_load failed"
 	else
 		log_fail "kexec_load failed"
-- 
2.7.5

