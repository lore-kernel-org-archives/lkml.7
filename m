Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44543ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FC221925
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732051AbfJNNEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:04:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732032AbfJNNEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:04:11 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9ED2CXx016389
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 09:04:11 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vmqravpvr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 09:04:10 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 14 Oct 2019 14:04:00 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Oct 2019 14:03:56 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9ED3tm259900046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 13:03:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E4194C063;
        Mon, 14 Oct 2019 13:03:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D17F4C04A;
        Mon, 14 Oct 2019 13:03:52 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.59.28])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Oct 2019 13:03:52 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     christophe.leroy@c-s.fr, mpe@ellerman.id.au, mikey@neuling.org
Cc:     npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v5 0/7] Powerpc/Watchpoint: Few important fixes
Date:   Mon, 14 Oct 2019 18:33:39 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101413-0012-0000-0000-00000357EF6B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101413-0013-0000-0000-000021930186
Message-Id: <20191014130346.22660-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910140126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-September/197621.html

v4->v5:
 - patch 1,2,3/7: Split v4 patch1 into three differnet patches.
   * 1st patch to replace hardcoded watchpoint length with macros
   * 2nd patch that fixes the unaligned watchpoint issue
   * 3rd patch that fixes ptrace code that mucks around address/len
 - patch 3/7: v4 patch1 was creating a regression in watchpoint length
   calculation in ptrace code. Fixed that.
 - patch 7/7: Disabled MODE_RANGE and 512 byte testcases for 8xx. (Build
   tested only)
 - patch 7/7: Unaligned watchpoints are not supported with DABR. Test
   unaligned watchpoint only when DAWR is present.

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
 .../selftests/powerpc/ptrace/perf-hwbreak.c   | 111 +++-
 .../selftests/powerpc/ptrace/ptrace-hwbreak.c | 581 +++++++++++-------
 8 files changed, 582 insertions(+), 265 deletions(-)

-- 
2.21.0

