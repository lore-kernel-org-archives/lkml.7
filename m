Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C039C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB9721655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409796AbfIXQPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:15:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409781AbfIXQPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:15:05 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8OGA6Wl096323;
        Tue, 24 Sep 2019 12:14:42 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v7mdepqgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 12:14:42 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8OGAXn7009028;
        Tue, 24 Sep 2019 16:14:42 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01wdc.us.ibm.com with ESMTP id 2v5bg6x0sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 16:14:42 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8OGEeLl60227958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 16:14:40 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21736BE053;
        Tue, 24 Sep 2019 16:14:40 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 706A9BE04F;
        Tue, 24 Sep 2019 16:14:39 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 24 Sep 2019 16:14:39 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        andrew@aj.id.au, joel@jms.id.au, mark.rutland@arm.com,
        robh+dt@kernel.org, maz@kernel.org, jason@lakedaemon.net,
        tglx@linutronix.de, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 1/4] dt-bindings: interrupt-controller: Add Aspeed SCU interrupt controller
Date:   Tue, 24 Sep 2019 11:14:29 -0500
Message-Id: <1569341672-27632-2-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569341672-27632-1-git-send-email-eajames@linux.ibm.com>
References: <1569341672-27632-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=782 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909240147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Aspeed SCU interrupt controller and add an include file
for the interrupts it provides.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../interrupt-controller/aspeed,ast2xxx-scu-ic.txt | 26 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++++++
 .../interrupt-controller/aspeed-scu-ic.h           | 23 +++++++++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
 create mode 100644 include/dt-bindings/interrupt-controller/aspeed-scu-ic.h

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
new file mode 100644
index 0000000..baa3780
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
@@ -0,0 +1,26 @@
+Aspeed AST25XX and AST26XX SCU Interrupt Controller
+
+Required Properties:
+ - #interrupt-cells		: must be 1
+ - compatible			: must be "aspeed,ast2500-scu-ic",
+				  "aspeed,ast2600-scu-ic0" or
+				  "aspeed,ast2600-scu-ic1"
+ - reg				: address and size of the SCU register
+				  associated with the controller
+ - interrupts			: interrupt from the parent controller
+ - interrupt-controller		: indicates that the controlle receives and
+				  fires new interrupts for child busses
+
+Example:
+
+    syscon@1e6e2000 {
+        ranges = <0 0x1e6e2000 0x1a8>;
+
+        scu_ic: interrupt-controller@18 {
+            #interrupt-cells = <1>;
+            compatible = "aspeed,ast2500-scu-ic";
+            reg = <0x18 0x04>;
+            interrupts = <21>;
+            interrupt-controller;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index cda6013..4a1687b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2650,6 +2650,13 @@ S:	Maintained
 F:	drivers/pinctrl/aspeed/
 F:	Documentation/devicetree/bindings/pinctrl/aspeed,*
 
+ASPEED SCU INTERRUPT CONTROLLER DRIVER
+M:	Eddie James <eajames@linux.ibm.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
+F:	include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
+
 ASPEED VIDEO ENGINE DRIVER
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-media@vger.kernel.org
diff --git a/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h b/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
new file mode 100644
index 0000000..f315d5a
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_ASPEED_SCU_IC_H_
+#define _DT_BINDINGS_INTERRUPT_CONTROLLER_ASPEED_SCU_IC_H_
+
+#define ASPEED_SCU_IC_VGA_CURSOR_CHANGE			0
+#define ASPEED_SCU_IC_VGA_SCRATCH_REG_CHANGE		1
+
+#define ASPEED_AST2500_SCU_IC_PCIE_RESET_LO_TO_HI	2
+#define ASPEED_AST2500_SCU_IC_PCIE_RESET_HI_TO_LO	3
+#define ASPEED_AST2500_SCU_IC_LPC_RESET_LO_TO_HI	4
+#define ASPEED_AST2500_SCU_IC_LPC_RESET_HI_TO_LO	5
+#define ASPEED_AST2500_SCU_IC_ISSUE_MSI			6
+
+#define ASPEED_AST2600_SCU_IC0_PCIE_PERST_LO_TO_HI	2
+#define ASPEED_AST2600_SCU_IC0_PCIE_PERST_HI_TO_LO	3
+#define ASPEED_AST2600_SCU_IC0_PCIE_RCRST_LO_TO_HI	4
+#define ASPEED_AST2600_SCU_IC0_PCIE_RCRST_HI_TO_LO	5
+
+#define ASPEED_AST2600_SCU_IC1_LPC_RESET_LO_TO_HI	0
+#define ASPEED_AST2600_SCU_IC1_LPC_RESET_HI_TO_LO	1
+
+#endif /* _DT_BINDINGS_INTERRUPT_CONTROLLER_ASPEED_SCU_IC_H_ */
-- 
1.8.3.1

