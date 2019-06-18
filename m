Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4497DC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2327220B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfFROsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:48:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729295AbfFROsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:48:39 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IEmGBX162842
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 10:48:37 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t7101u73f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 10:48:29 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Tue, 18 Jun 2019 15:47:40 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Jun 2019 15:47:35 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5IElYrw52560094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 14:47:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4B7E11C04C;
        Tue, 18 Jun 2019 14:47:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDC4A11C052;
        Tue, 18 Jun 2019 14:47:32 +0000 (GMT)
Received: from naverao1-tp.ibmuc.com (unknown [9.85.74.6])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jun 2019 14:47:32 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] powerpc/ftrace: Patch out -mprofile-kernel instructions
Date:   Tue, 18 Jun 2019 20:16:59 +0530
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061814-0008-0000-0000-000002F4CECD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061814-0009-0000-0000-00002261E6AA
Message-Id: <cover.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=543 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906180119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since RFC:
- Patches 1 and 2: No changes
- Patch 3: rename function to ftrace_replace_code_rec() to signify that 
  it acts on a ftrace record.
- Patch 4: numerous small changes, including those suggested by Nick 
  Piggin.
- Patch 4: additionally handle scenario where __ftrace_make_call() can 
  be invoked without having called __ftrace_make_call_prep(), when a 
  kernel module is loaded while function tracing is active.
- Patch 5 to 7: new, to have ftrace claim ownership of two instructions, 
  and to have kprobes work properly with this.


--
On powerpc64, -mprofile-kernel results in two instructions being 
emitted: 'mflr r0' and 'bl _mcount'. So far, we were only nop'ing out 
the branch to _mcount(). This series implements an approach to also nop 
out the preceding mflr.


- Naveen


Naveen N. Rao (7):
  ftrace: Expose flags used for ftrace_replace_code()
  x86/ftrace: Fix use of flags in ftrace_replace_code()
  ftrace: Expose __ftrace_replace_code()
  powerpc/ftrace: Additionally nop out the preceding mflr with
    -mprofile-kernel
  powerpc/ftrace: Update ftrace_location() for powerpc -mprofile-kernel
  kprobes/ftrace: Use ftrace_location() when [dis]arming probes
  powerpc/kprobes: Allow probing on any ftrace address

 arch/powerpc/kernel/kprobes-ftrace.c |  30 +++
 arch/powerpc/kernel/trace/ftrace.c   | 272 ++++++++++++++++++++++++---
 arch/x86/kernel/ftrace.c             |   3 +-
 include/linux/ftrace.h               |   7 +
 kernel/kprobes.c                     |  10 +-
 kernel/trace/ftrace.c                |  17 +-
 6 files changed, 300 insertions(+), 39 deletions(-)

-- 
2.22.0

