Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B928C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370E7218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="CKcL4ouO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfDYJRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:17:49 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37911 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726887AbfDYJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:17:47 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3P91Rgv023616;
        Thu, 25 Apr 2019 11:17:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=YxS1CmFL4QUjGza2F9ElVAd/BnjMK/K8FnWYOu39aEY=;
 b=CKcL4ouOzvK6j6Z3lB1aJDZeXhk4CLwcPkktnry9uxvq8ZSdCogCTERnNiXRgcYvfP9g
 0iqjMC35nMDV07nmBhN2ohR2ojdU9n6gAu8DFGh8/4OCj3q9VRh/jqnxlfWVTLb9lf7m
 Wo7oN4OEVSwrh+V8xq1zjUOu+XD0Pch9JJxhdwb9haN1XcXJdn7/XoRI91Hrj6xBfNXn
 kI1OTQ3gBBG3XFsQrcjv1b0G0Wcjytpb38/Ui80xMl1EROsRVrnwlkyJe+uQNFBVbmdO
 MfOYhQ+hg/HhZoCwUIrRvNeE0Y038caYMUb1ajdKQNbmOKo+4LUTpkep0fNmY3YZa/Td +w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rys6s2m27-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Apr 2019 11:17:31 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0A91334;
        Thu, 25 Apr 2019 09:17:31 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D0A791615;
        Thu, 25 Apr 2019 09:17:30 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 25 Apr
 2019 11:17:30 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Apr 2019 11:17:30
 +0200
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
Subject: [PATCH v2 1/6] dt-bindings: hwlock: add support of shared locks
Date:   Thu, 25 Apr 2019 11:17:18 +0200
Message-ID: <1556183843-28033-2-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556183843-28033-1-git-send-email-fabien.dessenne@st.com>
References: <1556183843-28033-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use #hwlock-cells value to define whether the locks can be shared
by several users.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

