Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4481BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120DE217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTatGZPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfDJXPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:15:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40079 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfDJXPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:15:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so4825558wre.7;
        Wed, 10 Apr 2019 16:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k+4rEQwoh/x6L1vMEfLnhjWMCaYNdunEelwJgclnNME=;
        b=PTatGZPCmjZFTroABySWpv9xgTtzKUseUwkanagKUsXUKRbVHbfePali9R3GdcNq/5
         uJVUib94G/JjRkzik5rbzY53Rnw2nxW+9aZRvTLjnmrqlKwe3FMfiflavsxv0vAbuxIy
         JtXpBy7K2rKTE52leAuqJehzqxqKttc7LZ5dmx7WeNDsghSMdDLOD/tT2Eoom54OGwdj
         lbB5UDi7L/00ENpMgbuaqW+QUvlu5eOIGzLeKz6pZG3isdvMka3uP7BnjrFVUawwvEaK
         D2CYWO8XYer5ZzVbU89wmyooFp5vjS+dtdjhWuAP1dHuhNQ0tURTOGhjgryQs11+dvs3
         f+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k+4rEQwoh/x6L1vMEfLnhjWMCaYNdunEelwJgclnNME=;
        b=fQupqflM8H0Vendxh2+gtLrAAh1+K4J739msdwVBAgTohGKq50TKUuVSQ6COnDAUFF
         3Koto3iOyrOSVcIBV8OkgmUnzMfFdvzgDM2PzxiOigFQ9eg74z3jVDSvXTQu04juj6K/
         eH+/2Fi0Z0dxiwkxpx7sBy5/tTHXYr+U1YLoBWb2WNsjnIBqZ4X3Mf8LG1p7H2XnPbtd
         2eqKD4nVLMxBPv3NsLSlQfFxk3vy/YOywgvnhTCy7oc+p5jQ3POetthjdoSNuHx4OGP/
         DGXkQjmmpZyIgPymG7qOYxW2DBcnqbDEtX7YXQOl3zUEd+fC3hJyh0yBKTXpm8X0Fe2R
         G1rA==
X-Gm-Message-State: APjAAAUSD2huY6kZkLqd2/s/Jf/dLzhH3iR77ldDZzdGCzRPaOR0enZs
        Tuhm4Bj6gA4+oFHeA5BuCMc=
X-Google-Smtp-Source: APXvYqx31kLMhziL8Yo+k+kniqiBbaLP+FOOPB0SCGUEW+Sn18W3vniwd88vAy6StyFgWGrMHpl3HQ==
X-Received: by 2002:adf:97c5:: with SMTP id t5mr11390835wrb.252.1554938137150;
        Wed, 10 Apr 2019 16:15:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id n6sm8504947wmn.48.2019.04.10.16.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:15:36 -0700 (PDT)
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
Subject: [PATCH 7/8] arm64: dts: allwinner: Add mali GPU supply for OrangePi Boards
Date:   Thu, 11 Apr 2019 01:25:42 +0200
Message-Id: <20190410232543.13297-8-peron.clem@gmail.com>
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
Orange Pi One Plus and Lite2 boards.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 62e27948a3fa..bd13297555ab 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -55,6 +55,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
-- 
2.17.1

