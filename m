Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED2FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4942C2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM2q6YDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfC2Ijc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:39:32 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:38637 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbfC2IjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:39:17 -0400
Received: by mail-pg1-f175.google.com with SMTP id j26so874291pgl.5;
        Fri, 29 Mar 2019 01:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/EbcEuSb4+GVtPwZ6CTWAqigRhpwJKmXogMtZe4IOA=;
        b=EM2q6YDQE8uajRpv97pUFUeqJKZZ/4mu1aUELtmQy9knzFB/8bMF8dcje/WjKS5rCj
         IhcBIt7alk3pF3U9gQcDXeCZkrmCYsiMF5ONyDz1g6uCYepmLqcj2E69UErhMsVn+7YH
         7o6iUrqnbF8OVUWx21Xkz7Np7DMwqJMyGjpnrp6NE95hkcdP27F1NrQLsGxx61pdEHD9
         euIubxXmbRFxb55JprK3Gw117OhGfsmkC0cUVNf5fFOpYsNWRAej6o0IucYbUXaUYr5s
         kcxK8hXaHhG417IYia5N9NV8iXmKgzuTLHOYscm43iB22pWQKDJrCFZ/Cz0a9nInsK1c
         z1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/EbcEuSb4+GVtPwZ6CTWAqigRhpwJKmXogMtZe4IOA=;
        b=SPbrBvq4JRQrfnWW7H6blxn+CJkLHqRINq9EY7TOHPp0GqYl5eKXBx1GzM1spauvTZ
         nmIPuZPJ1Rz69U4KmbdOMX89B+PDGsHPRnAGTCB5Spm9Aa0fD46rteChh47J8QOz9q5Z
         1tDP5FrecuZnMBJ8vBmOvvdUYXywlGnj4gmccgrNAcqgTnpPZHEqSVSXHNkRlPlLbGHD
         hjzIzgw1J0HJLaN9pRrTnX6gtpPGjkSATNlGYE7DB+0O1WC7ztml2I9Dz2q4u+xyUCo4
         IdgdLMARK2cjIwMBpoq0C3SNj+GLRiGZVVla30JsfdXCzTK+LexDvGZA3AWSx6eYY1pw
         AZyw==
X-Gm-Message-State: APjAAAU7ihCL8vCQZs7fEV35dl3g0eDKAFtXmtaO3ZGX8XkKGBs4zTyv
        oEfVPVDuiX/CjWN7dfPJtngRB123
X-Google-Smtp-Source: APXvYqzRJ9RLReddQkT0yKMZKFm7PR7nBzWMj4CO4q/E/cnoq6rk2hrbWTxK5V51oIS0rUAc3IYFog==
X-Received: by 2002:a63:f707:: with SMTP id x7mr36479288pgh.343.1553848756276;
        Fri, 29 Mar 2019 01:39:16 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id z21sm1889690pfn.139.2019.03.29.01.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 01:39:15 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Rob Herring <robh@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: arm: fsl: Add support for ZII i.MX7 RPU2 board
Date:   Fri, 29 Mar 2019 01:38:57 -0700
Message-Id: <20190329083858.9988-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329083858.9988-1-andrew.smirnov@gmail.com>
References: <20190329083858.9988-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ZII i.MX7 RPU2 board.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index fb0a37bf16b8..18ffe3bfecf7 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -141,6 +141,7 @@ properties:
         items:
           - enum:
               - fsl,imx7d-sdb             # i.MX7 SabreSD Board
+              - zii,imx7d-rpu2            # ZII RPU2 Board
           - const: fsl,imx7d
 
       - description:
-- 
2.20.1

