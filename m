Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC34C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E242A2341B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QrSrtGf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfH3HSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:18:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46234 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfH3HRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:17:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so4523130wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 00:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/2VDCi/8Nc6XhM54Nc0WK1H6m9eTFCgJrShafTKplS8=;
        b=QrSrtGf9FjbrWkItYR3Mc4CqOLVCYT1FVWbRgCBg2Pu/Fdf7C/4W6eYHgzOrrBrWbq
         JHcZW2ZIjjrgIMQnvF7oziVkdb5dPpo+6eWCQ5nhUyt1Z9tP+vFcNiObTEgtx/nnWCJl
         7iD8LMqU3plCtQh2fTh2ZZFznTJef7MGmH//2p0s3OE4tADTPh08wkNf1xINmnxfzwhs
         ECTsBbUZW40ejM+T1jUx+/elyxT9b9iZnRpX3tYsx10etXTY/QLw2SW002oG3aNRq7F+
         YvYG/vUCfOfN5mPEFl9doHPOtPUb8oeaEAJp0Q32nCKYuWSi+4Vl9qItEHDWCe18BsIe
         Ox7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/2VDCi/8Nc6XhM54Nc0WK1H6m9eTFCgJrShafTKplS8=;
        b=Tz8JGH/yRvvziyoGIIE512KH7otVcklLcHTF8RCGm3lkyVXgyrDgd8J8fC+0zVQ3Ch
         o1VM/suE/cnZTOTzpjpNCdahy/4JNbziWj6c1vUsvPL8CEROTFlA15VowQFEANc50gP3
         NbZguSA0lDhrpPzDVDaOGd0hRW5cXIXESWC6YLuAkW2jutZ/kriurTVaiIKRwibHy99j
         JjebpWiRz1MivaSDLU2yq+I3S/kp7ZeJGIrx4k7R4hEP3dh89h+grtRTe09G1IBin5yA
         da67hrl0xLb1/U/fw/nBfU7XlNKiRHa946qGZ/rajPw35Mhfce5BIfTZ0ad15oiAsOEq
         mBgA==
X-Gm-Message-State: APjAAAUNX56EmkPCuVygB4hu/6S1LanPyJ+E4YoRZj4FEoD8Qbt+zueL
        9LilbbkhZHaFwNWc7dytmjo64w==
X-Google-Smtp-Source: APXvYqxQ+fhzAN12dqj8HcI+oZPcaqT6YamoO9mQejjXIJ1ON3y2eTjRph0jPHsEoE+jZMTi9k9wbg==
X-Received: by 2002:adf:f0ce:: with SMTP id x14mr16642888wro.31.1567149473261;
        Fri, 30 Aug 2019 00:17:53 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x6sm7637529wrt.63.2019.08.30.00.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 00:17:52 -0700 (PDT)
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
Subject: [PATCH 3/4] phy: tegra: use regulator_bulk_set_supply_names()
Date:   Fri, 30 Aug 2019 09:17:39 +0200
Message-Id: <20190830071740.4267-4-brgl@bgdev.pl>
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
 drivers/phy/tegra/xusb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 2ea8497af82a..faf1137d1432 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -862,7 +862,6 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 	struct tegra_xusb_padctl *padctl;
 	const struct of_device_id *match;
 	struct resource *res;
-	unsigned int i;
 	int err;
 
 	/* for backwards compatibility with old device trees */
@@ -907,8 +906,9 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 		goto remove;
 	}
 
-	for (i = 0; i < padctl->soc->num_supplies; i++)
-		padctl->supplies[i].supply = padctl->soc->supply_names[i];
+	regulator_bulk_set_supply_names(padctl->supplies,
+					padctl->soc->supply_names,
+					padctl->soc->num_supplies);
 
 	err = devm_regulator_bulk_get(&pdev->dev, padctl->soc->num_supplies,
 				      padctl->supplies);
-- 
2.21.0

