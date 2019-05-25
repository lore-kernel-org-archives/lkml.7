Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7CBC282E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757202133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hid6LcFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfEYQXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 12:23:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36046 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfEYQXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 12:23:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id v22so4679162wml.1;
        Sat, 25 May 2019 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OlAy4iNnvpXUfWGzbLAVAxpfZU/8XBVjL/0mbqQ077c=;
        b=Hid6LcFkjp/uCFTQ8+JUV9wkDRDxQ5n/luRNm+f87fvUA6aSgXGkTu2cpND0HqGipX
         W8kiEMpIpTWBFsfjv1qcGygssRzr9+pZYRLkJpCDYNuxxOrZPoRl2hGLz313q4JEtg0L
         HgP9qUTpzN1AYV5Ke6SF0VSYyiuoKxcv0ZSjRUtlvCk1M7/aG3s0cwnoUYQMswc4O6AW
         REh8R/mGBFsRah9xYMdlsRL4SWPCNrIe67ml80VoiNPYdfBVSA8cPc6IF2KiwS9H14TR
         QBJi5UgTXSJ16qkZj49TVOl4Erpt6gJuTMzI6ssAmmv37L3FcTY/NMy3o3J9g2hzehXx
         rShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OlAy4iNnvpXUfWGzbLAVAxpfZU/8XBVjL/0mbqQ077c=;
        b=JvpM1ehLoxY999O24kYWlJ7qYho6AveVvaJlb7ANuAcGDYv7Qx+ZfOq5P0uwOBx9zo
         ICgPCKElUkPxMps0G2aRnb4Pg3aL5qG1VKVa18Z8EpM8gYnl4kE7cVMA4XLWw/obBikC
         uQRUe+icIC5/LhWBcVkul3UgrH377Uzp3tx4hSarySLh9YF3cyA/nRfeUA1I/nDBWm3Y
         kXFl2Nj+wy482wXwVctAn68/oFaP5dMGZ1xMGeifugF+X2HQ/Q94Tsh1G920TQHldOfR
         CmSO1NrJWHcmdFJx+B7JhmSSIaQGFxIWrXjnXgDcBhYPqO2vhzffql1+tnOew80JUYgu
         KEDQ==
X-Gm-Message-State: APjAAAVxuISkb7xCKPrRFkYsnYWSrXx5UVRFlOOUkEBD3LnkWIzbCBbh
        4+d7mRTfeqmNtLte6iLjW1w=
X-Google-Smtp-Source: APXvYqzeJRaf2YrofzXm0wnzXdjpc7yDd4pAHttdNjL7/dmyVC2pKdylt4bQ+mVkGLlcN76UZiDo6A==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr12209726wmd.115.1558801418274;
        Sat, 25 May 2019 09:23:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id k184sm13194409wmk.0.2019.05.25.09.23.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 09:23:37 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 6/7] arm64: dts: allwinner: h6: Enable SPDIF for Beelink GS1
Date:   Sat, 25 May 2019 18:23:22 +0200
Message-Id: <20190525162323.20216-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525162323.20216-1-peron.clem@gmail.com>
References: <20190525162323.20216-1-peron.clem@gmail.com>
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
2.20.1

