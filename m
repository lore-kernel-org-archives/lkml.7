Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72897C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D41B2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DyFfgQQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbfFLHzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:55:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40129 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfFLHzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:55:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so6297864pla.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 00:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fl90wvGVk9jQf/e3ED2nkXc10vHdjJ0BRJ8wEykJJm4=;
        b=DyFfgQQEx33mWJYiam6MYxvlG5nNkiPk4WCy+71VVasj+drxJg4JufGNFag39gfBEH
         zSr0p6ZySEs9Vb4s9fSruFnjk083UoQt1dAJ4v9r36BI/G4+w6wc6YDXy8MznwFvb6PI
         xzXGKBOgdDXnJ6KvOtldHLy7rk0UPyZ/Ft0P8nTKlNScfLIYyaBJhBdneF3HNjOtP5Dw
         J6CAweQoC3TLOnsXB9kf9xDoMJQKV8fdD2/AOPlBBy8PnfnoUFUrNt4PZ4G0cSrX/2BG
         1p34vLC0YZAaptN62xEiP6S45+MFJgjIVD2HV14gVazd9qNgNEjFwswjK/vwsWG+xD0L
         vgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fl90wvGVk9jQf/e3ED2nkXc10vHdjJ0BRJ8wEykJJm4=;
        b=pYIKmuu2InFQ0WFgLDLfYR6YZQwJCRkewhHoDvZgmoPI0xHTIMTVCzLpJqpVaIji6b
         DPinxj3/bc+I+JXBvkI6NNn/R1eIMUDgckv9+cD3Qm52vUCvQQ8Re7PMEXBrSlBzqxCM
         IfohjqVzre3S9inKVoFlUVIqaDVMK6Uelq6RadKm4E/72KfsHUE/9K4em93rubzMOsG1
         dN9cx0hffer3obwSoe2opILxpsnvle7AX0ND8SWXMqf75nZQUMRcQPuqRDrqi6yUjv2J
         gwP2Das/IXCz4Su5bu2gzqGMLQDzzMaCkXcy9ZcTeyeEvrnY5tLHSWRyuRjXpnF1LgkU
         MU+A==
X-Gm-Message-State: APjAAAUUoufRxwmclyZzq6a8bAKW54Rc5s6ZNNkf+nkryA6GrXUnquYo
        vmELla+iW+akYykQFUcmVx0w
X-Google-Smtp-Source: APXvYqxWBYUdZW2Y4YlWacoCLLvBzvetdV8f6Kh7h4YdWN/CXwrhdOPQFCd141iMalRdxN8KCq/8mw==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr3378053pla.50.1560326121013;
        Wed, 12 Jun 2019 00:55:21 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:894:d456:15b5:9ca9:e3ec:c06a])
        by smtp.gmail.com with ESMTPSA id b15sm16846399pfi.141.2019.06.12.00.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 00:55:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        robh+dt@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 3/4] dt-bindings: arm: stm32: Document Avenger96 devicetree binding
Date:   Wed, 12 Jun 2019 13:24:50 +0530
Message-Id: <20190612075451.8643-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612075451.8643-1-manivannan.sadhasivam@linaro.org>
References: <20190612075451.8643-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit documents Avenger96 devicetree binding based on
STM32MP157 SoC.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index f53dc0f2d7b3..4d194f1eb03a 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -25,5 +25,7 @@ properties:
           - const: st,stm32h743
 
       - items:
+          - enum:
+              - arrow,stm32mp157a-avenger96 # Avenger96
           - const: st,stm32mp157
 ...
-- 
2.17.1

