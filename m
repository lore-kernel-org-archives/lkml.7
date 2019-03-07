Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA9AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CA72083D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UxkAYps1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfCGOB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:01:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40945 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfCGOBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:01:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id y6so2406243wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 06:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bF9AZzlBu8fUtOoQqmikOZMaNtULZj7Mnfny5E9VbB4=;
        b=UxkAYps1T8dKVh4A5qYQ9F+WrOtMCzWwldBcVXUB4df7LukXZBcj8i1w4RbdYsJN1+
         rCNjoSCtg1WPyMA86vIuAKu0oUC7rOM2iDfIcov7EH98jFGMDfQ0nh8GClyfYpeL1tOd
         2t4Pszo0rQIzRkgnJiec9GTwnXhNqRP1s9J2yuO6emOGWmBfslgBIFjkJeTc5zFB33y1
         JYwLS2UH3LkTd8o+oZHPAui8Cy7HfUOXMJMc0jSX1AxvSrDh8aJH1h/YokX4sWJjEE69
         R3rqYP6QuWHbjHcbK6NnRkqmH7EY5Au0KmSl9vJzJx0rSCO5wWEFY5+mKHhmFiMGBZ0j
         E+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bF9AZzlBu8fUtOoQqmikOZMaNtULZj7Mnfny5E9VbB4=;
        b=XZTDRE4RV6lRYYa1RIAXdv4S2B/CXhEPFl/FM7oSaFBnvxSEF0Fxlso1DTy7CQsL08
         3+BQYLXJl7MvYbt8BWFnbYtdm7OhXSXkyQa1T9vbZHLvYJcyL4wn73t4GOM8Ba92J5zd
         +Repd7+QrsQ/HlV2+FPcHgnre4+DNcm2gQ2SlnDNwEImpPH2kGaxNfF3YHVNMjTrozD9
         8N5/JfZGsg888Hzjf+iXrEPgoRnOwcQEkei+QgbOEyOTjaz7oUiQXFzUDSVZxhMjpQQZ
         Q6DGnTzS1wLM+aG3Z1cVmwhVBWoURdohvRGzlAltbsnSj2AcKsByko6qFq4LQ/WTWDEV
         fpgA==
X-Gm-Message-State: APjAAAXutOQrISA9278rV4IENM1TJzRtymErlNY7f5Xvartsckxx72AN
        +ejG5XEQ8jyb6QEW6U0RVBizMQ==
X-Google-Smtp-Source: APXvYqwhG1xRFbVRSgMiSCarrZZx2xIhmA4EvlY/SwsSDDj0FlXOpI+HLNZNwCrRhTyBAbQtHIUbFw==
X-Received: by 2002:a5d:668e:: with SMTP id l14mr6931120wru.198.1551967313024;
        Thu, 07 Mar 2019 06:01:53 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h137sm9892098wmg.41.2019.03.07.06.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 06:01:52 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] soc: amlogic: gx-socinfo: Add new SoC IDs and Packages IDs
Date:   Thu,  7 Mar 2019 15:01:46 +0100
Message-Id: <20190307140147.22047-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307140147.22047-1-narmstrong@baylibre.com>
References: <20190307140147.22047-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the:
- G12A SoC ID and S905X2, S905D2 package IDs, found booting the
  X96 Max and U200 Reference Board
- G12B SoC ID and S922X package ID, found booting the Odroid-N2
- S805X, S805Y package IDs found in the vendor U-Boot source

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 1ae339f5eadb..c8d138d85f34 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -37,6 +37,8 @@ static const struct meson_gx_soc_id {
 	{ "AXG", 0x25 },
 	{ "GXLX", 0x26 },
 	{ "TXHD", 0x27 },
+	{ "G12A", 0x28 },
+	{ "G12B", 0x29 },
 };
 
 static const struct meson_gx_package_id {
@@ -53,11 +55,16 @@ static const struct meson_gx_package_id {
 	{ "S905W", 0x21, 0xa0, 0xf0 },
 	{ "S905L", 0x21, 0xc0, 0xf0 },
 	{ "S905M2", 0x21, 0xe0, 0xf0 },
+	{ "S805X", 0x21, 0x30, 0xf0 },
+	{ "S805Y", 0x21, 0xb0, 0xf0 },
 	{ "S912", 0x22, 0, 0x0 }, /* Only S912 is known for GXM */
 	{ "962X", 0x24, 0x10, 0xf0 },
 	{ "962E", 0x24, 0x20, 0xf0 },
 	{ "A113X", 0x25, 0x37, 0xff },
 	{ "A113D", 0x25, 0x22, 0xff },
+	{ "S905D2", 0x28, 0x10, 0xf0 },
+	{ "S905X2", 0x28, 0x40, 0xf0 },
+	{ "S922X", 0x29, 0x40, 0xf0 },
 };
 
 static inline unsigned int socinfo_to_major(u32 socinfo)
-- 
2.20.1

