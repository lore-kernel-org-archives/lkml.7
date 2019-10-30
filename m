Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD02ECA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B335220856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak2pbzBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfJ3BEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 21:04:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34149 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfJ3BEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 21:04:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id v3so3151457wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 18:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5BUDv5SzjoPNUH8eX9BsExMRskMoCgy1lMsq/PW/h24=;
        b=ak2pbzBRUpoVboJbNkCZO1ERrTrVyaWaoBKa+8lA6oAgYErv6PsAjO8mmvXuLy2Ium
         luyPaYstnGBJk/+RRObnX1JSiVRwptCEUDTk8MB+XsmlbF+cFeAMdcQkqDC0Apk/vWtS
         TdBC1gdnfxn3G9Jjc6Q/nvoQLEfJycRgOBDU4HnzUdldK/arQhF44uIcM1i8sXXxjOvt
         FHxrg9CJ/gC6G/l0rBbsDgmsM2MtDI/NdmbOU8R+er8WiRNS1h7z+6PfXcWHTl3JFoWu
         yJBF6IH4EB+NPQii5ZQ3GPyjTHgCUa7LAEC0hQG4QNh+rM8DI8E/qNhpXsjdZ24OucMr
         JjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5BUDv5SzjoPNUH8eX9BsExMRskMoCgy1lMsq/PW/h24=;
        b=Uo5ZWZgj7I6JR8M01hCvmpfXsEgwMSCZ7WOSUtIoyH0IHug0x5mkz8C0daoFsznn6J
         Y/A3GnfS6QXeVu3Yb7ln+QxUl3Urg1fuQ582a9XKfc9+KVbCoVPBTvKjUy/zt+BoPAa9
         SL0wVotaJIdmqxNwBQgYujtm564CvErGA4le1fTbKqjWKpO6usfBJ17joZy4//XQulvg
         HMw00u35ujz9ogBv55JlaEME2lPM/yf5jwlCxYxfZx5ZpJ8zmS5EJqU22d+3Sl/eNHel
         MSU1pV7iCKUbZIj1Ptgmz4IZ5RKf4eVawZwtJgrWtZEIALGTBxCYaWGVWVejbZigPT5g
         78oA==
X-Gm-Message-State: APjAAAXZNAANlvExrqQEgwDY3PnpSJiZIkxRPDfVzUgZVsH104s6aC9D
        8zS4PrDqg0L3dp8GvogXLd4=
X-Google-Smtp-Source: APXvYqyzU5KWypL3dJMrEivGN/RI66W/6qw+DVzTLawdpBa+0UHs3nOhRtWi7ZGWvT0j6Gtu/3HYgw==
X-Received: by 2002:a7b:c101:: with SMTP id w1mr6805153wmi.130.1572397491865;
        Tue, 29 Oct 2019 18:04:51 -0700 (PDT)
Received: from localhost ([92.177.95.83])
        by smtp.gmail.com with ESMTPSA id e15sm338461wrx.58.2019.10.29.18.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 18:04:51 -0700 (PDT)
From:   Roi Martin <jroi.martin@gmail.com>
To:     valdis.kletnieks@vt.edu
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Roi Martin <jroi.martin@gmail.com>
Subject: [PATCH 2/6] staging: exfat: make alignment match open parenthesis
Date:   Wed, 30 Oct 2019 02:03:24 +0100
Message-Id: <20191030010328.10203-3-jroi.martin@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191030010328.10203-1-jroi.martin@gmail.com>
References: <20191030010328.10203-1-jroi.martin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl warning:

	CHECK: Alignment should match open parenthesis

Signed-off-by: Roi Martin <jroi.martin@gmail.com>
---
 drivers/staging/exfat/exfat_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index d8f4fad732c4..177787296ab9 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -1703,7 +1703,7 @@ struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
 	size_t bufsize;
 
 	pr_debug("%s entered p_dir dir %u flags %x size %d\n",
-		__func__, p_dir->dir, p_dir->flags, p_dir->size);
+		 __func__, p_dir->dir, p_dir->flags, p_dir->size);
 
 	byte_offset = entry << DENTRY_SIZE_BITS;
 	ret = _walk_fat_chain(sb, p_dir, byte_offset, &clu);
@@ -1835,8 +1835,8 @@ struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
 		*file_ep = (struct dentry_t *)&es->__buf;
 
 	pr_debug("%s exiting es %p sec %llu offset %d flags %d, num_entries %u buf ptr %p\n",
-		   __func__, es, (unsigned long long)es->sector, es->offset,
-		   es->alloc_flag, es->num_entries, &es->__buf);
+		 __func__, es, (unsigned long long)es->sector, es->offset,
+		 es->alloc_flag, es->num_entries, &es->__buf);
 	return es;
 err_out:
 	pr_debug("%s exited NULL (es %p)\n", __func__, es);
@@ -1862,7 +1862,7 @@ static s32 __write_partial_entries_in_entry_set(struct super_block *sb,
 	u8 *buf, *esbuf = (u8 *)&es->__buf;
 
 	pr_debug("%s entered es %p sec %llu off %d count %d\n",
-		__func__, es, (unsigned long long)sec, off, count);
+		 __func__, es, (unsigned long long)sec, off, count);
 	num_entries = count;
 
 	while (num_entries) {
@@ -1876,8 +1876,8 @@ static s32 __write_partial_entries_in_entry_set(struct super_block *sb,
 			goto err_out;
 		pr_debug("es->buf %p buf_off %u\n", esbuf, buf_off);
 		pr_debug("copying %d entries from %p to sector %llu\n",
-			copy_entries, (esbuf + buf_off),
-			(unsigned long long)sec);
+			 copy_entries, (esbuf + buf_off),
+			 (unsigned long long)sec);
 		memcpy(buf + off, esbuf + buf_off,
 		       copy_entries << DENTRY_SIZE_BITS);
 		buf_modify(sb, sec);
-- 
2.20.1

