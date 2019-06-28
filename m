Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6AAC5B578
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618C1214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q+tavAz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfF1TR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 15:17:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43249 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfF1TR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 15:17:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so3752405plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oXtkM4aHKOnTJKw67ITzOE7Djp+Tjx5ybqojMfIapIs=;
        b=Q+tavAz/9L9I5vppzzXPeRINDKgcw0V5Q3jq1RwfcZrcrozz1wy2w/ofYWTqa5ZOr+
         R8cHr0+UnGrRDfMng3Vl3oSLwMwJ+YT5uJhHyYm9JDgZTMZfbx1BDB7vzh+/2QjXwfFV
         Fi+Kf7Y7ibge7Kf1f3YBA7DXP5QtgsnHs4Kv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oXtkM4aHKOnTJKw67ITzOE7Djp+Tjx5ybqojMfIapIs=;
        b=Ephbid9tOcwyzyeyk6RZ2ZGZ7cX1CiH73qG0bcWPRvUguLRHT0+Wu/OUujj2y8EgK+
         sWTTUglwKOBSIzF6YgZ9hEB2xnMvCRQYB1mVOnQz82JB6oSYQNDBEwPpM28Rvf1h4EDe
         yMwRDT3jUYljYYGWoK9R9uGqb7ErTEu+rSGTOkqhSBx+OXdc7sCyHju/IgziXXfHsAKs
         czZLmbasxClYxcWuBT07nWN4LeyN5eNoCwGDcDaGHmCv64yOamEtrEr4OeWP8IdFS6I6
         BMrmxsFnDzmwRdnf1VdI7RdYRK4H9Nktuq0FDf3RntOy7EkNc6g571yJBRhmFPUeyoFI
         IsjA==
X-Gm-Message-State: APjAAAWxubhUAl8sTcP7wf1mOkveaAlYfSKn1qxYwe8KGNca2hFZbgFu
        mWwodtpU4O4gBp1KyAdYpKITlw==
X-Google-Smtp-Source: APXvYqwgWzRj23UKu4WIzEyRZGqaiSfkTgg8Zhzwecmd6S/kgsA4Sz/QqX4OwWg33aT5uidjZ+S4qA==
X-Received: by 2002:a17:902:165:: with SMTP id 92mr13744206plb.197.1561749445559;
        Fri, 28 Jun 2019 12:17:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 64sm4328756pfe.128.2019.06.28.12.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 12:17:25 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 2/4] iio: cros_ec_accel_legacy: Fix incorrect channel setting
Date:   Fri, 28 Jun 2019 12:17:09 -0700
Message-Id: <20190628191711.23584-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190628191711.23584-1-gwendal@chromium.org>
References: <20190628191711.23584-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INFO_SCALE is set both for each channel and all channels.
iio is using all channel setting, so the error was not user visible.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/accel/cros_ec_accel_legacy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 46bb2e421bb9..ad19d9c716f4 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -319,7 +319,6 @@ static const struct iio_chan_spec_ext_info cros_ec_accel_legacy_ext_info[] = {
 		.modified = 1,					        \
 		.info_mask_separate =					\
 			BIT(IIO_CHAN_INFO_RAW) |			\
-			BIT(IIO_CHAN_INFO_SCALE) |			\
 			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
 		.ext_info = cros_ec_accel_legacy_ext_info,		\
-- 
2.22.0.410.gd8fdbe21b5-goog

