Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603A4C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3038B20848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OMEfpFp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfEPOc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:32:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35000 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfEPOcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:32:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so3509090wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 07:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MCh2hGUp25ZJxGPePdNkCdsXMQeyI1uh6u/3BErb/Yw=;
        b=OMEfpFp+KLYfHxBXZQN0DYJBsoAo0sh4lRfrR313ZuB2/XYxZ/vjI6eKK50+gx3Yjw
         iy/aG0HxJxse2ASHabxUprCKQwTA8S/D9Jbp/D+q6RSfdY/vwPZHD3yNw2YP6SZQLDOx
         uJOdZbDahQGnPtwFHIFAyPVE6NLig8V9vbihySB31clyVUel3Os3k0hcA+kLwKXzUNqS
         uJFODNwm8obBwNITLOp+rZ0t76VNSkUFBT8DstnZFCQboxjmJxsgH3AEbja7zzD4+7wM
         W5qbm0IrBKpwpPVx/zNQO8sDc4DurMp+oNShr2bhF0Vi2T9z/mZrVO8ynoNwX3uuPGXu
         eA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MCh2hGUp25ZJxGPePdNkCdsXMQeyI1uh6u/3BErb/Yw=;
        b=hYxVMKiAv+0/KdkXHu5Hrxp8ehzljLWuo+f0fi/tzWNzbIEXS6leszEmbJmYoGnQLl
         qMsU6vz9l4ZRDYvgPv3J/ZqdUie0hfJaukkzpqakJt9OiIA1KHQ4yeHxQpHMRdEeSAso
         ktFQNKIW7OPdykkAaOJa7wATkPnkYuvSTBX9Z9KmERssB6ooohKFtMRhwFK3occaYFuK
         NpkpM0Go2Ni3kqQLhVeAx57+aFBKSEhJECGt3ktWL1HFqLC/1/XQfYu4YLBric05cRE8
         lYc05+/ADhbJLh30KhDXkUQt1wbk+DkFJXyTXAcUdRwqnH7X1sqDz58ZNCn5JUvYBtgn
         ErgA==
X-Gm-Message-State: APjAAAVHpjVENDzDN7nMGTX3CAghMWUx1Vxf/Fp4kTj82l1e07x+lm48
        JO8pwh+CZdiwJYVEmsDv0be/yw==
X-Google-Smtp-Source: APXvYqxh4XiN4cDh/DoIiPtCPuo2gI4Fpj7ttgza+eSTorRPdi7jF2OwizM5OMIMXOYlejycpeH0jw==
X-Received: by 2002:a5d:45c7:: with SMTP id b7mr7863823wrs.176.1558017143940;
        Thu, 16 May 2019 07:32:23 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id h12sm2386548wre.14.2019.05.16.07.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 07:32:23 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: g12a: add tohdmitx
Date:   Thu, 16 May 2019 16:32:16 +0200
Message-Id: <20190516143216.6193-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the hdmitx glue device linking the SoC audio interfaces to the
embedded Synopsys hdmi controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Hi Kevin,

 The related device driver and dt-binding have been merged in the ASoC
 tree, for-5.3 branch [0]

 This patch is based on the audio series I have just sent [1]. Like the
 patches I have sent this week, they are all based on Linus's master
 branch. This is done so it applies nicely when setup your branch based
 on 5.2-rc1

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/?h=for-5.3
[1]: https://lkml.kernel.org/r/20190514142649.1127-1-jbrunet@baylibre.com

 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 3c92d165621c..90da7cc81681 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -1677,6 +1677,14 @@
 					clock-names = "pclk", "mclk";
 					status = "disabled";
 				};
+
+				tohdmitx: audio-controller@744 {
+					compatible = "amlogic,g12a-tohdmitx";
+					reg = <0x0 0x744 0x0 0x4>;
+					#sound-dai-cells = <1>;
+					sound-name-prefix = "TOHDMITX";
+					status = "disabled";
+				};
 			};
 
 			usb3_pcie_phy: phy@46000 {
-- 
2.20.1

