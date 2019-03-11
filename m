Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE034C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5C32086A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfCKLmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:42:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727388AbfCKLmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:42:08 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BBdjAZ048995
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:42:08 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r5mn5xctw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:42:07 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 11 Mar 2019 11:42:05 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Mar 2019 11:42:02 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2BBg1MT25624802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Mar 2019 11:42:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9219A11C05B;
        Mon, 11 Mar 2019 11:42:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80B5F11C04A;
        Mon, 11 Mar 2019 11:42:00 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.93.170])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Mar 2019 11:42:00 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v3 6/7] selftests/ima: loading kernel modules
Date:   Mon, 11 Mar 2019 07:41:12 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
References: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19031111-0020-0000-0000-00000321374B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031111-0021-0000-0000-000021735B04
Message-Id: <1552304473-3966-7-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903110088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the appended kernel module signature can be verified, when loading
a kernel module via either the init_module or the finit_module syscall,
verifying the IMA signature requires access to the file descriptor,
which is only available via the finit_module syscall.  As "modprobe"
does not provide a flag allowing the syscall - init_module or
finit_module - to be specified, this patch does not load a kernel
module.

This test simply verifies that on secure boot enabled systems with
"CONFIG_IMA_ARCH_POLICY" configured, that at least an appended kernel
module signature or an IMA signature is required based on the Kconfig
and the runtime IMA policy.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 tools/testing/selftests/ima/Makefile              |  2 +-
 tools/testing/selftests/ima/test_kernel_module.sh | 93 +++++++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/ima/test_kernel_module.sh

diff --git a/tools/testing/selftests/ima/Makefile b/tools/testing/selftests/ima/Makefile
index 00270de0b637..e1c59c510e1b 100644
--- a/tools/testing/selftests/ima/Makefile
+++ b/tools/testing/selftests/ima/Makefile
@@ -4,7 +4,7 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
-TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh
+TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh test_kernel_module.sh
 TEST_FILES := ima_common_lib.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/ima/test_kernel_module.sh b/tools/testing/selftests/ima/test_kernel_module.sh
new file mode 100755
index 000000000000..319c601b9697
--- /dev/null
+++ b/tools/testing/selftests/ima/test_kernel_module.sh
@@ -0,0 +1,93 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# On secure boot enabled systems with "CONFIG_IMA_ARCH_POLICY" configured,
+# this test verifies that at least an appended kernel module signature or
+# an IMA signature is required.  It does not attempt to load a kernel module.
+
+TEST="KERNEL_MODULE"
+. ./ima_common_lib.sh
+
+trap "{ rm -f $IKCONFIG ; }" EXIT
+
+# Some of the IMA builtin policies may require the kernel modules to
+# be signed, but these policy rules may be replaced with a custom
+# policy.  Only CONFIG_IMA_APPRAISE_REQUIRE_MODULE_SIGS persists after
+# loading a custom policy.  Check if it is enabled, before reading the
+# IMA runtime sysfs policy file.
+# Return 1 for IMA signature required and 0 for not required.
+is_ima_sig_required()
+{
+	local ret=0
+
+	kconfig_enabled "CONFIG_IMA_APPRAISE_REQUIRE_MODULE_SIGS=y" \
+		"IMA kernel module signature required"
+	if [ $? -eq 1 ]; then
+		return 1
+	fi
+
+	# The architecture specific or a custom policy may require the
+	# kernel module to be signed.  Policy rules are walked sequentially.
+	# As a result, a policy rule may be defined, but might not necessarily
+	# be used.  This test assumes if a policy rule is specified, that is
+	# the intent.
+	if [ $ima_read_policy -eq 1 ]; then
+		check_ima_policy "appraise" "func=MODULE_CHECK" \
+			"appraise_type=imasig"
+		ret=$?
+		[ $ret -eq 1 ] && log_info "IMA signature required";
+	fi
+	return $ret
+}
+
+# loading kernel modules requires root privileges
+require_root_privileges
+
+# Are appended signatures required?
+if [ -e /sys/module/module/parameters/sig_enforce ]; then
+	sig_enforce=$(cat /sys/module/module/parameters/sig_enforce)
+	if [ $sig_enforce = "Y" ]; then
+		log_pass "appended kernel module signature required"
+	fi
+fi
+
+get_secureboot_mode
+if [ $? -eq 0 ]; then
+	log_skip "secure boot not enabled"
+fi
+
+# get the kernel config
+get_kconfig
+
+# Determine which kernel config options are enabled
+kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
+	"architecture specific policy enabled"
+arch_policy=$?
+
+kconfig_enabled "CONFIG_MODULE_SIG=y" \
+	"appended kernel modules signature enabled"
+appended_sig_enabled=$?
+
+kconfig_enabled "CONFIG_IMA_READ_POLICY=y" "reading IMA policy permitted"
+ima_read_policy=$?
+
+is_ima_sig_required
+ima_sig_required=$?
+
+if [ $arch_policy -eq 0 ]; then
+	log_skip "architecture specific policy not enabled"
+fi
+
+if [ $appended_sig_enabled -eq 1 ]; then
+	log_fail "appended kernel module signature enabled, but not required"
+fi
+
+if [ $ima_sig_required -eq 1 ]; then
+	log_pass "IMA kernel module signature required"
+fi
+
+if [ $ima_read_policy -eq 1 ]; then
+	log_fail "IMA kernel module signature not required"
+else
+	log_skip "reading IMA policy not permitted"
+fi
-- 
2.7.5

