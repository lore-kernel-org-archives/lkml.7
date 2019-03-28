Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB88C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C46D2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="iSy+p5yA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfC1UPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:15:21 -0400
Received: from sonic307-55.consmr.mail.gq1.yahoo.com ([98.137.64.31]:36804
        "EHLO sonic307-55.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbfC1UPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1553804119; bh=PGDTTX7B2fn8LesJKqcunO1ft0IhcfNy9fZGZkuMCHE=; h=From:To:Cc:Subject:Date:From:Subject; b=iSy+p5yAy6NgbGmfMk5u30xOJAz8OYzKwlyhbUCxiM+xG0yJJTlJL8wWafyVjqj33nANpiKdWenIB0zi3FTs1D++8uq4jAxwW6uQLjRkSu47LENDLBe0g/PI4iyytk5bMOklavJ5/k++mqqjavTxelU/46RG4ItwXREfy6oBWxznO8pxcvbiMiqvNiACcrteZJWemlqzT9xZSsrGOyy2Z8WAHrIBy52sqnpWrC8xIUNViCENY42iGk0uDHeoHsDWPaBaBEx+qtIPF95gS6V11MxTtlNDFeV9AN8Icmea37Jl/KAsALfBFOiVQeMen0yHlToJ9XJdZzmeCOKUA7eUQg==
X-YMail-OSG: o8AP6p4VM1mVUrcGKDjEuTkYhWC2jy0M62_nxWSjJFyOw6U03r3AwEFuqxdAwQM
 MkkESK9a7IN.CKSkMygHx85GNOEw_iJiXI0W5xIfmOTwaEqrDNMpT4eBTZ1ujgLEsVLrE22PokIP
 0E9Rb7ppensnNOLw1R2e623KJ6IivUZ1pvgUTUQ8EQkMAojj5M_MSbx6oQOnxNybna4ceuaZcKPg
 Q2HxH8Ob7byRDYpuVMhqQJIOOBPvHa.EwGPpy8o0WjBsv.Ljy4Nor2XzSTopaR_eVEtPv06y7H0R
 o9_DBHxNMgLeL1ZJorRe5dkmgLGIqiUGdcutcVFMf8pGbJiW4aCsITGXhWfKr_EfW.fznltlQvWf
 fFMH19WxiP1CUlOl8ReA1lnCMD0zLcseE1n9ASaaYnndafoPHABRbXBDNJdyfIBObb6V52HSsVQl
 54dcyWTT6VGlZwTv6u9Rpi3u5g56WzGtwnugjoPUKYIsshdRk5R9VVQ22otG0UUFYGlIi0S2ByrT
 7aekSccNoJDq9LAessAOxE4NFWHj8mw4WKLUBaBnfp1MxCTPC8A9wehsV.OdchFWnAKvI4ZwYAqr
 gw9Wa4JcmeEjUEH6XTRvGopjnoLnsHH.bnziwtq_Vu_XDA.K6GszIAh439ZiJ_V1133mwCOo5SIu
 uBjhVenrtfzawBxf_pw4rxFopA.T6AkfWm19X9V.XsEUE5Dvyuq7ly0cf853SpjZlVmmBdd5.2l2
 W1QzfUP35qlo3qU.5osQ1rXXji0_0BZ.1gj7YXTFPk2JXXurV5ludMIfh1z77ZyxoepE7HXoksLO
 ZkUIC4xITSH1i2NjTtbrxJgU5olZmIObSZkbURtSkM5OnwmamphY68de7s_HlIcLJntTerPO9Eiz
 8.grE_gFLE2igbrOfWtpm1aDv.jJtNYp1A8kZ41G2SZ0jvvSqZfmv0gAlB97kXyAFJdebf31zOVB
 Cy2IJCiZxgbnX0vYsI7miv2S8Yro3Ik69iYalMeLVNuCgr5.0n0slkJevugzYZFOagDFlvMfGjHs
 9N_X0VN4iTye5oiahEjlom0wIz.BnBBHyEPO_385HVuXPwLnCxJ6FP_QBgrT48Xpdc.F1Sg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Mar 2019 20:15:19 +0000
Received: from 183.157.11.1 (EHLO localhost.localdomain) ([183.157.11.1])
          by smtp425.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a59588148c0d3fa99ecdf37d24287377;
          Thu, 28 Mar 2019 20:15:19 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>, chao@kernel.org,
        weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        "# 4 . 19+" <stable@vger.kernel.org>
Subject: [PATCH] staging: erofs: keep corrupted fs from crashing kernel in erofs_readdir()
Date:   Fri, 29 Mar 2019 04:14:58 +0800
Message-Id: <20190328201458.30629-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

After commit 419d6efc50e9, kernel cannot be crashed in the namei
path. However, corrupted nameoff can do harm in the process of
readdir for scenerios without dm-verity as well. Fix it now.

Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

The remaining work of
https://lore.kernel.org/linux-fsdevel/20181102194235.GA32577@ZenIV.linux.org.uk/
and the patch had been staying in my private repo for a while.

I'd like to get it reviewed now and fixed.

Thanks,
Gao Xiang

 drivers/staging/erofs/dir.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/erofs/dir.c b/drivers/staging/erofs/dir.c
index 829f7b12e0dc..9bbc68729c11 100644
--- a/drivers/staging/erofs/dir.c
+++ b/drivers/staging/erofs/dir.c
@@ -23,6 +23,21 @@ static const unsigned char erofs_filetype_table[EROFS_FT_MAX] = {
 	[EROFS_FT_SYMLINK]	= DT_LNK,
 };
 
+static void debug_one_dentry(unsigned char d_type, const char *de_name,
+			     unsigned int de_namelen)
+{
+#ifdef CONFIG_EROFS_FS_DEBUG
+	/* since the on-disk name could not have the trailing '\0' */
+	unsigned char dbg_namebuf[EROFS_NAME_LEN + 1];
+
+	memcpy(dbg_namebuf, de_name, de_namelen);
+	dbg_namebuf[de_namelen] = '\0';
+
+	debugln("found dirent %s de_len %u d_type %d", dbg_namebuf,
+		de_namelen, d_type);
+#endif
+}
+
 static int erofs_fill_dentries(struct dir_context *ctx,
 			       void *dentry_blk, unsigned int *ofs,
 			       unsigned int nameoff, unsigned int maxsize)
@@ -33,14 +48,10 @@ static int erofs_fill_dentries(struct dir_context *ctx,
 	de = dentry_blk + *ofs;
 	while (de < end) {
 		const char *de_name;
-		int de_namelen;
+		unsigned int de_namelen;
 		unsigned char d_type;
-#ifdef CONFIG_EROFS_FS_DEBUG
-		unsigned int dbg_namelen;
-		unsigned char dbg_namebuf[EROFS_NAME_LEN];
-#endif
 
-		if (unlikely(de->file_type < EROFS_FT_MAX))
+		if (de->file_type < EROFS_FT_MAX)
 			d_type = erofs_filetype_table[de->file_type];
 		else
 			d_type = DT_UNKNOWN;
@@ -48,26 +59,20 @@ static int erofs_fill_dentries(struct dir_context *ctx,
 		nameoff = le16_to_cpu(de->nameoff);
 		de_name = (char *)dentry_blk + nameoff;
 
-		de_namelen = unlikely(de + 1 >= end) ?
-			/* last directory entry */
-			strnlen(de_name, maxsize - nameoff) :
-			le16_to_cpu(de[1].nameoff) - nameoff;
+		/* the last dirent in the block? */
+		if (de + 1 >= end)
+			de_namelen = strnlen(de_name, maxsize - nameoff);
+		else
+			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
 
 		/* a corrupted entry is found */
-		if (unlikely(de_namelen < 0)) {
+		if (unlikely(nameoff + de_namelen > maxsize ||
+			     de_namelen > EROFS_NAME_LEN)) {
 			DBG_BUGON(1);
 			return -EIO;
 		}
 
-#ifdef CONFIG_EROFS_FS_DEBUG
-		dbg_namelen = min(EROFS_NAME_LEN - 1, de_namelen);
-		memcpy(dbg_namebuf, de_name, dbg_namelen);
-		dbg_namebuf[dbg_namelen] = '\0';
-
-		debugln("%s, found de_name %s de_len %d d_type %d", __func__,
-			dbg_namebuf, de_namelen, d_type);
-#endif
-
+		debug_one_dentry(d_type, de_name, de_namelen);
 		if (!dir_emit(ctx, de_name, de_namelen,
 			      le64_to_cpu(de->nid), d_type))
 			/* stopped by some reason */
-- 
2.11.0

