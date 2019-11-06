Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3B8C5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3046B2178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWzySGaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbfKFOXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:23:21 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46574 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfKFOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:23:21 -0500
Received: by mail-yw1-f68.google.com with SMTP id i2so9601609ywg.13;
        Wed, 06 Nov 2019 06:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSWVp70y2kpyJk9Cxl49/cxLR3cgjAESMYLS12E5oUY=;
        b=bWzySGaI1gx56KAqizix5H7Yk63JM+hiMx+HiAX2uSV+XOVSC9t6Jrkst9wSIn/yLa
         Xcu/wWwfjHrzCGL5RS/ikhES7rrC7bIxuo/xobxeHHdGdiupSqBrywwc01R4ggjyVVwT
         6JEpWFWZxnJ/BBGpPpEnMjKz3Upd/nuofT7yj7MARsElGSSh3VroG1/9NtMtS9asMnub
         XLFSnfkiGKtLmEppBnfnGIvYYIlvm1VLadl1ERrUOnACBilCnP8g/fKJMCpoXlfG+JUY
         67VOsBsBFFpozYlaQHVQN8dlLJyN6q8JLY/4aG2J/Ve/avl4AYaZ4kmHQxum19YIaqTs
         NVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSWVp70y2kpyJk9Cxl49/cxLR3cgjAESMYLS12E5oUY=;
        b=qtKs5GLIU+YfDebyWhUMdfm/bNZAHgHx/y3Hi3xLbx9Tqcy3wXsvUDhSBZY37Zrj8W
         xjLpQskhxGI9T5kJ0IP/rJcEQnGGMx5KDkXJ6suEHVyjPnutbPRJ2a0NDqUMtU69bWYr
         P89CNtcHGuz6SQhWVQZ1+PvJNvr/X+j1AFFqaPMZCdbU/m1EeHWWVujNWBAg4W4SCQXM
         8w60ryy34mRSScIeosW1Ax2eKogZP7dHPBTs8wp+03gVcWHFih3dtlqEGa233EJm/AeP
         iBDymxPVeUmgGY981iKEn8KEj3VX6moAgWJ6B82SX6mXb3QyXZIIrcvgkXuPecxBWl/Y
         HRrQ==
X-Gm-Message-State: APjAAAWvnrWG5dPY6Sy/aUcytqzEL4EUWoZI4fIX6LVIxuO9pcoQZtGm
        9i6FbIcPCu4lWQVNL3HRrNXSW961+uo=
X-Google-Smtp-Source: APXvYqzoYMq5gT/9eBMtyUIJu1a4USxwCNgZTNpjMjW3B/XCmy9qZhYAuVQhtBUvi/iW0mEQY3Xf8A==
X-Received: by 2002:a81:58c6:: with SMTP id m189mr1437100ywb.25.1573050199708;
        Wed, 06 Nov 2019 06:23:19 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id f203sm4436246ywa.106.2019.11.06.06.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 06:23:18 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] ARM: dts: imx6q-logicpd: Enable ili2117a Touchscreen
Date:   Wed,  6 Nov 2019 08:23:08 -0600
Message-Id: <20191106142308.10511-1-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LCD used with the imx6q-logicpd board has an integrated
ili2117a touch controller connected to i2c1.

This patch adds the node to enable this feature.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
ili2117 support is scheduled to be introduced for Kernel v5.5.

V2:  Change node to touchscreen@26 and move comment about 5.5 to under the dashes

diff --git a/arch/arm/boot/dts/imx6q-logicpd.dts b/arch/arm/boot/dts/imx6q-logicpd.dts
index d96ae54be338..7a3d1d3e54a9 100644
--- a/arch/arm/boot/dts/imx6q-logicpd.dts
+++ b/arch/arm/boot/dts/imx6q-logicpd.dts
@@ -73,6 +73,16 @@
 	status = "okay";
 };
 
+&i2c1 {
+	touchscreen@26 {
+		compatible = "ilitek,ili2117";
+		reg = <0x26>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touchscreen>;
+		interrupts-extended = <&gpio1 6 IRQ_TYPE_EDGE_RISING>;
+	};
+};
+
 &ldb {
 	status = "okay";
 
-- 
2.20.1

