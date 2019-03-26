Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F89C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69552070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbfCZNgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:36:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbfCZNgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:36:42 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QDaBWL171230
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:36:40 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rfkyeudhu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:36:30 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 26 Mar 2019 13:35:08 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 13:35:05 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QDZ4iF16122080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 13:35:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5165611C066;
        Tue, 26 Mar 2019 13:35:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21A6011C05B;
        Tue, 26 Mar 2019 13:35:03 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.109.68])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 13:35:02 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v5 2/9] selftests/kexec: cleanup the kexec selftest
Date:   Tue, 26 Mar 2019 09:34:10 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
References: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032613-0008-0000-0000-000002D1B808
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032613-0009-0000-0000-0000223DE4D2
Message-Id: <1553607257-18906-3-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=861 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the few bashisms and use the complete option name for clarity.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 tools/testing/selftests/kexec/test_kexec_load.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kexec/test_kexec_load.sh b/tools/testing/selftests/kexec/test_kexec_load.sh
index 1c10093fb526..82a01a4d5c8d 100755
--- a/tools/testing/selftests/kexec/test_kexec_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_load.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0
 # Loading a kernel image via the kexec_load syscall should fail
-# when the kerne is CONFIG_KEXEC_VERIFY_SIG enabled and the system
+# when the kernel is CONFIG_KEXEC_VERIFY_SIG enabled and the system
 # is booted in secureboot mode.
 
 TEST="$0"
@@ -12,8 +12,8 @@ rc=0
 ksft_skip=4
 
 # kexec requires root privileges
-if [ $UID != 0 ]; then
-	echo "$TEST: must be run as root" >&2
+if [ $(id -ru) -ne 0 ]; then
+	echo "$TEST: requires root privileges" >&2
 	exit $ksft_skip
 fi
 
@@ -33,17 +33,17 @@ secureboot=`hexdump $file | awk '{print substr($4,length($4),1)}'`
 
 # kexec_load should fail in secure boot mode
 KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
-kexec -l $KERNEL_IMAGE &>> /dev/null
-if [ $? == 0 ]; then
-	kexec -u
-	if [ "$secureboot" == "1" ]; then
+kexec --load $KERNEL_IMAGE > /dev/null 2>&1
+if [ $? -eq 0 ]; then
+	kexec --unload
+	if [ $secureboot -eq 1 ]; then
 		echo "$TEST: kexec_load succeeded [FAIL]"
 		rc=1
 	else
 		echo "$TEST: kexec_load succeeded [PASS]"
 	fi
 else
-	if [ "$secureboot" == "1" ]; then
+	if [ $secureboot -eq 1 ]; then
 		echo "$TEST: kexec_load failed [PASS]"
 	else
 		echo "$TEST: kexec_load failed [FAIL]"
-- 
2.7.5

