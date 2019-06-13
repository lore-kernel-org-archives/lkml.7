Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4079C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9866620644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cuI3LB51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392726AbfFMQiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:38:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730615AbfFMHJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=shH3KKNW4gCRkiGBYeFaMz272SQX5YmHKG/m8UQSO3w=; b=cuI3LB51raGmz9P0nzgaFbNblD
        LX5hU6FVsCHCJBydAj+fIQc7mjcMkKa4NCeQbGeaqaDxUrEmvhzcdp+7wNrvXbbHQGO8019CXYnSF
        n5PtuKsW32MVb91WvzU2X+q88EUF+vZ1Uap7h8QtAqFTBX8GyJ43i8HcIUwVsKZItf8gtK8ZaVCF5
        3XqRhaoODez3vQG3Ty5dT7D2GjLLyyWjxyApXPMEaGGzEl31owZw0whWPtLlulZnjvaBU7CTQLxqw
        CKBuYCItMCRRKUgPhsru8yjwHoUaC/JN9wddKa1eruGP67D04kZ7FXHjsJEz5vxRIUO4ea6mkWSXp
        NMDHjvWg==;
Received: from mpp-cp1-natpool-1-013.ethz.ch ([82.130.71.13] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbJrm-0004PI-4d; Thu, 13 Jun 2019 07:09:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/17] binfmt_flat: make support for old format binaries optional
Date:   Thu, 13 Jun 2019 09:08:58 +0200
Message-Id: <20190613070903.17214-13-hch@lst.de>
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

No need to carry the extra code around, given that systems using flat
binaries are generally very resource constrained.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/Kconfig.binfmt |  7 +++++++
 fs/binfmt_flat.c  | 30 ++++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 286b425b30b9..62dc4f577ba1 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -106,6 +106,13 @@ config BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 config BINFMT_FLAT_OLD_ALWAYS_RAM
 	bool
 
+config BINFMT_FLAT_OLD
+	bool "Enable support for very old legacy flat binaries"
+	depends on BINFMT_FLAT
+	help
+	  Support decade old uClinux FLAT format binaries.  Unless you know
+	  you have some of those say N here.
+
 config BINFMT_ZFLAT
 	bool "Enable ZFLAT support"
 	depends on BINFMT_FLAT
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 404a0bedc85b..1e88f4e62e65 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -374,6 +374,7 @@ calc_reloc(unsigned long r, struct lib_info *p, int curid, int internalp)
 
 /****************************************************************************/
 
+#ifdef CONFIG_BINFMT_FLAT_OLD
 static void old_reloc(unsigned long rl)
 {
 	static const char *segment[] = { "TEXT", "DATA", "BSS", "*UNKNOWN*" };
@@ -411,6 +412,7 @@ static void old_reloc(unsigned long rl)
 
 	pr_debug("Relocation became %lx\n", val);
 }
+#endif /* CONFIG_BINFMT_FLAT_OLD */
 
 /****************************************************************************/
 
@@ -461,6 +463,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 	if (flags & FLAT_FLAG_KTRACE)
 		pr_info("Loading file: %s\n", bprm->filename);
 
+#ifdef CONFIG_BINFMT_FLAT_OLD
 	if (rev != FLAT_VERSION && rev != OLD_FLAT_VERSION) {
 		pr_err("bad flat file version 0x%x (supported 0x%lx and 0x%lx)\n",
 		       rev, FLAT_VERSION, OLD_FLAT_VERSION);
@@ -476,6 +479,23 @@ static int load_flat_file(struct linux_binprm *bprm,
 		goto err;
 	}
 
+	/*
+	 * fix up the flags for the older format,  there were all kinds
+	 * of endian hacks,  this only works for the simple cases
+	 */
+	if (rev == OLD_FLAT_VERSION &&
+	   (flags || IS_ENABLED(CONFIG_BINFMT_FLAT_OLD_ALWAYS_RAM)))
+		flags = FLAT_FLAG_RAM;
+
+#else /* CONFIG_BINFMT_FLAT_OLD */
+	if (rev != FLAT_VERSION) {
+		pr_err("bad flat file version 0x%x (supported 0x%lx)\n",
+		       rev, FLAT_VERSION);
+		ret = -ENOEXEC;
+		goto err;
+	}
+#endif /* !CONFIG_BINFMT_FLAT_OLD */
+
 	/*
 	 * Make sure the header params are sane.
 	 * 28 bits (256 MB) is way more than reasonable in this case.
@@ -487,14 +507,6 @@ static int load_flat_file(struct linux_binprm *bprm,
 		goto err;
 	}
 
-	/*
-	 * fix up the flags for the older format,  there were all kinds
-	 * of endian hacks,  this only works for the simple cases
-	 */
-	if (rev == OLD_FLAT_VERSION &&
-	   (flags || IS_ENABLED(CONFIG_BINFMT_FLAT_OLD_ALWAYS_RAM)))
-		flags = FLAT_FLAG_RAM;
-
 #ifndef CONFIG_BINFMT_ZFLAT
 	if (flags & (FLAT_FLAG_GZIP|FLAT_FLAG_GZDATA)) {
 		pr_err("Support for ZFLAT executables is not enabled.\n");
@@ -833,6 +845,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 					goto err;
 			}
 		}
+#ifdef CONFIG_BINFMT_FLAT_OLD
 	} else {
 		for (i = 0; i < relocs; i++) {
 			__be32 relval;
@@ -840,6 +853,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 				return -EFAULT;
 			old_reloc(ntohl(relval));
 		}
+#endif /* CONFIG_BINFMT_FLAT_OLD */
 	}
 
 	flush_icache_range(start_code, end_code);
-- 
2.20.1

