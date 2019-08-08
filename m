Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E02C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6382184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cmstt1tV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733021AbfHHOpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:45:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37049 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732909AbfHHOp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:45:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id b3so2818532wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 07:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XkV4oZs6ZiC2qzQJvCHYzSVuaz5P2YoXcRt/ldJXf5U=;
        b=Cmstt1tVGYRTZuFBXbdhJ+G+C+NK7oqB9DQGo6s/cQGQ7ycTpaLAzGYn4DV7Gq6D26
         Q89Oj18lD1j5IctLMbOvMvmyoteBXsTTl4EqjGiOgzXpEzgBsWpMuadf3sVxQJavKm5u
         CYoKSgMPMiKyj5ECNVWps666HHfD2EwqUlr8LK1CD1XiPmaEKtrH6Hq//3qJOgNBFkW5
         h77BtlUNVFa/1jv/32Al884UmaU3svQZ5jdwfWpGI4DadINDh89SPK3zQpOjwEdBSloY
         bQfLMVcZDbyVeimk8pGD8YcdOsiWojgOiaIdwpzvzjDIKAklwKCe969dvoSSnHpfyOzi
         uFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XkV4oZs6ZiC2qzQJvCHYzSVuaz5P2YoXcRt/ldJXf5U=;
        b=l1cT60TwMKEv7y9TV6SRk8b9QgybuC51hQ/XHBF7AjvN6yDRPTxU3Q7Y2y3P0wgJie
         wSEkvbPyEx7yRQyxmqcwnYQhuLkXvcU8MwC/xEeCe+TDIiHfflCASTA/g2n3azjv6nj5
         iMO2Uaq5SOW1cvLpFDOayRMYP68n3zEgcnypQaMXJGp50hCi4NgjFaa3SgZUGOmSswUm
         VaakQCmJwuXJpujdXOBqMnVkKCiVoHhxmNCYBfQx3wCeLYqMQAX9KCGXAnUW2C8+0fUD
         TUiSWWv4p0R/F6Lb3HsgVt6ln8bxXA6kB21HgAgmKAB+Z1S68F7hncz0iTD4+FI0HiQv
         0/Cg==
X-Gm-Message-State: APjAAAV0buBRpVJMxQUA+B66mmG71D2FpPiY4n7fCvAgKVznSvJRuamJ
        OcdUcZCtZ2H51YgzUP1LC20exQ==
X-Google-Smtp-Source: APXvYqxvtipX5ZGjzUSMQiJMzVQY+uy2fllw+fKJ1JcU+ugIbvCyHpyFwIVkEqu5KPNs9bO3Ey+HMg==
X-Received: by 2002:adf:f646:: with SMTP id x6mr18613900wrp.18.1565275528042;
        Thu, 08 Aug 2019 07:45:28 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id g15sm2009060wrp.29.2019.08.08.07.45.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 07:45:27 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, broonie@kernel.org
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/4] dt-bindings: ASoC: Add WSA881x bindings
Date:   Thu,  8 Aug 2019 15:45:03 +0100
Message-Id: <20190808144504.24823-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
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

