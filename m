Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2112C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFF820657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fc3zXjbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfCKOGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:06:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45686 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfCKOGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:06:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id d24so4144835ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cldebn5rQ3z+ex+yG3KpHfwUvm64BqEilOiuGA7ptts=;
        b=fc3zXjbHWePFSl/8ywyy56bp8XEoYyYsQOahifwsBFsaOE6ruvYqhTBjfutOOx1S/m
         6jEEbdy0NRKOFpGj2YIgOGBbNTlhlubvjxh4FnJNHu3kNw4uYmwLME+n3Gurw7CvF5tu
         JJCkvDwLIPU1HJehjQIeEa8VAWQTVyEeQPzbT7+EgWRQk75ITr2XEak1ftNqH/9408sr
         OJS/s15UcgaUCXne6yOfxOIs2n2TwYgL+CfaKMcdnGZgG7JMKVhOvDe44exyRYqSOF1I
         cZmFlETxYuPUxvaMf4fOqdMRPkAxuxQkLl4cTUiSySrvkJCVHx4jlyrPhnP34fAmHBbE
         V7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cldebn5rQ3z+ex+yG3KpHfwUvm64BqEilOiuGA7ptts=;
        b=eU1PKYIfmD49FgQqG6o4SNZi9CQZYeL+oBTqgMSxv7B8bbYfO0WwMFXfAtWtuvX5ZS
         AC3lN1Z3AYYw1kRXsPJgRmC9J76oRtpYA3Fo8zrtL5LJke+4ZpRmVMUvTojn6SWF44UH
         UETsFv5eojDTTd4baEcyeZovUVMdCbDder78rD9Mc9e7DeoBfIJGPC7dbZYRo1xoYh9T
         YQ+iJNqkHpe2to3dRoz9uImaFhI6SPCkaiLU8HkCfYpgog9XreQcdxNCXaBFc5xeKjUn
         ckHxFnBOqyMPjSGM2D8clSvE6GUbdn/qneFmc2LkXthyDFlTDfRSnhe4ZUdDMQ1tEh2p
         LPTQ==
X-Gm-Message-State: APjAAAVtL0rR02QVKR6rn2D0wALMH/o/XEuxf6aNp3uT+syzxBzyxJFG
        POLzus1ZicmkwALjz0PZgl4luw==
X-Google-Smtp-Source: APXvYqxslZKk9LPyS2+ini2QVJLuEsay4sTvNRtRxTZ1f9kbRXF6OoNqzV9bYryBPJvGNG/Ib76DHg==
X-Received: by 2002:a2e:3c10:: with SMTP id j16mr866358lja.113.1552313163663;
        Mon, 11 Mar 2019 07:06:03 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h9sm70453ljg.3.2019.03.11.07.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 07:06:02 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     andy.gross@linaro.org, bjorn.andersson@linaro.org
Cc:     daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] arm64: dts: sdm845: Include the interconnect resources DT header
Date:   Mon, 11 Mar 2019 16:06:02 +0200
Message-Id: <20190311140602.12160-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the device tree header for the on-chip interconnect endpoint
resources on sdm845 devices. This will allow using the "interconnects"
property in DT nodes to describe the interconnect path resources they use.

The sdm845 interconnect provider DT node is already present, but the
header file with the resources is not included, so let's fix this.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5308f1671824..be4d4c5859c0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/qcom,lpass-sdm845.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,videocc-sdm845.h>
+#include <dt-bindings/interconnect/qcom,sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
