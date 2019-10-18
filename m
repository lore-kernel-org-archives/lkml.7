Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A39CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBA8222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SGq9PI4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633947AbfJRM4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:56:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52169 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410137AbfJRM4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:56:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so6108807wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 05:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tA6TKsBMxQLUjSU3fzXg4jKW0/ylO7bO362kG6mzlHw=;
        b=SGq9PI4daFfcszjMKf2wYtPHwldGY0somzhl6xsa50sVxELUnAfL1hBRF6DH65q8e+
         ejb63GlrWXNL/FqxGKP+fBm7jeh1Xxm3kB66e+SmLAN+BX6OlCaLM69RkdnszMpvJ4ua
         NdH4/2Qmt6LOZutddI2mB4sg7QT6L42JVh97GK7baN2XK5Hrikafro5EnAFfm9ldTAdq
         pYA+68ajMbp7se1ubtErRWe6dlKVnwiiVatdOzyhewkYYqz3nYhszY/g0lVNv1CBQp7r
         88R6F4ZTnbr6TLNCeplZ9/nRPFa7M5jMKG+i5UOJpzDRzv6M1AgqLIKuOgb65MS9Q3v0
         6rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tA6TKsBMxQLUjSU3fzXg4jKW0/ylO7bO362kG6mzlHw=;
        b=tijtU8M8zVnn5SYEaz4G2sNktzLm81DqSVqCUPE+RSfiCver3QNhSGrUi1kF2LnbX+
         NWolSz5iXf2JYZwnvHuclzQutpVa/yizpyOxN8pTgpp3S9/X01foYioayLChVZSMOkZJ
         YLqAaSv1sDduikBdLvBgZgaJYeq3vB/CtLPOzqevkT8FtAw2l5eqee8e6d/0sYNC0QdR
         DnpMftlVY6Ss0Od4hUHPQ523/nIrOicdvMV79lSfSvS7YKZE/AbhnJRcpwAlMphlae+u
         qTnWkHl//isf55+Le+QsViPO5kBGg+BoM92BXlSPEP/kYi4auaqzQROPkqcavjGYFIva
         f49Q==
X-Gm-Message-State: APjAAAV9NmAC6TOMhOW70xW4mCPIMtSCfAhFzC0tUaoIb9xwQpzdN6TO
        18LqLdOJZd2LOQSHb9dAeUOu2g==
X-Google-Smtp-Source: APXvYqwp46K8H2YQKmb4g7tbkrXHvSEqRlsPgEVRW9eieKGVBHP4e+KFUDwUxLyeujyMKqy4+WUygQ==
X-Received: by 2002:a05:600c:23cf:: with SMTP id p15mr3532014wmb.1.1571403372638;
        Fri, 18 Oct 2019 05:56:12 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.47])
        by smtp.gmail.com with ESMTPSA id q14sm6058491wre.27.2019.10.18.05.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:56:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, linus.walleij@linaro.org,
        daniel.thompson@linaro.org, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dilinger@queued.net, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/4] mfd: cs5535-mfd: Remove mfd_cell->id hack
Date:   Fri, 18 Oct 2019 13:56:06 +0100
Message-Id: <20191018125608.5362-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018125608.5362-1-lee.jones@linaro.org>
References: <20191018125608.5362-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation abuses the platform 'id' mfd_cell member
to index into the correct resources entry.  If we place all cells
into their numbered slots, we can cycle through all the cell entries
and only process the populated ones which avoids this behaviour.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/cs5535-mfd.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index 2c47afc22d24..b01e5bb4ed03 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -62,26 +62,22 @@ static int cs5535_mfd_res_disable(struct platform_device *pdev)
 static struct resource cs5535_mfd_resources[NR_BARS];
 
 static struct mfd_cell cs5535_mfd_cells[] = {
-	{
-		.id = SMB_BAR,
+	[SMB_BAR] = {
 		.name = "cs5535-smb",
 		.num_resources = 1,
 		.resources = &cs5535_mfd_resources[SMB_BAR],
 	},
-	{
-		.id = GPIO_BAR,
+	[GPIO_BAR] = {
 		.name = "cs5535-gpio",
 		.num_resources = 1,
 		.resources = &cs5535_mfd_resources[GPIO_BAR],
 	},
-	{
-		.id = MFGPT_BAR,
+	[MFGPT_BAR] = {
 		.name = "cs5535-mfgpt",
 		.num_resources = 1,
 		.resources = &cs5535_mfd_resources[MFGPT_BAR],
 	},
-	{
-		.id = PMS_BAR,
+	[PMS_BAR] = {
 		.name = "cs5535-pms",
 		.num_resources = 1,
 		.resources = &cs5535_mfd_resources[PMS_BAR],
@@ -89,8 +85,7 @@ static struct mfd_cell cs5535_mfd_cells[] = {
 		.enable = cs5535_mfd_res_enable,
 		.disable = cs5535_mfd_res_disable,
 	},
-	{
-		.id = ACPI_BAR,
+	[ACPI_BAR] = {
 		.name = "cs5535-acpi",
 		.num_resources = 1,
 		.resources = &cs5535_mfd_resources[ACPI_BAR],
@@ -115,16 +110,16 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
 		return err;
 
 	/* fill in IO range for each cell; subdrivers handle the region */
-	for (i = 0; i < ARRAY_SIZE(cs5535_mfd_cells); i++) {
-		int bar = cs5535_mfd_cells[i].id;
-		struct resource *r = &cs5535_mfd_resources[bar];
+	for (i = 0; i < NR_BARS; i++) {
+		struct mfd_cell *cell = &cs5535_mfd_cells[i];
+		struct resource *r = &cs5535_mfd_resources[i];
 
-		r->flags = IORESOURCE_IO;
-		r->start = pci_resource_start(pdev, bar);
-		r->end = pci_resource_end(pdev, bar);
+		if (!cell)
+			continue;
 
-		/* id is used for temporarily storing BAR; unset it now */
-		cs5535_mfd_cells[i].id = 0;
+		r->flags = IORESOURCE_IO;
+		r->start = pci_resource_start(pdev, i);
+		r->end = pci_resource_end(pdev, i);
 	}
 
 	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, cs5535_mfd_cells,
-- 
2.17.1

