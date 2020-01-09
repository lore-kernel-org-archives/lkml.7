Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99FAC33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F17F2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qOrtFJtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbgAIKcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:32:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39683 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbgAIKcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:32:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id 20so2211381wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4kehVIjAHriar2YTBKhxGT8qow3PLLc5BwohGlX0qC4=;
        b=qOrtFJtLIaXW++SFF/qMAXRFmybsQ2xQvkpdc/HMCFtIOWlqSnwZ13LLtMECWM7g9y
         dv8RHKpkZvpbpXTkFUEebLw35UjOs/8k3nfXbXvBYvprekm0MrsfJc4AK/TfUZUOyvkZ
         DmPCtKiYedPw/lJppMAhQEhvx2Ji9KXfPJAweDfaPsLU/K1UQARQWluwpSd8kj+vMUP7
         5HftOWc0FQgRaGfS6lzBAW5BluFQAphPQ+73f4sSsf7J9+mp4IYSGlxs7SGTao8acxnP
         IOtqZXJbdnmdymg6WdvQcNjtYQckSC/wqi+MItjtXtC8Ae0CT/Nt+oIqJ5MForUlbIdk
         HT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4kehVIjAHriar2YTBKhxGT8qow3PLLc5BwohGlX0qC4=;
        b=Fk3CVNa4HMB++eD8oZQRGa+aTJFzgMAB0fO9s07rjTdoCwkMNpVONiuUJgbv9Rad4W
         tp839DYUxUoT3tRaCdLJ7poXS665BP3dzUly4gZVR//TvAOe4gsHSjlBOXGsOLIjW4Z+
         O/Nob+KYKilDmzTQGh656YINTm4GTfHT+Cbby4vp4DFPujUispeAuaY01DufVmg2DIMv
         whKwKeY0/MY41gskQf4tHt56m43V/M2+p/ctqJkrx2riroXZ8T5AEqRIED7+wmiTUtCu
         Cq6tRDFlUpolNDQByzMqydQFLw/PXUXyEvDzmPyHBS7/30eKOB5JkU/EaBxSZZmdDWme
         GsZQ==
X-Gm-Message-State: APjAAAXaO0JKBCnwccPQIqWSOo7mC60BWdoRG+aGcCY0YbcS4mY62771
        IX/WxnkqfuR55nZW0UK4WEYTcw==
X-Google-Smtp-Source: APXvYqzK+Wb3+g1lUqNuslmW/ldsTQjMHl9M1Zw97Swn6ARQbBwTnHgOCMerBMrf3DPJpc3J3JdZrA==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr4053004wmo.13.1578565924298;
        Thu, 09 Jan 2020 02:32:04 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z83sm2473830wmg.2.2020.01.09.02.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:32:03 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/4] dt-bindings: SLIMBus: add slim devices optional properties
Date:   Thu,  9 Jan 2020 10:31:45 +0000
Message-Id: <20200109103148.5612-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200109103148.5612-1-srinivas.kandagatla@linaro.org>
References: <20200109103148.5612-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an optional SLIMBus Interface device phandle property
that could be used by some of the SLIMBus devices.

Interface device is mostly used with devices that are dealing
with streaming.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/slimbus/bus.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/slimbus/bus.txt b/Documentation/devicetree/bindings/slimbus/bus.txt
index 52fa6426388c..bbe871f82a8b 100644
--- a/Documentation/devicetree/bindings/slimbus/bus.txt
+++ b/Documentation/devicetree/bindings/slimbus/bus.txt
@@ -32,6 +32,10 @@ Required property for SLIMbus child node if it is present:
 	 	  Product Code, shall be in lower case hexadecimal with leading
 		  zeroes suppressed
 
+Optional property for SLIMbus child node if it is present:
+- slim-ifc-dev	- Should be phandle to SLIMBus Interface device.
+		  Required for devices which deal with streams.
+
 SLIMbus example for Qualcomm's slimbus manager component:
 
 	slim@28080000 {
@@ -43,8 +47,14 @@ SLIMbus example for Qualcomm's slimbus manager component:
 		#address-cells = <2>;
 		#size-cell = <0>;
 
+		codec_ifd: ifd@0,0{
+			compatible = "slim217,60";
+			reg = <0 0>;
+		};
+
 		codec: wcd9310@1,0{
 			compatible = "slim217,60";
 			reg = <1 0>;
+			slim-ifc-dev  = <&codec_ifd>;
 		};
 	};
-- 
2.21.0

