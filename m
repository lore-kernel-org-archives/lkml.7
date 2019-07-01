Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84879C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558372145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aE0/HsdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfGAJN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:13:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33042 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbfGAJNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:13:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id h19so14102136wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 02:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iLPdkIIajL0BePyX9s9LXKBvN5QXDWO/1gyRVKFqDN0=;
        b=aE0/HsdUowLdBiwwT5Llzn0yz2Mvoo0fNfQZ5VdqgzbnTVn1ofeKlzTJ7TiheerzSR
         i+0YiHLPhzrVP676eQ/tK4gvqF0+gkZwOPZ9830FpXIbP6EI2Mrsodt46cWtxlIwLMbz
         f+ijT/977kKhzkbELGMiD1/5N5FnkI/58DZwTALokN6CfJEj6z1wc4I9YtYNXd2UqvGY
         dkkVBXAffZVlAgGrsfIRDrzfT7/eVJaD6ETXKzHAODaDrRasdA69TK7QmA3+r21ozjtd
         vf9awc9KkKIal/dK7VuA0RRgM0y769hNiNlgQZI9SZV0EfVUf8YcBhExp7Iubzzbr/Lm
         m5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLPdkIIajL0BePyX9s9LXKBvN5QXDWO/1gyRVKFqDN0=;
        b=rhSluz0K0h/eC5ZuXfMlCJRRozlo98pXfraceCly9bknvhnAV8GsXb/rlAqMx2779N
         LfXH0ciRDWEyXfw3tUb6xLCQEoDyP47HNs7lIwzlFhBgR2yqsD8HTdI+Mmo8KT33odVQ
         n0bTOrMe5MG4hye5m/KS82Q2yincdXen8sU1oHYeyGWTMspTsgGARJ/r5YudbZF+Yrb/
         BlEF6ykAZcZDHT0GL9qgiLh5P1+2rwNVD/X3r3RZN5udcNSJgm86na1jNHtGaLWc7qNf
         QGeMNVva3KDU7Hx/Qv6Vawsk4ALJ3jUg++SVJNunsrEO4tCznoDAP7MmKzcd67O6/+t7
         zFCA==
X-Gm-Message-State: APjAAAUVtdSLmMdp35EIL3WI0v3x0XHFTzXgw+V4iAv7CN43nn5fG6YN
        j1dZbLl2anhFZC6mUkshim3I6A==
X-Google-Smtp-Source: APXvYqw3bjE+2MC197ZVmKI9jTgl7nRMUlNZcDxQsa1ro0kO0ElgRLoXdMMsi1K/ozyeevudDXTctA==
X-Received: by 2002:a1c:7008:: with SMTP id l8mr15428508wmc.64.1561972401463;
        Mon, 01 Jul 2019 02:13:21 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id i16sm6305659wrm.37.2019.07.01.02.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 02:13:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC/RFT v3 10/14] arm64: dts: meson-g12-common: add pwm_a on GPIOE_2 pinmux
Date:   Mon,  1 Jul 2019 11:12:54 +0200
Message-Id: <20190701091258.3870-11-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701091258.3870-1-narmstrong@baylibre.com>
References: <20190701091258.3870-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ao_pinctrl subnode for the pwm_a function on GPIOE_2.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 9f34004625e8..ab8a72a226df 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1970,6 +1970,14 @@
 						};
 					};
 
+					pwm_a_e_pins: pwm-a-e {
+						mux {
+							groups = "pwm_a_e";
+							function = "pwm_a_e";
+							bias-disable;
+						};
+					};
+
 					pwm_ao_a_pins: pwm-ao-a {
 						mux {
 							groups = "pwm_ao_a";
-- 
2.21.0

