Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B39C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861C120720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QLx9yX4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgAHFYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 00:24:19 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39447 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgAHFYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 00:24:13 -0500
Received: by mail-pj1-f66.google.com with SMTP id t101so559921pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 21:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UOwyKJvK30gkDautsCvwyHXlhtr89ohJP+HqIMRnEEY=;
        b=QLx9yX4oKgUhsf9zqBiMKi9PC3cJUGptpG/rsIeA0xAbFDz3AFhMYQndfD4e5TiiA5
         wduA+xP76VAH3pTE/Y7N2zNP97+RQWMddxzeUn/Nf0v4LIAyD01x4QhbaispCA389giy
         7q8R+qc9ynzewq3J8aV43Z09BdUAkc5nDf8Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UOwyKJvK30gkDautsCvwyHXlhtr89ohJP+HqIMRnEEY=;
        b=GQqQQa5bUBlnvd6l3/BMzL/RmrFpFgTInTjf8dOj9VRuXUb+4a5nV1MPvbRPrLjUgV
         9H29zI9cWE1H83PATy28CjWNW+Tdc9pGIy+C8rMS6giT14DLoZU7H7gx6dWvtpUUr9bY
         Pnr6D5FtioI/jBc9CmR9IDs3J8KS3F+6XidyHNk5l/xc0x7PwWQnYyBttUCRBHtTUxNa
         Sd6tXtmtUwVD36J9WPgKj169Man7wMmv9DrCbEI3DZcahSlFCujdfv7b9XAd8wjKBFf4
         iLM4BytkJaN2sPIJIOw5uqDypy1QOh9ocDYv6fXRoETE2EhBPFY5WZzjKnA3SK42OEqb
         QS6A==
X-Gm-Message-State: APjAAAUjZkSiHOVn7aKDwWjaMAtLGefqzOfEVixmN6GvKh44PkFP8VYL
        Ijum3rJEns9eLzkbemaKD8XPAQ==
X-Google-Smtp-Source: APXvYqyP94Ucu5iILCPq19i7mowizjkSB4O/xb8qsx3dYRf/q3ysQY9apimu4OZEq+YRXwTIHiTnjQ==
X-Received: by 2002:a17:902:265:: with SMTP id 92mr3326908plc.188.1578461052777;
        Tue, 07 Jan 2020 21:24:12 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id n24sm387505pff.12.2020.01.07.21.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 21:24:12 -0800 (PST)
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
Subject: [PATCH v2 6/7, RFC] drm/panfrost: Add bifrost compatible string
Date:   Wed,  8 Jan 2020 13:23:36 +0800
Message-Id: <20200108052337.65916-7-drinkcat@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200108052337.65916-1-drinkcat@chromium.org>
References: <20200108052337.65916-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For testing only, the driver doesn't really work yet, AFAICT.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 48e3c4165247cea..f3a4d77266ba961 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -591,6 +591,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "arm,mali-t830" },
 	{ .compatible = "arm,mali-t860" },
 	{ .compatible = "arm,mali-t880" },
+	{ .compatible = "arm,mali-bifrost" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.24.1.735.g03f4e72817-goog

