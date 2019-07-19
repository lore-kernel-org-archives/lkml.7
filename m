Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01826C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5942173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBQxcCKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfGSMOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:14:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50340 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfGSMOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:14:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so28610440wml.0;
        Fri, 19 Jul 2019 05:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F6zESjJw5gi9GyaRx05z2263B816bds++z6rEjY7GBY=;
        b=rBQxcCKPpAGT5kBMGgeyGoam1a9RgUnNe3XM3HwkofbHBS6aPNoGiV0fPWlLb0ogBv
         4l0X7msaSLAx3jyTgQokU8FDURdSbPaY6wroGOAkvYz7RkrU/tje0XnuKmLRniacSaf9
         Lc7i6xwUauO1mTQHvC4pqQZmswEJQTR1XX6c5O6kXVnHFI4RnYjvPh0qSUf2RMoTUi0m
         TMmXi+PF84gspRd6gf0uAPqm8QjnNwXbnLlHp22E+n9h27jOC0aOK3TI1PN9ySQorCW/
         nla9IkN82Hv9DjZ10cPU7D+8giGglW1hcnsPTB4vAmbGQK7PaLHLMQQJjYFFRDTmz9WE
         GL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F6zESjJw5gi9GyaRx05z2263B816bds++z6rEjY7GBY=;
        b=jB+5vMJtvgJnRQzhCF45vNUXdjQzu6npUI2nzhKlMYAmnnc5OKvJxqnvk7WTC+Ohnv
         PzbDvoUV7Q6tlWAUe3HhTOQ34DWhAViqOaPK3I3BgrgJzDCVlSpRVOOd1b/biDnMDIi1
         D41e1HymYauMj0OI/EClX8EyZf3VbI7hvCJeTnQeER1c5DvJgWbAg7WMSMZM0H7AN4ds
         acqBE7+qv59ewlAI+B45uPsxOprwiElsq5B39tPf14jlI3XwerWffEARfNlVzNsWysje
         pjwmC/ftTd58VA57mn+izVgvQe/64/W4EtOUTQofftzbXafzjvIREVJATVaHhYeBZQxi
         h83w==
X-Gm-Message-State: APjAAAXqTDDS1uXQgLhtWXRPOBrcdNxm8O2ta+d9sQrapzaX2pCG+T5g
        rNHPh01DyeQGH9CdHPmhxFw=
X-Google-Smtp-Source: APXvYqxSfE5k3AZUgLPNsy65WZQLQ7MoyydOZ3KjU7X2xwBYxVpD7OvWuV2qO7vQK9OyMDSH5V6ONA==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr45643612wmk.99.1563538490401;
        Fri, 19 Jul 2019 05:14:50 -0700 (PDT)
Received: from localhost.localdomain ([212.146.100.6])
        by smtp.gmail.com with ESMTPSA id y18sm30135261wmi.23.2019.07.19.05.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 05:14:50 -0700 (PDT)
From:   andradanciu1997 <andradanciu1997@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        j.neuschaefer@gmx.net, andradanciu1997@gmail.com,
        aisheng.dong@nxp.com, leoyang.li@nxp.com, l.stach@pengutronix.de,
        pankaj.bansal@nxp.com, bhaskar.upadhaya@nxp.com,
        pramod.kumar_1@nxp.com, angus@akkea.ca, richard.hu@technexion.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 2/2] dt-bindings: arm: fsl: Add the pico-pi-imx8m board
Date:   Fri, 19 Jul 2019 15:14:30 +0300
Message-Id: <20190719121430.9318-3-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190719121430.9318-1-andradanciu1997@gmail.com>
References: <20190719121430.9318-1-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andra Danciu <andradanciu1997@gmail.com>

Add an entry for TechNexion PICO-PI-IMX8M board based on i.MX8MQ SoC
Datasheet can be found at:
https://s3.us-east-2.amazonaws.com/technexion/datasheets/picopiimx8m.pdf

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7294ac36f4c0..54c094341121 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -219,6 +219,7 @@ properties:
           - enum:
               - fsl,imx8mq-evk            # i.MX8MQ EVK Board
               - purism,librem5-devkit     # Purism Librem5 devkit
+              - technexion,pico-pi-imx8m  # TechNexion PICO-PI-8M evk
           - const: fsl,imx8mq
 
       - description: i.MX8QXP based Boards
-- 
2.11.0

