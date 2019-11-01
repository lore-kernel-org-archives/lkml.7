Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6D8CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C441C21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnSa6iYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbfKAHps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:45:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38737 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730135AbfKAHpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:45:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id v9so8814194wrq.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 00:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L3ntFqp0Br65sFjkR6CV5W+v78yDN2My2Y/1a4PurZc=;
        b=dnSa6iYhiNbdnjJmZ64ci22Ch8sTiVytWPZwp/hjW4bZZj9bX8HlNOYpLoAJtK5QAW
         Mjqohe0lpiN6BwInpgNQwBaMm48MYcx6CmBAjKRAXH7Ehq5xE64nuEyjgqn6s/vuwoo3
         6vTfUBcQyK5pt++HyFRgz/y4lBQg0/NNs+GOae3rK+gMX+/aEsXaOOuk5NyQs2YoEchD
         flDohJEiKxDyuUWk6L+KAxXWJNP/GlaHVI+5rw7gBmd8ms7/mvM0CdudoEcElp7d6Lu+
         9C0eNZNkHRPYs0IIF5MtPX0dISfIH/38IYa/Ffo67/O4qa1tko1zJQn9o7W9W4rlmvFw
         VKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L3ntFqp0Br65sFjkR6CV5W+v78yDN2My2Y/1a4PurZc=;
        b=gxqSvkF/fBs+54mUODH33nUl7cavm/KASqTW0tUhhjX38mAT8MuCjkHjmPPC9maMjf
         TPLFwUZzcLpXS7CilIre2ZiCUVYlJ3zzUL5EkqcTUhd8K/sf3w1LHGIxksVb/9BdNHOP
         SJNcycO1LmMjT7u7L9zeGEgeIOnPjVgvpKKU4wRTWtb8W/HTRg2jxlN7Hb8DkUw0+Ao4
         ke0yIw14wNMPiu5LWxBCShl67JhGF6E+1SYKLBT1izEXm4qfg98hSNDpdsfT26o6UfBH
         a/v5ii77xUUfj6GEmtBUSLWNsb/ntFKOtRQZv6rQ9XfTzQ746+TXvj5xZqUmjzE+xvtw
         1snw==
X-Gm-Message-State: APjAAAUcQWApc/TPAV401DUoETsp6Cyhylm5tXZZ5K9HAvv4fKdb39Ny
        xHvR2eK68aLMqgN/jDKJgz+pyA==
X-Google-Smtp-Source: APXvYqx/1+hZC5UBRjfU3f5D4vrBgNt9VxnDiNvcvjWAc0qKrIRAMx9kJKRvXpI1bvbFhPWOGkmUqQ==
X-Received: by 2002:adf:9799:: with SMTP id s25mr9477755wrb.390.1572594332397;
        Fri, 01 Nov 2019 00:45:32 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id b1sm576215wrw.77.2019.11.01.00.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 00:45:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, linus.walleij@linaro.org, baohua@kernel.org,
        stephan@gerhold.net, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 10/10] mfd: mfd-core: Move pdev->mfd_cell creation back into mfd_add_device()
Date:   Fri,  1 Nov 2019 07:45:18 +0000
Message-Id: <20191101074518.26228-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101074518.26228-1-lee.jones@linaro.org>
References: <20191101074518.26228-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the complexity of mfd_platform_add_cell() has been removed. The
only functionality left duplicates cell memory into the child's platform
device. Since it's only a few lines, moving it to the main thread and
removing the superfluous function makes sense.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
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

