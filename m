Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193B4CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E346720B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbfJVKdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 06:33:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730197AbfJVKdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:33:37 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9MAXEl5111333;
        Tue, 22 Oct 2019 06:33:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vsxm8uh9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 06:33:21 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9MAXL7M111933;
        Tue, 22 Oct 2019 06:33:21 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vsxm8uh90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 06:33:21 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9MAUmVM007385;
        Tue, 22 Oct 2019 10:33:20 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 2vqt46muur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 10:33:20 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9MAXJev53346812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 10:33:19 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E37AAC059;
        Tue, 22 Oct 2019 10:33:19 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F2DCAC05E;
        Tue, 22 Oct 2019 10:33:19 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.31.210])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 22 Oct 2019 10:33:19 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 246DB2E31C4; Tue, 22 Oct 2019 16:03:17 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamaleshb@in.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v2 1/1] pseries/hotplug-cpu: Change default behaviour of cede_offline to "off"
Date:   Tue, 22 Oct 2019 16:03:11 +0530
Message-Id: <1571740391-3251-2-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571740391-3251-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1571740391-3251-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910220095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Currently on PSeries Linux guests, the offlined CPU can be put to one
of the following two states:
   - Long term processor cede (also called extended cede)
   - Returned to the hypervisor via RTAS "stop-self" call.

This is controlled by the kernel boot parameter "cede_offline=on/off".

By default the offlined CPUs enter extended cede. The PHYP hypervisor
considers CPUs in extended cede to be "active" since they are still
under the control fo the Linux guests. Hence, when we change the SMT
modes by offlining the secondary CPUs, the PURR and the RWMR SPRs will
continue to count the values for offlined CPUs in extended cede as if
they are online. This breaks the accounting in tools such as lparstat.

To fix this, ensure that by default the offlined CPUs are returned to
the hypervisor via RTAS "stop-self" call by changing the default value
of "cede_offline_enabled" to false.

Fixes: commit 3aa565f53c39 ("powerpc/pseries: Add hooks to put the CPU
into an appropriate offline state")

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 Documentation/core-api/cpu_hotplug.rst       |  2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index 4a50ab7..5319593 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -53,7 +53,7 @@ Command Line Switches
 ``cede_offline={"off","on"}``
   Use this option to disable/enable putting offlined processors to an extended
   ``H_CEDE`` state on supported pseries platforms. If nothing is specified,
-  ``cede_offline`` is set to "on".
+  ``cede_offline`` is set to "off".
 
   This option is limited to the PowerPC architecture.
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index bbda646..f9d0366 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -46,7 +46,17 @@ static DEFINE_PER_CPU(enum cpu_state_vals, preferred_offline_state) =
 
 static enum cpu_state_vals default_offline_state = CPU_STATE_OFFLINE;
 
-static bool cede_offline_enabled __read_mostly = true;
+/*
+ * Determines whether the offlined CPUs should be put to a long term
+ * processor cede (called extended cede) for power-saving
+ * purposes. The CPUs in extended cede are still with the Linux Guest
+ * and are not returned to the Hypervisor.
+ *
+ * By default, the offlined CPUs are returned to the hypervisor via
+ * RTAS "stop-self". This behaviour can be changed by passing the
+ * kernel commandline parameter "cede_offline=on".
+ */
+static bool cede_offline_enabled __read_mostly;
 
 /*
  * Enable/disable cede_offline when available.
-- 
1.9.4

