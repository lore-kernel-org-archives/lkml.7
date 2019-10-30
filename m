Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0485CA9EC4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31F120663
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iXm81CQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfJ3JCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:02:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44766 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfJ3JCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:02:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id e10so1026805pgd.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=19R5LsKrbgqwghaZ71mmjHUlNxFRBymDHjBQo6p8lc4=;
        b=iXm81CQavjLlHdERzGPrpTTyW7r5NcqLhXFQ1WTyFwd+Z6701Mb2qRcRfg5NKqcz9T
         nzePMn/HZp7MECls2uqe67R5z7/Kt84ihDs9n0aseUOZhymnypq1pNIRqiT6x7e9JMi5
         4P8nxqOnOnymKHdeojgbnKk9W9P10K/gCNd76px0xlCr0Ok7i7BigOn/D99Lu6x9cEM2
         khUU9lr8+DL784zXy36KHdzoAVcwpDpoQdx2Ya9i5v1E+7QCJ48ShqIcdLbdKF5YSSGz
         j8OaVO4qQAyXo1Uzd5vKUwAscz2pFh4nZdgUkthhf4AWXGYlWJO6Kb6enL6DZnyYynGq
         soWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=19R5LsKrbgqwghaZ71mmjHUlNxFRBymDHjBQo6p8lc4=;
        b=AB4zwBpBLUHOmfq912Mm1l4u3GvuE5vdkh8mmpV6tkpnEB5fwzGxnR3WLoHmBoUJyS
         bRIEjZoQvcO50mX8Kza9qFbdQpMLP7jKebvIF6kWmVKPm7iBamKI7EYeGXSN0tNafM30
         ci60aFrp7ghGUSI3AnU2b0NZB/FDdh55KSj+qDENYlK4R3++ltYVvc8qcy5KNBovb6dq
         Qd5mzWO9bHl7tkWtNFeo/LAkwPvWt6qf4HvcfEIqEDywBmkd+5dVHXexiKpp04PnjPt/
         KuiAXawkvEFYvXhXAdY0+z7evGkHNDiTQnuwD1nGNAT4ODm37CQteE1D5Eu4vNU/ruer
         0yBQ==
X-Gm-Message-State: APjAAAV+mlKXqGZ3b2DwjgjGxvlcCzAFv29FBIJRMZqxpcJhjsHM7VZS
        HE5ZTCc5MjpYLZ/OPGguexC+
X-Google-Smtp-Source: APXvYqwUuGARa9qA1Xv26SDwtPBHlu97DYP79Xh26qXZ4IpI9ZV/Bzj19v7ntAvjvWo3KKyAV/P64g==
X-Received: by 2002:a17:90a:a598:: with SMTP id b24mr12829604pjq.46.1572426125350;
        Wed, 30 Oct 2019 02:02:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:618e:77d9:c9fa:423a:3851:8df4])
        by smtp.gmail.com with ESMTPSA id g24sm2070351pfi.81.2019.10.30.02.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 02:02:04 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        darshak.patel@einfochips.com, prajose.john@einfochips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/4] dt-bindings: arm: Add devicetree binding for Thor96 Board
Date:   Wed, 30 Oct 2019 14:31:22 +0530
Message-Id: <20191030090124.24900-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030090124.24900-1-manivannan.sadhasivam@linaro.org>
References: <20191030090124.24900-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Thor96 Board from Einfochips. This board is
one of the 96Boards Consumer Edition platform powered by NXP i.MX8MQ SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
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

