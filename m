Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B87C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E89120720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KZ2Fr1SI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgAHFYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 00:24:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34134 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgAHFYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 00:24:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id x17so642638pln.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 21:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GZPi5S7C9JBOvDvG9rs8XlkVI4VOHpLwCsMiOaYI8o4=;
        b=KZ2Fr1SIWZOlOI/MInwohmz1Hb6Xx7Tq+QTxkCat51I7DcfFdbynSqAxDlo/ZrmAzy
         bzYx04hvPnPCCny7HlSE8qtcQ54XXy3skRRoKWw/srh/+NPKZBDJmkfK0r32EhMKP8As
         Ki1O01CCcGhKnBDTGVZ2lIeuDq9nZ6XwreZMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GZPi5S7C9JBOvDvG9rs8XlkVI4VOHpLwCsMiOaYI8o4=;
        b=ttWuzfrOS/zkZy3DtiYcpL6tvKVsFFYivV5G2+AsbQsRiDxLfOjAXI6xxlEATyM/oP
         tu1JhLctVt7XhhcPnumcVTkAKx972HxfD1svGF88bRkn/s67kKxDxDStGQMBk0DRti4F
         MUs/OjtO2izeVSJV+51xhBEHMipcG4vyAbci+qWEFip+VrmPaIgthS8G7bW3L/jBgOoq
         F66MdviK2Awqfq3D4WVW0od8e9UrDXDTYMuobgz14PZhpqzl0hrs3u1M4J7jbg9Smifk
         T461oRiOiBrnWrYNoEVh3dTQMD8la8TcGsCyI2pjN9RsfPW8tn5/+8j5MNdZu6JXtcez
         jVlw==
X-Gm-Message-State: APjAAAW8h+dsPfXFhrNl05UHXjncXJ1jASM356jN5tXcEYA35jxg1RHq
        3DsuZf5DZySgkkc0egi4UXyLGg==
X-Google-Smtp-Source: APXvYqyXscgEKtXSz2fpP6ePSqF6Ze4O7OI5VBeA+RFqRdvOMivOeOELOfMM09JM7WNsSJ6itelcsA==
X-Received: by 2002:a17:90a:d789:: with SMTP id z9mr2508178pju.5.1578461047043;
        Tue, 07 Jan 2020 21:24:07 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id n24sm387505pff.12.2020.01.07.21.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 21:24:06 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org
Subject: [PATCH v2 4/7] drm/panfrost: Add support for a second regulator for the GPU
Date:   Wed,  8 Jan 2020 13:23:34 +0800
Message-Id: <20200108052337.65916-5-drinkcat@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200108052337.65916-1-drinkcat@chromium.org>
References: <20200108052337.65916-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some GPUs, namely, the bifrost/g72 part on MT8183, have a second
regulator for their SRAM, let's add support for that.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_device.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 238fb6d54df4732..a0b0a6fef8b4e63 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -102,12 +102,33 @@ static int panfrost_regulator_init(struct panfrost_device *pfdev)
 		return ret;
 	}
 
+	pfdev->regulator_sram = devm_regulator_get_optional(pfdev->dev, "sram");
+	if (IS_ERR(pfdev->regulator_sram)) {
+		ret = PTR_ERR(pfdev->regulator_sram);
+		dev_err(pfdev->dev, "failed to get SRAM regulator: %d\n", ret);
+		goto err;
+	}
+
+	if (pfdev->regulator_sram) {
+		ret = regulator_enable(pfdev->regulator_sram);
+		if (ret < 0) {
+			dev_err(pfdev->dev,
+				"failed to enable SRAM regulator: %d\n", ret);
+			goto err;
+		}
+	}
+
 	return 0;
+
+err:
+	regulator_disable(pfdev->regulator);
+	return ret;
 }
 
 static void panfrost_regulator_fini(struct panfrost_device *pfdev)
 {
 	regulator_disable(pfdev->regulator);
+	regulator_disable(pfdev->regulator_sram);
 }
 
 int panfrost_device_init(struct panfrost_device *pfdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 06713811b92cdf7..a124334d69e7e93 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -60,6 +60,7 @@ struct panfrost_device {
 	struct clk *clock;
 	struct clk *bus_clock;
 	struct regulator *regulator;
+	struct regulator *regulator_sram;
 	struct reset_control *rstc;
 
 	struct panfrost_features features;
-- 
2.24.1.735.g03f4e72817-goog

