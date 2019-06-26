Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C2AC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F2720645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iGiWLvlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfFZJGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:06:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35347 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfFZJGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:06:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id f15so1808141wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 02:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eF8xBGeTljvvRz8oIGPjn0ZgbNxxAvWP0tXIK0uht64=;
        b=iGiWLvlF9SZhluA3F+KAM2/tCHwVb25WwE0mD4s7gqR2aS8FzItv4qoTJ8Iao5iq48
         JaGcJ1DCcq6Q5eL1kVo0OYiG0qZGnLj3xOZOmOW6559WsqekGnFnpodwwgfq7cvmeO5G
         ycFBGVOMHZCGZCe7wrm9mJgOtzcTwg7RneAEhQ1Z6oFfDyPL0bNHHTYbYOxgcukStIua
         7DXFslAO7UTuzF7RjMKOalwvB9PjrMAWzM9dCIfNr12ASjR7BRvyQl5nXcdOMoy5i9xH
         /BgNivTRdSxu4JrnIBNLYf/tg5kZF415nAXXk5+id6Km+clLGLeqUId6zbOyhS+En46P
         yvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eF8xBGeTljvvRz8oIGPjn0ZgbNxxAvWP0tXIK0uht64=;
        b=YYY2UOC3GInweUVZNw+mTvvioxsrI5t8yTiChJSVSnn/hT8JMxBv5e0g8SHuw27szV
         bb/wvVLSodWxjVqf9qA96IiEK/fy0aeEMcGmNcinwFRpuR6uHVYBY1ZEOEeDRoISoUvO
         4y2Orwp9Wf9KbVprgyhAbP9JWp69gZuzdT8TDjXv70LVi7pmjKYaER7ADPg1qh0nDD2b
         0Pdm3bnSTXJG4HoZMqwLXySd3udsNr87zM5wmxAv4EVCyZl+I0+arLy0pH3hBSRcNZdH
         Uz4CLQ52irjgohP3njRPlJY21DHqCBOA9xEZHly+2hSDygPIypOxgOHh8jEJThxK+Tud
         1f3Q==
X-Gm-Message-State: APjAAAXBQ6sa1o/UOaYM9IHwV+ZoSAThPl62LbcV1tl6x9dmVY+g87+2
        AQhQJiA+r38OL5GQOgJ1WWWVNA==
X-Google-Smtp-Source: APXvYqxGIbGVdH3JbhRFGsnQlF9QaGYIVNAf55TKRRbU5nT1JyjtgKrrXt4UH6i4OZuMmo0ITXSpgw==
X-Received: by 2002:adf:81c9:: with SMTP id 67mr2686925wra.62.1561540007306;
        Wed, 26 Jun 2019 02:06:47 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o6sm1925797wmc.46.2019.06.26.02.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jun 2019 02:06:46 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC/RFT v2 10/14] arm64: dts: meson-g12-common: add pwm_a on GPIOE_2 pinmux
Date:   Wed, 26 Jun 2019 11:06:28 +0200
Message-Id: <20190626090632.7540-11-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626090632.7540-1-narmstrong@baylibre.com>
References: <20190626090632.7540-1-narmstrong@baylibre.com>
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
index 2baa04303762..76484801478d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1984,6 +1984,14 @@
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

