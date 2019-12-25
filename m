Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7604C2D0D2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 01:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F274206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 01:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tSNOIM69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfLYBGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 20:06:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39599 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfLYBGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 20:06:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so20912569wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 17:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1v1/8y8CUDSaeLfYYLYF1rkrU5gMM13TJol/uHd2tC4=;
        b=tSNOIM69MMOjJH/sfNVJOpLIcVsK8HZ+NzFyxnKHHVIu/FB4hvz4tuuBEltwjcl7ek
         BxKKUDg6hWQKBSaEpmZ82iYKhncIZI4O9UkjUbDxbrj7kHw7uVzR29Z0gfgRFuNydkwm
         Zx4Mrz/a1haEYLzEeM2QT9T1QH2HmKhs7epXupdK0F70RLMB4Uoi1L0hL+cY0vrLdaey
         bbb8T1cHWNG6eaOnBlrGJGQzppWfZkoQ6TrKdbaxar6HTTXn/cFiyPJV26qmBCVLDmin
         1Z/9AHK9x+dZi2f44nd5TBTaOFaDZyHw/ncx4Ej1EedHT6/oLwMostEqduVaHlqIy71k
         NHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1v1/8y8CUDSaeLfYYLYF1rkrU5gMM13TJol/uHd2tC4=;
        b=bQoWhjMVGbocytEDL0tJpIROAX+Wsd/PBIQjk6jxf5zQigu7E4IY8pb+1yfsQH9BxK
         Ln69r20k0p6wJhquBo/9pkMDyaq9n8GTKBbTv5RgcaTfM3XYdbW7vZDt+D3biM+Rt0nr
         5VZWY+uubNNcOvYDPKNwPDssrPeOv0XLoXdfRyA1iaicQv1GHAusD1kknRblRMoEhCoM
         XyFOfkUBS999OxZqzxk+ij6HkxmLt+pQwZrvKIC0eS93AuEwee8CWprb7Gw4WCJwu/Pl
         Hn3TNP7xGpt7WGpwV2Pye53ydkn06gvWj5PFK5gfWC22b2UsNkBq0vmKTT6jbFLJmcox
         yQHw==
X-Gm-Message-State: APjAAAWHnxOr5hR9SMlYWy6BCwpwctXZa8pgdx9sA/4Y0uS2e8R9JvXc
        Ksnml2GUDeMdWfjufQzQAHo=
X-Google-Smtp-Source: APXvYqwal9Dqdu1QdR5DDgMywNyzalC84bZXRuqTVUKDZK0qWD4Ca7MSdgLlEk510rDzH8ntqBIw8Q==
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr4059081wrs.303.1577235982476;
        Tue, 24 Dec 2019 17:06:22 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id x26sm4066127wmc.30.2019.12.24.17.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 17:06:21 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] ARM: dts: meson8b: fix the clock controller compatible string
Date:   Wed, 25 Dec 2019 02:06:05 +0100
Message-Id: <20191225010607.1504239-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191225010607.1504239-1-martin.blumenstingl@googlemail.com>
References: <20191225010607.1504239-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Meson8b clock controller is an evolution of the Meson8 clock
controller. The clock controller on Meson8b contains two identical mali
clock trees for glitch-free rate switching.
Use the correct compatible string to make use of the glitch free mux.

Fixes: b6db3936f2833c ("ARM: dts: meson: switch the clock controller to the HHI register area")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 8ac8bdfaf58f..5b5791924753 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -442,7 +442,7 @@ &gpio_intc {
 
 &hhi {
 	clkc: clock-controller {
-		compatible = "amlogic,meson8-clkc";
+		compatible = "amlogic,meson8b-clkc";
 		clocks = <&xtal>, <&ddr_clkc DDR_CLKID_DDR_PLL>;
 		clock-names = "xtal", "ddr_pll";
 		#clock-cells = <1>;
-- 
2.24.1

