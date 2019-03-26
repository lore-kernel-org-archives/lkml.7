Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469C5C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A0C20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfCZNgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:36:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731565AbfCZNf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:35:59 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QDZhtl070166
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:35:57 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rfm6t30qa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:35:51 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 26 Mar 2019 13:35:05 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 13:35:02 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QDZ20222741128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 13:35:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8C8C11C04A;
        Tue, 26 Mar 2019 13:35:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A420B11C052;
        Tue, 26 Mar 2019 13:35:00 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.109.68])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 13:35:00 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v5 1/9] selftests/kexec: move the IMA kexec_load selftest to selftests/kexec
Date:   Tue, 26 Mar 2019 09:34:09 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
References: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032613-0028-0000-0000-0000035875DF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032613-0029-0000-0000-000024172DBE
Message-Id: <1553607257-18906-2-git-send-email-zohar@linux.ibm.com>
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

As requested move the existing kexec_load selftest and subsequent kexec
tests to the selftests/kexec directory.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tools/testing/selftests/Makefile                 |  2 +-
 tools/testing/selftests/ima/Makefile             | 11 -----
 tools/testing/selftests/ima/config               |  4 --
 tools/testing/selftests/ima/test_kexec_load.sh   | 54 ------------------------
 tools/testing/selftests/kexec/Makefile           | 11 +++++
 tools/testing/selftests/kexec/config             |  4 ++
 tools/testing/selftests/kexec/test_kexec_load.sh | 54 ++++++++++++++++++++++++
 7 files changed, 70 insertions(+), 70 deletions(-)
 delete mode 100644 tools/testing/selftests/ima/Makefile
 delete mode 100644 tools/testing/selftests/ima/config
 delete mode 100755 tools/testing/selftests/ima/test_kexec_load.sh
 create mode 100644 tools/testing/selftests/kexec/Makefile
 create mode 100644 tools/testing/selftests/kexec/config
 create mode 100755 tools/testing/selftests/kexec/test_kexec_load.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 1a2bd15c5b6e..6da1e32d2b99 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -14,11 +14,11 @@ TARGETS += firmware
 TARGETS += ftrace
 TARGETS += futex
 TARGETS += gpio
-TARGETS += ima
 TARGETS += intel_pstate
 TARGETS += ipc
 TARGETS += ir
 TARGETS += kcmp
+TARGETS += kexec
 TARGETS += kvm
 TARGETS += lib
 TARGETS += membarrier
diff --git a/tools/testing/selftests/ima/Makefile b/tools/testing/selftests/ima/Makefile
deleted file mode 100644
index 0b3adf5444b6..000000000000
--- a/tools/testing/selftests/ima/Makefile
+++ /dev/null
@@ -1,11 +0,0 @@
-# Makefile for kexec_load
-
-uname_M := $(shell uname -m 2>/dev/null || echo not)
-ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
-
-ifeq ($(ARCH),x86)
-TEST_PROGS := test_kexec_load.sh
-
-include ../lib.mk
-
-endif
diff --git a/tools/testing/selftests/ima/config b/tools/testing/selftests/ima/config
deleted file mode 100644
index 6bc86d4d9bb4..000000000000
--- a/tools/testing/selftests/ima/config
+++ /dev/null
@@ -1,4 +0,0 @@
-CONFIG_IMA_APPRAISE
-CONFIG_IMA_ARCH_POLICY
-CONFIG_SECURITYFS
-CONFIG_KEXEC_VERIFY_SIG
diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
deleted file mode 100755
index 1c10093fb526..000000000000
--- a/tools/testing/selftests/ima/test_kexec_load.sh
+++ /dev/null
@@ -1,54 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0+
-# Loading a kernel image via the kexec_load syscall should fail
-# when the kerne is CONFIG_KEXEC_VERIFY_SIG enabled and the system
-# is booted in secureboot mode.
-
-TEST="$0"
-EFIVARFS="/sys/firmware/efi/efivars"
-rc=0
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-# kexec requires root privileges
-if [ $UID != 0 ]; then
-	echo "$TEST: must be run as root" >&2
-	exit $ksft_skip
-fi
-
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
-
-# kexec_load should fail in secure boot mode
-KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
-kexec -l $KERNEL_IMAGE &>> /dev/null
-if [ $? == 0 ]; then
-	kexec -u
-	if [ "$secureboot" == "1" ]; then
-		echo "$TEST: kexec_load succeeded [FAIL]"
-		rc=1
-	else
-		echo "$TEST: kexec_load succeeded [PASS]"
-	fi
-else
-	if [ "$secureboot" == "1" ]; then
-		echo "$TEST: kexec_load failed [PASS]"
-	else
-		echo "$TEST: kexec_load failed [FAIL]"
-		rc=1
-	fi
-fi
-
-exit $rc
diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
new file mode 100644
index 000000000000..0b3adf5444b6
--- /dev/null
+++ b/tools/testing/selftests/kexec/Makefile
@@ -0,0 +1,11 @@
+# Makefile for kexec_load
+
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+
+ifeq ($(ARCH),x86)
+TEST_PROGS := test_kexec_load.sh
+
+include ../lib.mk
+
+endif
diff --git a/tools/testing/selftests/kexec/config b/tools/testing/selftests/kexec/config
new file mode 100644
index 000000000000..6bc86d4d9bb4
--- /dev/null
+++ b/tools/testing/selftests/kexec/config
@@ -0,0 +1,4 @@
+CONFIG_IMA_APPRAISE
+CONFIG_IMA_ARCH_POLICY
+CONFIG_SECURITYFS
+CONFIG_KEXEC_VERIFY_SIG
diff --git a/tools/testing/selftests/kexec/test_kexec_load.sh b/tools/testing/selftests/kexec/test_kexec_load.sh
new file mode 100755
index 000000000000..1c10093fb526
--- /dev/null
+++ b/tools/testing/selftests/kexec/test_kexec_load.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+# Loading a kernel image via the kexec_load syscall should fail
+# when the kerne is CONFIG_KEXEC_VERIFY_SIG enabled and the system
+# is booted in secureboot mode.
+
+TEST="$0"
+EFIVARFS="/sys/firmware/efi/efivars"
+rc=0
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+# kexec requires root privileges
+if [ $UID != 0 ]; then
+	echo "$TEST: must be run as root" >&2
+	exit $ksft_skip
+fi
+
+# Make sure that efivars is mounted in the normal location
+if ! grep -q "^\S\+ $EFIVARFS efivarfs" /proc/mounts; then
+	echo "$TEST: efivars is not mounted on $EFIVARFS" >&2
+	exit $ksft_skip
+fi
+
+# Get secureboot mode
+file="$EFIVARFS/SecureBoot-*"
+if [ ! -e $file ]; then
+	echo "$TEST: unknown secureboot mode" >&2
+	exit $ksft_skip
+fi
+secureboot=`hexdump $file | awk '{print substr($4,length($4),1)}'`
+
+# kexec_load should fail in secure boot mode
+KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
+kexec -l $KERNEL_IMAGE &>> /dev/null
+if [ $? == 0 ]; then
+	kexec -u
+	if [ "$secureboot" == "1" ]; then
+		echo "$TEST: kexec_load succeeded [FAIL]"
+		rc=1
+	else
+		echo "$TEST: kexec_load succeeded [PASS]"
+	fi
+else
+	if [ "$secureboot" == "1" ]; then
+		echo "$TEST: kexec_load failed [PASS]"
+	else
+		echo "$TEST: kexec_load failed [FAIL]"
+		rc=1
+	fi
+fi
+
+exit $rc
-- 
2.7.5

