Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C43AC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C8B20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qDUoEL4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfFGOgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:36:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37295 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbfFGOg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:36:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so2414118wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yzwm61NtsfJloRnjhHQ2pNy1sZapkxopjI5To5eokmA=;
        b=qDUoEL4nRKcZI9y3p+jeTm2EjoiCbh1HvlpSlAj+IWDyZ4jApgStI06rtjMzCCOk1h
         u17Q2R17nmbM88NuygYNrO3A0K1pI3TAQvYjlW7IIkMe+F6UDceLSxFdYBtQ+LFvKDEH
         DywDQKTFecmG4RW+ye25f/K0iyhHl48RLrshTmtc9tUJFFNr6t0Gdbq0utFObzMkt3EW
         kjyTUVUJj3T4bgdXBwxtxQvGXV59W98rjC6nslvvwLmrp0XG/XBn3/2Tg6G/05DCvcJd
         2cDLTuZWMoGfQNVvM8/6FuT0bSrVt5hicV4yEuTFr4ob92b9nzCPg9cXNxOXJnJYhNdu
         VGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yzwm61NtsfJloRnjhHQ2pNy1sZapkxopjI5To5eokmA=;
        b=j9QTL3f2kJ1ITRweewj5minIxE+v+14BB1EsTorJv0Pao3E/HuajY8meBm9c5xZ4vg
         N8DoY+KMb5Aa9joVWfltgmxU2gl5Cpu+z0b1susOxIThdPJyv6QmRL4YIfefY4hO+KsG
         0dNg+YEwpfdl+vn6D1jLK8LFDbTw+86XgeRJrK9qQL7stLbonoRSfP5a0Fg08R2gzQCO
         fwYTg0u6oN0L+Tx5s+UNCHsfKohgz4oNgDnUKzyHBowjhWMJqVXcC5B1w0/wQCJ4vOBM
         WwgqOO4A5SRUU/B8FZNaOcg/IxHf/+f3z/8nurSEms4T+tPHwfYecBX+oXQ3tdLhp1qK
         3DiA==
X-Gm-Message-State: APjAAAWYFKZ6gZXrFTv59pr+dCxsMBhs32g1mFnJNVaYGGyGQSFe5dWJ
        9C7h/wWbjjUngnhGTdCJtA6ZMn0Jm/AVkA==
X-Google-Smtp-Source: APXvYqyLiq7oGwG34/LuS+puV3t82LEW50K75nVMrI2JjH6TznYgTa/uwUU9L0+Y4gM07PfkYTktsA==
X-Received: by 2002:adf:dc09:: with SMTP id t9mr34361430wri.69.1559918185693;
        Fri, 07 Jun 2019 07:36:25 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t63sm2999829wmt.6.2019.06.07.07.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Jun 2019 07:36:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/4] arm64: dts: meson-g12a-sei510: bump bluetooth bus speed to 2Mbaud/s
Date:   Fri,  7 Jun 2019 16:36:17 +0200
Message-Id: <20190607143618.32213-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607143618.32213-1-narmstrong@baylibre.com>
References: <20190607143618.32213-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting to 2Mbaud/s is the nominal bus speed for common usages.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 3e0e119c13ce..4fc30131e5e7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -530,6 +530,7 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
 		clocks = <&wifi32k>;
 		clock-names = "lpo";
 		vbat-supply = <&vddao_3v3>;
-- 
2.21.0

