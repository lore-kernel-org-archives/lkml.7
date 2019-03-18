Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898C2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5871D20693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="byqOkFPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfCRKFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:05:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33681 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfCRKFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:05:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so1757130wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l4lB+A4NpMmoBfDCc0H8yeSl4aEUFbhEf+MpsV/sM+E=;
        b=byqOkFPIOilU2z0se+NOCtFSnZjUM8EL67m8TACubdxgrGRXTSIpYz/9Yh2GMzicNK
         Fdg1XPXfbAD2h6eb4mBaCbIJv9C/rBEg9Qxu8bXROvWuFedcgKHgpVw0jquyKrE7UrRI
         EtwKBMJqD4+yBWEixq+Lu2fQ9IGWJTt8Jf/PQ2RW7Sv8oz9PrOLpNkg9zVcISIPqjLAQ
         Zl1TWCxtVM22LrKbBT4UN1hbh7WkPFTaX4ShpcPBewfYasvBwDfzJZ3j0dY+yzImxCNE
         ZaB+22JrrDht/R0cGUp86DtOpwaPJbOu3NUOJX/JcIAlmNvEVA7sDvAobdSV5V3nXfyO
         mS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4lB+A4NpMmoBfDCc0H8yeSl4aEUFbhEf+MpsV/sM+E=;
        b=L4p7x2FFt7iWUsfh3U70w4/azE/04P0JOnrmDc+Kf2xXg5nE/Nx9+5Hf4NSz42eejq
         kThHifiivQYcYnUsfEvuYw0hEDLdqgaqHEsFZD7CrwhtwgucWo0JGzZEKkW7MTJwnrXF
         fOQ8rkSS+o6ZLGcaK8duVSdVK4fiBBiQj5Lhc5xNoHYpblb22QkAP+pyx4UV9F41Ea0D
         L2vcMPbOapitObTXY0SHtUNTs+dk5BjN4N2ri9gQHg4bQ5PI+j8IskYlA5/a+pdPH3GV
         siCDQnY3pHDRMlE+adYHfd24MO10Cm781+UQs/D8U6Ign2QN1qBrkscGzO2ytewYo+4Y
         If7w==
X-Gm-Message-State: APjAAAVPxSiyESdIIwa6SphA/wRo6sDTgzCp/gzksho3WqMe6opYH4hR
        uG2B9UCpw3ggip/phntyFbkjlw==
X-Google-Smtp-Source: APXvYqyot5ZvVxet/erVaABn/qqOji/jAmi82itVHtOpYI0u2yg3sNOlkhFoZw/AtCIwhjWSOdqRgw==
X-Received: by 2002:a1c:1a46:: with SMTP id a67mr3702308wma.21.1552903503069;
        Mon, 18 Mar 2019 03:05:03 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i11sm5216800wrp.40.2019.03.18.03.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 03:05:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 03/11] arm64: dts: meson-g12a-x96-max: add uart_AO pinctrl
Date:   Mon, 18 Mar 2019 11:04:50 +0100
Message-Id: <20190318100458.5619-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318100458.5619-1-narmstrong@baylibre.com>
References: <20190318100458.5619-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl on the always-enabled debug UART AO.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index c62d3d5706ff..0edbd00b358f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -25,4 +25,6 @@
 
 &uart_AO {
 	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
 };
-- 
2.20.1

