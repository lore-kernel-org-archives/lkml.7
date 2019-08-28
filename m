Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2C4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A272189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="od89jVX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfH1T5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 15:57:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45764 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1T5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:57:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id k13so930268qtm.12;
        Wed, 28 Aug 2019 12:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8TI0FYfNM24ppkJYFG6qOg+IUh+v/+7bkBCmbd/o1U=;
        b=od89jVX6U1HTi2Ua0mQBqSe9vCA9lhvMN+NiX3sSQ2zqbFaFsl3Ec/OZ526tbAYWSI
         JQAAoYmaSvdo2sKk4wMenaTTMKsWjXJu98MMUnyrWuc8AyJqtyU+dPCyKupXSYqgQw5F
         cfdMgjSKfULJWwk0gLhPORT/Pix+JwjhE99314NnOCmFwxclFVlRvEKuPpFogSFHud3w
         kwDH6+cpZYu/Yhn2xsHvNAe9E1bjetWXmrhm91Z+hLL+0dC3QK38d/2h4eFTuK4ni4RX
         7pz/lcpXaMALM5cvu60lLXVkVfAjH+ezK/33OU/nCupZCsYdxyjoLggP3sJ5jK77gOo0
         vrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8TI0FYfNM24ppkJYFG6qOg+IUh+v/+7bkBCmbd/o1U=;
        b=n9zCzhtnQN4fap4PtQkpidY/hoz/IsZuHuVXB8f3CVmX9R3KvWWVCgrwlS3sfrrg95
         uOhgWEzk3tr6DY/mzcLeu9/vNXvO47JNp5X3y9h2Qbo1yI3TqDCtAViVG2Lbgz9c5bJz
         PKhf8xlWxIJFTf6gOIhG4+ONu8aQgOpaxpNVgJDhq/U0zTv8RrVRQlBDz+ynoKFB/2N1
         Y6CbK2FwLLUEmtcK61i+ZQdiONwWyMGMs44mn1bpJRYawjjbzudPP6osM/txz/dhdBAJ
         FJFhZF1a/WrWitNdTTj1HM19Qmi9BQa8KsNEWE1dFvq9OmaSh+e57acoOpT4MvX9XbuY
         yEpw==
X-Gm-Message-State: APjAAAUsV8qnoGmHJZSPqjRhmaBwNuc8gysNwr86NuPpaV/W+GZSosxM
        nXHMj8S1X5OL0Z6fJ1eRcaY=
X-Google-Smtp-Source: APXvYqzT87+RKNEsWkCNXwUBTwGxlha0v6Y5m9kSXMYf11Ty/t78K9JvfdUPECbHxaWLT//6zXsroA==
X-Received: by 2002:ac8:4895:: with SMTP id i21mr6318407qtq.146.1567022253364;
        Wed, 28 Aug 2019 12:57:33 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-170-30-28.mycingular.net. [166.170.30.28])
        by smtp.googlemail.com with ESMTPSA id q6sm105689qtr.23.2019.08.28.12.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 12:57:32 -0700 (PDT)
From:   Peter Vernia <peter.vernia@gmail.com>
To:     peter.vernia@gmail.com
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, poeschel@lemonage.de
Subject: [PATCH] pinctrl-mcp23s08: Fix property-name in dt-example
Date:   Wed, 28 Aug 2019 15:56:09 -0400
Message-Id: <20190828195609.4176-1-peter.vernia@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device-tree properties documentation-file specifies the property
"microchip,spi-present-mask" as required for MCP23SXX chips. However,
the device-tree-source example below it uses only "spi-present-mask".
Without "microchip," on the front, the driver will print "missing
spi-present-mask" when it initializes.

Update the device-tree example with the correct property-name.

Signed-off-by: Peter Vernia <peter.vernia@gmail.com>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt
index 625a22e2f211..8b94aa8f5971 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt
@@ -82,7 +82,7 @@ gpiom1: gpio@0 {
         compatible = "microchip,mcp23s17";
         gpio-controller;
         #gpio-cells = <2>;
-        spi-present-mask = <0x01>;
+        microchip,spi-present-mask = <0x01>;
         reg = <0>;
         spi-max-frequency = <1000000>;
 };
-- 
2.20.1

