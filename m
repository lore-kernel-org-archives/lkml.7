Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB11CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F1120679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NL9naB86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502895AbfJXOnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:43:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35613 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502885AbfJXOnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:43:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id c8so9573382pgb.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2UoSxu4ISRxofxwFZ2v9JG7zQdt9X9lHqu74cjbmWOc=;
        b=NL9naB86Ee+CKVQ+AxELEdANKhDOXHfV2IVHHFBKwkBqZ7aSoH4ytqXml813h/VULl
         BiKGsJVwXEbKNHk8oSNT7RIFwz1vjBuMSTr264xnrqHbtNR0543nDpPoucKnDI7X3+TF
         1iFvC4xwiIffkW60ZxVm51NiUwY6mKJfqEQ6ztvbBSzdxrYgeYRUjRML3KUpCaT8AR4y
         p8VTGVVbNmeo7KXnYytrJSh/mgS0eaEcEWNMSWLsXfj0dgR8KysPMccpuprVOgBIFur2
         aAr1OEWxW/cfIuUM9axxN/Lc3LahT1VIObaRh1YZQntZN7IX2TME5WL2TEX8UxZFMJe4
         Sk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2UoSxu4ISRxofxwFZ2v9JG7zQdt9X9lHqu74cjbmWOc=;
        b=dNlG0q94eHpYL/QN5n3pDVi9u8Qo9xLWhJDqTds3ir6Nyr75AotXII3JS2v2mS/f12
         KHhkBLEW3UMZHJIh3akS028u3ppVk+qkf0edFm5FWQ0jdT1QpeC9buavFXxjd3RxwTK4
         IOv9v6l/0k4pke4Yn/l29z4PUad3QIBjKFMaqhkE11iYl7JPozMgbSjCK/ozJKVlbkOC
         AInqoX9o6R10XP1xw1UD130ExUGTKv9tKxhrv4dUIYrbogzlxvIMN2dlSwWv+QomoEq9
         2wMTlAaVeE3XJ1qU8MwSqRwqdkbZJd1ad+IdAz6Q0fFF5xXQtQUQCo0a3bxY87oEctnG
         OBfw==
X-Gm-Message-State: APjAAAV+GoYmqNgZtTPy6E6SWWZ7h3JsllwVa/wX75jgzuI8GMhJUW//
        gM3yLzJuNo/fkVtCYShbd/gr
X-Google-Smtp-Source: APXvYqwKvgKgE4c3s0sCd/U7krExMDS/JsSah401n4Z/IyqsYW8gYj1usJWSIza+wIgKmHUVQZ0QEg==
X-Received: by 2002:a63:4d61:: with SMTP id n33mr16708322pgl.158.1571928181935;
        Thu, 24 Oct 2019 07:43:01 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:997:a0de:81a:ea25:468a:5918])
        by smtp.gmail.com with ESMTPSA id 193sm29059810pfc.59.2019.10.24.07.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 07:43:01 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        darshak.patel@einfochips.com, prajose.john@einfochips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/3] dt-bindings: arm: Add devicetree binding for Thor96 Board
Date:   Thu, 24 Oct 2019 20:12:33 +0530
Message-Id: <20191024144235.3182-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024144235.3182-1-manivannan.sadhasivam@linaro.org>
References: <20191024144235.3182-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Thor96 Board from Einfochips. This board is
one of the 96Boards Consumer Edition platform powered by NXP i.MX8MQ SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 1b4b4e6573b5..8016174d5e49 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -239,6 +239,7 @@ properties:
         items:
           - enum:
               - boundary,imx8mq-nitrogen8m # i.MX8MQ NITROGEN Board
+              - einfochips,imx8mq-thor96  # i.MX8MQ Thor96 Board
               - fsl,imx8mq-evk            # i.MX8MQ EVK Board
               - purism,librem5-devkit     # Purism Librem5 devkit
               - solidrun,hummingboard-pulse # SolidRun Hummingboard Pulse
-- 
2.17.1

