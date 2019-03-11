Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3E8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F132084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfCKLl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:41:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727306AbfCKLl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:41:56 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BBf1Gc007183
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:41:55 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r5ngcm1tg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:41:54 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 11 Mar 2019 11:41:51 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Mar 2019 11:41:48 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2BBflUR20643962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Mar 2019 11:41:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A611811C05B;
        Mon, 11 Mar 2019 11:41:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 968E711C052;
        Mon, 11 Mar 2019 11:41:46 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.93.170])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Mar 2019 11:41:46 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Dave Young <dyoung@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v3 0/7] selftests/ima: add kexec and kernel module tests
Date:   Mon, 11 Mar 2019 07:41:06 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19031111-0012-0000-0000-000003013BC7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031111-0013-0000-0000-0000213856CF
Message-Id: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
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

The kernel can be configured to require kexec kernel images and kernel
modules are signed.  An IMA policy can be specified on the boot command
line or a custom IMA policy loaded requiring the kexec kernel image and
kernel modules be signed.  In addition, systems booted in secure boot
mode with the IMA architecture specific policy enabled, require validly
signed kexec kernel images and kernel modules.

In addition to two methods of signing kernel images and two methods of
signing kernel modules, there are two syscalls for each.

kernel image:  PE signature, IMA signature
kexec syscalls: kexec_load, kexec_file_load

Both the PE and IMA kernel image signature can only be verified when
loaded via the kexec_file_load syscall.

kernel moodule: appended signature, IMA signature
kernel module syscalls: init_module, finit_module

The appended kernel module signature can be verified when the kernel
module is loaded via either syscall.  The IMA kernel module signature
can only be verified when the kernel module is loaded via the
finit_module syscall.

The selftests in this patch set verify that only signed kernel images
and kernel modules are loaded as required, based on the kernel config,
the secure boot mode, and the IMA runtime policy.

Loading a kernel image or kernel module requires root privileges.  To
run just the IMA selftests: sudo make TARGETS=ima kselftest

Changelog:
- Updated tests based on Petr's review, including the defining a common
  test to check for root privileges.
- Modified config, removing the CONFIG_KEXEC_VERIFY_SIG requirement.
- Updated the SPDX license to GPL-2.0 based on Shuah's review.
- Updated the secureboot mode test to check the SetupMode as well, based
  on David Young's review.


Mimi Zohar (6):
  selftests/ima: cleanup the kexec selftest
  selftests/ima: define a set of common functions
  selftests/ima: define common logging functions
  kselftest/ima: define "require_root_privileges"
  selftests/ima: kexec_file_load syscall test
  selftests/ima: loading kernel modules

Petr Vorel (1):
  selftests/ima: Add missing '=y' to config options

 tools/testing/selftests/ima/Makefile               |   3 +-
 tools/testing/selftests/ima/config                 |   7 +-
 tools/testing/selftests/ima/ima_common_lib.sh      | 173 +++++++++++++++++++
 tools/testing/selftests/ima/test_kernel_module.sh  |  93 ++++++++++
 .../testing/selftests/ima/test_kexec_file_load.sh  | 190 +++++++++++++++++++++
 tools/testing/selftests/ima/test_kexec_load.sh     |  53 ++----
 6 files changed, 476 insertions(+), 43 deletions(-)
 create mode 100755 tools/testing/selftests/ima/ima_common_lib.sh
 create mode 100755 tools/testing/selftests/ima/test_kernel_module.sh
 create mode 100755 tools/testing/selftests/ima/test_kexec_file_load.sh

-- 
2.7.5

