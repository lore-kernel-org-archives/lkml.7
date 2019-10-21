Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92164CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6960920882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qEsVLyo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfJUO3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:29:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51377 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbfJUO3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:29:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id q70so6405906wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xl8dby32+WRQvYjST6zEPeGq6+V7I2trjy7FQBP1swo=;
        b=qEsVLyo5NG4gK+9ZmATJ8Y72nvHsOzQW/2XXX8HNL5FxWQ8st+Y6iNew+jhz761Aov
         AxFlS+rK7VL2UPuhfT8sGgJ93LZRlMMrES0Yg38y2tCJKtDtdepO/Q4pkDDl7CUnkFMd
         J0tCDLlqfOk9N2PIYHsisU7W/g4Xq33numuOSiZ42WKTbs/aQ431RB03tXMXGT4oAwq6
         2kS9hIYWpnDZyEYYAbPG0GDvCiKAs8q7OLUC1QeE1kSnkMQ8AFHLHuJabqmXyK1HzohU
         Utds4GE7aucsrDlURY5boNivbcp6m5FJ/NmSOoucp6ULMVqaQ50Kzif73tl2lCUUORtY
         MyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xl8dby32+WRQvYjST6zEPeGq6+V7I2trjy7FQBP1swo=;
        b=R98TQQ43sWS5uip5NpQtubR8ovYXPrn9B+yL4V0mevrpuI/Y+iNTszx625T6Kkly/x
         93zt/4cGgaT8WfvNC/YK67/5kEnT0t3T5hC4wB8U7Nb9Nw0aKux8wPh2hxEZ4y/KNzF+
         sHO0OZejSnztPf+z/RqtQEUZHx6RuRwrnXG6UBev0aQPDLNMlFqDlOJ76/bvWgLITaZg
         7G62KSwdzgjZ3ZyOZOt1x78YHqOBEPZe6d2J3/Z6j2hn0KsUu3rrEYCbp6yZ8W5ayl6E
         coOHVxZlV5W3JSUcIixEgls9NrxJcxs1pMPBIOg6bQ7rORLPehdoKlRIHjXuMVTuIkDt
         dwjg==
X-Gm-Message-State: APjAAAU+ay28xnFCFLijqRQHOCMBV1wDH6fhhftyU9KgrUK29XEL69mC
        Mh7pkShCBQYdU0ybY09be9b/Mg==
X-Google-Smtp-Source: APXvYqx3WVElzku2QZ1szzxkfQy8cYhynmJ0ewftEjT+hqo8LlK3Xt1bRuLtHgfsKsTpIcl6iOakzQ==
X-Received: by 2002:a1c:39d7:: with SMTP id g206mr20289925wma.7.1571668149171;
        Mon, 21 Oct 2019 07:29:09 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d11sm17304463wrf.80.2019.10.21.07.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 07:29:08 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/5] arm64: dts: meson-g12b-odroid-n2: add missing amlogic,s922x compatible
Date:   Mon, 21 Oct 2019 16:29:02 +0200
Message-Id: <20191021142904.12401-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191021142904.12401-1-narmstrong@baylibre.com>
References: <20191021142904.12401-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-g12b-odroid-n2.dt.yaml: /: compatible: ['hardkernel,odroid-n2', 'amlogic,g12b'] is not valid under any of the given schemas

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 42f15405750c..0e54c1dc2842 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -12,7 +12,7 @@
 #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
 / {
-	compatible = "hardkernel,odroid-n2", "amlogic,g12b";
+	compatible = "hardkernel,odroid-n2", "amlogic,s922x", "amlogic,g12b";
 	model = "Hardkernel ODROID-N2";
 
 	aliases {
-- 
2.22.0

