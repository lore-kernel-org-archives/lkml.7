Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A660CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDB72084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="e8fUERxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfCKJ4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:56:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43026 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfCKJ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:56:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id d17so4295716wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tgjmXU98UgpESiVAhCUJ94ToSTR4AXwNyUDy2FHUfUY=;
        b=e8fUERxaJOijPz7SdXnJ76K82ahZ10WDqueGGh9r6fekVphkvE1OCzvO2zEMSzZYP1
         yEOVYC6SPOS7WHl1quAeXtHBi0bmf0a1YroxTPlZSLmwczj1xMm37qMDWkkCeZwwzebW
         mm4TsZarlvTHsSFUKCnN+BdbzRqR5+tVlMJOMNk+5rkAqOzGdu9m0VToleZVrML9jFT9
         XuwfLx7oDc/pJZkGVGQI6JPX/lvqbSzVbd5rWgC7fWMq5sch44eWGVmQXl129+mRBYUX
         iIal0a/+CqOTZM1U1MqxyfMWiefm4yotykAbIe+r3aQVzQeezRjn9PKNahgh38O7ZDt1
         e0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tgjmXU98UgpESiVAhCUJ94ToSTR4AXwNyUDy2FHUfUY=;
        b=Hu+8oabPLOUikPxrXDHNnulIqLJBZts/5ta/+1PCclKQcUSB7ujQhaCVoa76fciyAH
         h/LxODzfN9AKqqgY33EMbVhCWW3WMs1PbbYjuV7oa5Zvs7fCrpSna+/URagrJoHKLCSq
         pgebSpJE32PvbJ5jzq1KFgaKz5pAZUG6+jqCYdgaoOdm2vTqHCfIm/moXC6ta3LMbVJ7
         oahS5pweGSGYUfn91TJpdQMDP8FV3qYEoRlXbCgSJe+hh7jxIORNzkjtw67r34yKeXfx
         5yvOLaVPrbrWfi5ghm/qnoT+uvXYUeEoAhrj9E2HQDgSFalak85SU3EIyQBk+qQ/xbuq
         Yc7w==
X-Gm-Message-State: APjAAAVj0n2gkTxqs9IYV6Ze0j3jk/VtsWZldjTDpdGuY1mTi3kJIA4y
        /GcNss5mo81JX9ZDd0MEyHp0SA==
X-Google-Smtp-Source: APXvYqzbhyk+A9wTozxQspxlP7cmicAHAc4YM05jwZvwHHrygXlTwvZlna1hJxG0GZHovF8WvlF13Q==
X-Received: by 2002:a5d:4302:: with SMTP id h2mr19966564wrq.273.1552298177670;
        Mon, 11 Mar 2019 02:56:17 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e12sm4764737wrs.91.2019.03.11.02.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 02:56:17 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] arm64: dts: meson-g12a-u200: add uart_AO pinctrl
Date:   Mon, 11 Mar 2019 10:56:03 +0100
Message-Id: <20190311095613.11371-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311095613.11371-1-narmstrong@baylibre.com>
References: <20190311095613.11371-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl on the always-enabled debug UART AO.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index c44dbdddf2cf..f2afd0bf3e28 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -25,5 +25,7 @@
 
 &uart_AO {
 	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
 };
 
-- 
2.20.1

