Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7068C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6F620820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XGMTXBKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390283AbfFJVUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:20:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38468 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390184AbfFJVUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MpfWK/0vENKyxeud9UpYn1xqE4+sty9MPUJubwIq9q0=; b=XGMTXBKR2of90n9B9Kzp92+BDO
        CS8Gu0mx2mY9f3eJUqh313R3OHs5pBRP0q1QUopJi3xN9/YNSiWsaJZuMl61TAAviIAvGUqrsh8Pd
        a82jZFkiViwQudyH1dgdtBvxk4VO3CClvhRFz2hkZ//zUITcfWL2/EHu+RqUNpeduhKKLkfyE23p1
        2vnoefGssodvFrK2kOpet/e9ye9Zqr0JxvicVLF4XgXwX0sDQueo4Lo89u36ErVUZQbwQx7jPqL9J
        FhNWYS3cuEOEPR1PHdy58rbF6nA9J/B+gmjyH+rqaJLorKPtLgmQVuxPBnNh713kKADOP018fywCF
        e4RHBn0Q==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haRif-0000eX-46; Mon, 10 Jun 2019 21:20:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] binfmt_flat: make support for old format binaries optional
Date:   Mon, 10 Jun 2019 23:20:10 +0200
Message-Id: <20190610212015.9157-11-hch@lst.de>
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

No need to carry the extra code around, given that systems using flat
binaries are generally very resource constrained.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/Kconfig.binfmt |  7 +++++++
 fs/binfmt_flat.c  | 29 +++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

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
index 6c1848dee724..ed7d969593d2 100644
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
@@ -476,6 +479,22 @@ static int load_flat_file(struct linux_binprm *bprm,
 		goto err;
 	}
 
+	/*
+	 * fix up the flags for the older format,  there were all kinds
+	 * of endian hacks,  this only works for the simple cases
+	 */
+	if (IS_ENABLED(CONFIG_BINFMT_FLAT_OLD_ALWAYS_RAM) &&
+	    rev == OLD_FLAT_VERSION)
+		flags = FLAT_FLAG_RAM;
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
@@ -487,14 +506,6 @@ static int load_flat_file(struct linux_binprm *bprm,
 		goto err;
 	}
 
-	/*
-	 * fix up the flags for the older format,  there were all kinds
-	 * of endian hacks,  this only works for the simple cases
-	 */
-	if (IS_ENABLED(CONFIG_BINFMT_FLAT_OLD_ALWAYS_RAM) &&
-	    rev == OLD_FLAT_VERSION)
-		flags = FLAT_FLAG_RAM;
-
 #ifndef CONFIG_BINFMT_ZFLAT
 	if (flags & (FLAT_FLAG_GZIP|FLAT_FLAG_GZDATA)) {
 		pr_err("Support for ZFLAT executables is not enabled.\n");
@@ -833,6 +844,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 					goto err;
 			}
 		}
+#ifdef CONFIG_BINFMT_FLAT_OLD
 	} else {
 		for (i = 0; i < relocs; i++) {
 			__be32 relval;
@@ -840,6 +852,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 				return -EFAULT;
 			old_reloc(ntohl(relval));
 		}
+#endif /* CONFIG_BINFMT_FLAT_OLD */
 	}
 
 	flush_icache_range(start_code, end_code);
-- 
2.20.1

