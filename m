Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861DEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CB12084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDCOGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:06:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbfDCOG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:06:29 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33DvYZ1030823
        for <linux-kernel@vger.kernel.org>; Wed, 3 Apr 2019 10:06:28 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rmwq5j7tu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:06:27 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 3 Apr 2019 15:06:25 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Apr 2019 15:06:22 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x33E6LE351445816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Apr 2019 14:06:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 347A5AE053;
        Wed,  3 Apr 2019 14:06:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53120AE045;
        Wed,  3 Apr 2019 14:06:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.94.125])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Apr 2019 14:06:20 +0000 (GMT)
Subject: [PATCH] selftests/kexec: update get_secureboot_mode
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Wed, 03 Apr 2019 10:06:09 -0400
In-Reply-To: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
References: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19040314-4275-0000-0000-00000323D782
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040314-4276-0000-0000-00003832DEE1
Message-Id: <1554300369.7309.59.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_secureboot_mode() function unnecessarily requires both
CONFIG_EFIVAR_FS and CONFIG_EFI_VARS to be enabled to determine if the
system is booted in secure boot mode.  On some systems the old EFI
variable support is not enabled or, possibly, even implemented.

This patch first checks the efivars filesystem for the SecureBoot and
SetupMode flags, but falls back to using the old EFI variable support.

The "secure_boot_file" and "setup_mode_file" couldn't be quoted due to
globbing.  This patch also removes the globbing.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tools/testing/selftests/kexec/kexec_common_lib.sh | 87 +++++++++++++++++------
 1 file changed, 67 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kexec/kexec_common_lib.sh b/tools/testing/selftests/kexec/kexec_common_lib.sh
index b7ac8f3fa025..4d3ff08bdb81 100755
--- a/tools/testing/selftests/kexec/kexec_common_lib.sh
+++ b/tools/testing/selftests/kexec/kexec_common_lib.sh
@@ -35,6 +35,64 @@ log_skip()
 }
 
 # Check efivar SecureBoot-$(the UUID) and SetupMode-$(the UUID).
+# (Based on kdump-lib.sh)
+get_efivarfs_secureboot_mode()
+{
+	local efivarfs="/sys/firmware/efi/efivars"
+	local secure_boot_file=""
+	local setup_mode_file=""
+	local secureboot_mode=0
+	local setup_mode=0
+
+	# Make sure that efivar_fs is mounted in the normal location
+	if ! grep -q "^\S\+ $efivarfs efivarfs" /proc/mounts; then
+		log_info "efivars is not mounted on $efivarfs"
+		return 0;
+	fi
+	secure_boot_file=$(find "$efivarfs" -name SecureBoot-* 2>/dev/null)
+	setup_mode_file=$(find "$efivarfs" -name SetupMode-* 2>/dev/null)
+	if [ -f "$secure_boot_file" ] && [ -f "$setup_mode_file" ]; then
+		secureboot_mode=$(hexdump -v -e '/1 "%d\ "' \
+			"$secure_boot_file"|cut -d' ' -f 5)
+		setup_mode=$(hexdump -v -e '/1 "%d\ "' \
+			"$setup_mode_file"|cut -d' ' -f 5)
+
+		if [ $secureboot_mode -eq 1 ] && [ $setup_mode -eq 0 ]; then
+			log_info "secure boot mode enabled (efivar_fs)"
+			return 1;
+		fi
+	fi
+	return 0;
+}
+
+get_efi_var_secureboot_mode()
+{
+	local efi_vars="/sys/firmware/efi/vars"
+	local secure_boot_file=""
+	local setup_mode_file=""
+	local secureboot_mode=0
+	local setup_mode=0
+
+	if [ ! -d "$efi_vars" ]; then
+		log_skip "efi_vars is not enabled\n"
+		return 0;
+	fi
+	secure_boot_file=$(find "$efi_vars" -name SecureBoot-* 2>/dev/null)
+	setup_mode_file=$(find "$efi_vars" -name SetupMode-* 2>/dev/null)
+	if [ -f "$secure_boot_file/data" ] && \
+	   [ -f "$setup_mode_file/data" ]; then
+		secureboot_mode=`od -An -t u1 "$secure_boot_file/data"`
+		setup_mode=`od -An -t u1 "$setup_mode_file/data"`
+
+		if [ $secureboot_mode -eq 1 ] && [ $setup_mode -eq 0 ]; then
+			log_info "secure boot mode enabled (efi_var)"
+			return 1;
+		fi
+	fi
+	return 0;
+}
+
+# Check efivar SecureBoot-$(the UUID) and SetupMode-$(the UUID).
 # The secure boot mode can be accessed either as the last integer
 # of "od -An -t u1 /sys/firmware/efi/efivars/SecureBoot-*" or from
 # "od -An -t u1 /sys/firmware/efi/vars/SecureBoot-*/data".  The efi
@@ -42,32 +100,21 @@ log_skip()
 # Return 1 for SecureBoot mode enabled and SetupMode mode disabled.
 get_secureboot_mode()
 {
-	local efivarfs="/sys/firmware/efi/efivars"
-	local secure_boot_file="$efivarfs/../vars/SecureBoot-*/data"
-	local setup_mode_file="$efivarfs/../vars/SetupMode-*/data"
 	local secureboot_mode=0
-	local setup_mode=0
 
-	# Make sure that efivars is mounted in the normal location
-	if ! grep -q "^\S\+ $efivarfs efivarfs" /proc/mounts; then
-		log_skip "efivars is not mounted on $efivarfs"
-	fi
+	get_efivarfs_secureboot_mode
+	secureboot_mode=$?
 
-	# Due to globbing, quoting "secure_boot_file" and "setup_mode_file"
-	# is not possible.  (Todo: initialize variables using find or ls.)
-	if [ ! -e $secure_boot_file ] || [ ! -e $setup_mode_file ]; then
-		log_skip "unknown secureboot/setup mode"
+	# fallback to using the efi_var files
+	if [ $secureboot_mode -eq 0 ]; then
+		get_efi_var_secureboot_mode
+		secureboot_mode=$?
 	fi
 
-	secureboot_mode=`od -An -t u1 $secure_boot_file`
-	setup_mode=`od -An -t u1 $setup_mode_file`
-
-	if [ $secureboot_mode -eq 1 ] && [ $setup_mode -eq 0 ]; then
-		log_info "secure boot mode enabled"
-		return 1;
+	if [ $secureboot_mode -eq 0 ]; then
+		log_info "secure boot mode not enabled"
 	fi
-	log_info "secure boot mode not enabled"
-	return 0;
+	return $secureboot_mode;
 }
 
 require_root_privileges()
-- 
2.7.5

