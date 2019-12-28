Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3715BC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08448208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7vEaKGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfL1Ugd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:36:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37941 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfL1UgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:36:16 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so7881739ljh.5;
        Sat, 28 Dec 2019 12:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fgW9WfTn8X3WZuGcM/h5imLbxZaVk2cOU8JExlEzbac=;
        b=a7vEaKGiraduPlz/LEWZFrz2HVZNJmM+o8/HNt+p4O6ZbUkPFk8qbHsozvcq0YtQ5o
         ygQC0BnfUieesBs6dDquCRfaPzOQG00oINlNygIhpQWxNVLZoj3qKaMvZg7HI4Rp5Nu7
         0qNQB1/JZp7ynY1oOWr7C73fKiEPSmQLmpC9uan7/ECSqLi9n6oCRvamwYfpASD17PL4
         5gR4e7Ie/NOL2qfpYMMJO8lyYmEW2qAd1L1+A2MK/fQOlpnJkafOd5jdgJ/hDF0iIzIC
         a/TMbDGYl5L04dfGT8jaRsG2PdEPrDiW9tCfARyrd5tMiZwUB/dTBYLSAb00Gj0RLgG0
         ofdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fgW9WfTn8X3WZuGcM/h5imLbxZaVk2cOU8JExlEzbac=;
        b=Zf6GZjZNgIidiT+f79dS45OqDWnSofdnd05JTYh3ZhFOwWgzx4rkUyV12dYQXmHWK6
         RZJt3sPXFsBIOdWonZo7eJL8L6WB+m1xF5WoIm6mPFpKMZRh8jyVTwyZm4XohZuWOwRL
         ZxLavDUOlE4I01PxA4nGKqNIsaXuD24tFkiFysND3m86Qh07O0nyNAFz/lpkNJJEWd6z
         /pDDL73gBhvr8kF8a0BthWVaWpiuxzk1wncUrNgxvukODJF61Y8/753LDVJJsHFpwHQM
         N/iEkqTw39xLuWFEZcDXvOwA3NuOns8VN3HFvfhjD+nILjfNAZ6LcmYWUQe6ZaWo7ffR
         pS5A==
X-Gm-Message-State: APjAAAXhF+I/Vp/y+YQ687ujY3kg8KyLDJyRrCaaj1nidtSny4rz5HEz
        kf2XgX/OJ9nbbiGjJyxNMvGu0X3g
X-Google-Smtp-Source: APXvYqwkWEkCJvJNUwGG0WqfR9fyeX9vhdoAfDOI7ZSJ384mLZEsH+drdrJLz1djD2HuBOPj73CllQ==
X-Received: by 2002:a2e:909a:: with SMTP id l26mr12822834ljg.209.1577565373710;
        Sat, 28 Dec 2019 12:36:13 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d9sm15162614lja.73.2019.12.28.12.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:36:13 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/16] usb: host: ehci-tegra: Remove unused fields from tegra_ehci_hcd
Date:   Sat, 28 Dec 2019 23:33:58 +0300
Message-Id: <20191228203358.23490-17-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228203358.23490-1-digetx@gmail.com>
References: <20191228203358.23490-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few stale fields in tegra_ehci_hcd structure, let's remove them.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/host/ehci-tegra.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 4d2cdec4cb78..eb82cdfffc3c 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -42,12 +42,10 @@ struct tegra_ehci_soc_config {
 };
 
 struct tegra_ehci_hcd {
-	struct tegra_usb_phy *phy;
 	struct clk *clk;
 	struct reset_control *rst;
 	int port_resuming;
 	bool needs_double_reset;
-	enum tegra_usb_phy_port_speed port_speed;
 };
 
 static int tegra_reset_usb_controller(struct platform_device *pdev)
-- 
2.24.0

