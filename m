Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F28C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5EA21855
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xHc7JZPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390382AbfEXJ4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 05:56:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57888 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390247AbfEXJ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 05:56:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4O9rYtP154062;
        Fri, 24 May 2019 09:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=gph/cZtiNouDdoN+j1zsu+fZav7CrzoQ3asuHLB7WAM=;
 b=xHc7JZPtrR3yGBCBdSUIC6QItzPJ6112PvNTPnsdtI+15j82K4ObCHLmlo0+zq81ESBf
 b3vchUJWuh4hlHZ3VKP+fz3K6eZS9qrgd7YTWd0f4Ke9B6TtT/zLeLJUyd6HcVVJrlVD
 87Y7pOeLXHWQPSXufLC6+9NK7qXjwGEAvYtK+lZJ843OBl4TMTAuQNaPydBIRsyh7n51
 cnjIwHDRi9Yoa9ENnxL1GA/9nbSlOMkYrRVXv7rzmc/1SQoNUXqNzIIcL82TTfsOA9JG
 6r2InjI10ZlRVbE0Ix+gqSXAT9Os7ULyLoyEwS+DiyeAfKjRRUi+qBtNPFtNZH/7IRLq Zw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2smsk5g2qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 09:56:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4O9tlVn151536;
        Fri, 24 May 2019 09:56:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2smsgw1gk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 09:56:05 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4O9u4tl023849;
        Fri, 24 May 2019 09:56:04 GMT
Received: from tomti.i.net-space.pl (/10.175.163.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 May 2019 09:56:04 +0000
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     dpsmith@apertussolutions.com, eric.snowberg@oracle.com,
        hpa@zytor.com, kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        ross.philipson@oracle.com
Subject: [PATCH RFC 2/2] x86/boot: Introduce dummy MLE header
Date:   Fri, 24 May 2019 11:55:04 +0200
Message-Id: <20190524095504.12894-3-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190524095504.12894-1-daniel.kiper@oracle.com>
References: <20190524095504.12894-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9266 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905240068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9266 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905240068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DO NOT APPLY!!!

THIS PATCH INTRODUCES DUMMY MLE HEADER AND SIMPLY ILLUSTRATES HOW TO
EXTEND THE setup_header2 PROPERLY.

DO NOT APPLY!!!

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
---
 Documentation/x86/boot.txt               |  6 ++++++
 arch/x86/Kconfig                         |  7 +++++++
 arch/x86/boot/compressed/Makefile        |  1 +
 arch/x86/boot/compressed/setup_header2.S |  6 ++++++
 arch/x86/boot/compressed/sl_stub.S       | 28 ++++++++++++++++++++++++++++
 5 files changed, 48 insertions(+)
 create mode 100644 arch/x86/boot/compressed/sl_stub.S

diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.txt
index ff10c6116662..09cf50d7dca2 100644
--- a/Documentation/x86/boot.txt
+++ b/Documentation/x86/boot.txt
@@ -793,6 +793,12 @@ Offset/size:	0x0004/4
   This field contains the size of the setup_header2 including setup_header2.header.
   It should be used by the boot loader to detect supported fields in the setup_header2.
 
+Field name:	mle_header_offset
+Offset/size:	0x0008/4
+
+  This field contains the MLE header offset from the beginning of the kernel image.
+  If it is set to zero then it means that MLE header is not build into the kernel.
+
 
 **** THE IMAGE CHECKSUM
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5ad92419be19..021e274ede54 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1961,6 +1961,13 @@ config EFI_MIXED
 
 	   If unsure, say N.
 
+config SECURE_LAUNCH_STUB
+       bool "Secure Launch stub support"
+       depends on X86_64
+       ---help---
+         This kernel feature allows a bzImage to be loaded directly
+         through Intel TXT or AMD SKINIT measured launch.
+
 config SECCOMP
 	def_bool y
 	prompt "Enable seccomp to safely compute untrusted bytecode"
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index c12ccc2bd923..9722d119e19a 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -78,6 +78,7 @@ vmlinux-objs-y := $(obj)/vmlinux.lds $(obj)/setup_header2.o $(obj)/head_$(BITS).
 
 vmlinux-objs-$(CONFIG_EARLY_PRINTK) += $(obj)/early_serial_console.o
 vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr.o
+vmlinux-objs-$(CONFIG_SECURE_LAUNCH_STUB) += $(obj)/sl_stub.o
 ifdef CONFIG_X86_64
 	vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr_64.o
 	vmlinux-objs-y += $(obj)/mem_encrypt.o
diff --git a/arch/x86/boot/compressed/setup_header2.S b/arch/x86/boot/compressed/setup_header2.S
index 0b3963296825..eb732626fd22 100644
--- a/arch/x86/boot/compressed/setup_header2.S
+++ b/arch/x86/boot/compressed/setup_header2.S
@@ -9,4 +9,10 @@ setup_header2:
 	.ascii	"hDR2"
         /* Size. */
 	.long	setup_header2_end - setup_header2
+        /* MLE header offset. */
+#ifdef CONFIG_SECURE_LAUNCH_STUB
+	.long	mle_header
+#else
+	.long	0
+#endif
 setup_header2_end:
diff --git a/arch/x86/boot/compressed/sl_stub.S b/arch/x86/boot/compressed/sl_stub.S
new file mode 100644
index 000000000000..34f5000528e4
--- /dev/null
+++ b/arch/x86/boot/compressed/sl_stub.S
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2019 Oracle and/or its affiliates. All rights reserved.
+ *
+ * Author(s):
+ *     Ross Philipson <ross.philipson@oracle.com>
+ */
+	.code32
+	.text
+
+	/* The MLE Header per the TXT Specification, section 4.1 */
+	.global	mle_header
+
+mle_header:
+	.long	0x9082ac5a    /* UUID0 */
+	.long	0x74a7476f    /* UUID1 */
+	.long	0xa2555c0f    /* UUID2 */
+	.long	0x42b651cb    /* UUID3 */
+	.long	0x00000034    /* MLE header size */
+	.long	0x00020002    /* MLE version 2.2 */
+	.long	0x01234567    /* Linear entry point of MLE (virt. address) */
+	.long	0x00000000    /* First valid page of MLE */
+	.long	0x00000000    /* Offset within binary of first byte of MLE */
+	.long	0x00000000    /* Offset within binary of last byte + 1 of MLE */
+	.long	0x00000223    /* Bit vector of MLE-supported capabilities */
+	.long	0x00000000    /* Starting linear address of command line */
+	.long	0x00000000    /* Ending linear address of command line */
-- 
2.11.0

