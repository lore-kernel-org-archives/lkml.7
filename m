Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5576FC04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CD02080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="myoH4NG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfEBWyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 18:54:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34836 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfEBWy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 18:54:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so1719396plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 15:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BCfT3guVZby54KoAuU06+BY6v/qUrN3VwEkT+0PJiPM=;
        b=myoH4NG/U3H7QRfzmXh4KXBkwHqlnBXLuw+YtDbLUP16dgiGTtAys0/bk3SYGDdI70
         6K+XsQzwdrj70SZjh8KM5efvveW/76bJR9i09nnkUlZn/ZFw1ZqUNUvi7N6yAStsPwSx
         uiRq7YcNI6KCMxbDCNVDo5hZeJamSb50B5Czo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BCfT3guVZby54KoAuU06+BY6v/qUrN3VwEkT+0PJiPM=;
        b=iJ98ezYikTBzP6Sm2ZtLWFFmYwjmeEDYw5nrRVC3q6cxMmGe1QAFU/8xYL9HSexwup
         n1kCUgCNq7UC4Yf48ypXFcTdEUCFk3hnJNAMoaat7t+hDKMGIEjisUkFASu1AgiqkuCj
         GLt0WjreuMF1n4N88+ekwNWTcqI2OjeSoYkgo63bppy9KIG9diJxe2ICtELKoSbmfN9H
         lDaRWdGZ/GsJCbEew1dY/TgaaU/q27YSU7hnJ0aCbMwAOLVCzXqpGoksKowYRvv5wnjN
         lUWH7KGcu2Vsip688Sr1z4HxyvSrjUi4M+7NZm4INbtznSvzyAvkD6SRG20yS+wnxCy9
         dG1A==
X-Gm-Message-State: APjAAAXZfvfBzH9EdQ3VDgQavVtVsf97fVB3kEZCoOXLUOY+7Guu3Z5C
        pITK/52Rs5GrtSotc9if/zAFkg==
X-Google-Smtp-Source: APXvYqw7cw2KkNl8Nu4qGTRrZSO9BSZbc8Jug59xzytFinnS0nDNEMXcfMRtFwgbTp5rGb5QpsTCQQ==
X-Received: by 2002:a17:902:1602:: with SMTP id g2mr6499886plg.325.1556837666467;
        Thu, 02 May 2019 15:54:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id v15sm264736pff.105.2019.05.02.15.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 15:54:25 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] ARM: dts: rockchip: Switch to builtin HDMI DDC bus on rk3288-veyron
Date:   Thu,  2 May 2019 15:53:34 -0700
Message-Id: <20190502225336.206885-3-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190502225336.206885-1-dianders@chromium.org>
References: <20190502225336.206885-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Downstream Chrome OS kernels use the builtin DDC bus from dw_hdmi on
veyron.  This is the only way to get them to negotiate HDCP.

Although HDCP isn't currently all supported upstream, it still seems
like it makes sense to use dw_hdmi's builtin I2C.  Maybe eventually we
can get HDCP negotiation working.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288-veyron.dtsi | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 1252522392c7..e1bee663d2c5 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -163,7 +163,8 @@
 };
 
 &hdmi {
-	ddc-i2c-bus = <&i2c5>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_ddc>;
 	status = "okay";
 };
 
@@ -334,14 +335,6 @@
 	i2c-scl-rising-time-ns = <300>;		/* 225ns measured */
 };
 
-&i2c5 {
-	status = "okay";
-
-	clock-frequency = <100000>;
-	i2c-scl-falling-time-ns = <300>;
-	i2c-scl-rising-time-ns = <1000>;
-};
-
 &io_domains {
 	status = "okay";
 
-- 
2.21.0.1020.gf2820cf01a-goog

