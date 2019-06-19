Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFB0C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9B221721
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WdDNnA6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfFSSQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:16:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47067 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfFSSQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:16:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so205417wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KUfLyApZ5AwkW9imsp2WRnl5X/PfSEjVc3u7oW3Doog=;
        b=WdDNnA6lznVGqEp9pRzxOJCwP8r9S6Oya03237rOEHm7XlJKozJXSCXZ2GuP78pA+g
         nlgwN5KtnNgzu1oxWjPtXST52wHS6M9wvZX7rUrMnglRR46nycAkTPoaK+3cCil9YX8Y
         YYaujc5kUbCIbxOH+TAPrPcD95TF/D0J6FOGnY8xY6Hqgc4gGiMkj+MPj/jwwA216QzZ
         WAgaeDiHHO/Je889WzarHg1JJ/jokv9T8oWWo+y4og7qYcfDuSvI036vaMaslFHJAlw6
         px9HYu/LeHrYo8WV6WHq/MZx1hhAugaBx9KGjGAaYQP75MDn4tmBg5d9p6uY33tCgF4x
         Nt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KUfLyApZ5AwkW9imsp2WRnl5X/PfSEjVc3u7oW3Doog=;
        b=nkEwk71E2Q+Fli5PpyDfNrK0ExYAlJ7ZfFcy5ksAC8BEly0mn57a3uBi89jurqRHwt
         SCOE+rgkzvroIB2PS0xDEq/9WxKbr+3q4oIsav3dw27OHaQEzqN3pWqlsro9YF+JHsMl
         AeN6APU1H+vAzQyeegOyoMQ/xa+I1JGIw+02XDBDSDPF2U8Ixh9zwQTK1mWBxDF86Gpq
         8nyzMOz1bJPwAIH2L+0pVhSYmndEMxRq7/y0BJRnstndCW6Xz/OuQjhy9kQajm4uV4K6
         /van5KSk8CYyAVz41mK2038znh3vNPEaAZKabfyN5R3D9f7dXfPKYytU7XWn+xjsuZjs
         nVeA==
X-Gm-Message-State: APjAAAV1YSFXaupMyG2EH5XiALqBmiOOLKv9yMabx/78CmEYZGS27ZUb
        /1oV2rwdNS6XcLovvYeuUIHxuA==
X-Google-Smtp-Source: APXvYqysIa7yB7+ZaVWnQPKAicicBYiFlTH1tQoPMtYEJ9avZgZbvM6vmyIp3EAshKxTRp9m38X+IQ==
X-Received: by 2002:adf:f951:: with SMTP id q17mr60175084wrr.173.1560968216764;
        Wed, 19 Jun 2019 11:16:56 -0700 (PDT)
Received: from localhost.localdomain (14.red-79-146-87.dynamicip.rima-tde.net. [79.146.87.14])
        by smtp.gmail.com with ESMTPSA id d18sm29977759wrb.90.2019.06.19.11.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Jun 2019 11:16:56 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jeffrey.l.hugo@gmail.com,
        niklas.cassel@linaro.org
Subject: [PATCH] arm64: dts: qcom: qcs404-evb: fix vdd_apc supply
Date:   Wed, 19 Jun 2019 20:16:53 +0200
Message-Id: <20190619181653.29407-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The invalid definition in the supply causes the Qualcomm's EVB-1000
and EVB-4000 not to boot.

Fix the boot issue by correctly defining the supply: vdd_s3 (namely
"vdd_apc") is actually connected to vph_pwr.

Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
Tested-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index b6092a742675..11c0a7137823 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -65,7 +65,7 @@
 };
 
 &pms405_spmi_regulators {
-	vdd_s3-supply = <&pms405_s3>;
+	vdd_s3-supply = <&vph_pwr>;
 
 	pms405_s3: s3 {
 		regulator-always-on;
-- 
2.21.0

