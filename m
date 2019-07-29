Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B6AC7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9B7206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VlPXaYyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387947AbfG2NCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:02:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56073 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbfG2NCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:02:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so53775962wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EvlHbCW1OevHbW9Yaby9CFqayEK2s/Y2m4Jve2BO5WQ=;
        b=VlPXaYyPE4XBjSsfVxe3EjW4kowH8F7+G6YW+blqO2MW2TSUgeQr0Zuos0Ma6FWy/Q
         5jcd3ND8KK+L+x0oslsy145/BK7NM9ViNdZo/8QCWFQprAkPDSwl2KYfBBp6HiI2qZE2
         rdQyfzIZwe0u/l9+AyZKwG+LVikNAaoJwCMevQEkp+n1IpRQXYiF2NnpIB2iXNBQZ6KF
         94G4LF7tuhl/TLiFfMZ9THMM5mSQLg+tdfLsLD0x1JagkBkV2Q9sc7UV4TzvAvJyZDgf
         k8pu5zAAvVwvgZi7bvs7ogdjx7dL6M3AZ42kEuUVUXwcGX03X4tQAA/PN7iXN/iAcahm
         iOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EvlHbCW1OevHbW9Yaby9CFqayEK2s/Y2m4Jve2BO5WQ=;
        b=mVwkt5pRMdYsUE5CJ0m0vu15yoM2ploaq08e8f4aJYsktQJK/9SmHqJHNOYah5OnwV
         AmS7W81jCdY3pnDX0z/IAPhHXuBXu8BVmc/O/bPOdl1UhuVPZuDFkSqKoYjf4zH81RGl
         H9WE40gi/FF/1U388N3H+idesLe26J3X1t9SfWOueFAnO+BtzCb7oIQ1/XIzkCY3iqXF
         JfBH3WFV4VnlzlVdmnUWKnPVtN1ldiyhCbyQNvuRDjwYVdsKe9hv40uepLLvVfV8HoZF
         SfrdCOcSCnyQnDuM+gBX0tbLyGFUR7N+VwjGQReeAqEfkrG2YbXYBACv4h05+0nQNNAL
         uvLA==
X-Gm-Message-State: APjAAAVGyWKCNzlY8TALCQWVTgGtfsPIliwU1PzzTlJB0MZbPVjPTTUf
        mJsVagtJTxyKZtXLPC5jZ6sLMhvqiis=
X-Google-Smtp-Source: APXvYqwQo1q5iaW3jvl4f3ZJ8VQMUpxNO5ykvWK67eymaccK4cp71AzuQkWF8mYx0Mt+HvpBngFHmw==
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr104511842wmj.31.1564405343272;
        Mon, 29 Jul 2019 06:02:23 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x185sm52990545wmg.46.2019.07.29.06.02.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 06:02:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] soc: amlogic: meson-clk-measure: protect measure with a mutex
Date:   Mon, 29 Jul 2019 15:02:17 +0200
Message-Id: <20190729130218.6635-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729130218.6635-1-narmstrong@baylibre.com>
References: <20190729130218.6635-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to protect clock measuring when multiple process asks for
a measure, protect the main measure function with mutexes.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-clk-measure.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
index 19d4cbc93a17..c470e24f1dfa 100644
--- a/drivers/soc/amlogic/meson-clk-measure.c
+++ b/drivers/soc/amlogic/meson-clk-measure.c
@@ -11,6 +11,8 @@
 #include <linux/debugfs.h>
 #include <linux/regmap.h>
 
+static DEFINE_MUTEX(measure_lock);
+
 #define MSR_CLK_DUTY		0x0
 #define MSR_CLK_REG0		0x4
 #define MSR_CLK_REG1		0x8
@@ -360,6 +362,10 @@ static int meson_measure_id(struct meson_msr_id *clk_msr_id,
 	unsigned int val;
 	int ret;
 
+	ret = mutex_lock_interruptible(&measure_lock);
+	if (ret)
+		return ret;
+
 	regmap_write(priv->regmap, MSR_CLK_REG0, 0);
 
 	/* Set measurement duration */
@@ -377,8 +383,10 @@ static int meson_measure_id(struct meson_msr_id *clk_msr_id,
 
 	ret = regmap_read_poll_timeout(priv->regmap, MSR_CLK_REG0,
 				       val, !(val & MSR_BUSY), 10, 10000);
-	if (ret)
+	if (ret) {
+		mutex_unlock(&measure_lock);
 		return ret;
+	}
 
 	/* Disable */
 	regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_ENABLE, 0);
@@ -386,6 +394,8 @@ static int meson_measure_id(struct meson_msr_id *clk_msr_id,
 	/* Get the value in multiple of gate time counts */
 	regmap_read(priv->regmap, MSR_CLK_REG2, &val);
 
+	mutex_unlock(&measure_lock);
+
 	if (val >= MSR_VAL_MASK)
 		return -EINVAL;
 
-- 
2.22.0

