Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2772C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED0D206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="b8nluRDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfCRJ72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:59:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43020 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfCRJ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:58:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so16254410wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYk3r0leNCPgpCAbWkPSi9BELgwJXXTm0j6LgXKT/hA=;
        b=b8nluRDfQBz+bboGy0UiNEqclvnEeVbVctSZaHhFe/Q9qNAXqgQ51yX30VbxSaMjon
         MfrXSY7YJdKNSNW8hOtae87IG0O4MG2e/YXh5HJGtoGzpdoDS4c5c4SabKF+YLi1MSO3
         aAFWLMmqbfhdDVepMAZTDGhsL8EM5EVH6VT47EktalHiR04epUHDdd+9wKgowVXvwU8s
         x8wOPNTKQp7jVmAwMNmPLnqWl6uugexMzxtvJxFe4jtSaGimfxLIkElUAgJvxFSqzS32
         LfTou7sgC8cd0NOYNP3snodb4Ltw0piahFiDKKyoarQuJ1Ml/phwUmbhN3thhyXVKIOY
         iIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYk3r0leNCPgpCAbWkPSi9BELgwJXXTm0j6LgXKT/hA=;
        b=ZchwVVljPdowdaEqoo0g5KhT7gyQRg75gl7OH1tuir6wLqKfWqVo6HsPF40+QodAhF
         pLr53tiZ6iZE0QuUuy1Yq+tumJfcaodAeNzlYGkKWxA6PlN+7naTmnH3lIGtGJHLlr1p
         f6GaHnDJ9cE+h4C3Q4+CWC9u37TOgrnVzw8jIyVE/OYvbpqgDvxem8PxJ6oHs6wr7nMO
         41KO6eK4i0A2gE2PFtxQF8PMsVgEeTf1z+NEwcTdxdv+MiVyJijJMLFdmuv+ghaE7yyG
         wIU80N+3g6Hx5xONfy2dfV6Vtyg9CXk4yTlp+PvYEHxR4IOkb01yynwVgLTyxW9Fg83Y
         p/6w==
X-Gm-Message-State: APjAAAXaQPXsZCI86dntN+pEEi7VBZgt7+zfog0gVzIyjw4fzCqLOANd
        UjlUligq4EHrUsitOCv/t2sYH8nK6MjCyg==
X-Google-Smtp-Source: APXvYqz8zOxVQ8CAD/r0m6E/P/9f4qcx6BqOioj4ap08rp70H2iSLneMuNNn5Iw3uzoCI7+asc1KLQ==
X-Received: by 2002:adf:c002:: with SMTP id z2mr7400895wre.177.1552903137288;
        Mon, 18 Mar 2019 02:58:57 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g8sm5459034wro.77.2019.03.18.02.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 02:58:56 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 3/8] arm64: dts: meson: g12a: add uart_ao_a pinctrl
Date:   Mon, 18 Mar 2019 10:58:46 +0100
Message-Id: <20190318095851.4062-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318095851.4062-1-narmstrong@baylibre.com>
References: <20190318095851.4062-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

Add the always on UART pinctrl setting to the g12a soc DT.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index e050737a1b3e..7023c1c0f23c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -179,6 +179,24 @@
 						#gpio-cells = <2>;
 						gpio-ranges = <&ao_pinctrl 0 0 15>;
 					};
+
+					uart_ao_a_pins: uart-a-ao {
+						mux {
+							groups = "uart_ao_a_tx",
+								 "uart_ao_a_rx";
+							function = "uart_ao_a";
+							bias-disable;
+						};
+					};
+
+					uart_ao_a_cts_rts_pins: uart-ao-a-cts-rts {
+						mux {
+							groups = "uart_ao_a_cts",
+								 "uart_ao_a_rts";
+							function = "uart_ao_a";
+							bias-disable;
+						};
+					};
 				};
 			};
 
-- 
2.20.1

