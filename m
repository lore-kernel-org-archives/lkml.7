Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2254CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC7D2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfCMPvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:51:25 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47042 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbfCMPvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:51:20 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DFp5Kb012434;
        Wed, 13 Mar 2019 16:51:05 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2r458mjyf1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 13 Mar 2019 16:51:05 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C82E038;
        Wed, 13 Mar 2019 15:51:02 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A2A8953EF;
        Wed, 13 Mar 2019 15:51:02 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 13 Mar
 2019 16:51:02 +0100
Received: from localhost (10.201.23.25) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 13 Mar 2019 16:51:02
 +0100
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 1/6] dt-bindings: hwlock: add support of shared locks
Date:   Wed, 13 Mar 2019 16:50:32 +0100
Message-ID: <1552492237-28810-2-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552492237-28810-1-git-send-email-fabien.dessenne@st.com>
References: <1552492237-28810-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use #hwlock-cells value to define whether the locks can be shared
by several users.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 .../devicetree/bindings/hwlock/hwlock.txt          | 27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwlock/hwlock.txt b/Documentation/devicetree/bindings/hwlock/hwlock.txt
index 085d1f5..e98088a 100644
--- a/Documentation/devicetree/bindings/hwlock/hwlock.txt
+++ b/Documentation/devicetree/bindings/hwlock/hwlock.txt
@@ -13,7 +13,7 @@ hwlock providers:
 
 Required properties:
 - #hwlock-cells:        Specifies the number of cells needed to represent a
-                        specific lock.
+                        specific lock. Shall be 1 or 2 (see hwlocks below).
 
 hwlock users:
 =============
@@ -27,6 +27,11 @@ Required properties:
                         #hwlock-cells. The list can have just a single hwlock
                         or multiple hwlocks, with each hwlock represented by
                         a phandle and a corresponding args specifier.
+                        If #hwlock-cells is 1, all of the locks are exclusive
+                        (cannot be used by several users).
+                        If #hwlock-cells is 2, the value of the second cell
+                        defines whether the lock is for exclusive usage (0) or
+                        shared (1) i.e. can be used by several users.
 
 Optional properties:
 - hwlock-names:         List of hwlock name strings defined in the same order
@@ -46,14 +51,22 @@ of length 1.
 		...
 	};
 
-2. Example of a node using multiple specific hwlocks:
+2. Example of nodes using multiple and shared specific hwlocks:
 
-The following example has a node requesting two hwlocks, a hwlock within
-the hwlock device node 'hwlock1' with #hwlock-cells value of 1, and another
-hwlock within the hwlock device node 'hwlock2' with #hwlock-cells value of 2.
+The following example has a nodeA requesting two hwlocks:
+- an exclusive one (#hwlock-cells = 1) within the hwlock device node 'hwlock1'
+- a shared one (#hwlock-cells = 2, second cell = 1) within the hwlock device
+  node 'hwlock2'.
+The shared lock is also be used by nodeB.
 
-	node {
+	nodeA {
 		...
-		hwlocks = <&hwlock1 2>, <&hwlock2 0 3>;
+		hwlocks = <&hwlock1 2>, <&hwlock2 0 1>;
 		...
 	};
+
+	nodeB {
+		...
+		hwlocks = <&hwlock2 0 1>;
+		...
+	};
\ No newline at end of file
-- 
2.7.4

