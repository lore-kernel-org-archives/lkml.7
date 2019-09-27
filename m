Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E70AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6801C217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rpICZtHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfI0I2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:28:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39827 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfI0I2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:28:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17so785588plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 01:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kup3jsm2T4Dp1CMpcneLGkz+TmvPB+cIre+Bt8N3oes=;
        b=rpICZtHUVuixBVO9d63gc3dXlVxb5YYThUJCocG9ApQJYbNo/LxFKtQU5BHzYCzDwc
         wCoL5g5ttpMFs/gbhX3z9ojugOa2fWlQFa7Rd0LuJWQlT+IQe4lH4qxsWUOIMVSwqUXT
         uTT4JjV0ZBtr/GFzstQh90Zi5rpxlUijH+SZbUin3I289fbhcDde8eQaG1MamGu5F0NA
         wl2mgKMeTLY+dmDZmccS56NY/VpJT6knhUULKFmcsBQ6XqF6r8Wdez3brkUpGhmQgTpU
         HxHA3lwnbreMfHFCPN3M+6mSIcAEFwH/l6t4MELLMgZMOTXY+TMC3qRQLibaDWs44W2H
         c71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kup3jsm2T4Dp1CMpcneLGkz+TmvPB+cIre+Bt8N3oes=;
        b=gBIgyGdIER0Wgsg54B6PhXEkdz+kExg2vtU1+iHjbDvKC/h9aafTJF35Q2t7BCr5qI
         icJqNve5wZBUkYmnt7oNXwe2HazzjQdBqg7vnpSBueNhD6EAuA4DxLv9ADQdaNiQm5Dd
         naI7qh+qUS/YDsWwuQ7gWql32+cUAG6LWl/+TqGVj3miAQusU8UGZqKu5fkOoX6SK7HJ
         /IZMBQMaTT+g6lWoknm91gnsmvOOtwamdQLED8KfAzSXxMk3vp8VzMFrAx4/6+cb86zP
         IOD4KODTzwTcb6jusvVBR3OS5YcpaDzRjyvlxygANtYZNwuAByxPXPa2G3h1BEoWxvmZ
         C9JA==
X-Gm-Message-State: APjAAAV1YMMvCuNBKK+eO1zJoh60QBeeGrWDUuA77R9LJPpI+WDUgftB
        kekCnUPmKIbpNkfdZr/N8MgJ9w==
X-Google-Smtp-Source: APXvYqwYq8FcmeV1WLMy2kTsH58CPZftMErROYm+5CSFzop11lr8v6sNzDkPXayoOGA7AOSxCrihcQ==
X-Received: by 2002:a17:902:a985:: with SMTP id bh5mr3242251plb.107.1569572889229;
        Fri, 27 Sep 2019 01:28:09 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 6sm2043521pfa.162.2019.09.27.01.28.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Sep 2019 01:28:08 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     linus.walleij@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org
Cc:     baolin.wang@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hwspinlock: u8500_hsem: Change to use devm_platform_ioremap_resource()
Date:   Fri, 27 Sep 2019 16:27:41 +0800
Message-Id: <e991666ead56cac30a7ef9cec85e802b57d47458.1569572448.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1569572448.git.baolin.wang@linaro.org>
References: <cover.1569572448.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1569572448.git.baolin.wang@linaro.org>
References: <cover.1569572448.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together, which can simpify the code.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/u8500_hsem.c |   20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/hwspinlock/u8500_hsem.c b/drivers/hwspinlock/u8500_hsem.c
index 572ca79..c247a87 100644
--- a/drivers/hwspinlock/u8500_hsem.c
+++ b/drivers/hwspinlock/u8500_hsem.c
@@ -88,7 +88,6 @@ static int u8500_hsem_probe(struct platform_device *pdev)
 	struct hwspinlock_pdata *pdata = pdev->dev.platform_data;
 	struct hwspinlock_device *bank;
 	struct hwspinlock *hwlock;
-	struct resource *res;
 	void __iomem *io_base;
 	int i, ret, num_locks = U8500_MAX_SEMAPHORE;
 	ulong val;
@@ -96,13 +95,9 @@ static int u8500_hsem_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -ENODEV;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	io_base = ioremap(res->start, resource_size(res));
-	if (!io_base)
-		return -ENOMEM;
+	io_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
 
 	/* make sure protocol 1 is selected */
 	val = readl(io_base + HSEM_CTRL_REG);
@@ -112,10 +107,8 @@ static int u8500_hsem_probe(struct platform_device *pdev)
 	writel(0xFFFF, io_base + HSEM_ICRALL);
 
 	bank = kzalloc(struct_size(bank, lock, num_locks), GFP_KERNEL);
-	if (!bank) {
-		ret = -ENOMEM;
-		goto iounmap_base;
-	}
+	if (!bank)
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, bank);
 
@@ -135,8 +128,6 @@ static int u8500_hsem_probe(struct platform_device *pdev)
 reg_fail:
 	pm_runtime_disable(&pdev->dev);
 	kfree(bank);
-iounmap_base:
-	iounmap(io_base);
 	return ret;
 }
 
@@ -156,7 +147,6 @@ static int u8500_hsem_remove(struct platform_device *pdev)
 	}
 
 	pm_runtime_disable(&pdev->dev);
-	iounmap(io_base);
 	kfree(bank);
 
 	return 0;
-- 
1.7.9.5

