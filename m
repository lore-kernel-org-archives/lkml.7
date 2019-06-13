Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE3EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4462D2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oal5G6DK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732785AbfFMPOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:14:35 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:46629 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732249AbfFMN1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:27:24 -0400
Received: by mail-pl1-f173.google.com with SMTP id e5so8153792pls.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IFployeILFCgzGZc2q4P5YydzBLQjjv9PpitRIu8EHs=;
        b=oal5G6DKmpM2gjoDM6Nizu518dqxAi54e+Dkgt9/++sLxleEpXsbc3zsgWmlMKkRgs
         sfxH2RdRFccPtBUE26F+nw5CEJJ26aAO5cFgbH7Q0cf1E1u0FhcbPJMz0K/tCdbhNkJL
         clMxQOS9xSK6aPBdGg64uYtKxqMO4nKQIXmveSRZ69W9LbNgtKVNTmCfxpo2ft2YRwVk
         s23BZ1u3uiKYSZ9m9SrjdQ7M+5OSoycKzvry9uheTMQI9+1jS5tE26I7OHaZkrOs42ow
         FXxsYpDKiubQSlB9xiH3rCroDve9qOCcDRvOt2uj/4NdYBaOxEgMFD52E9i+cojiLdsQ
         3aBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IFployeILFCgzGZc2q4P5YydzBLQjjv9PpitRIu8EHs=;
        b=iBDR9PLG+68S8niJNlC9sLNQvCreS61ZGhNBpkAHKEW5hwAroqXi4xDbymJmNbhCvm
         DjurtXlWuOmxrslPxTQkUfZ2u7rtpqDYyFjmsKwXnsyPWvofvvd2kRx3jF4/nwdER07h
         bJnUWOyNLFERqVjXu5FU0cKNeKIsRqyxl9rsm9zDv3cvoONqiJ+I36DTB1k4VWF///7b
         5c2iPRcWQ2kbYVAUpwtR7WDAzOuegwzM8vW7znajXhbZ2oF+Ohsp9N7v2f3TjTEKSlME
         3TdwdwfFxkJvpQdTa5EUkijznP5E9+oc3GVXC6WQxLingwL0vYaLW5Z9LvoQhO7FN/a5
         m19Q==
X-Gm-Message-State: APjAAAWn9fC7meUUYNBfuzeTom9l/OE9GA09+ZLdyc5BB/pvw57fAo6z
        i/UAY0g4hOQeRx7KU6FINTbF
X-Google-Smtp-Source: APXvYqwTQd2pSdC7wJ4QhCSJEa/h6HwqS5fR4fIfIeiMuFebu68tpzNh3RDRYOL149zZxa3JIcFljA==
X-Received: by 2002:a17:902:b695:: with SMTP id c21mr35731043pls.160.1560432443695;
        Thu, 13 Jun 2019 06:27:23 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7141:4858:bdd9:1134:3bdd:7ab4])
        by smtp.gmail.com with ESMTPSA id y14sm1837pjr.13.2019.06.13.06.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 06:27:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pbrobinson@gmail.com,
        yossi@novtech.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: Document 96Boards Meerkat96 devicetree binding
Date:   Thu, 13 Jun 2019 18:57:04 +0530
Message-Id: <20190613132705.5150-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613132705.5150-1-manivannan.sadhasivam@linaro.org>
References: <20190613132705.5150-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document 96Boards Meerkat96 devicetree binding based on i.MX7D SoC.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7e2cd6ad26bd..dcd6c90b0cef 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -141,6 +141,7 @@ properties:
         items:
           - enum:
               - fsl,imx7d-sdb             # i.MX7 SabreSD Board
+              - novtech,imx7d-meerkat96   # i.MX7 Meerkat96 Board
           - const: fsl,imx7d
 
       - description:
-- 
2.17.1

