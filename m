Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35CEC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D212082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bbZzfdlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389966AbfFJVUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:20:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390127AbfFJVUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OLqEwqcQdKiJLl2M9TmN5lTWvVtrhUb8Z35dqhzeL58=; b=bbZzfdlGlG93uqA9gUEJtstdXl
        AK8eyCmHJ7h+V8dBqWTibKBrSs6QSluOGj7gjlzLvnTuifrO/Sdz8/PtIu8O+TYwCyNm5XdBhiQb1
        uTx7tI+RhQ1eowr5eNrmZ3Sn1tpFJ5Raog9Lt8locEHkslQ54Mdp4MIp5wYs5Yw8sXnhzICxnZie0
        KUwt4gqSYV57mxIB7GfQYYNtfA+uG7YO8AKIIjET8RfAA7ICz2FismWdP3PQGFsv3Vt0RlS9SOjcn
        mOB8UkVbFz+FkUX9/oPfZUvHfQ90Uysr30jg5ONDQbZ2SeCyNI5ZElaTapuM+Oz+iHyAYCB8MtfrW
        xmnIYofw==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haRiU-0000Ur-3A; Mon, 10 Jun 2019 21:20:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] binfmt_flat: remove the uapi <linux/flat.h> header
Date:   Mon, 10 Jun 2019 23:20:06 +0200
Message-Id: <20190610212015.9157-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610212015.9157-1-hch@lst.de>
References: <20190610212015.9157-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The split between the two flat.h files is completely arbitrary, and the
uapi version even contains CONFIG_ ifdefs that can't work in userspace.
The only userspace program known to use the header is elf2flt, and it
ships with its own version of the combined header.

Use the chance to move the <asm/flat.h> inclusion out of this file, as it
is in no way needed for the format defintion, but just for the binfmt
implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/binfmt_flat.c          |  1 +
 include/linux/flat.h      | 45 ++++++++++++++++++++++++++---
 include/uapi/linux/flat.h | 59 ---------------------------------------
 3 files changed, 42 insertions(+), 63 deletions(-)
 delete mode 100644 include/uapi/linux/flat.h

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index c09651087eda..6ae0f9af3fc9 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -42,6 +42,7 @@
 #include <asm/unaligned.h>
 #include <asm/cacheflush.h>
 #include <asm/page.h>
+#include <asm/flat.h>
 
 #ifndef flat_get_relocate_addr
 #define flat_get_relocate_addr(rel)	(rel)
diff --git a/include/linux/flat.h b/include/linux/flat.h
index 569b67d64d5c..21d901ba191b 100644
--- a/include/linux/flat.h
+++ b/include/linux/flat.h
@@ -10,8 +10,47 @@
 #ifndef _LINUX_FLAT_H
 #define _LINUX_FLAT_H
 
-#include <uapi/linux/flat.h>
-#include <asm/flat.h>
+#define	FLAT_VERSION			0x00000004L
+
+#ifdef CONFIG_BINFMT_SHARED_FLAT
+#define	MAX_SHARED_LIBS			(4)
+#else
+#define	MAX_SHARED_LIBS			(1)
+#endif
+
+/*
+ * To make everything easier to port and manage cross platform
+ * development,  all fields are in network byte order.
+ */
+
+struct flat_hdr {
+	char magic[4];
+	unsigned long rev;          /* version (as above) */
+	unsigned long entry;        /* Offset of first executable instruction
+	                               with text segment from beginning of file */
+	unsigned long data_start;   /* Offset of data segment from beginning of
+	                               file */
+	unsigned long data_end;     /* Offset of end of data segment
+	                               from beginning of file */
+	unsigned long bss_end;      /* Offset of end of bss segment from beginning
+	                               of file */
+
+	/* (It is assumed that data_end through bss_end forms the bss segment.) */
+
+	unsigned long stack_size;   /* Size of stack, in bytes */
+	unsigned long reloc_start;  /* Offset of relocation records from
+	                               beginning of file */
+	unsigned long reloc_count;  /* Number of relocation records */
+	unsigned long flags;
+	unsigned long build_date;   /* When the program/library was built */
+	unsigned long filler[5];    /* Reservered, set to zero */
+};
+
+#define FLAT_FLAG_RAM    0x0001 /* load program entirely into RAM */
+#define FLAT_FLAG_GOTPIC 0x0002 /* program is PIC with GOT */
+#define FLAT_FLAG_GZIP   0x0004 /* all but the header is compressed */
+#define FLAT_FLAG_GZDATA 0x0008 /* only data/relocs are compressed (for XIP) */
+#define FLAT_FLAG_KTRACE 0x0010 /* output useful kernel trace for debugging */
 
 /*
  * While it would be nice to keep this header clean,  users of older
@@ -22,8 +61,6 @@
  *        with the format above,  except to fix bugs with old format support.
  */
 
-#include <asm/byteorder.h>
-
 #define	OLD_FLAT_VERSION			0x00000002L
 #define OLD_FLAT_RELOC_TYPE_TEXT	0
 #define OLD_FLAT_RELOC_TYPE_DATA	1
diff --git a/include/uapi/linux/flat.h b/include/uapi/linux/flat.h
deleted file mode 100644
index 27e595e44fb7..000000000000
--- a/include/uapi/linux/flat.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (C) 2002-2003  David McCullough <davidm@snapgear.com>
- * Copyright (C) 1998       Kenneth Albanowski <kjahds@kjahds.com>
- *                          The Silver Hammer Group, Ltd.
- *
- * This file provides the definitions and structures needed to
- * support uClinux flat-format executables.
- */
-
-#ifndef _UAPI_LINUX_FLAT_H
-#define _UAPI_LINUX_FLAT_H
-
-
-#define	FLAT_VERSION			0x00000004L
-
-#ifdef CONFIG_BINFMT_SHARED_FLAT
-#define	MAX_SHARED_LIBS			(4)
-#else
-#define	MAX_SHARED_LIBS			(1)
-#endif
-
-/*
- * To make everything easier to port and manage cross platform
- * development,  all fields are in network byte order.
- */
-
-struct flat_hdr {
-	char magic[4];
-	unsigned long rev;          /* version (as above) */
-	unsigned long entry;        /* Offset of first executable instruction
-	                               with text segment from beginning of file */
-	unsigned long data_start;   /* Offset of data segment from beginning of
-	                               file */
-	unsigned long data_end;     /* Offset of end of data segment
-	                               from beginning of file */
-	unsigned long bss_end;      /* Offset of end of bss segment from beginning
-	                               of file */
-
-	/* (It is assumed that data_end through bss_end forms the bss segment.) */
-
-	unsigned long stack_size;   /* Size of stack, in bytes */
-	unsigned long reloc_start;  /* Offset of relocation records from
-	                               beginning of file */
-	unsigned long reloc_count;  /* Number of relocation records */
-	unsigned long flags;       
-	unsigned long build_date;   /* When the program/library was built */
-	unsigned long filler[5];    /* Reservered, set to zero */
-};
-
-#define FLAT_FLAG_RAM    0x0001 /* load program entirely into RAM */
-#define FLAT_FLAG_GOTPIC 0x0002 /* program is PIC with GOT */
-#define FLAT_FLAG_GZIP   0x0004 /* all but the header is compressed */
-#define FLAT_FLAG_GZDATA 0x0008 /* only data/relocs are compressed (for XIP) */
-#define FLAT_FLAG_KTRACE 0x0010 /* output useful kernel trace for debugging */
-
-
-
-#endif /* _UAPI_LINUX_FLAT_H */
-- 
2.20.1

