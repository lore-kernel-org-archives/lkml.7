Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54FEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFE522D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NvbbDwY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfHUOVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:21:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39557 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbfHUOVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:21:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so2231458wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OqX/ImXXX8Z4O+Ei2v1LhFkdAdb41P31AwRDJO9BdNk=;
        b=NvbbDwY1XDtyyzi2gbpW/zIgiFRA8TOFuNpW8JxN6ROQkrtih4k1zPD/F16/u2KfPv
         u1xIP8Nk+l4jQtYtZwvelSBTpp3nVXsKDJtyYrrFlV18FwqFoWbgk7a0s5wwinOuUGhc
         rMfhLIxyQDNZ1q75qEwg5dPLmfswO1+YDrx/1YheLRPhk2VJma3cDESVjU3Pl8gU37mt
         apSmV3rDAk4Rl1oxI9Y4nY3md/IXSmF7uibmUhNv6sTSORFOa8BaWpmzZWl/HMi2pPJV
         MJbM9M1bybRQBLSrTGU6d2AVB1118LOxYXxWHZ9fisuPa34x7AjZopsQEOze+QtulY9D
         DxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OqX/ImXXX8Z4O+Ei2v1LhFkdAdb41P31AwRDJO9BdNk=;
        b=ZlMrwNet+a6u2lsAY98Ha6HB5tzFQMI044vBX8qveD6U2ALAvxxLzfgMGLgQktLp9G
         UYIal015gMbasCRQZRGZUpo3iJ5qDHcoJqzbW/iWQtLhyuJa6zJ/7P0nHKDLbaWOg7LO
         o696pGCkcIEb9BvmZWHNIqR/7fytsm84eU0x4x/AB7pvQO3PboLOUNGgvgIdk76lIc9q
         F+rcCs7DGMEK5dwNgwvagWvDWMTchfmSYXsl95mcR0drw+FL4OwWbhrovMQxkByDGKDS
         SB7mJkiAnGwsbVFEVP8yoxVX6gXGHbdunTdfwDsYruiAHYOsphASPvXNWQ0+IkzTyRWS
         swTA==
X-Gm-Message-State: APjAAAXgGglTYlLyr3xakQ0HkfFILpEmaLvJ0Zo8SmZFxGr6Lb78OR8k
        daaM23gE/haUH4YY/gvzf4cdlQ==
X-Google-Smtp-Source: APXvYqx0vj8hLMqmfE14RFd4rwqLhHwh0J0v/lF1ibKLjjeaHMZ9g7uibDy5qziEYX3j69dk4bwppw==
X-Received: by 2002:a5d:6911:: with SMTP id t17mr40634132wru.255.1566397263853;
        Wed, 21 Aug 2019 07:21:03 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o9sm33418939wrm.88.2019.08.21.07.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:21:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 10/14] arm64: dts: meson-g12a: fix reset controller compatible
Date:   Wed, 21 Aug 2019 16:20:39 +0200
Message-Id: <20190821142043.14649-11-narmstrong@baylibre.com>
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
meson-g12a-u200.dt.yaml: reset-controller@1004: compatible:0: 'amlogic,meson-g12a-reset' is not one of ['amlogic,meson8b-reset', 'amlogic,meson-gxbb-reset', 'amlogic,meson-axg-reset']
meson-g12a-sei510.dt.yaml: reset-controller@1004: compatible:0: 'amlogic,meson-g12a-reset' is not one of ['amlogic,meson8b-reset', 'amlogic,meson-gxbb-reset', 'amlogic,meson-axg-reset']

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 465106d37289..74c587411306 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -2215,8 +2215,7 @@
 			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x100000>;
 
 			reset: reset-controller@1004 {
-				compatible = "amlogic,meson-g12a-reset",
-					     "amlogic,meson-axg-reset";
+				compatible = "amlogic,meson-axg-reset";
 				reg = <0x0 0x1004 0x0 0x9c>;
 				#reset-cells = <1>;
 			};
-- 
2.22.0

