Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAADEC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E6520673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="G+jGjIMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732210AbfFTPBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:01:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38871 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732055AbfFTPAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:00:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so3503969wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 08:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eF8xBGeTljvvRz8oIGPjn0ZgbNxxAvWP0tXIK0uht64=;
        b=G+jGjIMvhLDlHlsS6ZUQa62iQPcD1g9joTMkE88tdYoN0qASnjniGNFYJPZU+MLSCX
         H7EPMSh7fkUYj/ww1ZZ4miAqZl1duvLB+21CLWFEY9BOKNgXt9caf9pxRR0j94gTykle
         oZzT0WdZTg3PVn2yUYMarDfak4tAp1QeolW/5s6jNYm8aZxbPu/oQRZCVsjn8zZDkjR3
         g9qrP/pXJWwTpDIiKG3L5k4I7FRfpiQ4v2MH31zO/f3/tgspZsezciharlR3DlUw9mXJ
         0aaBOLMZUcIGomlBEMSR0QE/fZONdiICEkN1HZ0hE/PFo6spyeh0+0S+2jraLAi9vYs1
         AMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eF8xBGeTljvvRz8oIGPjn0ZgbNxxAvWP0tXIK0uht64=;
        b=oajSdGcQlL6kHwFrWhjxhel/tGXQ2Wf4VTfcZfrpE+FhcywbOFmS95qGYSWFruiW+D
         utpNucya0d49sVfLS5H8acii3JTpoJc5xsT2qXcKHwS4Vl2dy6UMI7zFybdABmZE2oic
         qVGR++mL9UyHVuuWd55SQfAWw6WuItlZe7cphtXFG+ruKzRaK/yD6UEyyjWjwIPX9eDE
         X2vUDpty7lw17AvD9ySd20mHrBk19+RI8i76pU0Wp+QJb8BDGwB7zClxG8KY5Dgupbls
         c3hwvQuBkTYTPWYsRhgwy8fZvP6iaZ0+lBgJlzOcJ3WmZHIY4OXVIR8zn9gS9TSjxp3m
         I2rg==
X-Gm-Message-State: APjAAAUyR906WRjw9uIE/ARE6z6E2N2EzeHrZPPHHrHNV/iZUZ6htSkM
        bq+pTO5TZB2eYGUE5BbRxEfGIg==
X-Google-Smtp-Source: APXvYqyB0M/8J7elbFZ7JqzPsyIKsmt8dD5yRCndjrBFTtmLDZMEgDCJQgbv0JCT6BR9I/9CVeq96w==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr56296wmf.154.1561042831759;
        Thu, 20 Jun 2019 08:00:31 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o126sm6802520wmo.1.2019.06.20.08.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 08:00:31 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC/RFT 10/14] arm64: dts: meson-g12-common: add pwm_a on GPIOE_2 pinmux
Date:   Thu, 20 Jun 2019 17:00:09 +0200
Message-Id: <20190620150013.13462-11-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190620150013.13462-1-narmstrong@baylibre.com>
References: <20190620150013.13462-1-narmstrong@baylibre.com>
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

