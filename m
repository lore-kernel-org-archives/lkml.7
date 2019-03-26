Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F975C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BF52070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbfCZNgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:36:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731599AbfCZNgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:36:36 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QDaBW8171230
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:36:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rfkyeudk0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:36:21 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 26 Mar 2019 13:35:10 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 13:35:07 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QDZ6M038666336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 13:35:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85E3A11C06C;
        Tue, 26 Mar 2019 13:35:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F7FB11C066;
        Tue, 26 Mar 2019 13:35:05 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.109.68])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 13:35:05 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v5 3/9] selftests/kexec: define a set of common functions
Date:   Tue, 26 Mar 2019 09:34:11 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
References: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032613-0008-0000-0000-000002D1B809
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032613-0009-0000-0000-0000223DE4D4
Message-Id: <1553607257-18906-4-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=944 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define, update and move get_secureboot_mode() to a common file for use
by other tests.

Updated to check both the efivar SecureBoot-$(UUID) and
SetupMode-$(UUID), based on Dave Young's review.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 tools/testing/selftests/kexec/Makefile            |  1 +
 tools/testing/selftests/kexec/kexec_common_lib.sh | 38 +++++++++++++++++++++++
 tools/testing/selftests/kexec/test_kexec_load.sh  | 17 ++--------
 3 files changed, 42 insertions(+), 14 deletions(-)
 create mode 100755 tools/testing/selftests/kexec/kexec_common_lib.sh

diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
index 0b3adf5444b6..1a795861040b 100644
--- a/tools/testing/selftests/kexec/Makefile
+++ b/tools/testing/selftests/kexec/Makefile
@@ -5,6 +5,7 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
 TEST_PROGS := test_kexec_load.sh
+TEST_FILES := kexec_common_lib.sh
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/kexec/kexec_common_lib.sh b/tools/testing/selftests/kexec/kexec_common_lib.sh
new file mode 100755
index 000000000000..05376be6a6f7
--- /dev/null
+++ b/tools/testing/selftests/kexec/kexec_common_lib.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Check efivar SecureBoot-$(the UUID) and SetupMode-$(the UUID).
+# The secure boot mode can be accessed either as the last integer
+# of "od -An -t u1 /sys/firmware/efi/efivars/SecureBoot-*" or from
+# "od -An -t u1 /sys/firmware/efi/vars/SecureBoot-*/data".  The efi
+# SetupMode can be similarly accessed.
+# Return 1 for SecureBoot mode enabled and SetupMode mode disabled.
+get_secureboot_mode()
+{
+	local efivarfs="/sys/firmware/efi/efivars"
+	local secure_boot_file="$efivarfs/../vars/SecureBoot-*/data"
+	local setup_mode_file="$efivarfs/../vars/SetupMode-*/data"
+	local secureboot_mode=0
+	local setup_mode=0
+
+	# Make sure that efivars is mounted in the normal location
+	if ! grep -q "^\S\+ $efivarfs efivarfs" /proc/mounts; then
+		log_skip "efivars is not mounted on $efivarfs"
+	fi
+
+	# Due to globbing, quoting "secure_boot_file" and "setup_mode_file"
+	# is not possible.  (Todo: initialize variables using find or ls.)
+	if [ ! -e $secure_boot_file ] || [ ! -e $setup_mode_file ]; then
+		log_skip "unknown secureboot/setup mode"
+	fi
+
+	secureboot_mode=`od -An -t u1 $secure_boot_file`
+	setup_mode=`od -An -t u1 $setup_mode_file`
+
+	if [ $secureboot_mode -eq 1 ] && [ $setup_mode -eq 0 ]; then
+		log_info "secure boot mode enabled"
+		return 1;
+	fi
+	log_info "secure boot mode not enabled"
+	return 0;
+}
diff --git a/tools/testing/selftests/kexec/test_kexec_load.sh b/tools/testing/selftests/kexec/test_kexec_load.sh
index 82a01a4d5c8d..86625c3f1e5d 100755
--- a/tools/testing/selftests/kexec/test_kexec_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_load.sh
@@ -5,7 +5,7 @@
 # is booted in secureboot mode.
 
 TEST="$0"
-EFIVARFS="/sys/firmware/efi/efivars"
+. ./kexec_common_lib.sh
 rc=0
 
 # Kselftest framework requirement - SKIP code is 4.
@@ -17,19 +17,8 @@ if [ $(id -ru) -ne 0 ]; then
 	exit $ksft_skip
 fi
 
-# Make sure that efivars is mounted in the normal location
-if ! grep -q "^\S\+ $EFIVARFS efivarfs" /proc/mounts; then
-	echo "$TEST: efivars is not mounted on $EFIVARFS" >&2
-	exit $ksft_skip
-fi
-
-# Get secureboot mode
-file="$EFIVARFS/SecureBoot-*"
-if [ ! -e $file ]; then
-	echo "$TEST: unknown secureboot mode" >&2
-	exit $ksft_skip
-fi
-secureboot=`hexdump $file | awk '{print substr($4,length($4),1)}'`
+get_secureboot_mode
+secureboot=$?
 
 # kexec_load should fail in secure boot mode
 KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
-- 
2.7.5

