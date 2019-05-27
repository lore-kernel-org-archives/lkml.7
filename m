Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570F9C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6602075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0taidlTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfE0NWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:22:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53472 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfE0NWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:22:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id d17so2981852wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DdDiX896+ezCVjE2omOCRKNF6RoJ/lx1xAP+K6/8hcI=;
        b=0taidlTmPCtCcB4JDbNmutRrOjR5sU3c+dVwtPaU9IRCQ0DyzKTGsFCl93SVFTE3Ro
         ccsPpDhPzt285NJdzFErdPt9OneOuVKy1/L1PDEl9dCYLm0T9UaLXGlEYyjhQtPCWriL
         zrhOYbgtmK1Ugz4k915t5pngUL2+4rnS2a7HqWAhcQ6+FaanvxOO4NFuH7GQon8VnL++
         Fhq50kZs28TwNur3YEFFbaU5B86p8vVGc7WGCryF0W1/ADPopbOehNDwlihgMmIZgIUc
         nGNegBj2pyTbz+GlzpmImgUv2alNedlx60dzK54mdtA4lBTFjNv4T0Y9NU68Lit/I6n1
         PaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DdDiX896+ezCVjE2omOCRKNF6RoJ/lx1xAP+K6/8hcI=;
        b=s+BKhHV3LgP3QTZOaUFsiUtnEiUyHUyX+T3+dp9kArbBm5e1UCoz3ly6hKDPbia6PK
         uy5JUC7jwEpufssRtUAyaCORwbXJ97A0hrEPmpo3hvqq+8dDgFxDlKQv/ghKemwPwt/u
         Zrh3yDNawMWYXqZN09X4vW43i7DD7eecERVgNU3HpL3/u0quLNZ9/2m8z7lppel2qeqh
         MvqRxsKTKNecsrnxKTQtTM55ejFfUk+TpDTJBM8HR5LgfCUFQCBMQxObOneObviDUUxo
         ks5R7YOONzxUi0ppz2td/nxgQtiRrhgi4fpUqCbYHlIqwMJPpYhOBHVjDkgqrxqB2X1F
         TeyQ==
X-Gm-Message-State: APjAAAVIFXksgaPWheV1XpU6v05cTZX6gyKGDzY8R4Co9IITWm3n3+t+
        u7Z5lRaC7ICfrL+GmyGPYSbzAfm+K5hHvQ==
X-Google-Smtp-Source: APXvYqx9B1l8Wqo70PYjwXfiLcOmhOwoS7q8t+cSLTwJ7RDvTS2xOIFZIkC/7C8I34i8CtpyFtMlkg==
X-Received: by 2002:a1c:7a0d:: with SMTP id v13mr9696782wmc.44.1558963328167;
        Mon, 27 May 2019 06:22:08 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l12sm7019836wmj.22.2019.05.27.06.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:22:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com
Subject: [PATCH 07/10] arm64: dts: meson-gxbb-vega-s95: enable CEC
Date:   Mon, 27 May 2019 15:21:57 +0200
Message-Id: <20190527132200.17377-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527132200.17377-1-narmstrong@baylibre.com>
References: <20190527132200.17377-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CEC nodes to support CEC communication on Vega S95

Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 6738b2aac9a0..be8799653ad7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -93,6 +93,13 @@
 	};
 };
 
+&cec_AO {
+	status = "okay";
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
 &ethmac {
 	status = "okay";
 	pinctrl-0 = <&eth_rgmii_pins>;
-- 
2.21.0

