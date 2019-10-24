Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788A6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE3421906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="exAyRgPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503628AbfJXQjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:39:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35244 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503551AbfJXQis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:38:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id l10so26413214wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LHOyXu4LqYDTcB2MwV67QciReuGA+gSIbqPrvF1Pvm4=;
        b=exAyRgPo0tbJRTibAfJNkRf5NqiS7Ggg8h7mHvZ93UuWH2HxFLfuM+W2DRhuQ3qGGe
         873Cwjby6hyu8499QtMvCUQtoiPQlnls1+CUQAl+qaV3cPMqI6WRcvL+uk/WNtrf1f3O
         V63sZiuElS1jIMoYNlFn6Qaif3JuuBTrukVtupm8yy0kK3BYvzaoaayGklWl7Nmj7bfQ
         MPKHe5ssUy6qZEWe0Lk2q1Zyo8YuhhrVyzXNbOU8foIv9fitdgPO/Cq580RJgByiKLik
         r4GpUfpfyrc3VEJqT5q86Px1YIobxXVM+oEi/sdSo1Q8HcJpmdMlS+V23XpuIu3ixY4x
         9Ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LHOyXu4LqYDTcB2MwV67QciReuGA+gSIbqPrvF1Pvm4=;
        b=Hcz7ZhJiQqGjsFwRwWwRycRx+okwZXcKPeP3biNidPs8iAXNyIPJZgOKQZ5aW4/0JS
         hFxa33CyTdNvv9Upkv4q0frCTAORlv74os8GHv7oiiMb0OBymnYl/EsBM4AZm7aonZQV
         RwWdzkneNxKgdZZFelXKgoiZ0NNHQsYE6/C5pPTbwMfXvOC34IfpptP2D8gw7/eqJQRW
         clQ8K52zBHkTDJ8/WZYsamWr2nABHQlLyXll7liP5TgP5NPU0q5tG8JS3LKloik/k/GG
         qr8A5BglgfosTMPu0x2lh/NVoRYJhnNGdHvIBnfc43ax9ncN8432J1JfCJDGYruugXYJ
         aGyw==
X-Gm-Message-State: APjAAAVON11DEMHEIZ1LCfG15kInf/EAPzQmF5pm4noPO1yPbVF63H9e
        2tdCCUlOxdR8xUwLMcYI+QGHJQ==
X-Google-Smtp-Source: APXvYqyubqgTBkJNQdyGVV4VJV2DqZXlnmzjNcJeg7aDjQ/q/fgUBOQsdJ+wi1CWkaW+OCsEsKoEzw==
X-Received: by 2002:adf:e50a:: with SMTP id j10mr4493921wrm.352.1571935126970;
        Thu, 24 Oct 2019 09:38:46 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id 6sm3446175wmd.36.2019.10.24.09.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:38:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 10/10] mfd: mfd-core: Move pdev->mfd_cell creation back into mfd_add_device()
Date:   Thu, 24 Oct 2019 17:38:32 +0100
Message-Id: <20191024163832.31326-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024163832.31326-1-lee.jones@linaro.org>
References: <20191024163832.31326-1-lee.jones@linaro.org>
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
index 2535dd3605c0..cb3e0a14bbdd 100644
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

