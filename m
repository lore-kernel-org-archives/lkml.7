Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EB9C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690B4219BE
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C+0QOCKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfGCAac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:30:32 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44679 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfGCAaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562113830; x=1593649830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eC3388U7gS1n3ruZjbzbm4lmFXg2heaDobqQD9WiAWA=;
  b=C+0QOCKAEbhZR5v+J6be+fZLj5sqLj+N4OIkj2VMi6g1VOhwxT3bBRai
   IibQtKrjE2e4YBelg2+hmjFkkvbtUZ+JLu/6yaX9kre/EDwSWXowcWK4q
   SfSBqiJ8ZQ/EUa6goUgmZRVXqYPSHlLHibraYgn+nnsVYFBadddTTN0ch
   uzXcT5aENuSZR11Oo2r6W5YXFZ3J9MzW/iLwqN/QrofISDHuS/to0xh5a
   eoQapwb7Vdr3JiBCm+VSnPJhVTxmSArkOhSUTtMhNl5+Wauv0cn15wf7r
   qpluYtfHVvaFG7hJ1MaU0QPDG4ZYKKnSX/1xmM7iCYDvL5LnS/fHnr3lh
   Q==;
IronPort-SDR: HaOIet/84U4Y9OYdqA+YSj3E5dejzBA2JHQNSNSejoRNovxc1/HcT8JC4v41YewWEI+FdOTQBt
 EQfbUfm2RwxxsdFxzPibFlKvQT511j/a9jCSqsIKrXlGizyqw9eNlD/+aAIEEW4ISijkFZdlJ7
 1V/C0Jw7pDmGWg5jznabivI+NscZWzTPi/emOfuyFebYlkZ75plt377SmdM4+o5/klVIc+K42/
 gnZA4i6akFVNVMhukP62fySHt4yoK8QSdK0Km5FDFMivCmhZuSvVCNrfs+lA1G8FJVUIxOHyAa
 8Ik=
X-IronPort-AV: E=Sophos;i="5.63,444,1557158400"; 
   d="scan'208";a="112096601"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2019 08:21:25 +0800
IronPort-SDR: QGMJZo2F3uqD8bPYl1o0Inag62CUN451vtBcMHr0xNWTtBCF0U1+ae+SN5EoO1ofC/DsWJ3+3g
 Avbf7JF/Ly9H5oL6w9TCi12e80/z2SjzgBj10dErkc9/J8TILKuAB7bDhCjXXjYQazL8MT8ejQ
 lCqfVE4SMXVYKRYZyYhj4m+gmFZza86F2A3fz6M1DzWUOJR2RteOZ0Hg5jIBcyZEZw+O2Di0Sg
 jn+EIe2JkTzwnkEyQatWNjJoVDbiEVjMwPjcW5zxndUaNVTPlFd68ro3SXdiDQ1xdaW+7fSULj
 g82XYEeSvJEFfFi45MF+0q2k
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 02 Jul 2019 17:20:26 -0700
IronPort-SDR: /Eb1azSXdLTLOQebGrz33CI2vNFmODdRTLA82uH87JswgpR2U10iElkUtedDOuRAqydizkFavC
 1V3LPk7wntybdS20LKCcNsUYV13a/oR3UCsCX+oP1gGGF2u4a0/7kDtEuWADI+q074AHzHRlGi
 eYfQOv+tgKvepB5dQwCzMzq75pJqZz4Yg5otonrNbiED4axAAq0uoh4aFZ27cg271THISFLjPu
 fvEc+G7PrI5Dm+dGnDcyfK55mVmBt6GBpTi8E78KBJ8HMniQwTW7jbnaUwDui0msqD5udCcpA1
 bfY=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO risc6-mainframe.int.fusionio.com) ([10.196.157.140])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2019 17:21:24 -0700
From:   Alistair Francis <alistair.francis@wdc.com>
To:     linux-riscv-bounces@lists.infradead.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 1/2] uapi/asm-generic: Allow defining a custom __SIGINFO struct
Date:   Tue,  2 Jul 2019 17:18:41 -0700
Message-Id: <20190703001842.12238-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190703001842.12238-1-alistair.francis@wdc.com>
References: <20190703001842.12238-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow defining a custom __SIGINFO struct. This allows architectures to
apply their own padding and allignment requirements to the struct. This
is similar to the __ARCH_SI_ATTRIBUTES #define that already exists, but
applies to the __SIGINFO struct instead of the siginfo_t struct.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/uapi/asm-generic/siginfo.h | 32 ++++++++++++++++--------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index cb3d6c267181..09b0a1abac14 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -108,23 +108,25 @@ union __sifields {
 	} _sigsys;
 };
 
-#ifndef __ARCH_HAS_SWAPPED_SIGINFO
-#define __SIGINFO 			\
-struct {				\
-	int si_signo;			\
-	int si_errno;			\
-	int si_code;			\
-	union __sifields _sifields;	\
+#ifndef __SIGINFO
+# ifndef __ARCH_HAS_SWAPPED_SIGINFO
+# define __SIGINFO 						\
+struct {							\
+	int si_signo;						\
+	int si_errno;						\
+	int si_code;						\
+	union __sifields _sifields __ARCH_SI_ATTRIBUTES;	\
 }
-#else
-#define __SIGINFO 			\
-struct {				\
-	int si_signo;			\
-	int si_code;			\
-	int si_errno;			\
-	union __sifields _sifields;	\
+# else
+# define __SIGINFO 						\
+struct {							\
+	int si_signo;						\
+	int si_code;						\
+	int si_errno;						\
+	union __sifields _sifields __ARCH_SI_ATTRIBUTES;	\
 }
-#endif /* __ARCH_HAS_SWAPPED_SIGINFO */
+# endif /* __ARCH_HAS_SWAPPED_SIGINFO */
+#endif /* __SIGINFO */
 
 typedef struct siginfo {
 	union {
-- 
2.22.0

