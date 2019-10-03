Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6559C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AE62133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="X/kzO0Mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfJCNIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:08:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38192 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729763AbfJCNIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:08:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id w12so2842367wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gw44OhLwQH/CUylU7AC4CHwJnvlb/yfwJWpgjG0sVUc=;
        b=X/kzO0Mf8rp6JZbTiG3DaCWVH2uV5D1spjhSzxDM04qlnvV1ZoRN3QOzZ/9nqxa/zp
         tdwHcsd3l+4EYuqpn5cBFbk0o84KyVO9d7lERByJbO2rJAbm0BLvjt1ldyaFFMLdgN1X
         7UZTdiJbnxHzLwGG6IWoqiwEb98+1sTYoA6VT8l08diTELNCv8xpUGcv6hP8ma1dPbp9
         X31T1cBs89lfR86fvQrZRVc6/q6zxcxMFFlhrZ0yjs75d5fPTvbzdsLnNonrvRSICnv0
         nXhT6m+ns+AObjmTCJL6XiI5tCPE6iFFqow3usBNluC+056y/CLuizemf28eEXii3L7R
         QBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gw44OhLwQH/CUylU7AC4CHwJnvlb/yfwJWpgjG0sVUc=;
        b=fWsMT+ecEWIgbR+8ApAfJcjuGPC5eniQxuQgs3Kf7KBp2uyZNnYrTXxKSgwr+daCrf
         HAMt6Cj+eAEEy3S5KbY/7AClLaqJXNlxfBdFfkCIWbdzpaD6yHlMJy2wt0/9zbl6/ixA
         UQqRkucEnz3ndJfQtwv9gWtcipfJKg7hbzmYyPscI5tNi42wUcKiuq3iCtVTz+Q/EYVY
         nedXJV90vbDmCmfMzGYEtFuY9fFbpu1DtC5hy3l4WExvkM25Ls9NjRe7ZPnpKZ8kix4L
         bMCWl46R69Lwa1qFQGze7A3sdIOn9rCMemSt44iCUG4/wZ8w2r/T7ZHJqOQ5UaNnxxfM
         v9yA==
X-Gm-Message-State: APjAAAVv5BY/BK6ka+VpTSKuOPgd3Tu7ceQeSnDvJW/7s1MN3TerJah0
        nEsWVwRx+USIa/BwihyM0zCunA==
X-Google-Smtp-Source: APXvYqyeIE9AetKtVnUHsr637KtU42j4dmzDlDnD4GEC3YwDwFMKDCM+icveVvh1Nm7BM1NCsLRREg==
X-Received: by 2002:a5d:458b:: with SMTP id p11mr7388306wrq.196.1570108123645;
        Thu, 03 Oct 2019 06:08:43 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 90sm3868870wrr.1.2019.10.03.06.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 06:08:43 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Jourdan <mjourdan@baylibre.com>
Subject: [PATCH] arm64: dts: meson-g12: add support for simplefb
Date:   Thu,  3 Oct 2019 15:08:41 +0200
Message-Id: <20191003130841.8412-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SimpleFB allows transferring a framebuffer from the firmware/bootloader
to the kernel, while making sure the related clocks and power supplies
stay enabled.

Add nodes for CVBS and HDMI Simple Framebuffers, based on the GXBB/GXL/GXM
support at [1].

[1] 03b370357907 ("arm64: dts: meson-gx: add support for simplef")

Cc: Maxime Jourdan <mjourdan@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
This will be handled in the in-review U-Boot Video support for G12A at [1]
and the simplefb handling code at [2] and simplefb removal in DRM driver at [3].

[1] https://patchwork.ozlabs.org/cover/1155898/
[2] https://gitlab.denx.de/u-boot/u-boot/blob/v2019.07/drivers/video/meson/meson_vpu.c#L145
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/meson/meson_drv.c?h=v5.3#n158

 .../boot/dts/amlogic/meson-g12-common.dtsi    | 26 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi    |  8 ++++++
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  8 ++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index f76773cabdb1..21c155f4508c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -16,6 +16,32 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		simplefb_cvbs: framebuffer-cvbs {
+			compatible = "amlogic,simple-framebuffer",
+				     "simple-framebuffer";
+			amlogic,pipeline = "vpu-cvbs";
+			clocks = <&clkc CLKID_HDMI>,
+				 <&clkc CLKID_HTX_PCLK>,
+				 <&clkc CLKID_VPU_INTR>;
+			status = "disabled";
+		};
+
+		simplefb_hdmi: framebuffer-hdmi {
+			compatible = "amlogic,simple-framebuffer",
+				    "simple-framebuffer";
+			amlogic,pipeline = "vpu-hdmi";
+			clocks = <&clkc CLKID_HDMI>,
+				 <&clkc CLKID_HTX_PCLK>,
+				 <&clkc CLKID_VPU_INTR>;
+			status = "disabled";
+		};
+	};
+
 	efuse: efuse {
 		compatible = "amlogic,meson-gxbb-efuse";
 		clocks = <&clkc CLKID_EFUSE>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
index 0d9df29994f3..d80d8a982917 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
@@ -342,3 +342,11 @@
 &sd_emmc_a {
 	amlogic,dram-access-quirk;
 };
+
+&simplefb_cvbs {
+	power-domains = <&pwrc PWRC_G12A_VPU_ID>;
+};
+
+&simplefb_hdmi {
+	power-domains = <&pwrc PWRC_G12A_VPU_ID>;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 1fdc5af5ae23..f89d744c9648 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -147,6 +147,14 @@
 	compatible = "amlogic,meson-sm1-pwrc";
 };
 
+&simplefb_cvbs {
+	power-domains = <&pwrc PWRC_SM1_VPU_ID>;
+};
+
+&simplefb_hdmi {
+	power-domains = <&pwrc PWRC_SM1_VPU_ID>;
+};
+
 &vpu {
 	power-domains = <&pwrc PWRC_SM1_VPU_ID>;
 };
-- 
2.22.0

