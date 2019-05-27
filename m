Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6954AC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D232133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="U3aDFZjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfE0NW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:22:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37787 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfE0NWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:22:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id h1so2789501wro.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4VtDGZ3OVSVw6HZggJOqUTRYqY5ZUaLIQ9cwARYH99A=;
        b=U3aDFZjkZXFYe7wNf6AFeyb2CzT8QJzBjLaQiB1ybT58exOolffDkQZVEQs9IwqDlR
         QupHWofac4pMpepiaHEoTBoAoDbCYUXpGZXPIAHJVsg6zrVjb/cSCHRMpR6uLZMrAIWk
         6rBE8L+83X9MjSsf0nrI/eChI1+CYF18c7AFPIb/WYqBGhWRRW4wCj9IwngIHnLdodiD
         vJcNQV1d2auvf/HD178QOgLZxp/OqkiTLwo7k2i+po9wNsk1Vih74NuIrIR3bKMaDjOQ
         clJSY0WBe8PP72dtaaKri3ykd9nxXqPJnaz84BsPl6+rXtGdeqp0Pso3z9BhRNexq2PC
         Yjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4VtDGZ3OVSVw6HZggJOqUTRYqY5ZUaLIQ9cwARYH99A=;
        b=lHcFAYjuVnQKwGFPP94Z0Je8NzHWgYXzNKWCqX3MyJsaXTfmWDJUEl03XVDaCdSa16
         +jviDezucl8GPCR8M6nbAoQnyoDu6ENkGmdfg2z8zBmczrJpBS0IFiQwrp8VFX3POHbl
         wKJszjl7x01ZiXm/6exnN2E6L7ilK0ssSvxEulI+GqQLJir+eKnhVGRp7aaxeGoru7BL
         FYoopxt+XoR02/Zo/cPqGggBNFZaVvcrrVf8aN0+c5cAbRUieYFBOMiNYFk01uTweWyA
         sXAnHuAWmP/350C8Y21J+JCaMYfdIZc0Of1r83+cB/O82YiBLBcAYQSnvozOMwpBbiPu
         PSmg==
X-Gm-Message-State: APjAAAW6CG7rBAuOIbZoOt2vBqL8rA25baZpu0qp83lEviCmqnDzCw9x
        3c8s25FV5lldEXb3ncs53fbdgg==
X-Google-Smtp-Source: APXvYqxf3k/7Wb+ZKnTinne4Kei3iMcPjtfcFlS1vpIpQ2xmpLUmTWkDcbZC/+3pmja1wPjdeR5u2w==
X-Received: by 2002:adf:ec8e:: with SMTP id z14mr45794613wrn.198.1558963329516;
        Mon, 27 May 2019 06:22:09 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l12sm7019836wmj.22.2019.05.27.06.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:22:08 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com
Subject: [PATCH 08/10] arm64: dts: meson-gxbb-vega-s95: enable SARADC
Date:   Mon, 27 May 2019 15:21:58 +0200
Message-Id: <20190527132200.17377-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527132200.17377-1-narmstrong@baylibre.com>
References: <20190527132200.17377-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SARARC node and associated regulator to support reading the
ADC inputs on the Vega S95

Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index be8799653ad7..4d2aa4dc59e7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -54,6 +54,13 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	vcc_3v3: regulator-vcc_3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC_3V3";
@@ -152,6 +159,11 @@
 	clock-names = "clkin0";
 };
 
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_ao18>;
+};
+
 /* Wireless SDIO Module */
 &sd_emmc_a {
 	status = "okay";
-- 
2.21.0

