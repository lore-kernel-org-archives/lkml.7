Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936F0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7642082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbfDBRrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:47:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730256AbfDBRrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:47:03 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x32HiKwX132437
        for <linux-kernel@vger.kernel.org>; Tue, 2 Apr 2019 13:47:02 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rmc12s9aj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 13:47:01 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <walling@linux.ibm.com>;
        Tue, 2 Apr 2019 18:47:00 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Apr 2019 18:46:57 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x32HktAe12910602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 17:46:55 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FC7C112062;
        Tue,  2 Apr 2019 17:46:55 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5078A112061;
        Tue,  2 Apr 2019 17:46:55 +0000 (GMT)
Received: from T470p.pok.ibm.com (unknown [9.56.58.47])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Apr 2019 17:46:55 +0000 (GMT)
From:   Collin Walling <walling@linux.ibm.com>
To:     pbonzini@redhat.com, david@redhat.com, cohuck@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com
Subject: [PATCH v3 0/2] Use DIAG318 to set Control Program Name & Version Codes
Date:   Tue,  2 Apr 2019 13:46:34 -0400
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040217-0072-0000-0000-000004148296
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010862; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183350; UDB=6.00619517; IPR=6.00964098;
 MB=3.00026263; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-02 17:46:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040217-0073-0000-0000-00004BAFF3D5
Message-Id: <20190402174636.15175-1-walling@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=875 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:

    v3
        - kernel patch for diag 0x318 instruction call fixup
            - this is to support QEMU changes found here:
              https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg00328.html
        - removed CPU model code
        - cleaned up diag318_info struct
        - cpnc is no longer unshadowed as it was not needed
        - rebased on 5.1.0-rc3

This instruction call is executed once-and-only-once during Kernel setup.
The availability of this instruction depends on Read SCP Info byte 134, bit 0.
Diagnose318's functionality is also emulated by KVM, which means we can 
enable this feature for a guest even if the host kernel cannot support it.

The CPNC and CPVC are used for problem diagnosis and allows IBM to identify 
control program information by answering the following question:

    "What environment is this guest running in?" (CPNC)
    "What are more details regarding the OS?" (CPVC)

In the future, we will implement the Control Program Version Code (CPVC) to
convey more information about the OS. For now, we set this field to 0 until
we come up with a solid plan.

Collin Walling (2):
  s390/setup: diag318: remove bit check and refactor struct
  s390/kvm: diagnose 318 handling

 Documentation/virtual/kvm/devices/vm.txt | 14 ++++
 arch/s390/include/asm/diag.h             |  6 +-
 arch/s390/include/asm/kvm_host.h         |  7 +-
 arch/s390/include/uapi/asm/kvm.h         |  4 ++
 arch/s390/kernel/setup.c                 | 12 ++--
 arch/s390/kvm/diag.c                     | 17 +++++
 arch/s390/kvm/kvm-s390.c                 | 83 ++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.h                 |  1 +
 arch/s390/kvm/vsie.c                     |  2 +
 9 files changed, 134 insertions(+), 12 deletions(-)

-- 
2.20.1

