Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FC7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEBB22DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AQsuMZUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfHTOk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:40:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40439 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729838AbfHTOk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:40:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so2872777wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qk9x+0yCuWahWTJ+d7U2hM8TpGj03opy/Zg7wU4wyWE=;
        b=AQsuMZUZoJCGFnG8pBMu4BcPk/gvh3HXAsjo9HRD48NR6bVp/F6ie64bEd7teqsYWr
         maNMIeLQrv2cWwsZlkYlDyAIaM6swmLWJgiQUP0iF1dyBIrG1nUK3Xrs1T8IdrwSXAzX
         LyTMYd9DViD/+sCR2xdwOFzG2fiPqtyl5Ix3NOcCwzoUFWkLr1lWxKPNCZi+phCqmNd0
         MErT/kb044CgXKa2Q3QiJIvhYPnEsYigSYjVB8wkZNGX/GAkG0NIq/TEtFmg4LwZJysR
         VoxQ7XZww3rPdkk7wdO9fwJBqyiocwsJwhn+YvwX867bN0/f3hq8m9uNNeIUkiNvWGvl
         nfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qk9x+0yCuWahWTJ+d7U2hM8TpGj03opy/Zg7wU4wyWE=;
        b=RfeoVKlZ94GrC7oJulrYRQsvtxVO0Vd+mg5873lgwaBxRgsu7+UsxjSuAZs0z+SueF
         xCXkVdclDFJPx2nrmr0/DPmz6v36qJRyIPCuhdtGSG0eieQQRRlD+wVYhRZRekEavGy+
         esGiNuX6bnHXeLuBVDoE4MqahRbAIcsB/JaqKpSrgYaoqRF9+eFVfvPXaOFuhTeXNKGK
         O7UEX6d+ENeBy5pOl/T2ezbfHm1XdMhO7OOWjSGmTOPs9NWi68ziJO4gUtmlOIaDOX08
         Qd7R8v9j2x3flCavAMcfh10PrKOb2/FzYOjDoJAhlUTgamXkqZiW6tEiqMVhDNtQS27X
         Yvtw==
X-Gm-Message-State: APjAAAWwqJ+aBAcRd0ktjdpeKcvCNlrTfnYvX3DCNL0D5i0k9oi0Q2E6
        QFwsaMC64X5Tc0x99e3i9CYypA==
X-Google-Smtp-Source: APXvYqyATvzMqlJgk0npoKT6MYofXdZjDlqt0Tu0cvJTJxNhlNG0pp+89Pj2oysiKwBtg3gUHQCl6Q==
X-Received: by 2002:a1c:eb0a:: with SMTP id j10mr337735wmh.125.1566312055993;
        Tue, 20 Aug 2019 07:40:55 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a18sm21826750wrt.18.2019.08.20.07.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 07:40:55 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 1/6] soc: amlogic: meson-gx-socinfo: Add SM1 and S905X3 IDs
Date:   Tue, 20 Aug 2019 16:40:47 +0200
Message-Id: <20190820144052.18269-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820144052.18269-1-narmstrong@baylibre.com>
References: <20190820144052.18269-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SoC IDs for the S905X3 Amlogic SM1 SoC.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index ff86a75939e8..b9f4c6f4fd03 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -39,6 +39,7 @@ static const struct meson_gx_soc_id {
 	{ "TXHD", 0x27 },
 	{ "G12A", 0x28 },
 	{ "G12B", 0x29 },
+	{ "SM1", 0x2b },
 };
 
 static const struct meson_gx_package_id {
@@ -66,6 +67,7 @@ static const struct meson_gx_package_id {
 	{ "S905X2", 0x28, 0x40, 0xf0 },
 	{ "S922X", 0x29, 0x40, 0xf0 },
 	{ "A311D", 0x29, 0x10, 0xf0 },
+	{ "S905X3", 0x2b, 0x5, 0xf },
 };
 
 static inline unsigned int socinfo_to_major(u32 socinfo)
-- 
2.22.0

