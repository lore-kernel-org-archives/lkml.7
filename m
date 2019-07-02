Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8624EC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD402184E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqcOXLgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfGBH6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:58:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33618 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbfGBH6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:58:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so7862567pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UvvlGp3eGSAUa3B7hadJaLjlVQSu5Rrm7GGTmDxM7o0=;
        b=ZqcOXLgUwmb+SaFcoTURDt1DfT/OdurUlX08xXmWoWNcgVdDLaLcBEdxfK4wIvW6ms
         S5rlpSmkz2YogNooxkp5JihSm1rBuN7YEC+BL4PjE/E6wSegso282MAU9cK12Lqb12nW
         84eKQcZoN9EahukuWgJ7r6jJZ6Dnhbds/Xet+BkBpeUbxg/pfUEXwnQRF6Al1IWoDQdA
         tSJGzLdpmZILgzDj81d/PdQtFZ4K2WhidNRyyvDA4hapckjdWqmYiklUNxZBED0tiiHu
         0CW87EdcoZ/n20Vb+Kso6Rj9PGabDtQYHP9iAuE+CkICxl7XJ16P5HTSIU2l/58pawil
         VtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UvvlGp3eGSAUa3B7hadJaLjlVQSu5Rrm7GGTmDxM7o0=;
        b=FyMqySJJT2ETu/0QO32yT72DWQ/POSQU4bAwxhroNoZ79FRQ/rIrdY3EJI8rPC420m
         Xpz/v+ovlOM30L7eMWeaRZzipwXNfEZwtROSPyP7ELl0O0zBrGvJp+Tq94bVFgGn4ArN
         UEGADNvoeP8uF26UPlMzSp66BLVSbngiBrrcbG1zbjvaSgD69Lm/Mfj5V4kPs28Zc7Gk
         5LeI14uxsNncAmrpOD7Pc1+3ndNENpouEbO03Czmgtl0ZnyEEZEuF+ZQ9kpQyfR+w+zd
         PFO+fR4r4mFwSNQfe4WjJ7nK9J2dFaLsDmT7NJhYV806tIqjgxAA2U+xsqi4fHEr32TB
         iO2Q==
X-Gm-Message-State: APjAAAXatwdOS5sraPxd+1qtUVxfuOdTjpZvD8Bozn159TKFAcefQFpu
        eObjGnM1Btme/BP2t0LmN6zr/cpHDG0=
X-Google-Smtp-Source: APXvYqwSqw2KRywk3iV11LpzzECFaXFgYDirK7TNtPC/AIPn+u+sVAUiP14cEOwDTUa3DevR0hBvhA==
X-Received: by 2002:a63:480e:: with SMTP id v14mr28638707pga.182.1562054321062;
        Tue, 02 Jul 2019 00:58:41 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id m101sm1488652pjb.7.2019.07.02.00.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:58:40 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 14/27] mtd: nand: use kzalloc instead of kmalloc and memset
Date:   Tue,  2 Jul 2019 15:58:34 +0800
Message-Id: <20190702075834.24166-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc followed by a memset with kzalloc.

There is a recommendation to use zeroing allocator
rather than allocator followed by memset with 0 in
./scripts/coccinelle/api/alloc/zalloc-simple.cocci

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Resend

 drivers/mtd/nand/raw/nand_bch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_bch.c b/drivers/mtd/nand/raw/nand_bch.c
index 55aa4c1cd414..17527310c3a1 100644
--- a/drivers/mtd/nand/raw/nand_bch.c
+++ b/drivers/mtd/nand/raw/nand_bch.c
@@ -170,7 +170,7 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 		goto fail;
 	}
 
-	nbc->eccmask = kmalloc(eccbytes, GFP_KERNEL);
+	nbc->eccmask = kzalloc(eccbytes, GFP_KERNEL);
 	nbc->errloc = kmalloc_array(t, sizeof(*nbc->errloc), GFP_KERNEL);
 	if (!nbc->eccmask || !nbc->errloc)
 		goto fail;
@@ -182,7 +182,6 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 		goto fail;
 
 	memset(erased_page, 0xff, eccsize);
-	memset(nbc->eccmask, 0, eccbytes);
 	encode_bch(nbc->bch, erased_page, eccsize, nbc->eccmask);
 	kfree(erased_page);
 
-- 
2.11.0

