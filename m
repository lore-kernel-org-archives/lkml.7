Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C3FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C2B2053B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391229AbfIESUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:20:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730926AbfIESUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:20:49 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x85ICgJt124532
        for <linux-kernel@vger.kernel.org>; Thu, 5 Sep 2019 14:20:49 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uu70u19gk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 14:20:48 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 5 Sep 2019 19:20:46 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Sep 2019 19:20:44 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x85IKhi750331744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Sep 2019 18:20:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB882AE051;
        Thu,  5 Sep 2019 18:20:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7343AE045;
        Thu,  5 Sep 2019 18:20:41 +0000 (GMT)
Received: from naverao1-tp.ibmuc.com (unknown [9.85.95.49])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Sep 2019 18:20:41 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/3] powerpc/ftrace: Enable HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
Date:   Thu,  5 Sep 2019 23:50:27 +0530
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19090518-0008-0000-0000-000003118392
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090518-0009-0000-0000-00004A2FDE4D
Message-Id: <cover.1567707399.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=552 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable HAVE_FUNCTION_GRAPH_RET_ADDR_PTR for more robust stack unwinding 
when function graph tracer is in use. Convert powerpc show_stack() to 
use ftrace_graph_ret_addr() for better stack unwinding.

- Naveen

Naveen N. Rao (3):
  ftrace: Look up the address of return_to_handler() using helpers
  powerpc/ftrace: Enable HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
  powerpc: Use ftrace_graph_ret_addr() when unwinding

 arch/powerpc/include/asm/asm-prototypes.h     |  3 ++-
 arch/powerpc/include/asm/ftrace.h             |  2 ++
 arch/powerpc/kernel/process.c                 | 19 ++++++-------------
 arch/powerpc/kernel/stacktrace.c              |  2 +-
 arch/powerpc/kernel/trace/ftrace.c            |  5 +++--
 arch/powerpc/kernel/trace/ftrace_32.S         |  1 +
 .../powerpc/kernel/trace/ftrace_64_mprofile.S |  1 +
 arch/powerpc/kernel/trace/ftrace_64_pg.S      |  1 +
 kernel/trace/fgraph.c                         |  4 ++--
 9 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.23.0

