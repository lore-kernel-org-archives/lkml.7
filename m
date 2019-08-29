Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D764C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405F622CEA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vSraP6xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfH2UDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:03:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35413 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbfH2UDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:03:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so5070697wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 13:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p680zAEryobKlt4lW3L6CDRlAanEpxTFkLsO4D5mjF0=;
        b=vSraP6xrw5G/N4zBQME8wvMKp2bSNx6/o6PF97n8Wb9WL6K8mrsLG5h96E7t1zyzo0
         uV8gLIzWQNCNLTZP72+mnB5U+B/dFXuz/iNHmdCx/f6SMZw/CdELkIfRw5zK2BOl9bsZ
         4UW7Ih7x0utEorDXwoOG5eXTafjn5xaJGH+bDPCHdpqGtFiQePDCIHMqNVvNT0pP1Zvy
         wL0kTgU3yyvt+gVOuy1O4sPwF+H/5Aycg6WUIw9VC0nwLVaflGZZ4LqAFU9R0mluJKl3
         qQ2T46wUnWu6C2qpSPyOQJakgsExPvFVcCKLxh93GN5Sty5PhnIY/2hmmLuDUkVS8zXb
         bHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p680zAEryobKlt4lW3L6CDRlAanEpxTFkLsO4D5mjF0=;
        b=VTmOl/3aplA5rwdY4y+QGjki1aONSV4gkRDrFpeksbDWCtkEDF5XYz2aicM8jh6KWc
         qP0elhygtoD+WOiRiMnNGFWVVpOKw86dFNHe8GjKv1zuIN4mQyEkEERmuqslFnihGb9F
         DMq/kSBPOl55ygQsCbibwhW0sW0yDVohbcqvVDQdELcISMIKz1cHMdnvuGiw/u1/oSj0
         b76DPU/BK4/l0o1dxGaZtAOct37tJGrdJwnr7ndjuUoxHJm8thY4H2WhlYS6bfZ/Xwc8
         dqvii7Hnb3z2s21jXSvKxnbcyhJq9ywiUhofZzcDca4A24FeDKMCF/il9OW5oGYCExW6
         8p+A==
X-Gm-Message-State: APjAAAWjsTMlh4UkuFcS9o0D8xh2fLtaFnJUQO8cHPXB3KQ4qV2NbCSY
        uExhegkdWVxqc+F7vz4LGp1Xag==
X-Google-Smtp-Source: APXvYqxEwqKarTekylYsSy42tncYr3cgdA8AaeAKY+NPrXroOaDE+8nIBsqNnKY0aBgP4aku1hqwaA==
X-Received: by 2002:a1c:cb83:: with SMTP id b125mr6655160wmg.43.1567109025744;
        Thu, 29 Aug 2019 13:03:45 -0700 (PDT)
Received: from localhost.localdomain (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id w8sm15584995wmc.1.2019.08.29.13.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Aug 2019 13:03:45 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: qcs404: add the watchdog node
Date:   Thu, 29 Aug 2019 22:03:40 +0200
Message-Id: <20190829200340.15498-2-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829200340.15498-1-jorge.ramirez-ortiz@linaro.org>
References: <20190829200340.15498-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows QCS404 based designs to enable watchdog support

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 131d8046d3be..17d4dd54c53a 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -875,6 +875,12 @@
 			#mbox-cells = <1>;
 		};
 
+		watchdog@b017000 {
+			compatible = "qcom,kpss-wdt";
+			reg = <0x0b017000 0x1000>;
+			clocks = <&sleep_clk>;
+		};
+
 		timer@b120000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.22.0

