Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A529AC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8520620989
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfF0LYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 07:24:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726308AbfF0LYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:24:09 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RBNspp007103
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 07:24:08 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tctec6w4w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 07:24:07 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 27 Jun 2019 12:24:06 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Jun 2019 12:24:03 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RBO2PK27328584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 11:24:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E46AA405B;
        Thu, 27 Jun 2019 11:24:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F0D7A405F;
        Thu, 27 Jun 2019 11:24:00 +0000 (GMT)
Received: from naverao1-tp.ibmuc.com (unknown [9.85.73.27])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 11:24:00 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/7] powerpc/ftrace: Patch out -mprofile-kernel instructions
Date:   Thu, 27 Jun 2019 16:53:48 +0530
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062711-0016-0000-0000-0000028CD918
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062711-0017-0000-0000-000032EA5657
Message-Id: <cover.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=718 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1 
(https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=114556):
- Patches 1,2,3 and 6: No changes
- Patch 4: Add smp_call_function() to flush icache on all cpus after 
  patching in the 'mflr r0' instruction.
- Patch 5: Changes as per Steven Rostedt's suggestions.
- Patch 7: Changes as per Masami and Joe Perches.

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
  ftrace: Update ftrace_location() for powerpc -mprofile-kernel
  kprobes/ftrace: Use ftrace_location() when [dis]arming probes
  powerpc/kprobes: Allow probing on any ftrace address

 arch/powerpc/include/asm/ftrace.h    |   8 +
 arch/powerpc/kernel/kprobes-ftrace.c |  32 +++-
 arch/powerpc/kernel/trace/ftrace.c   | 258 ++++++++++++++++++++++++---
 arch/x86/kernel/ftrace.c             |   3 +-
 include/linux/ftrace.h               |  15 ++
 kernel/kprobes.c                     |  10 +-
 kernel/trace/ftrace.c                |  15 +-
 7 files changed, 302 insertions(+), 39 deletions(-)

-- 
2.22.0

