Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AC8C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757DE20820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HrY0Qmw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390015AbfFJVUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:20:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390184AbfFJVUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hGQgwRV1eNL4J8F+4meQGtmLL8M3JcwulArYLNjpMJ8=; b=HrY0Qmw4UWxKsjKqwlGOY2rvJG
        UK7OXPg1aHe65+DyhhWcTojLokTJuiKlgU8nm8jMKBk33aAczqlY4M+sdNWN96cA1i1qGwkYqXF+V
        mCCACQ9yMyyfq6db7oCILXsO6ILPJDp8AViRTldak/C0s2Q+zPIUJabe3/tFNnTwTOEz+OuFBun19
        ho/e6SH9Qkxm1v5kl1uQmzMtKLsQ/oxe0W9JwbPLuSzebhJKB+R1lyA/+996cue4125f5nczqXmKp
        K9NVnDSnmA+fj0Q4Df69lnzNSX9zx4U7lbSdN1vKmwJhVe6BPKUnobOt/MEYHA34xgJbug9+IHAmX
        4w7EhwmA==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haRiZ-0000Zd-Af; Mon, 10 Jun 2019 21:20:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] binfmt_flat: add endianess annotations
Date:   Mon, 10 Jun 2019 23:20:08 +0200
Message-Id: <20190610212015.9157-9-hch@lst.de>
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

Most binfmt_flat on-disk fields are big endian.  Use the proper __be32
type where applicable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/binfmt_flat.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 6ae0f9af3fc9..6c1848dee724 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -421,7 +421,8 @@ static int load_flat_file(struct linux_binprm *bprm,
 	unsigned long textpos, datapos, realdatastart;
 	u32 text_len, data_len, bss_len, stack_len, full_data, flags;
 	unsigned long len, memp, memp_size, extra, rlim;
-	u32 __user *reloc, *rp;
+	__be32 __user *reloc;
+	u32 __user *rp;
 	struct inode *inode;
 	int i, rev, relocs;
 	loff_t fpos;
@@ -594,7 +595,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 			goto err;
 		}
 
-		reloc = (u32 __user *)
+		reloc = (__be32 __user *)
 			(datapos + (ntohl(hdr->reloc_start) - text_len));
 		memp = realdatastart;
 		memp_size = len;
@@ -619,7 +620,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 				MAX_SHARED_LIBS * sizeof(u32),
 				FLAT_DATA_ALIGN);
 
-		reloc = (u32 __user *)
+		reloc = (__be32 __user *)
 			(datapos + (ntohl(hdr->reloc_start) - text_len));
 		memp = textpos;
 		memp_size = len;
@@ -785,15 +786,16 @@ static int load_flat_file(struct linux_binprm *bprm,
 		u32 __maybe_unused persistent = 0;
 		for (i = 0; i < relocs; i++) {
 			u32 addr, relval;
+			__be32 tmp;
 
 			/*
 			 * Get the address of the pointer to be
 			 * relocated (of course, the address has to be
 			 * relocated first).
 			 */
-			if (get_user(relval, reloc + i))
+			if (get_user(tmp, reloc + i))
 				return -EFAULT;
-			relval = ntohl(relval);
+			relval = ntohl(tmp);
 			addr = flat_get_relocate_addr(relval);
 			rp = (u32 __user *)calc_reloc(addr, libinfo, id, 1);
 			if (rp == (u32 __user *)RELOC_FAILED) {
@@ -812,8 +814,13 @@ static int load_flat_file(struct linux_binprm *bprm,
 				 * Do the relocation.  PIC relocs in the data section are
 				 * already in target order
 				 */
-				if ((flags & FLAT_FLAG_GOTPIC) == 0)
-					addr = ntohl(addr);
+				if ((flags & FLAT_FLAG_GOTPIC) == 0) {
+					/*
+					 * Meh, the same value can have a different
+					 * byte order based on a flag..
+					 */
+					addr = ntohl((__force __be32)addr);
+				}
 				addr = calc_reloc(addr, libinfo, id, 0);
 				if (addr == RELOC_FAILED) {
 					ret = -ENOEXEC;
@@ -828,11 +835,10 @@ static int load_flat_file(struct linux_binprm *bprm,
 		}
 	} else {
 		for (i = 0; i < relocs; i++) {
-			u32 relval;
+			__be32 relval;
 			if (get_user(relval, reloc + i))
 				return -EFAULT;
-			relval = ntohl(relval);
-			old_reloc(relval);
+			old_reloc(ntohl(relval));
 		}
 	}
 
-- 
2.20.1

