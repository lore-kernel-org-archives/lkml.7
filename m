Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17E1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9352075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxiR3uwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfDCO6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:58:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42880 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfDCO6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:58:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id 103so15629315otd.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s3a6kw31Eh/tUpNZw00g//755YybTDwlei++L30AIDU=;
        b=BxiR3uwaNbydHkdnYDjQqZ2CZpMUam68b7NlCWCf9WW5vpam/pUfZ8yhTP2iKeFTVY
         NYuKa74n8WjXO6tJtY/7sxDBc/V8obuNRwfslwI9VPRE5zgITGOO38C9zekB/zmQK6Ry
         PX1nkHtNvKXmgLAiNz3RaEx3LTdMGbsZNZbeZBgve8Y8lL5lK4iUN6JJDdTSL+9mUnLT
         CskZbtM9+rBEKK5RhoWlMce/1+rhPLlNtA9mmE82lv650tG1zFcsXVTGDZaQkQYoKUs5
         /5RcSHRh1oxBoDWR2YM/fb4+SSBnotjBT6XhMjmR5pTmR6yqSJCOspi68EOioqAS0K0d
         PbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s3a6kw31Eh/tUpNZw00g//755YybTDwlei++L30AIDU=;
        b=j8dPOX5dWtOYW+buIfMtk1cQMyIUGldGQs3a4oO5qOAJ8es2diD7dtFcaff20GSqow
         cfEjvVBpEZN7J67sF4/N23xpPtSLz7yisVNMWyOgCIg8z4HHIKQ/ImpigYOnJPDQYpCR
         s2qSPRHJLMkQk+ceCmbyaQEqvimooZEKvfZBBqXodY6sSoBiJpalXkBAX8FDLo5LnX8L
         zgx8aWkuSaFGVWraXuo2jlI7hmTkNg1n2iyyqbDbT0OVahV40v4wiqsqn1oZ+GWwzQOq
         py7NQCpK5qdfEOEmCGHDekVYvIzDjOKt2noRaphlxeY8zJDI27GDwBe5abZy8v1gL3Us
         iLHA==
X-Gm-Message-State: APjAAAXjiuR9R4R01lmZ0LrFls40ZJDWtA2uDrLoclvPcALL3js6UQN+
        hrY8BFGsF4iYVA0R1n0daPo=
X-Google-Smtp-Source: APXvYqwj0LBgaaa4bajaFsEB5msUekPfrTHPn6F2F3WGkYDfZ+/ouxmFQlRGA6JXW98x2m+6AZUvSw==
X-Received: by 2002:a05:6830:1398:: with SMTP id d24mr86133otq.104.1554303528836;
        Wed, 03 Apr 2019 07:58:48 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:1876:bc0b:8981:17be])
        by smtp.gmail.com with ESMTPSA id 189sm6301129oid.35.2019.04.03.07.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 07:58:47 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH] Staging: gasket: Use DIV_ROUND_UP
Date:   Wed,  3 Apr 2019 09:58:44 -0500
Message-Id: <20190403145844.15624-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DIV_ROUND_UP in-kernel function to make code simple and more
understandable.

Issue found using Coccinelle.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>

---
Changes in v2:
- Commit log modified
---
 drivers/staging/gasket/gasket_page_table.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 26755d9ca41d..600928f63577 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -768,8 +768,7 @@ static bool gasket_is_extended_dev_addr_bad(struct gasket_page_table *pg_tbl,
 	page_lvl0_idx = gasket_extended_lvl0_page_idx(pg_tbl, dev_addr);
 
 	/* Get the count of affected level 0 pages. */
-	num_lvl0_pages = (num_pages + GASKET_PAGES_PER_SUBTABLE - 1) /
-		GASKET_PAGES_PER_SUBTABLE;
+	num_lvl0_pages = DIV_ROUND_UP(num_pages, GASKET_PAGES_PER_SUBTABLE);
 
 	if (gasket_components_to_dev_address(pg_tbl, 0, page_global_idx,
 					     page_offset) != dev_addr) {
@@ -1258,7 +1257,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 	dma_addr_t handle;
 	void *mem;
 	int j;
-	unsigned int num_pages = (size + PAGE_SIZE - 1) / PAGE_SIZE;
+	unsigned int num_pages = DIV_ROUND_UP(size, PAGE_SIZE);
 	const struct gasket_driver_desc *driver_desc =
 		gasket_get_driver_desc(gasket_dev);
 
-- 
2.17.1

