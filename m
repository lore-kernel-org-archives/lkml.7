Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7999FC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE9E20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cL1Ntde5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbfETNOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:14:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52153 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387510AbfETNOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:14:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id c77so11784841wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lReW9FwIxGx99lS6OVany4vLdxVRsXpnnou2eAJ8o5o=;
        b=cL1Ntde5vZe7svHI/Cm/TL/KzQ/1U7+O5qc3RSo1jBiQ5WFVAVlo47xIeIWw4o1MT9
         6Uxbqzm4JY8oOTd3NEn4WeW13iP5oAvTL6zuHSt6MlUfZXcoValiVlO4edsUzVjzuGWS
         kZzYGJOxjSfWy4oUd12HSpbjf4AIJJj6bV0EPiivdnVnDTLGDcYSo+g6lJQczIfpSZRe
         f3HverTOO1mWacxayDIvEF2ukEv7eOPVOKI7xWlff3MHqzCkFdqMc3MhyZTYadJPVsB5
         kZskwKT3Preg0ztqIvxwjvIxt1FrRBIICOspRaiV1RsLsVDwJwEKrko2+FXCvIjPbGA3
         t6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lReW9FwIxGx99lS6OVany4vLdxVRsXpnnou2eAJ8o5o=;
        b=DejDuRewGGzcngyStIH11wp4xUNveW/NLs+rkC0QbP3ZcVa5upmwympuRNHvMe/giU
         g+u9IOGYG+OEvmN9fRuw0lEac6P4ERypEge+G+0mvQHc9ygJVjuhyLvcvgvr0BMne204
         94wcMWVwPDLm7VTAuE96eD4f9ztiDKdGNk9EY3PfHa/EqavMpa5hQYr2nV3c/FLT4/T6
         Bqbnqye9Iv5p17KGQbkwAQNEmC9doTkU765tYjSPRj1KkD92Tn1H0qmW93jrSLpB+u3g
         9IoJr/aqR3QHIS0b9J8k3izd4/RRs/2WYFtK39ywkD3sqWVFq+nDI0gKpzi8q3zDDlTJ
         c4kw==
X-Gm-Message-State: APjAAAWd60eYYWPQD29FTZiVcG5QkElhGRzkp3+hngd68mnRBZ/TTsX0
        hFpeUNeB20FnQV9va/pceNL/h0n0Nnw=
X-Google-Smtp-Source: APXvYqzPKMGyx8ohUrx0UtG4Ku77wfZ9Z4PiWV2gxTjRwttAxpNy4fYX6jPVIUrbyVlEfTQJyUwPag==
X-Received: by 2002:a1c:7518:: with SMTP id o24mr10885489wmc.42.1558358052308;
        Mon, 20 May 2019 06:14:12 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z8sm18054284wrh.48.2019.05.20.06.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 06:14:11 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] arm64: dts: meson: u200: add internal network
Date:   Mon, 20 May 2019 15:14:00 +0200
Message-Id: <20190520131401.11804-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520131401.11804-1-jbrunet@baylibre.com>
References: <20190520131401.11804-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The u200 is the main mother board for the S905D2. It can provide
both the internal and external network. However, by default the
resistance required for the external RGMII bus are not fitted, so
enable the internal PHY.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index e02534ab7673..8551fbd4a488 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -15,6 +15,7 @@
 
 	aliases {
 		serial0 = &uart_AO;
+		ethernet0 = &ethmac;
 	};
 
 	chosen {
@@ -150,6 +151,12 @@
 	};
 };
 
+&ethmac {
+	status = "okay";
+	phy-handle = <&internal_ephy>;
+	phy-mode = "rmii";
+};
+
 &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
-- 
2.20.1

