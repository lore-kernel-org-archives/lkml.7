Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B88C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B418217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoX5klfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390253AbfGRMQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 08:16:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41710 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbfGRMQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:16:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so25244511wrm.8;
        Thu, 18 Jul 2019 05:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+7D2nyB7IRWk8qYlUoRME0i4EVxQgJrYu1PYhlispfI=;
        b=OoX5klfgY9pwcNh6uyScleKP5/kSaEptOq40fIgaH74lrxx6HFKst5HBu8jcXLuuAq
         8ljOwIqMaDCcdDsqe+uETMha3iJttpKIUQg7dWwqfoEjUbllI9qRJyYdox0sgfsubG99
         wwgnk56x0bwvF+9aKIDxl2FqEiwm1dp2qTurnCxAZAK4BXssY/I1PhHqcLz9xqn2pQP2
         WKizuZNmTEIRwdGF6CxwhiSV1QdHJlecQO2ZoskCGAAsoS1mXAbF94Q2Cn+qihTjW276
         U6oGv4u6u+8ZdnSoDx5XBqWqCsaMIveG93twzvFVTCpQ87yXy7rcL7FI09lU3gx7U7gX
         dh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+7D2nyB7IRWk8qYlUoRME0i4EVxQgJrYu1PYhlispfI=;
        b=guWwc07ufbB0MxvET/adm/pg2xVCnEumqRjpYVxhKUWgHOCmn21nx4NbVkFC4s66Qo
         PPfnmiwAd6m67BspFtvmkOrq5kLij0OH2Z2hUfMzSZceeZV1gW0qmgkD4Pwp1AtrKOBs
         8cGMFdagXKjriG48seIh2/giu09K9TtuDhJ8lABmGS1RC3xZaehDBwiseV/2laqQWMaE
         ovXS+lP9ngBFDE0jIWr7tcJYhqxlOqeO9c/TkVxVDPVslQrSViEIyT+/dkVpXNnL/8VS
         6Y4g2lep22eOOAnEcrD1WmkTyhtfgGoszWtrt/itdEaMJAFxJDR6qN6ZH3NsvfNE8rZ2
         0LVg==
X-Gm-Message-State: APjAAAWfRPPuemlj1APK0XtkWDihhGINVqVbkNDKXln4u351Z1+Fc+rS
        4u3md9PaN3ScnrbdKqC9nVg=
X-Google-Smtp-Source: APXvYqwpdKySKysVN91thSnJ8oAa5LioDdfCld5b6T4ZLJZrJvdR6WmWHqVKUHOK7LYooNUmh+6zOA==
X-Received: by 2002:adf:f088:: with SMTP id n8mr6189037wro.58.1563452213650;
        Thu, 18 Jul 2019 05:16:53 -0700 (PDT)
Received: from localhost.localdomain ([212.146.100.6])
        by smtp.gmail.com with ESMTPSA id f17sm22897463wmf.27.2019.07.18.05.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 05:16:53 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        u.kleine-koenig@pengutronix.de, aisheng.dong@nxp.com,
        andradanciu1997@gmail.com, leoyang.li@nxp.com, festevam@gmail.com,
        sriram.dash@nxp.com, l.stach@pengutronix.de, pankaj.bansal@nxp.com,
        ping.bai@nxp.com, pramod.kumar_1@nxp.com, bhaskar.upadhaya@nxp.com,
        richard.hu@technexion.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: arm: fsl: Add the pico-pi-imx8m board
Date:   Thu, 18 Jul 2019 15:16:28 +0300
Message-Id: <20190718121628.23991-3-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190718121628.23991-1-andradanciu1997@gmail.com>
References: <20190718121628.23991-1-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for TechNexion PICO-PI-IMX8M board based on i.MX8MQ SoC

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

