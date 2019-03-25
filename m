Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CB9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1411220700
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k497gvCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfCYSXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:23:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46489 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbfCYSXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:23:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id a22so6948269pgg.13;
        Mon, 25 Mar 2019 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=myxfOl3x0InEUOFqRtD3dMTsbZllOqZYwFaSG6Tv2rQ=;
        b=k497gvCsPr6WmCbHLrUthEJRLNFTnkn7OucLEwjmTO8STTgGh+h4l28rgn83ujQjIW
         4nq8B6Wf0WG/pfCD/KeqyjAoMpRfs8WPSC0P3EiJnWfyP8YN8IwTE4DPdbH5OzTj5e8z
         z8YEi/03MA9gRrs4yeCmTtySqys/B2pcGdsAcm7EB4f5TjvY5Z8f3m70N2b+N1lEgF2S
         ZChrAz8K1sU58A9nC5kjmVNKtGnNeZn/7X6EtGBqt5HYD55Qy9uxu9TV0VunQEOfc/q7
         yPdksdtIfP1pZs90zDoCcmkMGauAcPH3sM8ytcYXcTJehD25ov29uFW/YVnVtxlj4DiN
         mmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myxfOl3x0InEUOFqRtD3dMTsbZllOqZYwFaSG6Tv2rQ=;
        b=ujRrEIOMxvmAdTQcnvo5UmhCkwVDSBC7ARx89jI/bXD2K5vZhauNyD1aeu04Jkk8iI
         wwlRWECtqEn3ujfJISUd6yGEC2dTNeWxdhhgvRp6mUHHdpb0za3mTShGrWLbWYn7VPJq
         2HsAsAmJbfDOy31+2LoDi194OaRGXAAxKNjXruWdSmsBphrbNQldpAQsIFIpT3gsU7DE
         wtRUpeojQ5ZBX+Feev0JUpA5b9IeEEkszd2YhiS42oUFxWWpGvE9JZRaXk+ndN+l/nLc
         2TOQdOcHQHtVAfYw9+eBB5Z0dvkB+Ja4AcaGoOqlFiUY3/KW176hpSojsOy2fQkfwHQH
         Eraw==
X-Gm-Message-State: APjAAAUfcG0ue3wZgl60uPWCu8sht5yKLGA1NbqW/+tzE9J6hofJdofl
        RdaOTJavMiaunwG7w+eDTSMmZMiv
X-Google-Smtp-Source: APXvYqyrD1XTmaFHge77CAzCKYDqMTGHYeqd6o+TB2YS2McO3SMSqcao+/w/ZQ28Q95ACn3VJeHhgg==
X-Received: by 2002:a65:6645:: with SMTP id z5mr25186678pgv.251.1553538184123;
        Mon, 25 Mar 2019 11:23:04 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h19sm23603315pfd.130.2019.03.25.11.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 11:23:03 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: arm: fsl: Add support for ZII VF610 SPB4
Date:   Mon, 25 Mar 2019 11:22:42 -0700
Message-Id: <20190325182243.16788-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190325182243.16788-1-andrew.smirnov@gmail.com>
References: <20190325182243.16788-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ZII VF610 SPB4.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 431ca87aa600..fb0a37bf16b8 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -185,6 +185,7 @@ properties:
               - zii,vf610scu4-aib  # ZII VF610 SCU4 AIB
               - zii,vf610dtu       # ZII VF610 SSMB DTU Board
               - zii,vf610spu3      # ZII VF610 SSMB SPU3 Board
+              - zii,vf610spb4      # ZII VF610 SPB4 Board
           - const: zii,vf610dev
           - const: fsl,vf610
 
-- 
2.20.1

