Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D8DC76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B38F21738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQZobyBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfGVK2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:28:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38751 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfGVK2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:28:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so13406691wmj.3;
        Mon, 22 Jul 2019 03:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KlMITGUupMUS+z7cYFJpkuySI0G3DrjFsP62Lu6OHIQ=;
        b=nQZobyBxiZE42wghcJ4bHW7Gffd+ZlaEhHifNH/8x9rGQvmboMIohsKMQOxZqrbelF
         D+OH0k+jHbJ7O+Ha2Ozlc9DECX2713tWbF+vb6OEoeLqG8j3s+DIsyzqfgjzIHrNWLTJ
         cCOyLFUy8wdc7NfaAcHsYnSFFAdIXmS+mXmDxJE1mCLgD3duRvl0BN0oY7D4dMNIrK61
         8lm2hMiWXGz9tJD5qAVEEfw1i6mpR6Vcqr0ihAEYmt+iUDd0Ort0IAyKLi1MsSUkShqk
         bQJ5wQMXismOmS3/V4ep/5TO8mHo7Htpmnm9mb5j5TjTmAy2AKROSikcATpYllOEfBZl
         v6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KlMITGUupMUS+z7cYFJpkuySI0G3DrjFsP62Lu6OHIQ=;
        b=VtgzZrMntLQAV8PmXSNxmI2gEpbccjqBA2WhHu+HD2XO57pDnfzWD6wOKhMc1pnv9C
         DBJWC4iZLoSf1IcrL1rhh0ueqQoJIVayUHKKp9n/jQsLt1/frXnPNDGihf0Ivqf2kYNM
         FGmXn08l9H/VPgE1NIuD9xwEz8ahIJfhIXTm9jPSQg2vZoYPd44xoJ9Zyfet+1yyXzcq
         d7k0WV+cAcjKt1Wh92YYy1gwdxMHC8gO0imvU9EwVTVGApjpp78GZNBSHyZwMIDnurpN
         ISNvlIEUZLBJSxeQjs6MjkjIVlNMaFtRnebpVnjnD40jpjZxLnHW43KyfN/wJAQz8Q2d
         az/w==
X-Gm-Message-State: APjAAAUyvc2DLlm4WvGNnsJQQO7GbayM2io0J6We4kwH+JBLvH8XAEN8
        jRGZPdc+XnuaR5QVTzLQyJc=
X-Google-Smtp-Source: APXvYqyCbpEyLuMrWq0ggNzOSPn1qsyScrquvPzvhxrzrIh0BwX9iIXoOo4TuaH8a49JuVmdGLV2lw==
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr62407969wml.157.1563791280183;
        Mon, 22 Jul 2019 03:28:00 -0700 (PDT)
Received: from localhost.localdomain ([212.146.100.6])
        by smtp.gmail.com with ESMTPSA id o7sm34515181wmf.43.2019.07.22.03.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 03:27:59 -0700 (PDT)
From:   andradanciu1997 <andradanciu1997@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        Michal.Vokac@ysoft.com, ping.bai@nxp.com,
        u.kleine-koenig@pengutronix.de, leoyang.li@nxp.com,
        aisheng.dong@nxp.com, l.stach@pengutronix.de,
        pankaj.bansal@nxp.com, angus@akkea.ca, pramod.kumar_1@nxp.com,
        bhaskar.upadhaya@nxp.com, vabhav.sharma@nxp.com,
        andradanciu1997@gmail.com, richard.hu@technexion.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 2/2] dt-bindings: arm: fsl: Add the pico-pi-imx8m board
Date:   Mon, 22 Jul 2019 13:27:30 +0300
Message-Id: <20190722102730.15763-3-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190722102730.15763-1-andradanciu1997@gmail.com>
References: <20190722102730.15763-1-andradanciu1997@gmail.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

