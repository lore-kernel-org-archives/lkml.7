Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77323C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D5C2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rTy9XcjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389227AbfDRNwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:52:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43811 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRNwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:52:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so1143275pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f6u0NsaHuXkBa0FvVxI82I2fZsIMvs/TpAdd6MlVacQ=;
        b=rTy9XcjPrpwDwKG+V36EeMbFaV4xL3/EDThtXHBG7qfPOojsQBlpaYv1y68XelzPNg
         9q5X9J5E+lp3SwcBpvGTfVxXjdYOMf8xbFwlaAL0U206m6UluHX28Ud7TbgqvjtwGmJI
         HPN8FbBotEVjzTk3fvef39qG2hKWCiz2+5cBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f6u0NsaHuXkBa0FvVxI82I2fZsIMvs/TpAdd6MlVacQ=;
        b=J5jCohtPcS+Np0sEHjPVnpQltM38aI3aV7MqgHhi+tvjzA0fJB1pQOd7UE5Rj+ecAw
         X/CEHd7LB80qib8JrR1jS2ta0yj7xgN6cJFdLoMVD3XTV2q7hncR638TxT5ZJxp+JUbL
         rsY+PJawn/Fwmb5PnbE5WRhI6BsqFmke/XG4JrPEl3MXv0RFXrxzENeQhw08SfF1HpAR
         X62ctu7gZjOGg0mgoavozpAELV1W8MxPIkgZjPpyaZBNxF/AswPbIB+SpMZgtqsC8/fP
         HP6gzI7ReOMLLt89NK71JOuRjopVX7Ah8ejjkD4mHennU+6tKQTbH3cI4beLXDHtWlD+
         YI+A==
X-Gm-Message-State: APjAAAUJ9oANo30+ZHZKTdOZfggKG6jqEvjX6q8LqDpP8r/qyiGwH7Wu
        LKa3jr3U2vhn5R0LecFBuPM7xw==
X-Google-Smtp-Source: APXvYqzltQp54VEaBgATxKz1OzJZ9mn1NuEw8wRg0+pRH/RIBirGYOn1UhLKi3kdhlAcV6VtGYulpg==
X-Received: by 2002:a65:410c:: with SMTP id w12mr3735801pgp.268.1555595563362;
        Thu, 18 Apr 2019 06:52:43 -0700 (PDT)
Received: from localhost.localdomain ([115.97.185.144])
        by smtp.gmail.com with ESMTPSA id c5sm2357861pgh.5.2019.04.18.06.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 06:52:42 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 1/2] arm64: dts: allwinner: a64: Add pinmux setting for CSI MCLK on PE1
Date:   Thu, 18 Apr 2019 19:22:31 +0530
Message-Id: <20190418135232.9368-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some camera modules have the SoC feeding a master clock to the sensor
instead of having a standalone crystal. This clock signal is generated
from the clock control unit and output from the CSI MCLK function of
pin PE1.

Add a pinmux setting for it for camera sensors to reference.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- add /omit-if-no-ref/
- add pin name as csi-mclk-pin instead of csi-mclk 

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 728f70018c51..8c5b521e6389 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -595,6 +595,12 @@
 				function = "csi";
 			};
 
+			/omit-if-no-ref/
+			csi_mclk_pin: csi-mclk-pin {
+				pins = "PE1";
+				function = "csi";
+			};
+
 			i2c0_pins: i2c0-pins {
 				pins = "PH0", "PH1";
 				function = "i2c0";
-- 
2.18.0.321.gffc6fa0e3

