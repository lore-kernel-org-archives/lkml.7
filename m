Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC382C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796DE204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBcMLpPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfDSTOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:14:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33013 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfDSTOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:14:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id k1so6784715wrw.0;
        Fri, 19 Apr 2019 12:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wa5zJEu0wHUbCMisIa1+skTbLI8R1wqtGj7+AFP0Jt8=;
        b=bBcMLpPr0Ss4cubMiCFuMZtRRWsA95kPo3YepC4Izt3F0G987GtaNqcIeNFEIXC3jU
         hqjyHAbDsSPsw+Z8WIyRjHk/GVklQ9OmEmgAqKDRBXJMCyd7tFRFYHGIiMBlX+lPURVv
         3K5maGJFw13IjQ5kGtak8HaPI3WZIikq5YpTrXeHB/bKH+jHCBTO2TIY64coypKFGqz5
         oTSMofNYqcxK4F7XmP1YpDTjX4AjCub5UgI9K6+EgNqmi1i/pp890hElnP+ywYo9IU9X
         MDDG0EJAr/M2oBDkQTNlBXZ3IFXRgYroE9dSH1Gtpt8ZmfTxFi4+8IlGcYcdDM7yZhUI
         6kIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wa5zJEu0wHUbCMisIa1+skTbLI8R1wqtGj7+AFP0Jt8=;
        b=VZtI84a693CH9psepQEVJgFQzdhd+DpX8aQm+kvp3AH1MAWw/AzQsarJtytUQuaay5
         pTF2WeY8Z8DEXpduDF5Q6J40zHHlCWlk7J6soacFdGwS6SMAX17EpFLu+xzzG7NOldWO
         BS/mhCLvmncwJryoPXqDQT91xHQX8D9/4ngeNfCBY9lAHLySqxjnAUSlG1xEj2obkbQC
         YVh3XDvbpLA5JU7ydl3wSuKLvS1yMT/K5yCGKa7ewBCprjvdtpWBtgPox+89i9ZF9HPX
         9nsnnoInXL+XGYRR1sMT7Z4Gq5aD9Jc4bxonKab5m67bOAh00K7NHjt95RIMztdYg9/+
         qxbg==
X-Gm-Message-State: APjAAAWBfTPIbiIUx+s0wEHLKr/UVo4P8Vcuqud8n4aZemNRXx4lTxT7
        uyossbbdVjQ+Lp028wPfXSg=
X-Google-Smtp-Source: APXvYqzAekguxykEQv+5laFyV/ORVMc37WUNEIB1po0LKufS+N6gy/BH6mV8NVbozDDG0ziLWa7u3g==
X-Received: by 2002:adf:edca:: with SMTP id v10mr3849928wro.157.1555701262848;
        Fri, 19 Apr 2019 12:14:22 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id z18sm8131149wrr.90.2019.04.19.12.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 12:14:21 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 4/5] arm64: dts: allwinner: h6: Enable SPDIF for Beelink GS1
Date:   Fri, 19 Apr 2019 21:17:29 +0200
Message-Id: <20190419191730.9437-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190419191730.9437-1-peron.clem@gmail.com>
References: <20190419191730.9437-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beelink GS1 board has a SPDIF out connector, so enable it in
the device-tree.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 0dc33c90dd60..76a95ad33dc5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -243,6 +243,10 @@
 	vcc-pm-supply = <&reg_aldo1>;
 };
 
+&spdif {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.17.1

