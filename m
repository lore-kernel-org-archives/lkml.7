Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6077DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341DC217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZjZ6HlHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfFMQi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:38:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730611AbfFMHJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MoKtipbh9gB8twwKuqWxF281cRnPUPjy4c1d2++iOfE=; b=ZjZ6HlHGKt6643pV1fKSla5ZqK
        J0txpe3frJ04Oy3Ig1zldwEtPCAwzjZO7yE4m6TaTPwcxhWKx0XeJYozVB1Ua32Y387lqXXY6ozqm
        t6pP+BCKR/K9Ohl+3zpaloxeBqRLhkVJNOhwy+NoTOTpw96f0Y4shsdPQjSOXXUjoojy12GYSxc30
        Xyvn+mJLm00ZAHMhxs4HWHxGQ7ghnZHUIQnXJwrIxOymtbsal/T2LB2lziepr+azOXNiyBLGqvJmn
        Rkkv5MeTIju0DjVYuaNU1XSaM5xvIYqDGwGPDl9yBVIJQA7cVuXaIDOWENuAA1Kp2NYQx8w4nnugc
        cllvBhKA==;
Received: from mpp-cp1-natpool-1-013.ethz.ch ([82.130.71.13] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbJrc-0004Kb-G4; Thu, 13 Jun 2019 07:09:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 09/17] binfmt_flat: use fixed size type for the on-disk format
Date:   Thu, 13 Jun 2019 09:08:55 +0200
Message-Id: <20190613070903.17214-10-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613070903.17214-1-hch@lst.de>
References: <20190613070903.17214-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far binfmt_flat has only been supported on 32-bit platforms, so the
variable size of the fields didn't matter.  But the upcoming RISC-V
nommu port supports 64-bit CPUs, and we now have a conflict between
the elf2flt creation tool that always uses 32-bit fields and the kernel
that uses (unsigned) long field.  Switch to the userspace view as the
rest of the binfmt_flat format is completely architecture neutral,
and binfmt_flat isn't the right binary format for huge executables to
start with.

While we're at it also ensure these fields are using __be types as
they big endian and are byte swapped when loaded.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 include/linux/flat.h | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/linux/flat.h b/include/linux/flat.h
index 19c586b74b99..d586bb6e64a7 100644
--- a/include/linux/flat.h
+++ b/include/linux/flat.h
@@ -24,26 +24,26 @@
  */
 
 struct flat_hdr {
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
+	char	magic[4];
+	__be32	rev;          /* version (as above) */
+	__be32	entry;        /* Offset of first executable instruction
+				 with text segment from beginning of file */
+	__be32	data_start;   /* Offset of data segment from beginning of
+				 file */
+	__be32	data_end;     /* Offset of end of data segment from beginning
+				 of file */
+	__be32	bss_end;      /* Offset of end of bss segment from beginning
+				 of file */
 
 	/* (It is assumed that data_end through bss_end forms the bss segment.) */
 
-	unsigned long stack_size;   /* Size of stack, in bytes */
-	unsigned long reloc_start;  /* Offset of relocation records from
-	                               beginning of file */
-	unsigned long reloc_count;  /* Number of relocation records */
-	unsigned long flags;
-	unsigned long build_date;   /* When the program/library was built */
-	unsigned long filler[5];    /* Reservered, set to zero */
+	__be32	stack_size;   /* Size of stack, in bytes */
+	__be32	reloc_start;  /* Offset of relocation records from beginning of
+				 file */
+	__be32	reloc_count;  /* Number of relocation records */
+	__be32	flags;
+	__be32	build_date;   /* When the program/library was built */
+	__u32	filler[5];    /* Reservered, set to zero */
 };
 
 #define FLAT_FLAG_RAM    0x0001 /* load program entirely into RAM */
@@ -67,15 +67,15 @@ struct flat_hdr {
 #define OLD_FLAT_RELOC_TYPE_BSS		2
 
 typedef union {
-	unsigned long	value;
+	u32		value;
 	struct {
 #if defined(__LITTLE_ENDIAN_BITFIELD) || \
     (defined(mc68000) && !defined(CONFIG_COLDFIRE))
-		signed long offset : 30;
-		unsigned long type : 2;
+		s32	offset : 30;
+		u32	type : 2;
 # elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned long type : 2;
-		signed long offset : 30;
+		u32	type : 2;
+		s32	offset : 30;
 # else
 #   	error "Unknown bitfield order for flat files."
 # endif
-- 
2.20.1

