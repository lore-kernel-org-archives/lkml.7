Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC95C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BC6214DE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/3dl7go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfKRUFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:05:48 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42256 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfKRUFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:05:46 -0500
Received: by mail-lf1-f65.google.com with SMTP id z12so14867566lfj.9;
        Mon, 18 Nov 2019 12:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3yPaD5FrLV5EmLP9sdmGqZ7smshiHa//p8CMzoKpvD8=;
        b=H/3dl7go/Urixmr/tlsMWHcGE2OtjiTfeDb9AEUulMXvEtEjXHYhhi55bGclHkX+dV
         ITQcoKbcOVVsGYHNvhZ1i88/fcms9UKLFBp74Bc1IemELaCibP6KLJXKQm3cWt5539oL
         mgrSV2HQmNBlBItT0ydZrXwRvUbRSRv4E4scd9yKzkBOe2V49VY14gNNBzVztjrUu2iZ
         1HzrTwLZ/SpYMb5DZn7WzvMvWX0vp+JOlN64EqvhdWvW0VqCGJ2w2itXuW1BN0xZZyBC
         aFLXPsK65v7DUY67XcAofoyoi8cF900wIbEPtEZfCUBDAAO7Thra4hrE9YFKSFilQ00l
         MkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3yPaD5FrLV5EmLP9sdmGqZ7smshiHa//p8CMzoKpvD8=;
        b=Cj1qW7IViaEST95LkTkhQ9b9VHHfAtjb4Sunn+DPK5Zwn089ui8wM+Zyo9R4BcCWde
         3yiQRw/A9HJ/tLj2SQkoskXcQu+d6kZJ3wWzsWzpWYklyIFaTwfnL68mAWtZtXiuD/Tm
         /bfBLNAC0QFbZ3jrY9KBmddxDk053UGz0W9QrO63GdWF3NLuaAoEyIlOvrQtWMvyDufx
         m8elBeQkSQVz7dSNpqNsSqCmKOnVkFC0jy0MaXtmtyWGPwjjly5kWEOEmbTq1688YUm3
         vCPmjTQkqKfrbW02v8i2ZtYyJkkKNspFXGi6DRvD7fT8221ZX5afRtCIevZQlAF6bRE8
         69cQ==
X-Gm-Message-State: APjAAAX/dxj/yBg05alfDJV6Et8N7sgqx0whH+IoySbdCZiqMK8CVb95
        BjttvC3U+oJBeAm65QT2uJo=
X-Google-Smtp-Source: APXvYqyJHnyefn982bnopGrrZVszV336/yTbjQZ+2kB1eK02Gt2XTvr7NFIpbz7D2KtutG9rOwddtw==
X-Received: by 2002:a05:6512:1c3:: with SMTP id f3mr842838lfp.25.1574107543779;
        Mon, 18 Nov 2019 12:05:43 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:43 -0800 (PST)
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
Subject: [PATCH v1 13/29] memory: tegra: Register as interconnect provider
Date:   Mon, 18 Nov 2019 23:02:31 +0300
Message-Id: <20191118200247.3567-14-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory controller now provides memory clients with memory bandwidth using
interconnect API.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index ec8403557ed4..a4f7cc0bf9e7 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -699,6 +699,10 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		}
 	}
 
+	err = tegra_icc_mc_setup_interconnect(mc);
+	if (err)
+		dev_err(&pdev->dev, "failed to initialize ICC: %d\n", err);
+
 	return 0;
 }
 
-- 
2.23.0

