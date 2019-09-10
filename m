Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBE3C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456E62089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LFhaFNAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437050AbfIJROs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:14:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44872 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437019AbfIJROo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:14:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id u40so21632995qth.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pHdUSG06S1sXGHlL1sjMEDPrOFbJ84fKCAwVrFTIeNI=;
        b=LFhaFNAnkVRzT4lYKU7W1WSI9NH7ihO+uv0URMnSVT/UJgUfAuZJwBrSprbLW9Yy/B
         b5xcVb8rR3KvFvMYkhC/BaG/aXaeGihJMNQruiK49G0/BQ/BPp/JQwhcKgRh0gLSkRS/
         M1+Ui3smnc76FrOKXcWBcZ4JrQ7L5EWsjUoxBfA2td/AgchlqPqgt+tGKBK/JQl74eiE
         o59VD762axYy8+O7ySYNCY1WsgQXUrgaTxp96cX8ZKg4Ns5egLEuOYVlP2gJFR5Ckc3i
         wS9/nev0koEcsSbVXyg84TU7vP4DYfFBmoAZnUe61GwMq4oush4Fh7KqqC4PQpn+/1zV
         hjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pHdUSG06S1sXGHlL1sjMEDPrOFbJ84fKCAwVrFTIeNI=;
        b=R2Yx5CrPU/SUfNAOCQzFTtqcyhm66cMF6q7LpgOIXDISTFi+aQOriDTUvlE8FVXNYu
         RnrvfTLHugzoM7FUcMhuYPRQU8LQPHD5fZosFylnhumB3JQ9pbvMKx7x3FIXiqbQBSTu
         t68a8fSOvDBwW63zFANg28yhp1zKW5Jlw/+4yfWLZCbxH9aBQgLPi8QnbD4VRHysMh90
         IQarXYmUoC8p8eqqqAkxXjmow6vql2sQQUywp8LpZqE7bdhD6z4srzVV5CXja7oEZo4z
         AgY4+J1L2+vYyJsul1bVuPbtzlaLs/3UjIrFl9ymxPyK57nvyv3Ch20G1doqrPFAS3rB
         /yJQ==
X-Gm-Message-State: APjAAAWKZrX7Z18B1S3BGBJC9uipZ/mt+f5aaanedABh1RcDwyB3qaFx
        J++v6uMjWOTuriO/1JGbJY8Vfw==
X-Google-Smtp-Source: APXvYqzJLerY/k43OHwIVaiwNYn4guYcGyo1M1aaZ+k4SiKXSX8RWI41bTdRmjsTdpTncWtL1Ei5VA==
X-Received: by 2002:a05:6214:15d1:: with SMTP id p17mr19340829qvz.74.1568135682152;
        Tue, 10 Sep 2019 10:14:42 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id g45sm3400713qtc.9.2019.09.10.10.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Sep 2019 10:14:41 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] dt-bindings: thermal: Add generic power domain warming device binding
Date:   Tue, 10 Sep 2019 13:14:34 -0400
Message-Id: <1568135676-9328-4-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1568135676-9328-1-git-send-email-thara.gopinath@linaro.org>
References: <1568135676-9328-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding to define power domains as thermal warming
devices.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 .../bindings/thermal/pwr-domain-warming.txt        | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/pwr-domain-warming.txt

diff --git a/Documentation/devicetree/bindings/thermal/pwr-domain-warming.txt b/Documentation/devicetree/bindings/thermal/pwr-domain-warming.txt
new file mode 100644
index 0000000..25fc568
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/pwr-domain-warming.txt
@@ -0,0 +1,32 @@
+* Generic power domain based thermal warming device.
+
+This binding describes the power domains that can be used as a
+thermal warming device.
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be "thermal-power-domain-wdev"
+
+- #temp-reg-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: Must be 2
+
+- power-domains:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to power-domains that match power-domain-names
+
+- power-domain-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: The power-domains that can behave as warming devices
+
+Example 1
+thermal_wdev: rpmhpd_mx_wdev {
+		compatible = "thermal-power-domain-wdev";
+		#cooling-cells = <2>;
+		power-domains =  <&rpmhpd SDM845_MX>;
+		power-domain-names = "mx";
+	};
-- 
2.1.4

