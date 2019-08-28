Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7F6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A4420856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmauFG49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfH1U1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:27:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34285 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfH1U1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:27:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so332469pgc.1;
        Wed, 28 Aug 2019 13:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dkXX5TgiTvbmjZ2s48sm4xiTslbHfT/2Tf1RMDcUMM4=;
        b=lmauFG49VNHXeEHXlI8hUJynuUqS3GWxNpN9EIvomJl3C9ApBZzLH/erJcW6rTzdgw
         Lt5iL4SbrD/pv4FYJSvMNDc5RoBBFqvCnChz/nyFqV6jaIhuund/Km4eDj7iZsoa1cmN
         zw3ru34EDUQ7Hb/P8ut5dyDuh8XNHF+4tq/VaNO/GgEHvLSCk6DAK77CBeoS1WOh5Vvg
         /wknMk9qtIbldZ4WMagQ1WgWEQOTyH9bJJNU0kT0m3YbTPS+BN4q+qu1u0I1fsAYP3Uk
         FmgwNwr30tTw6lbv8nhaVxImkRrYqQn0RwsnhBYyXPQSR6aS0EaqFUyHuK6oJ58t9FgV
         dSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkXX5TgiTvbmjZ2s48sm4xiTslbHfT/2Tf1RMDcUMM4=;
        b=TpsGz9394kelTSTRqIYRd2MTocVYBJQLF0+g23Z4OaMV9pR2IZokk6ahZvdE5Gq8Ui
         d5Vmj4uFpiKByTPEhSdAiQMkr/XXth4k1Qas80pS+ILDtWmlBY0O+vnkK/o2Ft6Mc21i
         PzyM4wyaIzMyHzgQnt20dItyf5QTDPRduLKXeB2k+NOivtoQ3EPK9aeRk2UgIcCEwGud
         1eNss0cTG9IA6wKNAesGi3/5n/mt8Ml7E8C72G9rmag4XE0WsvCYDKfRaXRgIE+NpyvB
         ts3/CSmzpVt7rT0NvW6/RJk6eiByRZASp2/KlwiVmBbnHqEi52IdbQvOqL6OA62mJIEh
         iW0Q==
X-Gm-Message-State: APjAAAWnwT1Df4kGcUnjwZ1lqrMyiXToSstMSdyR8PPJZfSd8yTMvE3E
        CfdASjh6r3kpqk/ZCWzrncI=
X-Google-Smtp-Source: APXvYqzh2Ahi+YBjudkc/D6a3Rt2lT3vtzWfy3Lwr8zSzRTJ1DJR4wGqglvYhUWpr6KYMJNbz3+Mtw==
X-Received: by 2002:a62:641:: with SMTP id 62mr6804168pfg.55.1567024064309;
        Wed, 28 Aug 2019 13:27:44 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.111])
        by smtp.gmail.com with ESMTPSA id g2sm253373pfq.88.2019.08.28.13.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 13:27:43 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv1 3/3] arm64: dts: meson: odroid-c2: Add missing regulator linked to HDMI supply
Date:   Wed, 28 Aug 2019 20:27:23 +0000
Message-Id: <20190828202723.1145-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190828202723.1145-1-linux.amoon@gmail.com>
References: <20190828202723.1145-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per shematics HDMI_P5V0 is supplied by P5V0 so add missing link.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index a078a1ee5004..47789fd50415 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -213,6 +213,8 @@
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	/* AP2331SA-7 */
+	hdmi-supply = <&p5v0>;
 };
 
 &hdmi_tx_tmds_port {
-- 
2.23.0

