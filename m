Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41D8C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE0F2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfIYEGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 00:06:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbfIYEGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 00:06:41 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8P41te5113925
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 00:06:40 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v7xdevdcy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 00:06:40 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 25 Sep 2019 05:06:38 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Sep 2019 05:06:34 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8P46Xkf50266234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 04:06:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A01A4A4059;
        Wed, 25 Sep 2019 04:06:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E42B1A4055;
        Wed, 25 Sep 2019 04:06:31 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.31.69])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Sep 2019 04:06:31 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org, christophe.leroy@c-s.fr
Cc:     npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v4 0/5] Powerpc/Watchpoint: Few important fixes
Date:   Wed, 25 Sep 2019 09:36:25 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19092504-0012-0000-0000-000003503F5F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092504-0013-0000-0000-0000218AD173
Message-Id: <20190925040630.6948-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-25_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909250039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-July/193339.html

v3->v4:
 - Instead of considering exception as extraneous when dar is outside of
   user specified range, analyse the instruction and check for overlap
   between user specified range and actual load/store range.
 - Add selftest for the same in perf-hwbreak.c
 - Make ptrace-hwbreak.c selftest more strict by checking address in
   check_success.
 - Support for 8xx in ptrace-hwbreak.c selftest (Build tested only)
 - Rebase to powerpc/next

@Christope, Can you please check Patch 5. I've just build-tested it
with ep88xc_defconfig.

Ravi Bangoria (5):
  Powerpc/Watchpoint: Fix length calculation for unaligned target
  Powerpc/Watchpoint: Don't ignore extraneous exceptions blindly
  Powerpc/Watchpoint: Rewrite ptrace-hwbreak.c selftest
  Powerpc/Watchpoint: Add dar outside test in perf-hwbreak.c selftest
  Powerpc/Watchpoint: Support for 8xx in ptrace-hwbreak.c selftest

 arch/powerpc/include/asm/debug.h              |   1 +
 arch/powerpc/include/asm/hw_breakpoint.h      |   9 +-
 arch/powerpc/kernel/dawr.c                    |   6 +-
 arch/powerpc/kernel/hw_breakpoint.c           |  76 ++-
 arch/powerpc/kernel/process.c                 |  46 ++
 arch/powerpc/kernel/ptrace.c                  |  37 +-
 arch/powerpc/xmon/xmon.c                      |   3 +-
 .../selftests/powerpc/ptrace/perf-hwbreak.c   | 111 +++-
 .../selftests/powerpc/ptrace/ptrace-hwbreak.c | 579 +++++++++++-------
 9 files changed, 595 insertions(+), 273 deletions(-)

-- 
2.21.0

