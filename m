Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3473C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF5F2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MiJuoVo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfE0NWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:22:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39311 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfE0NWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:22:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id e2so8162263wrv.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1P5QlVaHw/qutd0fn2pg3sEjq4K4xykyak/BNOBt7EY=;
        b=MiJuoVo4XE9EvwCi1lJ/KTjNn5vkTGuOAboQ1357fR8CCKNsFMkHx7jbSvFLyf8nAK
         lT0K3rrLl7Udusvz9kAPZ2Am/rHTN8UJMd2sjIQeV0EUo007PCehoOLFxmjZNm5VZY4r
         DFPwp91uwX2GfPpY1/vvPH0Penf8j3IsYBnOJu3yTpXNEVMdNLFnyVeTf7xRpkTODG32
         hRFdP+VZyIPkWJaHaiWHkrWfTleo4gO1n1ozF1DlcemA7hAzh1FDoyJgGNELfPPNkog1
         pD9D6pirVHuUyUozIsY0z7VhmmegqBdW7iVCknjA9PIhemNQwpp0NhCCQwSQvOKlTabG
         +CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1P5QlVaHw/qutd0fn2pg3sEjq4K4xykyak/BNOBt7EY=;
        b=niQl9zB+YslURf6XeQWy7Uuffsz0bUzmNNmwVoKBCDoippdjF7FCTBLfscUXwpqMQN
         3oZsgsoLAejGPGWuZ7o+SM8h1ATAJarj38ZtZsN35n5HAI5F9wkDJ43R/DTzFy+ic5+f
         0+6LWZlZHkevcITmnoRH0C1teYFD/jN4JILYs3wIWzZ4LXh2z+aczUSV/6yBkvukGF47
         +UgqwWUw0NbMT+BraeCszJ9wPlHcZaM0n1+tfG3vj1HNzEq63INgT0tegPLgvw0ADhTe
         7t6SmXiurfE6AZQSmBKMaREOCePRZTid4WSOwNTk15eJzt++gVniTUDQ5JELQ9b+CLeb
         Dk/w==
X-Gm-Message-State: APjAAAW42cxZKBI30NxI7wI7UhfJBeZXsp7HTtDuoFbb9IiXW3AtD6Yt
        d5xDywm4IIq8jZRRL2qjOJibqQ==
X-Google-Smtp-Source: APXvYqyWlquctEhMRszF7odvCHXFI0pvNktDwIVJZOgmAvW/p89BNtQ/h0utKRsS3NvmSJeu3FKaGQ==
X-Received: by 2002:a5d:680f:: with SMTP id w15mr7705835wru.349.1558963331213;
        Mon, 27 May 2019 06:22:11 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l12sm7019836wmj.22.2019.05.27.06.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:22:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com
Subject: [PATCH 10/10] arm64: dts: meson-gxbb-vega-s95: add ethernet PHY interrupt
Date:   Mon, 27 May 2019 15:22:00 +0200
Message-Id: <20190527132200.17377-11-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527132200.17377-1-narmstrong@baylibre.com>
References: <20190527132200.17377-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the external ethernet PHY interrupt on the Vega S95 board.

Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 9b52f3dcdd49..18856f28fd60 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -128,6 +128,9 @@
 		eth_phy0: ethernet-phy@0 {
 			/* Realtek RTL8211F (0x001cc916) */
 			reg = <0>;
+			interrupt-parent = <&gpio_intc>;
+			/* MAC_INTR on GPIOZ_15 */
+			interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
 		};
 	};
 };
-- 
2.21.0

