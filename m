Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACDCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EC02075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbfCZNf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:35:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbfCZNf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:35:26 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QDZ9Zs103187
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:35:25 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfm3b3ev5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:35:23 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 26 Mar 2019 13:35:18 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 13:35:14 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QDZDCb62914728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 13:35:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A077F11C04C;
        Tue, 26 Mar 2019 13:35:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F42D11C052;
        Tue, 26 Mar 2019 13:35:12 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.109.68])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 13:35:12 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v5 6/9] selftests/kexec: kexec_file_load syscall test
Date:   Tue, 26 Mar 2019 09:34:14 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
References: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032613-0028-0000-0000-0000035875E7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032613-0029-0000-0000-000024172DC5
Message-Id: <1553607257-18906-7-git-send-email-zohar@linux.ibm.com>
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

The kernel can be configured to verify PE signed kernel images, IMA
kernel image signatures, both types of signatures, or none.  This test
verifies only properly signed kernel images are loaded into memory,
based on the kernel configuration and runtime policies.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 tools/testing/selftests/kexec/Makefile             |   4 +-
 tools/testing/selftests/kexec/kexec_common_lib.sh  |  99 ++++++++++
 .../selftests/kexec/test_kexec_file_load.sh        | 203 +++++++++++++++++++++
 tools/testing/selftests/kexec/test_kexec_load.sh   |   1 -
 4 files changed, 304 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/kexec/test_kexec_file_load.sh

diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
index 1a795861040b..8e9b27a7452f 100644
--- a/tools/testing/selftests/kexec/Makefile
+++ b/tools/testing/selftests/kexec/Makefile
@@ -1,10 +1,10 @@
-# Makefile for kexec_load
+# Makefile for kexec tests
 
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
-TEST_PROGS := test_kexec_load.sh
+TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh
 TEST_FILES := kexec_common_lib.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/kexec/kexec_common_lib.sh b/tools/testing/selftests/kexec/kexec_common_lib.sh
index 1af892cee726..51ae64c79c41 100755
--- a/tools/testing/selftests/kexec/kexec_common_lib.sh
+++ b/tools/testing/selftests/kexec/kexec_common_lib.sh
@@ -4,6 +4,9 @@
 # Kselftest framework defines: ksft_pass=0, ksft_fail=1, ksft_skip=4
 
 VERBOSE="${VERBOSE:-1}"
+IKCONFIG="/tmp/config-`uname -r`"
+KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
+SECURITYFS=$(grep "securityfs" /proc/mounts | awk '{print $2}')
 
 log_info()
 {
@@ -74,3 +77,99 @@ require_root_privileges()
 		log_skip "requires root privileges"
 	fi
 }
