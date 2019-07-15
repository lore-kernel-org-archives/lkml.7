Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F27C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CE92145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732880AbfGOWMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 18:12:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731717AbfGOWMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 18:12:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6FLwYs1143921
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 18:12:29 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ts1e19f44-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 18:12:28 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 15 Jul 2019 23:12:26 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Jul 2019 23:12:23 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6FMCMGD46661880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 22:12:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0711DA4040;
        Mon, 15 Jul 2019 22:12:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C165A404D;
        Mon, 15 Jul 2019 22:12:21 +0000 (GMT)
Received: from localhost (unknown [9.145.71.68])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 15 Jul 2019 22:12:21 +0000 (GMT)
Date:   Tue, 16 Jul 2019 00:12:19 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Petr Tesarik <PTesarik@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Raymund Will <rw@suse.com>
Subject: [PATCH] s390: enable detection of kernel version from bzImage
References: <your-ad-here.call-01563228330-ext-8076@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <your-ad-here.call-01563228330-ext-8076@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
x-cbid: 19071522-0016-0000-0000-00000292D1B5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071522-0017-0000-0000-000032F09FA6
Message-Id: <patch.git-94e9726bbfe5.your-ad-here.call-01563228538-ext-5706@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907150246
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend "parmarea" to include an offset of the version string, which is
stored as 8-byte big endian value.

To retrieve version string from bzImage reliably, one should check the
presence of "S390EP" ascii string at 0x10008 (available since v3.2),
then read the version string offset from 0x10428 (which has been 0
since v3.2 up to now). The string is null terminated.

Could be retrieved with the following "file" command magic (requires
file v5.34):
8 string \x02\x00\x00\x18\x60\x00\x00\x50\x02\x00\x00\x68\x60\x00\x00\x50\x40\x40\x40\x40\x40\x40\x40\x40 Linux S390
>0x10008       string          S390EP
>>0x10428      bequad          >0
>>>(0x10428.Q) string          >\0             \b, version %s

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/boot/Makefile       | 2 +-
 arch/s390/boot/head.S         | 1 +
 arch/s390/boot/version.c      | 6 ++++++
 arch/s390/include/asm/setup.h | 4 +++-
 4 files changed, 11 insertions(+), 2 deletions(-)
 create mode 100644 arch/s390/boot/version.c

diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index 7cba96e7587b..4cf0bddb7d92 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -36,7 +36,7 @@ CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
 
 obj-y	:= head.o als.o startup.o mem_detect.o ipl_parm.o ipl_report.o
 obj-y	+= string.o ebcdic.o sclp_early_core.o mem.o ipl_vmparm.o cmdline.o
-obj-y	+= ctype.o text_dma.o
+obj-y	+= version.o ctype.o text_dma.o
 obj-$(CONFIG_PROTECTED_VIRTUALIZATION_GUEST)	+= uv.o
 obj-$(CONFIG_RELOCATABLE)	+= machine_kexec_reloc.o
 obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
diff --git a/arch/s390/boot/head.S b/arch/s390/boot/head.S
index 028aab03a9e7..2087bed6e60f 100644
--- a/arch/s390/boot/head.S
+++ b/arch/s390/boot/head.S
@@ -361,6 +361,7 @@ ENTRY(startup_kdump)
 	.quad	0			# INITRD_SIZE
 	.quad	0			# OLDMEM_BASE
 	.quad	0			# OLDMEM_SIZE
+	.quad	kernel_version		# points to kernel version string
 
 	.org	COMMAND_LINE
 	.byte	"root=/dev/ram0 ro"
diff --git a/arch/s390/boot/version.c b/arch/s390/boot/version.c
new file mode 100644
index 000000000000..ea5e49651931
--- /dev/null
+++ b/arch/s390/boot/version.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <generated/utsrelease.h>
+#include <generated/compile.h>
+
+const char kernel_version[] = UTS_RELEASE
+	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ") " UTS_VERSION;
diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index 925889d360c1..e5d28a475f76 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -54,6 +54,7 @@
 #define INITRD_SIZE_OFFSET	0x10410
 #define OLDMEM_BASE_OFFSET	0x10418
 #define OLDMEM_SIZE_OFFSET	0x10420
+#define KERNEL_VERSION_OFFSET	0x10428
 #define COMMAND_LINE_OFFSET	0x10480
 
 #ifndef __ASSEMBLY__
@@ -74,7 +75,8 @@ struct parmarea {
 	unsigned long initrd_size;			/* 0x10410 */
 	unsigned long oldmem_base;			/* 0x10418 */
 	unsigned long oldmem_size;			/* 0x10420 */
-	char pad1[0x10480 - 0x10428];			/* 0x10428 - 0x10480 */
+	unsigned long kernel_version;			/* 0x10428 */
+	char pad1[0x10480 - 0x10430];			/* 0x10430 - 0x10480 */
 	char command_line[ARCH_COMMAND_LINE_SIZE];	/* 0x10480 */
 };
 
-- 
2.21.0

