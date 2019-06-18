Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610B5C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FB620673
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="txKOyGl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfFRHFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:05:20 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33639 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfFRHFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:05:20 -0400
Received: by mail-oi1-f196.google.com with SMTP id q186so8325980oia.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qy2FdR6Glct2vKzJvpmQSCzJgy5iEEmaOujs7pDw8GA=;
        b=txKOyGl5liwOrHwHqS2y2mJP8cEAM78gyygiX00CliWDz6qGxGNqNLaI0IG40Ubte6
         dwib17D3CUTO1QHXmNrenNhpQbKksG1Xj4A1LymqmiYp9wnKSadK5xTbq++TY0KawAqy
         rNcolgypU2uUX7pP8cL1IuKBcQGL6a8/YpZ+Rl/J3iqLapjNb7ckxwQLjYPQC9PHx14G
         YJHN86dCj3jNpF8cMN3j8pMStWU5BMB/O3bZwJhogFpINSwsByfimmbiQhw4UZguHOiB
         PZFTKn89HPPYhDqP2v+E90CW9K3tTpUOazXAtiRlnXwJiy5P38/Jr0A3RzYpIeOpAvgY
         IAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qy2FdR6Glct2vKzJvpmQSCzJgy5iEEmaOujs7pDw8GA=;
        b=uELfoMdCsP7mmRDCIxBGF2UEUet/L4GG/VsS6hTuGaxiCoFpv+HylZqovmTlEFyKNS
         Wsbz1sFFMW/Yhf1Gmffj34cNl86/A/u/3GJY8r6Vmh84IisGlBr8NzNj+gAZoj27UTcw
         2dmjec2f9SojWaVGe0bGM403MlSYMTXjuGdtlqE0fnPeMVDdoPDPqx5tVe7q32ogCLUf
         KsE73MS5Gqr63DC102reTHZ+tcBxQ4sS5PGFIEP76aC6xfaP775jhQt5L/I6Y7ixOI37
         n2t8nEuTh8Ov1YuDajWy4rzyFaCnxmuuP2SkWMPumn2lzHHxhQBlj2EVkHFLT9tJQ6FN
         UYSQ==
X-Gm-Message-State: APjAAAVQGmgu84nTIQyDkLL4A++puld9w/3OSHf18FEWwsu+gGTsr4IA
        2j8nDdsMlp+NoWDFlqFjDhX1w+UHB3U=
X-Google-Smtp-Source: APXvYqwabpjxe1V064XCNOyWH8q4caObRzcly+FAT/rfy5W97dlFHwq5/HtzdJi92MY/4evDYT1X7g==
X-Received: by 2002:a63:224a:: with SMTP id t10mr947130pgm.289.1560835550760;
        Mon, 17 Jun 2019 22:25:50 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i133sm10011704pfe.75.2019.06.17.22.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 22:25:50 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] arm64: dts: qcom: msm8996: Correct apr-domain property
Date:   Mon, 17 Jun 2019 22:25:47 -0700
Message-Id: <20190618052547.32376-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The domain specifier was changed from using "reg" to "qcom,apr-domain",
update the dts accordingly.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c934e00434c7..1a139cfb240d 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1831,7 +1831,7 @@
 				power-domains = <&gcc HLOS1_VOTE_LPASS_ADSP_GDSC>;
 				compatible = "qcom,apr-v2";
 				qcom,smd-channels = "apr_audio_svc";
-				reg = <APR_DOMAIN_ADSP>;
+				qcom,apr-domain = <APR_DOMAIN_ADSP>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-- 
2.18.0

