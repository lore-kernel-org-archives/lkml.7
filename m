Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDBFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6A32084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cTeiB4Qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfJUK6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:58:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35561 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfJUK6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:58:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id l10so12992728wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aRIsIrxJRG4WGhOzej9X0cMyz5OqcLFYkbUiKyLomGE=;
        b=cTeiB4QcI/9D1UCeh1hzV+1od3PVVBhQlL72xj03bVUzMnwFnJarkT3Uqedx1NfBAs
         VYsdVW/U+jL6mmMApxUm7s8EdbLDQ34lDiQMVyO9e5xbSkHQ92Y3/3wKHbOlES7D+Q9a
         AKRv2JAi+ZPKpEzpS6yO7Nf7cRoCEXJebv27MfESjaxI9K2IO1OZJRf3ShNdo2GSHebK
         6VZoPHGPCibQycGVei+Ls5x1pYadk/6OK3pre7jjZbewtrAt0cEbQ59GI1uCS7ri9dRb
         foXS/X1MFU+gZDuV21M+EN9A04hTB6AvIaaOWnpSGeDfWgQNuXi0Xg3Ned6IUGuMXaRC
         bjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aRIsIrxJRG4WGhOzej9X0cMyz5OqcLFYkbUiKyLomGE=;
        b=AMuVirigt5A/YFoo5PMrccNLVMNrrKg9Z/W/mv1pgYtssT182/1pBbjyk0qvEJChmz
         0AHgrwtjKX1zWaPYMyT1SLGWa2nTkIQ/3hO+Ig0U/OYoyYeZ9jzWKYHhUFDxCDppPZIe
         E3FTwHPqefATqrIg8xq5s1Yx5In8OtAj/SOMCSE40n6yAySof7QkEeHrY1+DTuVDpp+i
         e9e1MVVFhlQCnxZesrTu/AoVPFtdu9/cOhhzKC/mowp3wuZe6Efl6ejeXFG3PHBKEz8k
         JgAe1J/ItL6J/d0zNDTvyVIEIJq1p9TZJMpYevtYdAZ9LrukkgA2wDX0doKJ4CNxINix
         BXFw==
X-Gm-Message-State: APjAAAX2Ze1+/4xACW3+7swcm8SjUXoYRK5Pwz5BX7Y5flb8bhzlcSKT
        EPXYIGzfPnMY9BpBH6sPhvD2lg==
X-Google-Smtp-Source: APXvYqwoMZ0Xrjo13bXEBEaHCm4InAmzMPniweiB+Wqxda5ESkJaOgUQJn/z4SYHvFyxum1/utelgg==
X-Received: by 2002:a5d:5401:: with SMTP id g1mr9448965wrv.54.1571655514185;
        Mon, 21 Oct 2019 03:58:34 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id q22sm12544289wmj.31.2019.10.21.03.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:58:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 9/9] mfd: mfd-core: Move pdev->mfd_cell creation back into mfd_add_device()
Date:   Mon, 21 Oct 2019 11:58:22 +0100
Message-Id: <20191021105822.20271-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021105822.20271-1-lee.jones@linaro.org>
References: <20191021105822.20271-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the complexity of mfd_platform_add_cell() has been removed. The
only functionality left duplicates cell memory into the child's platform
device. Since it's only a few lines, moving it to the main thread and
removing the superfluous function makes sense.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mfd-core.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 5d56015baeeb..849dbe3798b0 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -49,19 +49,6 @@ int mfd_cell_disable(struct platform_device *pdev)
 }
 EXPORT_SYMBOL(mfd_cell_disable);
 
-static int mfd_platform_add_cell(struct platform_device *pdev,
-				 const struct mfd_cell *cell)
-{
-	if (!cell)
-		return 0;
-
-	pdev->mfd_cell = kmemdup(cell, sizeof(*cell), GFP_KERNEL);
-	if (!pdev->mfd_cell)
-		return -ENOMEM;
-
-	return 0;
-}
-
 #if IS_ENABLED(CONFIG_ACPI)
 static void mfd_acpi_add_device(const struct mfd_cell *cell,
 				struct platform_device *pdev)
@@ -141,6 +128,10 @@ static int mfd_add_device(struct device *parent, int id,
 	if (!pdev)
 		goto fail_alloc;
 
+	pdev->mfd_cell = kmemdup(cell, sizeof(*cell), GFP_KERNEL);
+	if (!pdev->mfd_cell)
+		goto fail_device;
+
 	res = kcalloc(cell->num_resources, sizeof(*res), GFP_KERNEL);
 	if (!res)
 		goto fail_device;
@@ -183,10 +174,6 @@ static int mfd_add_device(struct device *parent, int id,
 			goto fail_alias;
 	}
 
-	ret = mfd_platform_add_cell(pdev, cell);
-	if (ret)
-		goto fail_alias;
-
 	for (r = 0; r < cell->num_resources; r++) {
 		res[r].name = cell->resources[r].name;
 		res[r].flags = cell->resources[r].flags;
-- 
2.17.1

