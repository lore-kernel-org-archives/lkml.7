Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5C0C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFF621721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lnVeOVFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfDMKeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:34:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40781 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfDMKdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so15138338wre.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9V+TJFDFFCIM8e1FXxwOAxvWSYjX8RCZCP7tk0faJT8=;
        b=lnVeOVFJQGEyFSwu51J7Ga/uPAG8kxMWBIIyeKG28u42MYy4B0PwZZY7PPggI13V1r
         WVA0fvixU7O9NLoo5wZNVyP+OJSzBgvtAidsEYCtklPJW3aqs5iMVX3lsWoK6ujjO0b6
         Dem/ZwXvXB6Xe14SJaroRtSF9xWVe3OB8NmbKh44XN36cziRiIYto524iKH9B/1q4XbR
         aCjGvEdXVxOeJAATkG5vxfKfqoJU/0CnpwON0dJr45aaZvwfSC+OL8f0JdOoZ+oF4kut
         g/7AiChKN3LPj5ao3O8oYCaXryW8xC6DwllOV/T3m/CVyhUKsE+l7uHyr/2q4XWWZUd8
         HPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9V+TJFDFFCIM8e1FXxwOAxvWSYjX8RCZCP7tk0faJT8=;
        b=fUEhP7pArihmAs7VNAHBY0D2zNNaYR4ugLg+Bv0i4Kf3whxDuvC6jVycNTYpk2In92
         Wp97faphLBmIdbDjO1VOnktv2OulF74jM3oCwIVCE9cUoV/LuMv5a6TAww2OIChfTJxM
         ooFu/jkrXA6jzz/7GAaEsFLVU2eLLoW8kUpsaVuwl82o0ChQBPMmmzOK3abYzcWRe0wq
         +YuZVQZ7LC9XP2vk4fCKq4LeQN+wr24UHBreEAmPVB39B3hFEeaMf248WE4m8/moFkSV
         RzF8PD8ch696Y9sqei0d5RlMVSml4YcBDNQ+TYuLjNJAKizrkvnozxrshsMJz9pg1l/E
         GPEg==
X-Gm-Message-State: APjAAAXqZKvfBQVd/LBLgFXhAIR3RBsu2566wMFfMnIlIgtCVgONGFq3
        oBWiBLxpnpuQ8PxFmj8kacIWQQ==
X-Google-Smtp-Source: APXvYqxQpLp4Rbk1+4B3XeKCxEz9xl73k8JgYNG8eMFwWy0NTRKYAi/g4LRQK9SgCItGPipN01weYA==
X-Received: by 2002:adf:e78e:: with SMTP id n14mr16873353wrm.14.1555151597180;
        Sat, 13 Apr 2019 03:33:17 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 09/20] dt-bindings: nvmem: Add STM32 factory-programmed romem
Date:   Sat, 13 Apr 2019 11:32:54 +0100
Message-Id: <20190413103305.9576-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
References: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

Add documentation for STMicroelectronics STM32 Factory-programmed
read only memory area.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/st,stm32-romem.txt         | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt

diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
new file mode 100644
index 000000000000..142a51d5a9be
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
@@ -0,0 +1,31 @@
+STMicroelectronics STM32 Factory-programmed data device tree bindings
+
+This represents STM32 Factory-programmed read only non-volatile area: locked
+flash, OTP, read-only HW regs... This contains various information such as:
+analog calibration data for temperature sensor (e.g. TS_CAL1, TS_CAL2),
+internal vref (VREFIN_CAL), unique device ID...
+
+Required properties:
+- compatible:		Should be one of:
+			"st,stm32f4-otp"
+			"st,stm32mp15-bsec"
+- reg:			Offset and length of factory-programmed area.
+- #address-cells:	Should be '<1>'.
+- #size-cells:		Should be '<1>'.
+
+Optional Data cells:
+- Must be child nodes as described in nvmem.txt.
+
+Example on stm32f4:
+	romem: nvmem@1fff7800 {
+		compatible = "st,stm32f4-otp";
+		reg = <0x1fff7800 0x400>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* Data cells: ts_cal1 at 0x1fff7a2c */
+		ts_cal1: calib@22c {
+			reg = <0x22c 0x2>;
+		};
+		...
+	};
-- 
2.21.0

