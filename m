Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7917C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF45218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfCVHbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:31:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbfCVHbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:31:31 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2M7O6Yp074820
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:31:30 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rcu3f0t7v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:31:30 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Fri, 22 Mar 2019 07:31:26 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Mar 2019 07:31:23 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2M7VOP022085792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 07:31:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E039F11C05B;
        Fri, 22 Mar 2019 07:31:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C422C11C064;
        Fri, 22 Mar 2019 07:31:22 +0000 (GMT)
Received: from boston16h.aus.stglabs.ibm.com (unknown [9.3.23.78])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Mar 2019 07:31:22 +0000 (GMT)
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH 0/2] Auto-promotion logic for cpuidle states
Date:   Fri, 22 Mar 2019 02:29:40 -0500
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19032207-0028-0000-0000-00000356F672
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032207-0029-0000-0000-000024159FD6
Message-Id: <20190322072942.8038-1-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=535 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903220057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the cpuidle governors (menu/ladder) determine what idle state a
idling CPU should enter into based on heuristics that depend on the idle
history on that CPU. Given that no predictive heuristic is perfect, there
are cases where the governor predicts a shallow idle state, hoping that
the CPU will be busy soon. However, if no new workload is scheduled on
that CPU in the near future, the CPU will end up in the shallow state.

Motivation
----------
In case of POWER, this is problematic, when the predicted state in the
aforementioned scenario is a lite stop state, as such lite states will
inhibit SMT folding, thereby depriving the other threads in the core from
using the core resources.

To address this, such lite states need to be autopromoted. The cpuidle-core
can queue timer to correspond with the residency value of the next
available state. Thus leading to auto-promotion to a deeper idle state as
soon as possible.

Experiment
----------
Without this patch -
It was seen that for a idle system, a cpu may remain in stop0_lite for few
seconds and then directly goes to a deeper state such as stop2.

With this patch -
A cpu will not remain in stop0_lite for more than the residency of next
available state, and thus it will go to a deeper state in conservative
fashion. Using this, we may spent even less than 20 milliseconds if
susbsequent stop states are enabled. In the worst case, we may end up
spending more than a second, as was the case without this patch. The
worst case will occur in the scenario when no other shallow states are
enbaled, and only deep states are available for auto-promotion.

Abhishek Goel (2):
  cpuidle : auto-promotion for cpuidle states
  cpuidle : Add auto-promotion flag to cpuidle flags

 arch/powerpc/include/asm/opal-api.h |  1 +
 drivers/cpuidle/Kconfig             |  4 ++
 drivers/cpuidle/cpuidle-powernv.c   | 13 ++++-
 drivers/cpuidle/cpuidle.c           | 79 ++++++++++++++++++++++++++++-
 drivers/cpuidle/governors/ladder.c  |  3 +-
 drivers/cpuidle/governors/menu.c    | 23 ++++++++-
 include/linux/cpuidle.h             | 12 +++--
 7 files changed, 127 insertions(+), 8 deletions(-)

-- 
2.17.1

