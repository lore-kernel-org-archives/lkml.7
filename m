Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DF7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1EC22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ld4EqF5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfHUOVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:21:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41736 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbfHUOU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:20:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id j16so2220540wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KYwR0J5MWB975uhtmdnb3gIh5UU/9QpLyEsCz2nQDEA=;
        b=Ld4EqF5RQZo7ySGIp7mftWRj+FPDgJ/s25SgUz5VqCdqcgJbuEFbepX8thjwdFDZMw
         2DWicyOmtqHLoPiNJ7YX7rst2SSnoZ4IEVIQn3q9Ps61DzG9hlp2nti5iVUjQDq2awew
         osjj0UneqGnSG4JlM0W0sqvMhNs/ExHHYgcPnHe1ifZCciX0fg8W2Ru/vKeAd+FscV8d
         Gh6fvNaO356hgwX96dt+x/mVPSJXqzxPpdA2TjtlN4DLp/sKEtUlj8t5OP+ib7ZXnTRY
         MZD+Men6lkXVVrbyHd2KAhqg8/d6rZ7wbNBriXUtzrPm/RutuSfpj/5Qixo++ELl4Ehz
         Lf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYwR0J5MWB975uhtmdnb3gIh5UU/9QpLyEsCz2nQDEA=;
        b=mINoiiDJkCxTC3vEc92H/GE6Wme+6zX0fy6Shri/0JiIHjuhollt56Jt5YqsmnaT7D
         jYSqVg1CypKTh0yPKfpTAQU7KuGUCoHO/n6jhoG1uQudGAOBe7pCGPC2f8gV0e5xqhHT
         GvRSuZI0TE+T8wFAKrpzDBkPRPiZ3Z78TigzirU4lT5A87kjYpWLILYKDQnM70qVbkYT
         lvmrBMWtZG8PZ2fxpBi2P8i3tJPweAZyxmACLuxQuXEk9Irjv7M8DjGUxX/vTbyqNFog
         NkARpx3q6F/ahUMS9/cxNTbeFPiJwajDrgIAI3+FIqhGGeU5zuE7T5f4fnrx9hzMGJRS
         Hjgw==
X-Gm-Message-State: APjAAAWiKFuBqZAyO85niDYimy+nGVM+2RVS06Jwmhz7YCG/WPne9pNr
        AFeN9ZeOjwAoHTW3NfLm3JgNyQ==
X-Google-Smtp-Source: APXvYqz+FlBb2jwjOaI90jFBUoyCKc3uk/XuSzdr1klw64PZi7MHEt8/o3WmqBd3rMA17VyQ89kr1g==
X-Received: by 2002:adf:f705:: with SMTP id r5mr40552098wrp.342.1566397256019;
        Wed, 21 Aug 2019 07:20:56 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o9sm33418939wrm.88.2019.08.21.07.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:20:55 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 03/14] arm64: dts: meson-gx: fix reset controller compatible
Date:   Wed, 21 Aug 2019 16:20:32 +0200
Message-Id: <20190821142043.14649-4-narmstrong@baylibre.com>
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
meson-gxbb-nanopi-k2.dt.yaml: reset-controller@4404: compatible:0: 'amlogic,meson-gx-reset' is not one of ['amlogic,meson8b-reset', 'amlogic,meson-gxbb-reset', 'amlogic,meson-axg-reset']

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index c2d3fffea8a7..5b3dfd03c3d3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -220,7 +220,7 @@
 			};
 
 			reset: reset-controller@4404 {
-				compatible = "amlogic,meson-gx-reset", "amlogic,meson-gxbb-reset";
+				compatible = "amlogic,meson-gxbb-reset";
 				reg = <0x0 0x04404 0x0 0x9c>;
 				#reset-cells = <1>;
 			};
-- 
2.22.0

