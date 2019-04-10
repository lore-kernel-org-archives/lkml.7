Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632A6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8D620820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojL6po6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfDJXPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:15:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36025 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfDJXPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:15:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so4862660wrd.3;
        Wed, 10 Apr 2019 16:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sgaCObQyxyHYTX1YXpu+MjtXHmBUZKNVey1+WmtN8oM=;
        b=ojL6po6l4LU/k/u3XfN9aPFLuB2HT3i/14b+tXflDIObX411NgTFq//0jyc/Skpvv/
         UDdg3BLLwRy0IqWoETfOWTx/iPzG1ijKkEAo/xRjzgs5xXtuARmo2t87TS1hQT9Suxmx
         rvRxOSD8LrZIiK2EPBGwN2OX99/DyvX5eIddFPtnsMQRH8hUNQMmtahAZN3mjCJ0lGX4
         RFmaynR7rhEYjM7lZsxxbPUN3bSIBDTQtuNsyywfhRKRTV64tLHW7y/8/HhkAmB3rFOy
         wUN5Z2JrF/gEZOWYH3nzWQgC9Vkk9IRt0Jc0Xt3aCOaZkQ4X0q6pVH5E/at2uDFP6vJa
         xvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgaCObQyxyHYTX1YXpu+MjtXHmBUZKNVey1+WmtN8oM=;
        b=VfgIh/zM18AHehWkkpnn2jW6/6w5AMIhCYeDIfy+QN7l0rU+4DfvUtXBZb5pclkDFA
         v7F79Zjc32TEP5B8VotjF3N94MX2/ebgTG9pF0y8gMqdAx2qxbjS8t9VJ7HL4roATzvN
         TlYNiKj9AtoDbnDbVYKllFbtEdLyKrUWIqNoneWe4cBLVPij2j87sIM0KsJrICS9N1LJ
         VZD47msdGCVBxDyPTD0zhCMCrnx41w3nDFWse62Z1R44BRfFaCmoSZCJh4in+gqdKyQc
         DcYCl3g4b+aKnudOjBB0+ATYLLy2/dSWtqDVf8uMYiUioTBR5I44zjfvhMpa6DteTFrM
         fCMA==
X-Gm-Message-State: APjAAAUY9I2/5dzzdFGOhAmlT/b6zMHWSG3Yu/YuzIMjWo3EqFxy0GXc
        83fO8WLfGEzNBKmfc7BXLnA=
X-Google-Smtp-Source: APXvYqyrEOhQGJXKNgtF9WRMgQDssvnADUdGdfCEkK5gOcrjWIPZQtC6Ecjsw4vVDy/iUkLvJdhcEQ==
X-Received: by 2002:adf:f7cc:: with SMTP id a12mr7719109wrq.87.1554938138130;
        Wed, 10 Apr 2019 16:15:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id n6sm8504947wmn.48.2019.04.10.16.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:15:37 -0700 (PDT)
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
Subject: [PATCH 8/8] arm64: dts: allwinner: Add mali GPU supply for OrangePi 3
Date:   Thu, 11 Apr 2019 01:25:43 +0200
Message-Id: <20190410232543.13297-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410232543.13297-1-peron.clem@gmail.com>
References: <20190410232543.13297-1-peron.clem@gmail.com>
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

