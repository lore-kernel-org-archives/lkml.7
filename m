Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF7DC2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8572073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vFQKn9Bv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfLIIjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:39:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33704 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfLIIjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:39:20 -0500
Received: by mail-lj1-f193.google.com with SMTP id 21so14644139ljr.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 00:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M6xBk2t3JSq6Gm+btMkUw0HvLbeKjwldK9lPc/9p6IU=;
        b=vFQKn9BvVVUUQ4Y9uusSgffYFjQKPOk2bHHTZorOpYzW/4FB9kB6JzD1XbXDirsL66
         NJhJcFSJBS9/9nXEbtC4h3cl0FQ9w3y0WHYi/zqUm06sd3JfJjSIfaZTPQfTVEvIL9Nx
         kwThT+MoV+y5uvtbP83Hoe1MPxjqQyz9E2MYnYL7N3U7Vt6onDSv+PlqO/P0Fxto37YB
         9zAywrd1pHIk68ouG2NpoiLA4GEz04/VVpDXnRTcMbH9d5jo4uQBhJcUBy8qFLL1JgVM
         rD/gDDq6nMW+NtJi+oVMZx/sL53+sIDMBMcspigWp//UCstQBEPwEJqCo+xH8CoXmcCQ
         Z5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M6xBk2t3JSq6Gm+btMkUw0HvLbeKjwldK9lPc/9p6IU=;
        b=QpjltNSXe+PYqt5cSpDScKcyjQ8ggi+C/+BzZ72aKJAJVE+PeoMK4YCXVXxPGYyHZa
         1qYoL2RuNwmmtDsmUqsT7kBM4mJHHXsG4g/dI1lixXAKGNoC7aVV1Z5p6hnmWiCa03si
         dy+nGEfIfivZMXS7+6/3Zz6JT5577Zt9ZXL0iT74iZ/9EBEbVx67hn7Pzf3PkFC8uU9U
         B8kLZTgl9Nq3ulUEoJFSd7leb4s9xLpJMcw9E5wVdcmtdzhjalPxb4lXLQawGDyJ/0BW
         mshPwgR4FDIJqGT/2FotBF13j8tCO7gKO0gi/fpiiVf2jk0bMK4xgjIeIy7Yrs+xQnIr
         Pebg==
X-Gm-Message-State: APjAAAUzI3ydpS8vWf+QYkRdY53gmxkaOE9+I5iUgbBhd0OC0z3Zjxuw
        219+dG9HF2B7paaHyhgVlTze7Q==
X-Google-Smtp-Source: APXvYqyd/Hl/dcqTOW4HAPtSVFyeUDEZNQ0Muro85srrZE45Au6soKwyk1tCfVT095Stl7QIjLEjvw==
X-Received: by 2002:a2e:844e:: with SMTP id u14mr12502198ljh.183.1575880758682;
        Mon, 09 Dec 2019 00:39:18 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.193])
        by smtp.gmail.com with ESMTPSA id r26sm10438971lfm.82.2019.12.09.00.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 00:39:18 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 4/6] dt-bindings: media: venus: describe sdm845 with optional pmdomains
Date:   Mon,  9 Dec 2019 10:38:22 +0200
Message-Id: <20191209083824.806-5-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209083824.806-1-stanimir.varbanov@linaro.org>
References: <20191209083824.806-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe an optional DT binding for sdm845 with power-domain-names
and clocks in Venus DT node. After that the binding for sdm845 will
have two options, the first will be to describe vcodec clocks and
pmdomains in (encoder and decoder) subnodes and the second will be
to describe vcodec clocks and pmdomains in the Venus DT node
(the parent). Both option will be handled in driver, and the second
one will give an opportunity to the driver to dynamically assign
vcodec pipelines for every given instance depending on its load.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../devicetree/bindings/media/qcom,venus.txt  | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,venus.txt b/Documentation/devicetree/bindings/media/qcom,venus.txt
index b602c4c025e7..69a104fcb8eb 100644
--- a/Documentation/devicetree/bindings/media/qcom,venus.txt
+++ b/Documentation/devicetree/bindings/media/qcom,venus.txt
@@ -35,6 +35,21 @@
 		- "iface"	Video accelerator AHB clock
 		- "bus"		Video accelerator AXI clock
 		- "mbus"	Video MAXI clock
+- clock-names:
+	Usage: required for sdm845
+	Value type: <stringlist>
+	Definition: Should contain the following entries:
+		- "core"	Core video accelerator clock
+		- "iface"	Video accelerator AHB clock
+		- "bus"		Video accelerator AXI clock
+- clock-names:
+	Usage: optional for sdm845
+	Value type: <stringlist>
+	Definition: Should contain the following entries:
+		- "vcodec0_core"	Codec0 core clock
+		- "vcodec0_bus"		Codec0 AXI clock
+		- "vcodec1_core"	Codec1 core clock
+		- "vcoded1_bus"		Codec1 AXI clock
 - power-domains:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -72,7 +87,12 @@ Every of video-encoder or video-decoder subnode should have:
 	Value type: <stringlist>
 	Definition: Should contain the following entries:
 		- "core"	Subcore video accelerator clock
-
+- clock-names:
+	Usage: required for sdm845
+	Value type: <stringlist>
+	Definition: Should contain the following entries:
+		- "core"	Video codec accelerator clock
+		- "bus"		Video codec AXI clock
 - power-domains:
 	Usage: required for msm8996
 	Value type: <prop-encoded-array>
-- 
2.17.1

