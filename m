Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAC9C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1373121721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rKpjLqGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392763AbfFMQi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:38:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730612AbfFMHJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uUqdnPcr//xkUhQW2fdv7g03UUDSBj1kSxBObliGyF4=; b=rKpjLqGr/WAIz3Bt4c5UtOIk/F
        eLOcJ02Volx3UdCuTLjfapw679H6Yk4zLNBX/f0lKekIcZNLgQ/xNvSdmGm57R5LYZvLO079oIK6M
        ke7f0iDa3BcSeOplcoXCLKKjR50fj55/i/JnYGHylIWj31+aOAuxjWJr7D3fhugaRXt0s3UuR1eOq
        3MocxG16SfUB8w9E7LjNIKZ1GvELaNGhS5Au1+anolvmuhHmlWgRsbWiRaX/cIVdMc/COyfRD5hZ8
        aDjwPUNl9hWekZxwIKxFBN429eG1ClCLTz5G7Axe0XgkdF3oJO3ammkMJEhMjelpvOxnghMaYm9aC
        KFO8Xjdw==;
Received: from mpp-cp1-natpool-1-013.ethz.ch ([82.130.71.13] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbJrf-0004Me-WD; Thu, 13 Jun 2019 07:09:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 10/17] binfmt_flat: add endianess annotations
Date:   Thu, 13 Jun 2019 09:08:56 +0200
Message-Id: <20190613070903.17214-11-hch@lst.de>
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

Most binfmt_flat on-disk fields are big endian.  Use the proper __be32
type where applicable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 fs/binfmt_flat.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index b63c5e63ae3f..404a0bedc85b 100644
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

