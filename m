Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA46BC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A3C22319
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIVfal5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfKRUGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:06:22 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35333 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfKRUF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:05:58 -0500
Received: by mail-lf1-f65.google.com with SMTP id q28so954488lfp.2;
        Mon, 18 Nov 2019 12:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rtrkjrjFdrCSY4w3UkoaopBMgCTAU9tc9NbxXmX2YTg=;
        b=bIVfal5TVp5xBuBX6ib+z1CzBJxpz6RaF2qAdEWAm9btjqcLZW4/Ah6i/EXi+X77vV
         PhqjrJDdznHgGQYBexXUTGuVqpa5110USfShOzHSTcvJDJH8dB/ZXVKtiL+yOUZ1fKzL
         cgL2KKrxnCNn7k6kCsm3t0aiOzj9nywSK2bmjLqTjRUSKMsGXXfU08ZW78R/DXS+gmPx
         DvmecJFJwWV+APIfPg+wsr+JjtYzcAw12XhS6aODRo9XLGDwpf6oVZhCCTNumEiByX+7
         lhY03Hdk5q/mcJhFuZCuW95zlgzwzmyYfIybzyKQFm8TNVLzCOe69QultsXAnnzUIGFS
         qBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rtrkjrjFdrCSY4w3UkoaopBMgCTAU9tc9NbxXmX2YTg=;
        b=g/Lz1XmIsCjeEYJkTXlNUTT6GLA4YMyXyr6wFyJjQi3Higl+l9kZQnfcaFKNt2GjJN
         6BzBjktSi5ASXqnjkCxjXDgZEeDkHnenypR1/I+uha76aj/4yuCIvNqYTTAhLLiXfUhC
         06uDE7ij+yjKBZCPaIDNhDlkKrz42AtCCJtHYo2AioWt+LCLOPJYRzWIkIgql4qnqCkh
         LfKPMWef+fojvr8PY8dHNZnOhUpUiENSjF9COmX1SIh+cYQUOIzqTk4X6K7egQooaCsR
         yTWTnAQlaZg2OVmnxyTjRXmficNkikwukbjFnHY8RGZQSh60gd7AT0ayceJVqzmdueww
         Oo/Q==
X-Gm-Message-State: APjAAAViDhFq9vUf50BHnUcb3nymWjirl5NvHFhKyf3b2KV5PjX45pvU
        i6RoivndbR+L5ROhQERR/4I=
X-Google-Smtp-Source: APXvYqwvDSE0CmdElgXhtuj+X3izqvNU9SOYdSyw5i/wFKniJwWhRhcNQLraK3ba4bGSLwu1vA1bjw==
X-Received: by 2002:a19:ac08:: with SMTP id g8mr934655lfc.112.1574107554632;
        Mon, 18 Nov 2019 12:05:54 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:54 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 24/29] drm/tegra: dc: Use devm_platform_ioremap_resource
Date:   Mon, 18 Nov 2019 23:02:42 +0300
Message-Id: <20191118200247.3567-25-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize that relatively new helper which makes code a bit cleaner.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 5b1f9ff97576..14834cba5455 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2421,7 +2421,6 @@ static int tegra_dc_couple(struct tegra_dc *dc)
 
 static int tegra_dc_probe(struct platform_device *pdev)
 {
-	struct resource *regs;
 	struct tegra_dc *dc;
 	int err;
 
@@ -2478,8 +2477,7 @@ static int tegra_dc_probe(struct platform_device *pdev)
 		tegra_powergate_power_off(dc->powergate);
 	}
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dc->regs = devm_ioremap_resource(&pdev->dev, regs);
+	dc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dc->regs))
 		return PTR_ERR(dc->regs);
 
-- 
2.23.0

