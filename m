Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E5AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E37C2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbfCZNfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:35:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbfCZNfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:35:16 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QDZ7FX103068
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:35:15 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfm3b3ebm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:35:12 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 26 Mar 2019 13:35:04 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 13:35:00 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QDYxPI39452882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 13:34:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5418A11C04C;
        Tue, 26 Mar 2019 13:34:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13F6211C04A;
        Tue, 26 Mar 2019 13:34:58 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.109.68])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 13:34:57 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v5 0/9] selftests/kexec: add kexec tests
Date:   Tue, 26 Mar 2019 09:34:08 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19032613-0028-0000-0000-0000035875DE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032613-0029-0000-0000-000024172DBC
Message-Id: <1553607257-18906-1-git-send-email-zohar@linux.ibm.com>
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

The kernel may be configured or an IMA policy specified on the boot
command line requiring the kexec kernel image signature to be verified.
At runtime a custom IMA policy may be loaded, replacing the policy
specified on the boot command line.  In addition, the arch specific
policy rules are dynamically defined based on the secure boot mode that
may require the kernel image signature to be verified.

The kernel image may have a PE signature, an IMA signature, or both. In
addition, there are two kexec syscalls - kexec_load and kexec_file_load
- but only the kexec_file_load syscall can verify signatures.

These kexec selftests verify that only properly signed kernel images are
loaded as required, based on the kernel config, the secure boot mode,
and the IMA runtime policy.

Loading a kernel image requires root privileges.  To run just the KEXEC
selftests: sudo make TARGETS=kexec kselftest

Changelog v5:
- Make tests independent of IMA being enabled, folding the changes
into the kexec_file_load test.
- Add support for CONFIG_KEXEC_VERIFY_SIG being enabled, but not
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG.

Changelog v4:
- Moved the kexec tests to selftests/kexec, as requested by Dave Young.
- Removed the kernel module selftest from this patch set.
- Rewritten cover letter, removing reference to kernel modules.

Changelog v3:
- Updated tests based on Petr's review, including the defining a common
  test to check for root privileges.
- Modified config, removing the CONFIG_KEXEC_VERIFY_SIG requirement.
- Updated the SPDX license to GPL-2.0 based on Shuah's review.
- Updated the secureboot mode test to check the SetupMode as well, based
  on David Young's review.

Mimi Zohar (8):
  selftests/kexec: move the IMA kexec_load selftest to selftests/kexec
  selftests/kexec: cleanup the kexec selftest
  selftests/kexec: define a set of common functions
  selftests/kexec: define common logging functions
  kselftest/kexec: define "require_root_privileges"
  selftests/kexec: kexec_file_load syscall test
  selftests/kexec: check kexec_load and kexec_file_load are enabled
  selftests/kexec: make kexec_load test independent of IMA being enabled

Petr Vorel (1):
  selftests/kexec: Add missing '=y' to config options

 tools/testing/selftests/Makefile                   |   2 +-
 tools/testing/selftests/ima/Makefile               |  11 --
 tools/testing/selftests/ima/config                 |   4 -
 tools/testing/selftests/ima/test_kexec_load.sh     |  54 ------
 tools/testing/selftests/kexec/Makefile             |  12 ++
 tools/testing/selftests/kexec/config               |   3 +
 tools/testing/selftests/kexec/kexec_common_lib.sh  | 175 +++++++++++++++++
 .../selftests/kexec/test_kexec_file_load.sh        | 208 +++++++++++++++++++++
 tools/testing/selftests/kexec/test_kexec_load.sh   |  47 +++++
 9 files changed, 446 insertions(+), 70 deletions(-)
 delete mode 100644 tools/testing/selftests/ima/Makefile
 delete mode 100644 tools/testing/selftests/ima/config
 delete mode 100755 tools/testing/selftests/ima/test_kexec_load.sh
 create mode 100644 tools/testing/selftests/kexec/Makefile
 create mode 100644 tools/testing/selftests/kexec/config
 create mode 100755 tools/testing/selftests/kexec/kexec_common_lib.sh
 create mode 100755 tools/testing/selftests/kexec/test_kexec_file_load.sh
 create mode 100755 tools/testing/selftests/kexec/test_kexec_load.sh

-- 
2.7.5

