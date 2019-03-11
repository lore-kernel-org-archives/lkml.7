Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE47FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEE920857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="v++2uJ/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfCKJ4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:56:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44436 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfCKJ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:56:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id w2so4295388wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vq3Rt6EgSxT8wPyvueXvlvQmKgRIGQTLWAAEmCmO554=;
        b=v++2uJ/bnOOVQB8dCle9HOgIr8mybhyNr8dL31jwh0V6fSmS8GnkKX/T4856bZC0i+
         x/k9PXLhVfR3rbQm37OgRUf4jAt/J2y8Kc0uTIJrBChye45nWxDeL1BI/bcxJCDsOUl+
         +U89ifH63K+k15+XaFfeVrbj0LfB1EMcyeIVS/jD59ZQKjdpspZRKB/gu++oLgx6ZYgL
         C18i0z679SLyLAyDJAhaEBXwWxEO8yJaQhGafX5E5EEvWD96kQ/8O58SAfFXMpASajta
         KvOubHDoB/ZltLI5yElZTJZJmcGQnpN9Te5FfcNJts53w8x+dhkM5+pznfV+k2eGC0rT
         xGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vq3Rt6EgSxT8wPyvueXvlvQmKgRIGQTLWAAEmCmO554=;
        b=eUhe2Lmj+HhU35S+HMp2pZYmN0j1jp2dr/VTQ3P/UAnxTGrDtNsJ8D30iEfjGlYyQT
         kbu8qBe95+zMgGZ1U7+TEXCaBklHw5eDU3kjXsJHCyQTUE6JoucbTsjCn0k+OxAIBXXg
         PE+8FQNJsPP39ztQlazwYqzk0XkkLpBKYaACEKkjQL5GkCVxI5F6GdSuPZehc772i2HF
         Q1ro0GcGr1upoARahZUeXP9N/u/7z/Oc1gSJ8lWiLtpg41qW9PBCDACSpMDBO1cfPRj4
         mKVw9MQ1AtJ3dqL6YMiIsXHMh+iK6IrK3D95XODrNJB6Bh7zbGLJmbN3OD7bD9Vgq9ma
         ETRg==
X-Gm-Message-State: APjAAAUHbZ2VW4UaY77x+kF923WOlywMXCzO+kuHQTAPvmSL5I6ftnEr
        eH0l7xPSy+CPRJH4+A6QRE3iKdKr2Eei5w==
X-Google-Smtp-Source: APXvYqzzyd1axhj/Hi8hHaoH+kaSxc3pe76K2W4+iiG2IZRth0V4nDjkB3cUN7FMkFbS07EQRDPFfQ==
X-Received: by 2002:adf:e8cf:: with SMTP id k15mr18689289wrn.193.1552298184237;
        Mon, 11 Mar 2019 02:56:24 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e12sm4764737wrs.91.2019.03.11.02.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 02:56:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] arm64: dts: meson-g12a-sei510: Enable USB
Date:   Mon, 11 Mar 2019 10:56:11 +0100
Message-Id: <20190311095613.11371-10-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311095613.11371-1-narmstrong@baylibre.com>
References: <20190311095613.11371-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USB2 and USB3 Host ports on the SEI520 Set-Top-Box.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 3d230545122e..5762bf3d6898 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -124,3 +124,12 @@
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
 };
+
+&usb {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&dwc2 {
+	status = "okay";
+};
-- 
2.20.1

