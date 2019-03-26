Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A2EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8FF2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbfCZNgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:36:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726266AbfCZNgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:36:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QDZgSd031871
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:36:00 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rfmc82e1a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:35:51 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 26 Mar 2019 13:35:16 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 13:35:12 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QDZBEh41746448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 13:35:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38A8D11C04A;
        Tue, 26 Mar 2019 13:35:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A14311C04C;
        Tue, 26 Mar 2019 13:35:10 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.109.68])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 13:35:10 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v5 5/9] kselftest/kexec: define "require_root_privileges"
Date:   Tue, 26 Mar 2019 09:34:13 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
References: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032613-4275-0000-0000-0000031F723B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032613-4276-0000-0000-0000382E08CC
Message-Id: <1553607257-18906-6-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=714 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many tests require root privileges.  Define a common function.

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 tools/testing/selftests/kexec/kexec_common_lib.sh | 7 +++++++
 tools/testing/selftests/kexec/test_kexec_load.sh  | 4 +---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kexec/kexec_common_lib.sh b/tools/testing/selftests/kexec/kexec_common_lib.sh
index d108ac538f14..1af892cee726 100755
--- a/tools/testing/selftests/kexec/kexec_common_lib.sh
+++ b/tools/testing/selftests/kexec/kexec_common_lib.sh
@@ -67,3 +67,10 @@ get_secureboot_mode()
 	log_info "secure boot mode not enabled"
 	return 0;
 }
+
+require_root_privileges()
+{
+	if [ $(id -ru) -ne 0 ]; then
+		log_skip "requires root privileges"
+	fi
+}
diff --git a/tools/testing/selftests/kexec/test_kexec_load.sh b/tools/testing/selftests/kexec/test_kexec_load.sh
index cbf598a380d2..49545fcdc646 100755
--- a/tools/testing/selftests/kexec/test_kexec_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_load.sh
@@ -8,9 +8,7 @@ TEST="$0"
 . ./kexec_common_lib.sh
 
 # kexec requires root privileges
-if [ $(id -ru) -ne 0 ]; then
-	log_skip "requires root privileges"
-fi
+require_root_privileges
 
 get_secureboot_mode
 secureboot=$?
-- 
2.7.5

