Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263F7C00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24852072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERNPqWxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgAFBRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:17:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34222 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbgAFBRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:17:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id z22so44469348ljg.1;
        Sun, 05 Jan 2020 17:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tc1NZnYVPS8eGKzhqigGBo/msJoPdsspl+hbIPJGjaE=;
        b=ERNPqWxqWjSbk38ja7XXNfIsMLjfeFR3skQ43achgRGZRI3thlsWKFbvf2ySjrERHQ
         k3vxK/B80tsB2/OWKU4GW56rF/x9D1g5mXh0XaKOEz9pjaydz7G2ue3Me6D4fKxGDSWg
         9l9OzFyNqzGHN7fGfQaTu33o1kJ5GhTNJFxk4vFyFQB+KYDFG+ZAdsvAANFGtqdU+7ex
         JTILV/ffJhlM36ElCkD5R4TfZPd28eWhGAIiyfcup4jW0OK/0bzLOSTIbBNGkxHSGkNN
         UsqQjG0LoUS5FzXmIwU+icE8mwQzZbui1Bu68Vp4YFSlUTMr+bz+zyVOds2F92sJfrBD
         ZA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tc1NZnYVPS8eGKzhqigGBo/msJoPdsspl+hbIPJGjaE=;
        b=OGX6rV7RAjRO5Bzsg32c3SxsYGL2URU/UJV5ijS7y9QJcdgGpI13iOZJva4eJ2YCrT
         CrAMW7x2EyPeOgbLSwEj7Qe7xj1BhzBdUFzdze1l8h9gsq5hrNXDOXzT6ugvqbLHwqZa
         m6zcPoW4ejbf9dtUk8K7lAXsQkJC+1pSqWnDyaygC9J9vpNve/L3GeShmd4/XWEKQDy7
         T589cMc0oANkgrTeboLtR1QHyYfWscLa3+gr2LL+ExEp6b8ZHg0b8ivyWyweInBTb++E
         VyjVD6L7y4ZK8hh7ShtrlA5NLBxsXz+wiLow9KCXknS2iROOQCObETtLrT5js1LezOkf
         /oeA==
X-Gm-Message-State: APjAAAUSQ/vT7S/sLKrSFWErB0pEOcefmEkd7XII8mesWS36CMMyIHkD
        FtwvkwIz/mK6tySulrCvIGw=
X-Google-Smtp-Source: APXvYqzYe34c41UYasOlO3Q71ehSfXf53xRSBQ2dulBdHYyvG1rnLXnOy+IYedOtnj/EkKxRWlM/Vw==
X-Received: by 2002:a2e:6c06:: with SMTP id h6mr56142370ljc.246.1578273452789;
        Sun, 05 Jan 2020 17:17:32 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y14sm28353271ljk.46.2020.01.05.17.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:17:32 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/13] dmaengine: tegra-apb: Remove MODULE_ALIAS
Date:   Mon,  6 Jan 2020 04:17:08 +0300
Message-Id: <20200106011708.7463-14-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106011708.7463-1-digetx@gmail.com>
References: <20200106011708.7463-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra APB DMA driver is an Open Firmware driver and thus it uses OF alias
naming scheme which overrides MODULE_ALIAS, meaning that MODULE_ALIAS does
nothing and could be removed safely.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 108307c428d1..7a6a7cb81e8a 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1630,7 +1630,6 @@ static struct platform_driver tegra_dmac_driver = {
 
 module_platform_driver(tegra_dmac_driver);
 
-MODULE_ALIAS("platform:tegra20-apbdma");
 MODULE_DESCRIPTION("NVIDIA Tegra APB DMA Controller driver");
 MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.24.0

