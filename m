Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3939C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8880821882
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6j+mJCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfGSKse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 06:48:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38158 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfGSKsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:48:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so31809145wrr.5;
        Fri, 19 Jul 2019 03:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F6zESjJw5gi9GyaRx05z2263B816bds++z6rEjY7GBY=;
        b=l6j+mJCAz/Hq7txaixfW57z5tP/Fjc3rd3mO+HrlOcYTMDonZ85id2k6kJjdWEOWDj
         Kpb2d7VxiHEcMwMpvJb5vgs2hYS7JzF8Nl6Hsteai5V7OF30pYbhNCq1oqguV1Bs2XNu
         88a0qlj9n7B4i7lIGNilgCfjSMzpwEcphxzI+F+g/3EKKxZZDdBkD6R+IxYTDK8hBKOY
         awKcvk01K2XSn2BaPubU6LVOFbpjIgvRT4dl3VmJRd5XOu8crMv4R51+xRX9teO9K2jU
         8rfylWxESifRldvD8ntYAvZ7VGciXThd1at09LoMdAF3JcMgrLXPpwfAKBuiVI0GdwLC
         98UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F6zESjJw5gi9GyaRx05z2263B816bds++z6rEjY7GBY=;
        b=H1Ybr6RmuFmjZAfGR/kp3BQNFDuAJFJQ/f4VZcfuPHyPi+5+nQiEmp/s3nsrMfJdgP
         b+W6s+czj2TWMl1QyPQ0PT7feNT+QJ0KEckWsp1C/16KNN7fuIWf2S0aK/jJ6hqQw6aS
         sRqOqmiwilWUJ8NyffrKmA232bvq5WjWOPy6BCDR/XQmoBGJEptRCwaB1QQx499cZm9i
         AYgoXLsskqOtCO3XpGUbUY3cp7jUFLW4/V2ZnU2t6N5BQhEMDZynKzQzhdwvj2dSBIvp
         iCzQvkMdUtOMFxQG/EjXh2H5BfIY/fSUHAfMOgy/17g8jALsyqHn54I1kpvG9M1prNCg
         DhfA==
X-Gm-Message-State: APjAAAXTj8Zzj+CDoG/mdfwIHscUQo4qS+Ioq6mkk4ixLTlKN72lotfw
        YovADDqlelrtiS1FBEIrSIA=
X-Google-Smtp-Source: APXvYqwm3q+6YT5lTT4nSCebmWLhcqNDHTsIASkXoH/IBVw+8AisfnaQieVklfWjF0xDcdQlrvzj5w==
X-Received: by 2002:adf:8364:: with SMTP id 91mr55545015wrd.13.1563533309849;
        Fri, 19 Jul 2019 03:48:29 -0700 (PDT)
Received: from localhost.localdomain ([212.146.100.6])
        by smtp.gmail.com with ESMTPSA id j17sm39635565wrb.35.2019.07.19.03.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 03:48:29 -0700 (PDT)
From:   andradanciu1997 <andradanciu1997@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        andrew.smirnov@gmail.com, manivannan.sadhasivam@linaro.org,
        ping.bai@nxp.com, Michal.Vokac@ysoft.com, leoyang.li@nxp.com,
        sriram.dash@nxp.com, l.stach@pengutronix.de, vabhav.sharma@nxp.com,
        bhaskar.upadhaya@nxp.com, pramod.kumar_1@nxp.com,
        pankaj.bansal@nxp.com, aisheng.dong@nxp.com, angus@akkea.ca,
        richard.hu@technexion.com, andradanciu1997@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/2] dt-bindings: arm: fsl: Add the pico-pi-imx8m board
Date:   Fri, 19 Jul 2019 13:48:02 +0300
Message-Id: <20190719104802.18070-3-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190719104802.18070-1-andradanciu1997@gmail.com>
References: <20190719104802.18070-1-andradanciu1997@gmail.com>
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

