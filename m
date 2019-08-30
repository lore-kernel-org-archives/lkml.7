Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEE8C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4332070B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WAQJlbmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfH3HRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:17:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39790 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbfH3HRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:17:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so5858472wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 00:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vb7GxMox8GW4icSo2qX00cFQWvHnLzZGW13vcUTShQE=;
        b=WAQJlbmkmnmIuVhxCeqPrEzfqnlpYvSOrdixOe4Z9156CTPal3tG1hwcQWWy+Z21tL
         mOiGmwjw5LfRU3lcXsunSl/jw76qkKc8yp1t1pSN/VD7DVAk4t5iQ9U8DBlJUmITUM9d
         2IxSHXLkycIF4k4hvH7PpYZlk+hhcgYSq5dtVERzmteYgGQlVN4d42mVn2UycezdGQMY
         sT9SipL7OZNffBIsqlS2BNojmLw2NFwsp6wHNFmpjYD5irxXIIEnoQ8PciwfpbL6F7SI
         /+ST61Q9PN6QhC7fIe/EyYjna6ppzVFEAoOClugrYP3bXmY1AVjOMWPK8HviQt2kClP1
         iDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vb7GxMox8GW4icSo2qX00cFQWvHnLzZGW13vcUTShQE=;
        b=i8U8SLa6plKIoF9Xxd0o7tt1nlK73Uof3NW9BvQycy0g2IITE/0v2aYmoWR53Paydo
         SAMZqenLTob5I9HOlOoWKDAfoxMzGJQtgRVbXy4n0gdwKt9eXzbaXrYwsWgUdctdCcJ8
         MR36PVFuEoxEw+SdxiMdz8YgaltT9Q+0A6QDmJMrJCD3spWiuAnnueMV6WK5Qf2NxEr7
         lmwoNRPyrmY91gAH/RkDE16prQN9jdd6vvO0Y1mcGaurETbdDDRIETGXbE+iHx8GvS6z
         vqMo1Hh+0zhRPvAdvYyVfKCkg11JBzQZWpVgGgW06dsLK+NoM/FOErHHwpfP89535OG0
         SFNA==
X-Gm-Message-State: APjAAAUnPRw/VX5/vvuSpfUxlChDD/gROjt0zO0KIjZmxqdnvHMbGMcE
        QAw3GCRhyw7/VCOYX/eehkAPnQ==
X-Google-Smtp-Source: APXvYqxIInMCzWNf34LxcyxSnQVs/J+xN1iNdetlgr35rdEBD2cxk1bJXmhlgRog97aovvym4oXZLQ==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr16210331wrs.347.1567149472173;
        Fri, 30 Aug 2019 00:17:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x6sm7637529wrt.63.2019.08.30.00.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 00:17:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/4] ahci: tegra: use regulator_bulk_set_supply_names()
Date:   Fri, 30 Aug 2019 09:17:38 +0200
Message-Id: <20190830071740.4267-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190830071740.4267-1-brgl@bgdev.pl>
References: <20190830071740.4267-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the new regulator helper instead of a for loop.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/ata/ahci_tegra.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index e3163dae5e85..cb55ebc1725b 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -483,7 +483,6 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 	struct tegra_ahci_priv *tegra;
 	struct resource *res;
 	int ret;
-	unsigned int i;
 
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
@@ -543,8 +542,9 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 	if (!tegra->supplies)
 		return -ENOMEM;
 
-	for (i = 0; i < tegra->soc->num_supplies; i++)
-		tegra->supplies[i].supply = tegra->soc->supply_names[i];
+	regulator_bulk_set_supply_names(tegra->supplies,
+					tegra->soc->supply_names,
+					tegra->soc->num_supplies);
 
 	ret = devm_regulator_bulk_get(&pdev->dev,
 				      tegra->soc->num_supplies,
-- 
2.21.0

