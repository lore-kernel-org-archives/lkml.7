Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8F2C4321B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F03F2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUoqo2jm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfFKKlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:41:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34957 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387631AbfFKKlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:41:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so12462371wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 03:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XkV4oZs6ZiC2qzQJvCHYzSVuaz5P2YoXcRt/ldJXf5U=;
        b=QUoqo2jm13Ah8FKoW9ZQffD7RxI2rPxaShyjImH5esJ3XGLFgOOSuXXn6Q6zUEWzve
         FoGVpsrmEoizOPupYvUMsyq0S/ncIbTuVNUAnkQPXp7Dr2a57Fcm/08o3KYvLJbbrUGG
         aYWjHG0lr7QZip82Nshzyn3AI0/D5ePUw//y/Fjys1hV+qhmCIN2Kr1I/v5Z/pXOjaOM
         3Zpr3NpZZft4km8qUpT7fcVj4DamJ0Xe9ab7TqEuIy/5P5lSO1gbHrOvAi/iZQ9jLZsF
         BMPpv01TZvuS2Z28DIBp1qlY1IkuclNetRMIcNmjjxJj2j4QxbLUVdbPFMv5KwQyVgUp
         UJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XkV4oZs6ZiC2qzQJvCHYzSVuaz5P2YoXcRt/ldJXf5U=;
        b=Y3lwwKmrogC4tAiM0LDrjTWkYEG3RxAJkeRRI7Kxl+j5VWhUvFoiLYFRaJKo64mu+V
         qUHXaS2RMWC9pvIeyjkdSi9ot9aQJRXF3WYnKGlpnRai9AC2t9ztu2AROifhoLfRJuTG
         8y3+yJCAvg99DLmJfY8nBR+M6FLFKfgWADubZ6TAjX3rMyb+XAg62bxFQR3CukH2JJP7
         RV3knJPkrMDUXvcNT0dwCkgdhdkaVk6ROflLwnHdGWTghjBFQM4e5G/vDlA8pS10G5CZ
         SHoABkYgie+zl7HZy2QYyb5rt9hDIlWAca80dvTIsfzrANpNsIQwR96hgwXsU5ajWRmc
         6LcQ==
X-Gm-Message-State: APjAAAWVCuHJviubd1MkD/pjCxyae0Rn+DiEjXi97RF7Vt7uH0n8Tn5i
        2RHvMYWLUOxV/GZLNCvvm1/mvg==
X-Google-Smtp-Source: APXvYqwfFkBFylnzRecASi8Zz0rbC6zl7wEOF2/dyq1l7Bhc83VPv5YNjRcpF6qSsCV/HdegblZWcQ==
X-Received: by 2002:adf:e2c7:: with SMTP id d7mr28417773wrj.272.1560249662909;
        Tue, 11 Jun 2019 03:41:02 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c65sm2359614wma.44.2019.06.11.03.41.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 03:41:02 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bgoswami@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 4/5] dt-bindings: ASoC: Add WSA881x bindings
Date:   Tue, 11 Jun 2019 11:40:42 +0100
Message-Id: <20190611104043.22181-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
References: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for WSA8810/WSA8815 Class-D Smart Speaker
Amplifier. This Amplifier also has a simple thermal sensor for
over temperature and speaker protection.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,wsa881x.txt           | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa881x.txt b/Documentation/devicetree/bindings/sound/qcom,wsa881x.txt
new file mode 100644
index 000000000000..582db402a482
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa881x.txt
@@ -0,0 +1,27 @@
+Bindings for Qualcomm WSA8810/WSA8815 Class-D Smart Speaker Amplifier
+
+WSA8810 is a class-D smart speaker amplifier and WSA8815 is a high-output
+power class-D smart speaker amplifier. This amplifier uses SoundWire
+digital audio as primary interface.
+
+Required properties with SoundWire Interface:
+
+- compatible:		Should be textual representation of SoundWire Enumeration
+			address.
+			Refer to soundwire/bus.txt for details.
+			Should be "sdw10,0217,2010,0" for WSA8810
+- sdw-instance-id:	Should be ('Instance ID') from SoundWire Enumeration
+		    	address.
+			Refer to soundwire/bus.txt for details.
+- pd-gpios: 		Should be phandle and gpio pair for
+			Powerdown/Shutdown pin.
+- #thermal-sensor-cells: Should be 0 
+
+Example:
+
+spkr_left:wsa8810-left{
+	compatible = "sdw10,0217,2010,0";
+	sdw-instance-id = <1>;
+	#thermal-sensor-cells = <0>;
+	...
+};
-- 
2.21.0

