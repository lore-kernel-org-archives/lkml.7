Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABECC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C924233FF
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LW+l31M7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfHUOVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:21:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47046 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbfHUOVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:21:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so2203901wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQsGf588I1IgMOXLjRz6MRHB0is1fYO095Je1lOaf9Y=;
        b=LW+l31M7FYVrlVwO4RtbdI+BnGwktSNVaamz/eKR9z2coAS6bqpoHr7rYFARFwL/Mf
         wFS+8u5TbHS+uymjwyKr8N7iigDZZ1ozV+ejoR64Swjea3vVo7scAMHxCPNpRxceGda6
         gyhdNWu6/YkBf9aZanJc2zX0dVp8k1c5+HOmX8xAPUZnhNoNP5HynafpwJZIg/7CmuVH
         LX9eiKWCNQEjwnZdEuS67XXXjgFb5FWlD8ox3xPvQ7sNONGGpAoCMd4wJi9W6iw8XhPL
         vQ/v4M7hMFRYbErQj1V5+zwmzriuBQbDfLvOxAIIJ1yyyfMaH0c1jQkQQIiZQhNhnEPN
         Al6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQsGf588I1IgMOXLjRz6MRHB0is1fYO095Je1lOaf9Y=;
        b=nAUnyoyTZUQKHtdTKhH6/Qs+FCeMMSQE5ZbDmlvjNH7rHlzN3JtDV/e36K7LXHRycK
         DDF+SNjoDbzIWVsVa6g71AIdAashFwF2b6DVpFopHBCLnarD85pb5A47DMh7ZhYfkctT
         LMpOKjo3GwHYiaMdAgl8ThWMQNf/2/dHNohUkgmk6GIv6F5UPK8QXJlrPvt62mUuwFjV
         fQIB+m+DL9Pi/yqZWkZpPdiNR8p7wa430b8NqHebcCfGcIGRevTiY4QDL+4ARYAKnKUV
         0smi+0ijqTH0IT6j0KtxoCoS5qNj7YDnyt2U5zcmKHWiKrCoTAUeufZkU+IAHODWRwvP
         GWsA==
X-Gm-Message-State: APjAAAUsOrwTE0QDwvXu3EmomoTwT2jgGglJYc1hfe/DFT5vKyVe4ccA
        OLo2Uz2RgNbwRsRYC0ChCne1tw==
X-Google-Smtp-Source: APXvYqy4npEQ++FBKKaWkKfxAcsByGUwBT/oVwhFh+ggmmOVv7yM6S/NZYUKqkvoXC8FkpwIs2j2Pw==
X-Received: by 2002:a5d:4e06:: with SMTP id p6mr42380673wrt.336.1566397264901;
        Wed, 21 Aug 2019 07:21:04 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o9sm33418939wrm.88.2019.08.21.07.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:21:04 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 11/14] arm64: dts: meson-g12a-x96-max: fix compatible
Date:   Wed, 21 Aug 2019 16:20:40 +0200
Message-Id: <20190821142043.14649-12-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821142043.14649-1-narmstrong@baylibre.com>
References: <20190821142043.14649-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-g12a-x96-max.dt.yaml: /: compatible: ['amediatech,x96-max', 'amlogic,u200', 'amlogic,g12a'] is not valid under any of the given schemas

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index fe4013cca876..acb931cf3e7c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -11,7 +11,7 @@
 #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
 / {
-	compatible = "amediatech,x96-max", "amlogic,u200", "amlogic,g12a";
+	compatible = "amediatech,x96-max", "amlogic,g12a";
 	model = "Shenzhen Amediatech Technology Co., Ltd X96 Max";
 
 	aliases {
-- 
2.22.0

