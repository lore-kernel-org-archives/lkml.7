Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D9DC04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A20F20818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfEOVCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:02:15 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:56102 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfEOVCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:02:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 48EB71801442B;
        Wed, 15 May 2019 23:02:11 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Michele Dionisio <michele.dionisio@gmail.com>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH] ubifs: Add support for zstd compression.
Date:   Wed, 15 May 2019 23:02:02 +0200
Message-Id: <20190515210202.21169-1-richard@nod.at>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michele Dionisio <michele.dionisio@gmail.com>

zstd shows a good compression rate and is faster than lzo,
also on slow ARM cores.

Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>
[rw: rewrote commit message]
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/Kconfig       | 10 ++++++++++
 fs/ubifs/compress.c    | 27 ++++++++++++++++++++++++++-
 fs/ubifs/super.c       |  2 ++
 fs/ubifs/ubifs-media.h |  2 ++
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/Kconfig b/fs/ubifs/Kconfig
index 9da2f135121b..8d84d2ed096d 100644
--- a/fs/ubifs/Kconfig
+++ b/fs/ubifs/Kconfig
@@ -5,8 +5,10 @@ config UBIFS_FS
 	select CRYPTO if UBIFS_FS_ADVANCED_COMPR
 	select CRYPTO if UBIFS_FS_LZO
 	select CRYPTO if UBIFS_FS_ZLIB
+	select CRYPTO if UBIFS_FS_ZSTD
 	select CRYPTO_LZO if UBIFS_FS_LZO
 	select CRYPTO_DEFLATE if UBIFS_FS_ZLIB
+	select CRYPTO_ZSTD if UBIFS_FS_ZSTD
 	select CRYPTO_HASH_INFO
 	select UBIFS_FS_XATTR if FS_ENCRYPTION
 	depends on MTD_UBI
@@ -37,6 +39,14 @@ config UBIFS_FS_ZLIB
 	help
 	  Zlib compresses better than LZO but it is slower. Say 'Y' if unsure.
 
+config UBIFS_FS_ZSTD
+	bool "ZSTD compression support" if UBIFS_FS_ADVANCED_COMPR
+	depends on UBIFS_FS
+	default y
+	help
+	  ZSTD compresses is a big win in speed over Zlib and
+	  in compression ratio over LZO. Say 'Y' if unsure.
+
 config UBIFS_ATIME_SUPPORT
 	bool "Access time support"
 	default n
diff --git a/fs/ubifs/compress.c b/fs/ubifs/compress.c
index 565cb56d7225..89183aeeeb7a 100644
--- a/fs/ubifs/compress.c
+++ b/fs/ubifs/compress.c
@@ -71,6 +71,24 @@ static struct ubifs_compressor zlib_compr = {
 };
 #endif
 
+#ifdef CONFIG_UBIFS_FS_ZSTD
+static DEFINE_MUTEX(zstd_enc_mutex);
+static DEFINE_MUTEX(zstd_dec_mutex);
+
+static struct ubifs_compressor zstd_compr = {
+	.compr_type = UBIFS_COMPR_ZSTD,
+	.comp_mutex = &zstd_enc_mutex,
+	.decomp_mutex = &zstd_dec_mutex,
+	.name = "zstd",
+	.capi_name = "zstd",
+};
+#else
+static struct ubifs_compressor zstd_compr = {
+	.compr_type = UBIFS_COMPR_ZSTD,
+	.name = "zstd",
+};
+#endif
+
 /* All UBIFS compressors */
 struct ubifs_compressor *ubifs_compressors[UBIFS_COMPR_TYPES_CNT];
 
@@ -228,13 +246,19 @@ int __init ubifs_compressors_init(void)
 	if (err)
 		return err;
 
-	err = compr_init(&zlib_compr);
+	err = compr_init(&zstd_compr);
 	if (err)
 		goto out_lzo;
 
+	err = compr_init(&zlib_compr);
+	if (err)
+		goto out_zstd;
+
 	ubifs_compressors[UBIFS_COMPR_NONE] = &none_compr;
 	return 0;
 
+out_zstd:
+	compr_exit(&zstd_compr);
 out_lzo:
 	compr_exit(&lzo_compr);
 	return err;
@@ -247,4 +271,5 @@ void ubifs_compressors_exit(void)
 {
 	compr_exit(&lzo_compr);
 	compr_exit(&zlib_compr);
+	compr_exit(&zstd_compr);
 }
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 04b8ecfd3470..ea8615261936 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1055,6 +1055,8 @@ static int ubifs_parse_options(struct ubifs_info *c, char *options,
 				c->mount_opts.compr_type = UBIFS_COMPR_LZO;
 			else if (!strcmp(name, "zlib"))
 				c->mount_opts.compr_type = UBIFS_COMPR_ZLIB;
+			else if (!strcmp(name, "zstd"))
+				c->mount_opts.compr_type = UBIFS_COMPR_ZSTD;
 			else {
 				ubifs_err(c, "unknown compressor \"%s\"", name); //FIXME: is c ready?
 				kfree(name);
diff --git a/fs/ubifs/ubifs-media.h b/fs/ubifs/ubifs-media.h
index 8b7c1844014f..697b1b89066a 100644
--- a/fs/ubifs/ubifs-media.h
+++ b/fs/ubifs/ubifs-media.h
@@ -348,12 +348,14 @@ enum {
  * UBIFS_COMPR_NONE: no compression
  * UBIFS_COMPR_LZO: LZO compression
  * UBIFS_COMPR_ZLIB: ZLIB compression
+ * UBIFS_COMPR_ZSTD: ZSTD compression
  * UBIFS_COMPR_TYPES_CNT: count of supported compression types
  */
 enum {
 	UBIFS_COMPR_NONE,
 	UBIFS_COMPR_LZO,
 	UBIFS_COMPR_ZLIB,
+	UBIFS_COMPR_ZSTD,
 	UBIFS_COMPR_TYPES_CNT,
 };
 
-- 
2.16.4

