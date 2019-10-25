Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB2CCA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10E5205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nzR3p0+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbfJYR5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:57:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42985 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbfJYR4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:56:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id c16so1624358plz.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 10:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLu60EjnRBnW4wz32/fkJTOsgD5cNWvT5qBN+RYNBTg=;
        b=nzR3p0+HUwjXCJKFafzIo/pTdfwQapiV5SDEz31AqhqaOqpWV+6AfLRqzgUNU2dQll
         GQOezQcsxvulPc8HLtausz/BgBiI92Lo/kgjsrUkgENWm4yzLSud7S0aX+UPD7aWADn8
         3z8WU/qkfRHqIk4IhK1d19jwGUosVM0Ma0W8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLu60EjnRBnW4wz32/fkJTOsgD5cNWvT5qBN+RYNBTg=;
        b=pTSsQnof56LHg1ndd/c9JspdZirLgv88ZU9yozA4UrDVcaFGbbWoJB7KQm/EKQoIxq
         /x519DzEBbc5MgslR8s2dqWw4BjslJyttuGPGG9ToPbBVZ4EDwDBeB4sJwVOWgMEe9Ef
         qG1V9yYJxnzArPqXXMwuJxIh9Wzzpf3mmJ6eLyZKqOfiALIJYUWbKt4vhmZkMAvO+Juc
         Pmy9Hz2XyRblwnflG1l++xd9ViuheEaTl3erL8BgslJu3OETskGXAby2UBxNPtLDFlUO
         xBvxOCWX2U8fB7R4xoZKx2cgui1H8fM17TXgAd5yFRnX2foxQ3cnszhyMzox1vZa6bZm
         YADQ==
X-Gm-Message-State: APjAAAXETf4cNpKPzsjBLJEn14kcxgtZVlM41+hrneY1jlEjt947eds4
        k6Lg4miAkgjYq9zfJxfQafhl9A==
X-Google-Smtp-Source: APXvYqwG2PcwNymr0aLBWSu0Ew+FNG8Zo1et6ICQyCp5D/JHBAhCy2QuD7wY9vd+w8cmoYVE4JztoA==
X-Received: by 2002:a17:902:304:: with SMTP id 4mr5342476pld.106.1572026214910;
        Fri, 25 Oct 2019 10:56:54 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id n15sm2926580pfq.146.2019.10.25.10.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:56:54 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v11 2/7] dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
Date:   Fri, 25 Oct 2019 23:26:20 +0530
Message-Id: <20191025175625.8011-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191025175625.8011-1-jagan@amarulasolutions.com>
References: <20191025175625.8011-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI PHY controller on Allwinner A64 is similar
on the one on A31.

Add A64 compatible and append A31 compatible as fallback.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml         | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
index fa46670de299..8841938050b2 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
@@ -15,7 +15,11 @@ properties:
     const: 0
 
   compatible:
-    const: allwinner,sun6i-a31-mipi-dphy
+    oneOf:
+      - const: allwinner,sun6i-a31-mipi-dphy
+      - items:
+          - const: allwinner,sun50i-a64-mipi-dphy
+          - const: allwinner,sun6i-a31-mipi-dphy
 
   reg:
     maxItems: 1
-- 
2.18.0.321.gffc6fa0e3

