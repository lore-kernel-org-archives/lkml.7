Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A838C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9C62077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfCNSmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:42:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727780AbfCNSmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:42:03 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2EIfCge073750
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 14:42:00 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r7set94ry-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 14:42:00 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 14 Mar 2019 18:41:58 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Mar 2019 18:41:54 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2EIfrRx27787304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Mar 2019 18:41:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83A8042045;
        Thu, 14 Mar 2019 18:41:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8812A4204C;
        Thu, 14 Mar 2019 18:41:52 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.108.186])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Mar 2019 18:41:52 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v4 1/8] selftests/kexec: move the IMA kexec_load selftest to selftests/kexec
Date:   Thu, 14 Mar 2019 14:41:09 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1552588876-28481-1-git-send-email-zohar@linux.ibm.com>
References: <1552588876-28481-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19031418-0020-0000-0000-000003236303
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031418-0021-0000-0000-0000217568F5
Message-Id: <1552588876-28481-2-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140130
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

