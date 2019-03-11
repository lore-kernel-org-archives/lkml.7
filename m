Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD21C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0AB206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xl+G+6NW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfCKJ5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:57:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35010 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbfCKJ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:56:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id t18so4317916wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Udu5uhezWydKZu4K1HYQtiJgtb0stOPsgF+RirKZSBY=;
        b=xl+G+6NWSc4HOZ1LJmn9AFbRGVHaMerxoQLx1UEkfoZKM1H7kNQMMYnvKFY+jjdmwu
         8yBm36k1lWaV3wVQItw8bUNNSpU0bRkYdprZijjP2NfeRNbobBCDc3vaeYM2suEJDxHz
         0REXZ5EtiIYdDkopWehhi/t8VSk/O7ksgavnd3usqmiI4i55WMyZjAKPQv4PU6DkFd11
         C3zbGhr8BguNYiCK6vAM7e0H+rr8EsrziPpHV8mpwoRVIpR22y4kNErGUcCBgKZUnzH0
         z2mJKC+cWbgDVqLBPJgFEsfyzoDnJY18czxBaXq6udftf1mC31slPAFazElmD9eHxNYD
         1WYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Udu5uhezWydKZu4K1HYQtiJgtb0stOPsgF+RirKZSBY=;
        b=gwBvTQeBQ/SMb7GZBsiHC6IL5aNrI+OfC9p2/alDu308n8mKiFo5I6ByD2oC1S6vwB
         h7ci5q3yPPeNeIoPnauyh0Abm6VCNolsZeS5RTgWB0Id7Lmf9xvAWkruHo/61f56qUAG
         yGVpH2TjYWXNOay4lP7O1LeyZG3oZtp5179YJO5X/ysAS4/EPNBmLvGvqXd0TrwORH2t
         iv+2ch8c5162uyimU8RsiD2af2OHUA/qEE5AeKq4eYirIIefw8uSMriTAS/qcTkKun7C
         cntWMKj3aTl77QuMSmWKxOY4hHkcI8EOzaUaT8jbHaobpGdDgf27W/Nd607SfcEFzkUJ
         fWlw==
X-Gm-Message-State: APjAAAWjMqgh6C16M11YPFimfUt9svx5uXBJuK/J26BJJCAAqHLNv4eL
        EKI7nkq63qao9ZMav7M+0Txt9Q==
X-Google-Smtp-Source: APXvYqwewHUUyU/UhXvbgGzdNB6BmlJnKJ5g9JfSkNDyqqdEMigm09Ikxn/YF/RPW0VtKkc3xtXvvg==
X-Received: by 2002:adf:e3d1:: with SMTP id k17mr19123533wrm.143.1552298185200;
        Mon, 11 Mar 2019 02:56:25 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e12sm4764737wrs.91.2019.03.11.02.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 02:56:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] arm64: dts: meson-g12a-u200: Enable USB
Date:   Mon, 11 Mar 2019 10:56:12 +0100
Message-Id: <20190311095613.11371-11-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311095613.11371-1-narmstrong@baylibre.com>
References: <20190311095613.11371-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USB2 OTG and USB3 Host ports on the S905D2 Reference Design.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index 17696f356ff2..cc043e075521 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -108,3 +108,19 @@
 	pinctrl-names = "default";
 };
 
+&usb {
+	status = "okay";
+	vbus-supply = <&usb_pwr_en>;
+};
+
+&usb2_phy0 {
+	phy-supply = <&vcc_5v>;
+};
+
+&usb2_phy1 {
+	phy-supply = <&vcc_5v>;
+};
+
+&dwc2 {
+	status = "okay";
+};
-- 
2.20.1

