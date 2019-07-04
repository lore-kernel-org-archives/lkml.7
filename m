Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB365C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B27218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ldgbZI8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfGDQjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:39:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42818 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDQjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:39:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64GXaCk130162;
        Thu, 4 Jul 2019 16:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=bBjnE+5ZfaiZIxaSGl2VijkZx98gp+NLRryM7lZTEFM=;
 b=ldgbZI8kaFOedg/YHZmNkF/BP9vCutG4iLW0U2U2hxZxVEOxTRGdAare7ChGkRNJpKUG
 Jd4Oz1UsHT2VQrtA6j5B8DxX5W8TOn2JVWgA22gDGGbIrMJvyY0LCPJ6x30EiT5MGmSN
 81J/O2eaSIaDU2WEQFALdohYoUpMli9n3zz5xAVd3KsmZtK4JtwG94iNaVMN9dVncYby
 5DdtfnXj9KGKmdQ9/QRVT3A/V2sDKt3NEhu+vxcoSIL1nW6TfNbS7dMYJLURPWihglxd
 +9GWtiK4TSP6GfMhn6jchJdudSnBgcZVbOG06A2+kB8EnNb/VxbQ2Ibn879Y3PCj8Nzy OA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2te61q7mev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 16:38:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64GX85c030742;
        Thu, 4 Jul 2019 16:36:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2th5qmc8he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 16:36:43 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x64GafEp023502;
        Thu, 4 Jul 2019 16:36:41 GMT
Received: from tomti.i.net-space.pl (/10.175.209.195)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jul 2019 09:36:41 -0700
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, corbet@lwn.net, dpsmith@apertussolutions.com,
        eric.snowberg@oracle.com, hpa@zytor.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, mingo@redhat.com,
        ross.philipson@oracle.com, tglx@linutronix.de
Subject: [PATCH v2 2/3] x86/boot: Introduce the setup_indirect
Date:   Thu,  4 Jul 2019 18:36:11 +0200
Message-Id: <20190704163612.14311-3-daniel.kiper@oracle.com>
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

The setup_data is a bit awkward to use for extremely large data objects,
both because the setup_data header has to be adjacent to the data object
and because it has a 32-bit length field. However, it is important that
intermediate stages of the boot process have a way to identify which
chunks of memory are occupied by kernel data.

Thus we introduce a uniform way to specify such indirect data as
setup_indirect struct and SETUP_INDIRECT type.

This patch does not bump setup_header version in arch/x86/boot/header.S
because it will be followed by additional changes coming into the
Linux/x86 boot protocol.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Reviewed-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
---
v2 - suggestions/fixes:
   - add setup_indirect usage example
     (suggested by Eric Snowberg and Ross Philipson).
---
 Documentation/x86/boot.rst            | 38 ++++++++++++++++++++++++++++++++++-
 arch/x86/include/uapi/asm/bootparam.h | 11 +++++++++-
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index a934a56f0516..23d3726d54fc 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -73,7 +73,7 @@ Protocol 2.14:	BURNT BY INCORRECT COMMIT ae7e1238e68f2a472a125673ab506d49158c188
 		(x86/boot: Add ACPI RSDP address to setup_header)
 		DO NOT USE!!! ASSUME SAME AS 2.13.
 
-Protocol 2.15:	(Kernel 5.3) Added the kernel_info.
+Protocol 2.15:	(Kernel 5.3) Added the kernel_info and setup_indirect.
 =============	============================================================
 
 .. note::
@@ -827,6 +827,42 @@ Protocol:	2.09+
   sure to consider the case where the linked list already contains
   entries.
 
+  The setup_data is a bit awkward to use for extremely large data objects,
+  both because the setup_data header has to be adjacent to the data object
+  and because it has a 32-bit length field. However, it is important that
+  intermediate stages of the boot process have a way to identify which
+  chunks of memory are occupied by kernel data.
+
+  Thus setup_indirect struct and SETUP_INDIRECT type were introduced in
+  protocol 2.15.
+  
+  struct setup_indirect {
+    __u32 type;
+    __u32 reserved;  /* Reserved, must be set to zero. */
+    __u64 len;
+    __u64 addr;
+  };
+
+  The type member is itself simply a SETUP_* type. However, it cannot be
+  SETUP_INDIRECT since making the setup_indirect a tree structure could
+  require a lot of stack space in something that needs to parse it and
+  stack space can be limited in boot contexts.
+
+  Let's give an example how to point to SETUP_E820_EXT data using setup_indirect.
+  In this case setup_data and setup_indirect will look like this:
+
+  struct setup_data {
+    __u64 next = 0 or <addr_of_next_setup_data_struct>;
+    __u32 type = SETUP_INDIRECT;
+    __u32 len = sizeof(setup_data);
+    __u8 data[sizeof(setup_indirect)] = struct setup_indirect {
+      __u32 type = SETUP_E820_EXT;
+      __u32 reserved = 0;
+      __u64 len = <len_of_SETUP_E820_EXT_data>;
+      __u64 addr = <addr_of_SETUP_E820_EXT_data>;
+    }
+  }
+
 ============	============
 Field name:	pref_address
 Type:		read (reloc)
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index b05318112452..aaaa17fa6ad6 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_BOOTPARAM_H
 #define _ASM_X86_BOOTPARAM_H
 
-/* setup_data types */
+/* setup_data/setup_indirect types */
 #define SETUP_NONE			0
 #define SETUP_E820_EXT			1
 #define SETUP_DTB			2
@@ -10,6 +10,7 @@
 #define SETUP_EFI			4
 #define SETUP_APPLE_PROPERTIES		5
 #define SETUP_JAILHOUSE			6
+#define SETUP_INDIRECT			7
 
 /* ram_size flags */
 #define RAMDISK_IMAGE_START_MASK	0x07FF
@@ -47,6 +48,14 @@ struct setup_data {
 	__u8 data[0];
 };
 
+/* extensible setup indirect data node */
+struct setup_indirect {
+	__u32 type;
+	__u32 reserved;  /* Reserved, must be set to zero. */
+	__u64 len;
+	__u64 addr;
+};
+
 struct setup_header {
 	__u8	setup_sects;
 	__u16	root_flags;
-- 
2.11.0

