Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4263C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E7A208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jVWJmx+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfHNOaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:30:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46947 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfHNO3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:29:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so111309133wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VoiyEoznGsebSQriKSg2X1Svm8xxDWhM6W5MAaVlZfM=;
        b=jVWJmx+y2kT3aUx0SBHcmJEyZLxN5wNHbfobgwLdEmu9GOF4E2zVIvj0kNud4Neakn
         r4R7ia+Bd2OZkcCwGHL65pU7hUFJMgtqCT21SoS9wIonU1OYjghZkmWIp5LG5UhnMjy4
         aphvTnLzuIjuzgZkMGHtcxjPODJxi/uVgkDuL4qTTHSM3AJQNhJDfW5eg8PDwNzLZL9H
         xf5ShTMpRmYZO5y6lcdNjn8FjLI6BmNp43rDtnu5kmKrPZecoVStxfTI/C11YJp28bwu
         wA6ZVmC4j8wJpBEpOOSTyYBEZb8STMFtzKYUHat6zc+01hNQb8bmQnOqU3xvByzrtftX
         PUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VoiyEoznGsebSQriKSg2X1Svm8xxDWhM6W5MAaVlZfM=;
        b=iB2f+dSaB2Hludty4VorlT7Td/DvtHuDYgLafaBGPPhmgMrlT0aeWdx4Y6cTqS2mjP
         M9Z4345ETI7uV3UaYwFDnxahwT9gC04+w5b05GrvDVLkM0MuQTJ9QXK+bT1d+vEvvHBd
         ugaDPbVC1J+Kj5goaiwxcsXJJ6Ik1Ge0z51ssxSefXfR4DrcdzJxR6vAqtGID/WGqLWc
         2Z5ZSNG0hu3Gnu+9SWF9R1+7ti124y7it5n+YE+HervWa1eb51XVdXyt5o2Oc5lfxZe/
         8A1dpjSldvXiJ3c21c9AkoO2+BR0P9CkwNFyByByW4r48DNWdHTgl4Uw5VzUwpAZcuJt
         gBnQ==
X-Gm-Message-State: APjAAAX12cvtLYp/4PGJFpNjl5zW4oDFO8g6w7kY4CEeS+WnS374Omgw
        azc+D1OxzHZI3moJr5jfYEWMBA==
X-Google-Smtp-Source: APXvYqzxlOMYI2lLiopD9DUTgVJHaln/oI01siPstd8Ym3P4VYWq9U2IwostDoeJEXuI843drXHC1Q==
X-Received: by 2002:adf:a2cd:: with SMTP id t13mr33117115wra.251.1565792971007;
        Wed, 14 Aug 2019 07:29:31 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o7sm4202908wmc.36.2019.08.14.07.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 07:29:30 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 08/14] arm64: dts: meson-gxl: fix internal phy compatible
Date:   Wed, 14 Aug 2019 16:29:12 +0200
Message-Id: <20190814142918.11636-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814142918.11636-1-narmstrong@baylibre.com>
References: <20190814142918.11636-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-gxl-s805x-libretech-ac.dt.yaml: ethernet-phy@8: compatible: ['ethernet-phy-id0181.4400', 'ethernet-phy-ieee802.3-c22'] is not valid under any of the given schemas

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index ee1ecdbcc958..43eb158bee24 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -709,7 +709,7 @@
 			#size-cells = <0>;
 
 			internal_phy: ethernet-phy@8 {
-				compatible = "ethernet-phy-id0181.4400", "ethernet-phy-ieee802.3-c22";
+				compatible = "ethernet-phy-id0181.4400";
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <8>;
 				max-speed = <100>;
-- 
2.22.0

