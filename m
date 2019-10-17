Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB6BFA3730
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85EB20663
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439423AbfJQJcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:32:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393479AbfJQJcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:32:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9H9O8BD127700
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 05:32:15 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vpkudc395-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 05:32:15 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 17 Oct 2019 10:32:13 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Oct 2019 10:32:10 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9H9W9BU21430454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 09:32:09 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53E7E4C050;
        Thu, 17 Oct 2019 09:32:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96AE54C059;
        Thu, 17 Oct 2019 09:32:06 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.56.216])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Oct 2019 09:32:06 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     christophe.leroy@c-s.fr, mpe@ellerman.id.au, mikey@neuling.org
Cc:     npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v6 0/7] Powerpc/Watchpoint: Few important fixes
Date:   Thu, 17 Oct 2019 15:01:57 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101709-0016-0000-0000-000002B8DDF5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101709-0017-0000-0000-0000331A0546
Message-Id: <20191017093204.7511-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-October/198069.html

v5->v6:
 - patch 6/7: mpe reported that the perf-hwbreak.c doesn't compile with older
   gcc:
        perf-hwbreak.c:182:2: error: dereferencing type-punned pointer will
        break strict-aliasing rules [-Werror=strict-aliasing]
            temp16 = *((__u16 *)target);
            ^
   Fixed that.

Ravi Bangoria (7):
  Powerpc/Watchpoint: Introduce macros for watchpoint length
  Powerpc/Watchpoint: Fix length calculation for unaligned target
  Powerpc/Watchpoint: Fix ptrace code that muck around with address/len
  Powerpc/Watchpoint: Don't ignore extraneous exceptions blindly
  Powerpc/Watchpoint: Rewrite ptrace-hwbreak.c selftest
  Powerpc/Watchpoint: Add dar outside test in perf-hwbreak.c selftest
  Powerpc/Watchpoint: Support for 8xx in ptrace-hwbreak.c selftest

 arch/powerpc/include/asm/hw_breakpoint.h      |   9 +-
 arch/powerpc/kernel/dawr.c                    |   6 +-
 arch/powerpc/kernel/hw_breakpoint.c           | 119 ++--
 arch/powerpc/kernel/process.c                 |   3 +
 arch/powerpc/kernel/ptrace.c                  |  16 +-
 arch/powerpc/xmon/xmon.c                      |   2 +-
 .../selftests/powerpc/ptrace/perf-hwbreak.c   | 119 +++-
 .../selftests/powerpc/ptrace/ptrace-hwbreak.c | 581 +++++++++++-------
 8 files changed, 590 insertions(+), 265 deletions(-)

-- 
2.21.0

