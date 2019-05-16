Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9218C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFB42082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ayq0D5zU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfEPQ3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:29:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42952 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfEPQ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:29:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id x15so1876861pln.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FOE0cCJQ21ga6g1DChuQ/Qq1kToyjWkdfWiPelD2OC4=;
        b=ayq0D5zU19MEk0xwhDehYCYeWHoQ08w7g7ZjKSj8+Z7ap0fNQU02iAUi4BNKUwMN5E
         DaDZsXTk9ac1bORDTuN/XFIeLq4ziTrZmWcEcwPx47BLpRJ937gCOyNca6DcHHrXlOI7
         n3NMuXxbDIDHBpYxtnrBUtgjXrYN73x/nRozw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FOE0cCJQ21ga6g1DChuQ/Qq1kToyjWkdfWiPelD2OC4=;
        b=Tsboz/UsV82SYMJarO96a7reXybKOkU+6AQJt5Q/5Iv6d6XkqCofroTQq1ABn/zsOk
         8EO1ZEYIRJCHIUhcfWO6p7/X5tL2V1ybUUlmAYYWjArisH+P6+Yimfes2Tp3xa6HDNDb
         84or7zWYYNYF7XhtNKLC8ydM5QU+Gkls/dwzeEMiw9ezrXzbLqQdumAKYSa69wOSNxnC
         Sm7E7Tux4aX7yB3JpPy4soVCFzPdoxUbxreGDZc8T8brTwWBgxqzOFjqquDVchQ8z38G
         SrN1qO0AvgVAhNP+El9O6nmWJk6qLskQRWS5Rd6di9rQzGmQKdY7V71oG3uPrG8ljujg
         DnLA==
X-Gm-Message-State: APjAAAXwh8pTp3uAk8Hf/5IMgXDju0t+wlIr0fv5AlfK/MGLq9LihSgk
        HMXDcKXzDcZaukANbCdUooeZnQ==
X-Google-Smtp-Source: APXvYqxrvwtoWK8QdXNAIVHAwc7IGRNSlG4OKmttVtrCs4o4+DbqSeo4gMHXIbJEH9AVCcAMyz3k0w==
X-Received: by 2002:a17:902:8a83:: with SMTP id p3mr51848281plo.88.1558024187640;
        Thu, 16 May 2019 09:29:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id g128sm7168645pfb.131.2019.05.16.09.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 09:29:47 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 1/3] ARM: dts: rockchip: raise CPU trip point temperature for veyron to 100 degC
Date:   Thu, 16 May 2019 09:29:40 -0700
Message-Id: <20190516162942.154823-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This value matches what is used by the downstream Chrome OS 3.14
kernel, the 'official' kernel for veyron devices. Keep the temperature
for 'speedy' at 90°C, as in the downstream kernel.

Increase the temperature for a hardware shutdown to 125°C, which
matches the downstream configuration and gives the system a chance
to shut down orderly at the criticial trip point.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- patch added to the series
---
 arch/arm/boot/dts/rk3288-veyron-speedy.dts | 4 ++++
 arch/arm/boot/dts/rk3288-veyron.dtsi       | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
index e16421d80d22..ab2a66aa337e 100644
--- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
@@ -64,6 +64,10 @@
 	temperature = <70000>;
 };
 
+&cpu_crit {
+	temperature = <90000>;
+};
+
 &edp {
 	/delete-property/pinctrl-names;
 	/delete-property/pinctrl-0;
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 192dbc089ade..58dc538b5df3 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -99,6 +99,10 @@
 	cpu0-supply = <&vdd_cpu>;
 };
 
+&cpu_crit {
+	temperature = <100000>;
+};
+
 /* rk3288-c used in Veyron Chrome-devices has slightly changed OPPs */
 &cpu_opp_table {
 	/delete-node/ opp-312000000;
@@ -371,6 +375,7 @@
 
 	rockchip,hw-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
 	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
+	rockchip,hw-tshut-temp = <125000>;
 };
 
 &uart0 {
-- 
2.21.0.1020.gf2820cf01a-goog

