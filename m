Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A34CC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078C3206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c52ZLFdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgAGV3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:29:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33000 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbgAGV3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:29:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so1218920wrq.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 13:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Pu/dDMk537qC5mOBVHU+A+jRveWe3R75ST+LMWDVefM=;
        b=c52ZLFdZXsExgpjcZnRO2yYDD+Ei3iPjWK618tjB3DiXpVJ3K4eseadQaOB6m2i/+H
         9hkP/WDhMV/8I4fHthTRUGLNYRWoF+j5MtZLsi9EhmEaFoj5NdVtSktszKtMA3py++KU
         Z9W5USYjw1DYM2G+uESm4rbZlBLMUiHAQfuFiSOm+bDMvOTjFdAax2+9WygBDZnWElqe
         JT+L8aKPOwHQDNmhYgowtepKkIAqELgO60QBcEqY2H1irsrKFY+yacEQg2tE0DA64ST6
         PXAKzddwaMVB4HiaeYwlrfLf+0odXBik3ra014fvgQZrOvHMRwRiVOHvxdG8OEBcNi6K
         4A0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pu/dDMk537qC5mOBVHU+A+jRveWe3R75ST+LMWDVefM=;
        b=heMpnXzUCd6d/GmL2200JQrX758XBbzdwi6H4ZR9vMdq4lFLzFYb1ZhgbqyxwVtT/K
         8mSTQTk6hqi+X61bojvT83WzzqFOxA5rbI5y75sW9Z0t01v6pFTj7esqTJvEIdMF7Xo1
         vHK2P8T4WSqzn90by87bfWdZhAVw6K7f68mr/NdBjhzmdWvn6LjdZjPV9fegy4vEuE93
         Hv3Ue5jSw0C0XGC+7Wr3hgk3UkBT/eXcNnafJq4m4dAf4GpN5AYUIRL+52XRa9121ivr
         Ftd4alOXKqJnmgeFfiVEbh7GNSKzjoomVrQYwhFZ8W5yEoNOjEgqKxqd11Y9qWq7aWxB
         EI3w==
X-Gm-Message-State: APjAAAV/WnXNZ6WAxz80U1Lg2CZig12SwDD1psBJ/p6kaF3F3qMZyiMq
        ThYFJSKl3dAWohCC5WvfZu0nN9QU
X-Google-Smtp-Source: APXvYqyn1j+zJ+70mtV5B7Qu/SRl7u2dn5peaGVVzEvkXMAl543hrsFC4k1ubiQshLMkXNMgdIw9Jg==
X-Received: by 2002:adf:ea42:: with SMTP id j2mr1074884wrn.270.1578432555913;
        Tue, 07 Jan 2020 13:29:15 -0800 (PST)
Received: from Pali-Latitude.lan (ip-89-103-160-142.net.upcbroadband.cz. [89.103.160.142])
        by smtp.gmail.com with ESMTPSA id f1sm1449144wru.6.2020.01.07.13.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 13:29:15 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: [PATCH 1/3] udf: Fix spelling in EXT_NEXT_EXTENT_ALLOCDESCS
Date:   Tue,  7 Jan 2020 22:29:02 +0100
Message-Id: <20200107212904.30471-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107134425.GE25547@quack2.suse.cz>
References: <20200107134425.GE25547@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
 fs/udf/ecma_167.h | 2 +-
 fs/udf/inode.c    | 6 +++---
 fs/udf/truncate.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
index fb7f2c7be..e7b889e01 100644
--- a/fs/udf/ecma_167.h
+++ b/fs/udf/ecma_167.h
@@ -757,7 +757,7 @@ struct partitionIntegrityEntry {
 #define EXT_RECORDED_ALLOCATED		0x00000000
 #define EXT_NOT_RECORDED_ALLOCATED	0x40000000
 #define EXT_NOT_RECORDED_NOT_ALLOCATED	0x80000000
-#define EXT_NEXT_EXTENT_ALLOCDECS	0xC0000000
+#define EXT_NEXT_EXTENT_ALLOCDESCS	0xC0000000
 
 /* Long Allocation Descriptor (ECMA 167r3 4/14.14.2) */
 
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index ea80036d7..e875bc566 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1981,10 +1981,10 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
 
 		__udf_add_aext(inode, &nepos, &cp_loc, cp_len, 1);
 		udf_write_aext(inode, epos, &nepos.block,
-			       sb->s_blocksize | EXT_NEXT_EXTENT_ALLOCDECS, 0);
+			       sb->s_blocksize | EXT_NEXT_EXTENT_ALLOCDESCS, 0);
 	} else {
 		__udf_add_aext(inode, epos, &nepos.block,
-			       sb->s_blocksize | EXT_NEXT_EXTENT_ALLOCDECS, 0);
+			       sb->s_blocksize | EXT_NEXT_EXTENT_ALLOCDESCS, 0);
 	}
 
 	brelse(epos->bh);
@@ -2143,7 +2143,7 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
 	unsigned int indirections = 0;
 
 	while ((etype = udf_current_aext(inode, epos, eloc, elen, inc)) ==
-	       (EXT_NEXT_EXTENT_ALLOCDECS >> 30)) {
+	       (EXT_NEXT_EXTENT_ALLOCDESCS >> 30)) {
 		udf_pblk_t block;
 
 		if (++indirections > UDF_MAX_INDIR_EXTS) {
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 63a47f1e1..532cda996 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -241,7 +241,7 @@ int udf_truncate_extents(struct inode *inode)
 
 	while ((etype = udf_current_aext(inode, &epos, &eloc,
 					 &elen, 0)) != -1) {
-		if (etype == (EXT_NEXT_EXTENT_ALLOCDECS >> 30)) {
+		if (etype == (EXT_NEXT_EXTENT_ALLOCDESCS >> 30)) {
 			udf_write_aext(inode, &epos, &neloc, nelen, 0);
 			if (indirect_ext_len) {
 				/* We managed to free all extents in the
-- 
2.20.1