+
+# Look for config option in Kconfig file.
+# Return 1 for found and 0 for not found.
+kconfig_enabled()
+{
+	local config="$1"
+	local msg="$2"
+
+	grep -E -q $config $IKCONFIG
+	if [ $? -eq 0 ]; then
+		log_info "$msg"
+		return 1
+	fi
+	return 0
+}
+
+# Attempt to get the kernel config first via proc, and then by
+# extracting it from the kernel image or the configs.ko using
+# scripts/extract-ikconfig.
+# Return 1 for found.
+get_kconfig()
+{
+	local proc_config="/proc/config.gz"
+	local module_dir="/lib/modules/`uname -r`"
+	local configs_module="$module_dir/kernel/kernel/configs.ko"
+
+	if [ ! -f $proc_config ]; then
+		modprobe configs > /dev/null 2>&1
+	fi
+	if [ -f $proc_config ]; then
+		cat $proc_config | gunzip > $IKCONFIG 2>/dev/null
+		if [ $? -eq 0 ]; then
+			return 1
+		fi
+	fi
+
+	local extract_ikconfig="$module_dir/source/scripts/extract-ikconfig"
+	if [ ! -f $extract_ikconfig ]; then
+		log_skip "extract-ikconfig not found"
+	fi
+
+	$extract_ikconfig $KERNEL_IMAGE > $IKCONFIG 2>/dev/null
+	if [ $? -eq 1 ]; then
+		if [ ! -f $configs_module ]; then
+			log_skip "CONFIG_IKCONFIG not enabled"
+		fi
+		$extract_ikconfig $configs_module > $IKCONFIG
+		if [ $? -eq 1 ]; then
+			log_skip "CONFIG_IKCONFIG not enabled"
+		fi
+	fi
+	return 1
+}
+
+# Make sure that securityfs is mounted
+mount_securityfs()
+{
+	if [ -z $SECURITYFS ]; then
+		SECURITYFS=/sys/kernel/security
+		mount -t securityfs security $SECURITYFS
+	fi
+
+	if [ ! -d "$SECURITYFS" ]; then
+		log_fail "$SECURITYFS :securityfs is not mounted"
+	fi
+}
+
+# The policy rule format is an "action" followed by key-value pairs.  This
+# function supports up to two key-value pairs, in any order.
+# For example: action func=<keyword> [appraise_type=<type>]
+# Return 1 for found and 0 for not found.
+check_ima_policy()
+{
+	local action="$1"
+	local keypair1="$2"
+	local keypair2="$3"
+	local ret=0
+
+	mount_securityfs
+
+	local ima_policy=$SECURITYFS/ima/policy
+	if [ ! -e $ima_policy ]; then
+		log_fail "$ima_policy not found"
+	fi
+
+	if [ -n $keypair2 ]; then
+		grep -e "^$action.*$keypair1" "$ima_policy" | \
+			grep -q -e "$keypair2"
+	else
+		grep -q -e "^$action.*$keypair1" "$ima_policy"
+	fi
+
+	# invert "grep -q" result, returning 1 for found.
+	[ $? -eq 0 ] && ret=1
+	return $ret
+}
diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
new file mode 100755
index 000000000000..4603282dd8b6
--- /dev/null
+++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
@@ -0,0 +1,203 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Loading a kernel image via the kexec_file_load syscall can verify either
+# the IMA signature stored in the security.ima xattr or the PE signature,
+# both signatures depending on the IMA policy, or none.
+#
+# To determine whether the kernel image is signed, this test depends
+# on pesign and getfattr.  This test also requires the kernel to be
+# built with CONFIG_IKCONFIG enabled and either CONFIG_IKCONFIG_PROC
+# enabled or access to the extract-ikconfig script.
+
+TEST="KEXEC_FILE_LOAD"
+. ./kexec_common_lib.sh
+
+trap "{ rm -f $IKCONFIG ; }" EXIT
+
+# Some of the IMA builtin policies may require the kexec kernel image to
+# be signed, but these policy rules may be replaced with a custom
+# policy.  Only CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS persists after
+# loading a custom policy.  Check if it is enabled, before reading the
+# IMA runtime sysfs policy file.
+# Return 1 for IMA signature required and 0 for not required.
+is_ima_sig_required()
+{
+	local ret=0
+
+	kconfig_enabled "CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS=y" \
+		"IMA kernel image signature required"
+	if [ $? -eq 1 ]; then
+		log_info "IMA signature required"
+		return 1
+	fi
+
+	# The architecture specific or a custom policy may require the
+	# kexec kernel image be signed.  Policy rules are walked
+	# sequentially.  As a result, a policy rule may be defined, but
+	# might not necessarily be used.  This test assumes if a policy
+	# rule is specified, that is the intent.
+	if [ $ima_read_policy -eq 1 ]; then
+		check_ima_policy "appraise" "func=KEXEC_KERNEL_CHECK" \
+			"appraise_type=imasig"
+		ret=$?
+		[ $ret -eq 1 ] && log_info "IMA signature required";
+	fi
+	return $ret
+}
+
+# The kexec_file_load_test() is complicated enough, require pesign.
+# Return 1 for PE signature found and 0 for not found.
+check_for_pesig()
+{
+	which pesign > /dev/null 2>&1 || log_skip "pesign not found"
+
+	pesign -i $KERNEL_IMAGE --show-signature | grep -q "No signatures"
+	local ret=$?
+	if [ $ret -eq 1 ]; then
+		log_info "kexec kernel image PE signed"
+	else
+		log_info "kexec kernel image not PE signed"
+	fi
+	return $ret
+}
+
+# The kexec_file_load_test() is complicated enough, require getfattr.
+# Return 1 for IMA signature found and 0 for not found.
+check_for_imasig()
+{
+	local ret=0
+
+	which getfattr > /dev/null 2>&1
+	if [ $?	-eq 1 ]; then
+		log_skip "getfattr not found"
+	fi
+
+	line=$(getfattr -n security.ima -e hex --absolute-names $KERNEL_IMAGE 2>&1)
+	echo $line | grep -q "security.ima=0x03"
+	if [ $? -eq 0 ]; then
+		ret=1
+		log_info "kexec kernel image IMA signed"
+	else
+		log_info "kexec kernel image not IMA signed"
+	fi
+	return $ret
+}
+
+kexec_file_load_test()
+{
+	local succeed_msg="kexec_file_load succeeded"
+	local failed_msg="kexec_file_load failed"
+	local key_msg="try enabling the CONFIG_INTEGRITY_PLATFORM_KEYRING"
+
+	line=$(kexec --load --kexec-file-syscall $KERNEL_IMAGE 2>&1)
+
+	if [ $? -eq 0 ]; then
+		kexec --unload --kexec-file-syscall
+
+		# In secureboot mode with an architecture  specific
+		# policy, make sure either an IMA or PE signature exists.
+		if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ] && \
+			[ $ima_signed -eq 0 ] && [ $pe_signed -eq 0 ]; then
+			log_fail "$succeed_msg (missing sig)"
+		fi
+
+		if [ $kexec_sig_required -eq 1 -o $pe_sig_required -eq 1 ] \
+		     && [ $pe_signed -eq 0 ]; then
+			log_fail "$succeed_msg (missing PE sig)"
+		fi
+
+		if [ $ima_sig_required -eq 1 ] && [ $ima_signed -eq 0 ]; then
+			log_fail "$succeed_msg (missing IMA sig)"
+		fi
+
+		if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
+		    && [ $ima_sig_required -eq 0 ] && [ $ima_signed -eq 0 ] \
+	            && [ $ima_read_policy -eq 0 ]; then
+			log_fail "$succeed_msg (possibly missing IMA sig)"
+		fi
+
+		if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 0 ]; then
+			log_info "No signature verification required"
+		elif [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
+		    && [ $ima_sig_required -eq 0 ] && [ $ima_signed -eq 0 ] \
+	            && [ $ima_read_policy -eq 1 ]; then
+			log_info "No signature verification required"
+		fi
+
+		log_pass "$succeed_msg"
+	fi
+
+	# Check the reason for the kexec_file_load failure
+	echo $line | grep -q "Required key not available"
+	if [ $? -eq 0 ]; then
+		if [ $platform_keyring -eq 0 ]; then
+			log_pass "$failed_msg (-ENOKEY), $key_msg"
+		else
+			log_pass "$failed_msg (-ENOKEY)"
+		fi
+	fi
+
+	if [ $kexec_sig_required -eq 1 -o $pe_sig_required -eq 1 ] \
+	     && [ $pe_signed -eq 0 ]; then
+		log_pass "$failed_msg (missing PE sig)"
+	fi
+
+	if [ $ima_sig_required -eq 1 ] && [ $ima_signed -eq 0 ]; then
+		log_pass "$failed_msg (missing IMA sig)"
+	fi
+
+	if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
+	    && [ $ima_sig_required -eq 0 ] && [ $ima_read_policy -eq 0 ] \
+	    && [ $ima_signed -eq 0 ]; then
+		log_pass "$failed_msg (possibly missing IMA sig)"
+	fi
+
+	log_pass "$failed_msg"
+	return 0
+}
+
+# kexec requires root privileges
+require_root_privileges
+
+# get the kernel config
+get_kconfig
+
+# Determine which kernel config options are enabled
+kconfig_enabled "CONFIG_IMA_APPRAISE=y" "IMA enabled"
+ima_appraise=$?
+
+kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
+	"architecture specific policy enabled"
+arch_policy=$?
+
+kconfig_enabled "CONFIG_INTEGRITY_PLATFORM_KEYRING=y" \
+	"platform keyring enabled"
+platform_keyring=$?
+
+kconfig_enabled "CONFIG_IMA_READ_POLICY=y" "reading IMA policy permitted"
+ima_read_policy=$?
+
+kconfig_enabled "CONFIG_KEXEC_SIG_FORCE=y" \
+	"kexec signed kernel image required"
+kexec_sig_required=$?
+
+kconfig_enabled "CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y" \
+	"PE signed kernel image required"
+pe_sig_required=$?
+
+is_ima_sig_required
+ima_sig_required=$?
+
+get_secureboot_mode
+secureboot=$?
+
+# Are there pe and ima signatures
+check_for_pesig
+pe_signed=$?
+
+check_for_imasig
+ima_signed=$?
+
+# Test loading the kernel image via kexec_file_load syscall
+kexec_file_load_test
diff --git a/tools/testing/selftests/kexec/test_kexec_load.sh b/tools/testing/selftests/kexec/test_kexec_load.sh
index 49545fcdc646..afd440ee23cb 100755
--- a/tools/testing/selftests/kexec/test_kexec_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_load.sh
@@ -14,7 +14,6 @@ get_secureboot_mode
 secureboot=$?
 
 # kexec_load should fail in secure boot mode
-KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
 kexec --load $KERNEL_IMAGE > /dev/null 2>&1
 if [ $? -eq 0 ]; then
 	kexec --unload
-- 
2.7.5

