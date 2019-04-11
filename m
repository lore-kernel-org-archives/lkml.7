Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA87C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A200217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3A7DxVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfDKKru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:47:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33822 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfDKKrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:47:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id r186so1650599wmf.1;
        Thu, 11 Apr 2019 03:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sgaCObQyxyHYTX1YXpu+MjtXHmBUZKNVey1+WmtN8oM=;
        b=h3A7DxVW+0PRm4RW0yFkuRt8I2eEtYCuczXFelTyN5D1FhMf0iIpmI8CPpzT+Z1vdM
         NKbxLK0FvBlEVkO0+myids57L9PB/tbFSgLvpBrtLFML+bUvmJJ2rlSD0/pp2p/3fNfM
         vEYaOwNo2ZKmLlyVCbbYgfviZ7T/8IQXRnnOrFXYWqLA4z/8qB+50vknCdRFERi48OgJ
         rAVLUkHdHuk2r1vJbuT9ro22zJaeNQUjGWI/p6ufAE7/sZPxT92EcDnJYSNgf3ElGB93
         VZBdl9H2MV9LThYwwqSQZohEr6xw0V61omZDM7Py4s9ijIWIpj6nseSgCkuSM9E9w2he
         5gGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgaCObQyxyHYTX1YXpu+MjtXHmBUZKNVey1+WmtN8oM=;
        b=kTFpfotZzQp1kOrmAqayiaohqX91g8Z0AAUp779bjv+663lnQ86iL8IyIPLl2nt5ND
         SnYyUXNEm6KE2P1Miyf7zE6RYCts2SMjBd6c5Q671VYco/UA4Cw2xlxye1rEn3sBSEVb
         I+Ol47QiIpAq+MaCZYPzvEqWLZta4veKbd8We8e4a3F2tpfaHVnsmk2NM+R1lIEabnpk
         3XgzdDih5TXLGl9HCteuP/msZRr7zLwxLY/L1LYp+i1gulYvdVjofmVyKdM1L6eQfXDG
         K24MWYwkZAeazNMf/RFdvl+5fXZmxd5eBD3z9+MvLZWNCIuQGtVltZAFpFX5csT5DKtZ
         kD8Q==
X-Gm-Message-State: APjAAAWWMynkPiNvEU0WoUhXg1Zt/UBIskJ7Ik1d7f58WFDfeo/ZFX7N
        79OhOzJ0BmpR9FEnTzZ3NBU=
X-Google-Smtp-Source: APXvYqwfyMn2Y5/mYn4Wxueal1nFGdObseD+pt+aaXlRn0/pSTvCbnS93jh7T5aYu7s0Vkoctynzvw==
X-Received: by 2002:a1c:cc15:: with SMTP id h21mr6044974wmb.85.1554979665527;
        Thu, 11 Apr 2019 03:47:45 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id k4sm54987587wro.33.2019.04.11.03.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 03:47:44 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 8/8] arm64: dts: allwinner: Add mali GPU supply for OrangePi 3
Date:   Thu, 11 Apr 2019 12:57:20 +0200
Message-Id: <20190411105720.32357-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411105720.32357-1-peron.clem@gmail.com>
References: <20190411105720.32357-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable and add supply to the Mali GPU node on the
Orange Pi 3 board.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 17d496990108..d4c989cc92a7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -58,6 +58,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
-- 
2.17.1

