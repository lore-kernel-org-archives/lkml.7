Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E58C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC7F23E30
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l31B3A5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfFDM3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:29:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34634 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfFDM3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:29:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id j24so19510889ljg.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 05:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MEMpjywarvEIBpqLOs0vJ3c4H0FioFO5FH41QQdLsTU=;
        b=l31B3A5DK5yaDaUiuO+4HGcagdn0NkvHuppeEAbpodeU9ctKE/fsIFO4+B2QfE/e7+
         G4cnqbrtvFi9AdL7LGafgtKNNbtaQH6MQLkvq7mvfC8wtRHAr4Sv62e9MbAURw95Sb1u
         FqCRGz7XfbCA0quCluQSn7QJlMLjuDlQdrlNEF2mMN1qJU2TFZAwQauDB92Oqd7rwz9u
         0Gyet5i9HEFB/jdW2Raxdn7K/E91xo2e9nhjWC+uuyhTE8vxwD5WAjwSsRPoCAgcICsm
         nJj2IlOT8k03uRjO3xFSFcG5ntXYi3dTqwH+UiVY8aHQJ1BPRGguknNx1ot+0vZC4PHP
         /rhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MEMpjywarvEIBpqLOs0vJ3c4H0FioFO5FH41QQdLsTU=;
        b=hX2xvdfnpuEaJtb8Q5m6007MGlhwI7CP8cZvwxFB5MMN56tO6mmAnLRXsZhWaAbteF
         4uK6L1EfMqD85lpn+sSD57AZ0mmbjy2aeLG8VaGK1lNXUgrPCC0XukmgrEy+yeU1MZ5R
         BmdFL11DhHTff4tp62CWNmkSxl3TA3BOiDqfk1iDLjX3PKw9pUfaaLRft/I9I73ySCcJ
         3cPNFClOWej3jxhgVxx1QXLHoS6Jbla/9CjP1Dw66QSn1ZXxD0Dmb12Q/Tbxg5RV7tl7
         8uWrn+M+HPyLSEgDKmvUJCZ8Rbp5F5cnA+OMrBYSXap6NA+uw0uJsOv21QoUNQt475Qw
         AUTg==
X-Gm-Message-State: APjAAAUXQIQ7oYODMVb8oVhHIeHdOl6yUP3z7fDF9x6pmmeff5I0XOi/
        zmH3LdmPXiTtoAud4gQ+gKgrIg==
X-Google-Smtp-Source: APXvYqwV+FwOVL156Jwgxn4HfmhR4c4RJUEji+CigP/7IgjPiauVSOU7vsxfGGhUtHXXXb6eAGi7BA==
X-Received: by 2002:a2e:890c:: with SMTP id d12mr16520655lji.107.1559651375370;
        Tue, 04 Jun 2019 05:29:35 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id l15sm3754389lji.5.2019.06.04.05.29.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 05:29:34 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     amit.kucheria@linaro.org, bjorn.andersson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: msm8996: fix PSCI entry-latency-us
Date:   Tue,  4 Jun 2019 14:29:31 +0200
Message-Id: <20190604122931.22235-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current entry-latency-us is too short.
The proper way to convert between the device tree properties
from the vendor tree to the upstream PSCI device tree properties is:

entry-latency-us = qcom,time-overhead - qcom,latency-us

which gives

entry-latency-us = 210 - 80 = 130

Fixes: f6aee7af59b6 ("arm64: dts: qcom: msm8996: Add PSCI cpuidle low power states")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index b7cf2a17dcb5..e8c03b5c8990 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -174,7 +174,7 @@
 				compatible = "arm,idle-state";
 				idle-state-name = "standalone-power-collapse";
 				arm,psci-suspend-param = <0x00000004>;
-				entry-latency-us = <40>;
+				entry-latency-us = <130>;
 				exit-latency-us = <80>;
 				min-residency-us = <300>;
 			};
-- 
2.21.0

