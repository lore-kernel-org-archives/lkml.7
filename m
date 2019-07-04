Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379A3C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071F22085A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hRxz717a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfGDQhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:37:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52566 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDQhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:37:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64GXjN6118928;
        Thu, 4 Jul 2019 16:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=NcEmgxFBkFhHtsmzHQMfdfD6CfmHpDivA+w7qyMfS38=;
 b=hRxz717aoeNnSARD0LpeSZul2T3ZtwlydauRX1/Zc6j2LHZfHtpJfmaag8+xsYBppedH
 r51OP+Z2vTp65LNqljauvjt+wwlbA5YmWBP3u/5mD+YMgoAuBcJ52tsZ29oMauhPstus
 /qT6qB/IljI/XWvBplLt8srirE1J0+bmuxUb8B1t7TEUMM2MzlhEQXgAgo15A+jKeTb4
 txa9orNnS/bo+gIft8CCmmTir96K0m9HnfFSER3ngTyfFq5wQmef3PZ2De9J/4wDBT7V
 9L+4s7tRYrA/5KmFrEn2wjhxyVJKkTnWM1AaxnH8QMNwHYiEdu+aet8jalq3RkXMHeLq rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2te61efkbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 16:36:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64GXjmP146881;
        Thu, 4 Jul 2019 16:36:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2th9ec1vs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 16:36:46 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x64GaiRq015099;
        Thu, 4 Jul 2019 16:36:44 GMT
Received: from tomti.i.net-space.pl (/10.175.209.195)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jul 2019 09:36:44 -0700
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, corbet@lwn.net, dpsmith@apertussolutions.com,
        eric.snowberg@oracle.com, hpa@zytor.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, mingo@redhat.com,
        ross.philipson@oracle.com, tglx@linutronix.de
Subject: [PATCH v2 3/3] x86/boot: Introduce the kernel_info.setup_type_max
Date:   Thu,  4 Jul 2019 18:36:12 +0200
Message-Id: <20190704163612.14311-4-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190704163612.14311-1-daniel.kiper@oracle.com>
References: <20190704163612.14311-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907040210
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907040210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This field contains maximal allowed type for setup_data and
setup_indirect structs.

And finally bump setup_header version in arch/x86/boot/header.S.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
Reviewed-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 Documentation/x86/boot.rst             | 10 +++++++++-
 arch/x86/boot/compressed/kernel_info.S |  4 ++++
 arch/x86/boot/header.S                 |  2 +-
 arch/x86/include/uapi/asm/bootparam.h  |  3 +++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 23d3726d54fc..63609fd0517f 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -73,7 +73,8 @@ Protocol 2.14:	BURNT BY INCORRECT COMMIT ae7e1238e68f2a472a125673ab506d49158c188
 		(x86/boot: Add ACPI RSDP address to setup_header)
 		DO NOT USE!!! ASSUME SAME AS 2.13.
 
-Protocol 2.15:	(Kernel 5.3) Added the kernel_info and setup_indirect.
+Protocol 2.15:	(Kernel 5.3) Added the kernel_info, kernel_info.setup_type_max
+		and setup_indirect.
 =============	============================================================
 
 .. note::
@@ -980,6 +981,13 @@ Offset/size:	0x0004/4
   This field contains the size of the kernel_info including kernel_info.header.
   It should be used by the boot loader to detect supported fields in the kernel_info.
 
+============	==============
+Field name:	setup_type_max
+Offset/size:	0x0008/4
+============	==============
+
+  This field contains maximal allowed type for setup_data and setup_indirect structs.
+
 
 The Image Checksum
 ==================
diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
index 3f1cb301b9ff..2f28aabf6558 100644
--- a/arch/x86/boot/compressed/kernel_info.S
+++ b/arch/x86/boot/compressed/kernel_info.S
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#include <asm/bootparam.h>
+
 	.section ".rodata.kernel_info", "a"
 
 	.global kernel_info
@@ -9,4 +11,6 @@ kernel_info:
 	.ascii	"InfO"
         /* Size. */
 	.long	kernel_info_end - kernel_info
+        /* Maximal allowed type for setup_data and setup_indirect structs. */
+	.long	SETUP_TYPE_MAX
 kernel_info_end:
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index ec6a25a43148..893a456663ab 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -300,7 +300,7 @@ _start:
 	# Part 2 of the header, from the old setup.S
 
 		.ascii	"HdrS"		# header signature
-		.word	0x020d		# header version number (>= 0x0105)
+		.word	0x020f		# header version number (>= 0x0105)
 					# or else old loadlin-1.5 will fail)
 		.globl realmode_swtch
 realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index aaaa17fa6ad6..2ba870dae6f3 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -12,6 +12,9 @@
 #define SETUP_JAILHOUSE			6
 #define SETUP_INDIRECT			7
 
+/* max(SETUP_*) */
+#define SETUP_TYPE_MAX			SETUP_INDIRECT
+
 /* ram_size flags */
 #define RAMDISK_IMAGE_START_MASK	0x07FF
 #define RAMDISK_PROMPT_FLAG		0x8000
-- 
2.11.0

