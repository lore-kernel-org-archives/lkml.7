Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F536CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B362084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+XYPSq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfJUK6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:58:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53318 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfJUK6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:58:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so12785545wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/WGAQrvHY5TjDUNFg6EjqFOZngCTsCOrFFEohgL8HW8=;
        b=B+XYPSq1urYE2HkEcpY2835/NlXmGMnLkjGbIG1A67Ue4TIGWTiHwFP/CiCW2C5h+T
         h4Cy7j+aP+O4QHAnjFTRRYyVNuY9Dh6GepwO16DNbSg9ZunSaKm2KiwnxR/YZxkMwume
         NnjiEuKgmvF+Dq/UPGVy5kIEYzNAySo86swGeLrolI3Qz1viYRWzQ6KZRM0MNDTUYMpQ
         bmqIfZxg98ZWG+aJ29/Z2AsbhE+1Fzf6S+BVkSKStF9ShV4MWItJp7AHceymb1CxWUxI
         pWOdsLZqoiaxyXUNnc5tGbN18hG0es6wJGt6f1gYZoqqxUFOuAHs6KTLEVxNnmsmJaGp
         FkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/WGAQrvHY5TjDUNFg6EjqFOZngCTsCOrFFEohgL8HW8=;
        b=OgwFFPaXGQUw0+0QQih5BrgYM1NQ7zuTw2FAM3+lSYj4jE9/Zf3Fq3Q5N86LkWRlSO
         P2fQrnyBrZ+rFNys8mg072sy4T4O5WU6IXaTyo+SzW4m6jZ5LZOJXqNLV0a4qYH5i11R
         A2M+0EKcl5HKQw/GJHp4LUR+lkXHLYaTARMme7vaudzHYUdcVoEhppoC9VQw8flrO4/G
         GAaDDG0wNWfr3k7NRZH9vUgvHP4s8lfJCAYWp7ZnNkA1KQz/caq9+IitE6HxzQ/f+M/W
         5jqxTHASd5ks3pTzkTD8+LfUU5zcRZKdmedQ5qTijwtB3VbeaYpbQQHc6CvPyAtBYZiU
         wMzg==
X-Gm-Message-State: APjAAAWmnoVNwCSCcrcJw8uA1/f/wBiNXq8zp0le/NBk3u45g3thag8r
        rieh8ekCjMgxFvTLJuS/ouFT5g==
X-Google-Smtp-Source: APXvYqy4ioC1NHywrjClvJ5LC459fxXuH6zKMg0fk8PIDO/Kskdhz3hGWzFcmG6iC/AhBj6iaHvygg==
X-Received: by 2002:a05:600c:2948:: with SMTP id n8mr5822833wmd.128.1571655507269;
        Mon, 21 Oct 2019 03:58:27 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id q22sm12544289wmj.31.2019.10.21.03.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:58:26 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 2/9] mfd: cs5535-mfd: Remove mfd_cell->id hack
Date:   Mon, 21 Oct 2019 11:58:15 +0100
Message-Id: <20191021105822.20271-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021105822.20271-1-lee.jones@linaro.org>
References: <20191021105822.20271-1-lee.jones@linaro.org>
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
index 2c47afc22d24..9ce6bbcdbda1 100644
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
+		if (cell->num_resources <= 0)
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

