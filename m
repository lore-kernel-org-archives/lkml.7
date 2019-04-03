Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22728C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A3420700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/ldKCXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDCPGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:06:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40834 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfDCPGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:06:47 -0400
Received: by mail-ot1-f66.google.com with SMTP id t8so15682749otp.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jVlIjtQwxYyX09oSeFlGbXBOL6rS+qf+Knhu7f5+tDo=;
        b=J/ldKCXPuimZU2+8sAQ6f0grbujEOjYu8NRrNP9kJ5lzjRNeouCCygAvVvvtG6mvfX
         vjvryVib843NspmQyv3P4HhnIAqKKy07tupvi4PUAF9va5AAwJ3KuXQSIzs4KjkekpWS
         MQ6ga8XV6xxUKKNL1j47N2H/EYzhI6onLvSpeDuNyB1oWNxrucuzD2LOhDaFNmcQqxL6
         gq+JvsfGWS1GzrMQlPMmo0fV7JN2joy427t0k9mjYapxNdyxvv843a1JMFz/vhRDp9v3
         xsdD8KiYupvUGmNwnxHr/bDhWYEYNJZuTNzU6+TpKmGcOVsAHXnmC6g80Yo30BNRZ3Nj
         nqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jVlIjtQwxYyX09oSeFlGbXBOL6rS+qf+Knhu7f5+tDo=;
        b=d7YmERXq+EnT8vamK/YMSViLAefGPkZar3lASo5/K5qwCFpPMJyHRGbZ8b8/Q4Thtj
         y9Bg69uE5D0xR2DxVzLmZVIP0gckoQnthskmTK/XyBbZ1BJFp01oNnamEW1Kc8xEW/8Y
         ZY9I/1u/hHQpysaOkRbQxu6LdX/9uUBQpk2/+3qVQv5S91umKFTfOncQzL5aVHoG5vAa
         0fcIoAXx0jJFHKwjFrBgBbk26Ra1vw1Crjq8nbITkIN33wPxOHwI7nPCehDpdHgvbv7n
         TRT19LThAU6cLbD9gO19vDsQV1bwBlPsZHLnv35idEAdNLOiOQ4pNoigQ7OnWQQYIFRt
         k23A==
X-Gm-Message-State: APjAAAUH9FG/sdRNTnCUS1oaoVIZOj8rvejbDfbvaq6AHeUD3ddLQVNR
        OeCe4FkOAoy0KeSA11bd/lE=
X-Google-Smtp-Source: APXvYqxpX/V4sfmN8lA0Kdb2CP/BKeVLTZMy+3CfDEn1jw0ZzosJNIRlTLM2AojSwPXBc8LB+lVKGw==
X-Received: by 2002:a9d:76cb:: with SMTP id p11mr103581otl.248.1554304006259;
        Wed, 03 Apr 2019 08:06:46 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:1876:bc0b:8981:17be])
        by smtp.gmail.com with ESMTPSA id o18sm6530337otp.65.2019.04.03.08.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 08:06:45 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH v3] Staging: gasket: Use DIV_ROUND_UP
Date:   Wed,  3 Apr 2019 10:06:43 -0500
Message-Id: <20190403150643.16043-1-madhumithabiw@gmail.com>
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
Changes in v3:
- Included version no in patch

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

