Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7F7C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26AF24672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNOtGjrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfLSKdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:33:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36128 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfLSKdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:33:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so5447839wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 02:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YC1onaWGjgTiGrUp75mNaoNmZWZWn8ozsG+Lz8zEBxg=;
        b=NNOtGjrvusypzMTC6MJS8EMtqQcuO5BJE9acFErPQYUgb6qPZe3jFF4p61eL5laUxW
         tuAsMpR75YhavzwfcY99YsJDQOvMJcS/g71uP5dW1poVMEOAiKVXYsRv83f+P2DKINe6
         ZnH8A4QVwNGfb7XhFy+e184o1unmEhWRUyelBx1ihqKbSfSjJnwOu+rwKIZpZOefqAI9
         nV7h4ChVDZFlXPeBKt62DSex2V0RjzmGBNEQt6fObCtHkTLVVufjT5mmTO/dS8i/+hy5
         M8zjIOzc5MQ0W5LhXtQn2eW+HT5wpVfM3JQxOQVqqBIOcvWYf5puQLbrXgFxtBhSU9yK
         krmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YC1onaWGjgTiGrUp75mNaoNmZWZWn8ozsG+Lz8zEBxg=;
        b=t9pxWmcLdIFfG1amt+G15M17TrHvt4fYLZsRtJB3zcOL3E2cVh+fh2xtmNpqUM4E7m
         dQxnUfTYzIVpNhjNMElkC2XKZb9igyrRJsZe2+hstYg1oO6xAYn5/C2Eiqzga/F9M9k7
         dW3F5Ay1VQowFHOykz/fOjAtJ4gv2QyRr52yESDGcTzB5VNLrQ3GRkZuSVD72PBsmykR
         Q+8mKnOSSH1gnat2oRx5a7v4X3UIlGMK5lIEformciYhB2+lV5VzpREKX855KHdTYhgF
         IU4k5VXf83yv4T29kA2QfvDAsLmT3OteUVhjWnCVG256zHwNwpTDoZg5Ulo80u2MYUl2
         gQ8g==
X-Gm-Message-State: APjAAAU15apsC26yo/KI/M41Yr7oY7pHnCiJUbGmy9ZMVtqwxJBet7g1
        iBT8ExQ3kZg6T2YiUOu8ZixHx+7iPlc=
X-Google-Smtp-Source: APXvYqxfo0snWNNJZR+HZ3eABwtxFyD/6cnRGxZomqgjOClUfLnrbHXMz0ncmNrqJw8+e8W1kW1oCw==
X-Received: by 2002:adf:c74f:: with SMTP id b15mr8529223wrh.272.1576751595154;
        Thu, 19 Dec 2019 02:33:15 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id i11sm5962942wrs.10.2019.12.19.02.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 02:33:14 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lee.jones@linaro.org, linus.walleij@linaro.org
Cc:     robh@kernel.org, vinod.koul@linaro.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org,
        bgoswami@codeaurora.org, linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 10/11] ASoC: qcom: dt-bindings: Add compatible for DB845c and Lenovo Yoga
Date:   Thu, 19 Dec 2019 10:31:52 +0000
Message-Id: <20191219103153.14875-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219103153.14875-1-srinivas.kandagatla@linaro.org>
References: <20191219103153.14875-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds compatible strings for DB845c and Lenovo Yoga C630
soundcard. Based on this compatible strings common machine driver
will be in better position to setup board specific configuration.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/qcom,sdm845.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
index 408c4837e6d5..ca8c89e88bfa 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
@@ -5,7 +5,10 @@ This binding describes the SDM845 sound card, which uses qdsp for audio.
 - compatible:
 	Usage: required
 	Value type: <stringlist>
-	Definition: must be "qcom,sdm845-sndcard"
+	Definition: must be one of this
+			"qcom,sdm845-sndcard"
+			"qcom,db845c-sndcard"
+			"lenovo,yoga-c630-sndcard"
 
 - audio-routing:
 	Usage: Optional
-- 
2.21.0

