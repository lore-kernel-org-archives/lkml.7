Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA498C28CC4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD2F208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="grc4vc5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfE2K4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:56:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33232 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfE2K4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:56:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id z28so1407538pfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/HOJUJPmu0DEDj06ebaN852o3ZXmTIE5qbyIrE/4RCQ=;
        b=grc4vc5ccDjj9vGZrQtKPLDitASXNBkw5h02ZiZKrmHLtsjSNj70fuqjGVRCQ14aRU
         7XJhUM2Pw9Boghtdessngp/2nRsKNIwLs0YzadVFrG2srOi5gqGysUxZ1iEocuhjGiUs
         G1BHkYB+bvxir0JgGl83waMzduEA5pjUWIGn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/HOJUJPmu0DEDj06ebaN852o3ZXmTIE5qbyIrE/4RCQ=;
        b=CtzpJrP7aKq7PTU9J9zQwEAWeLX2mhGJa1VA6Rp52AnUbrYJA9YFUVfmLvRFEJ0T9+
         qOOudWeoQ9FVjewU7kdqKOtJZ5TVI8chOIOWF49tG9ZrQHVl7aCgPgdxUXkobc8bm4DZ
         U0T+vas8+l2VU7kTjoh2UvbnT0b0jngKtMRyMF+AsJn8M7tegl1k9UIBvBhDMbSwSoYy
         CjriZ/9ishNRluQuI6Mitb6O94wohpSq2p6LnK1nvDIP1mlE+Tjfddv/aBgRYtNiLwgJ
         nxnGjw43YL/iHZBm0Bc8MWeLIDAmRknljde2yKSzkSANca+iW26527CTQLfbxJ+xvZMa
         tAHg==
X-Gm-Message-State: APjAAAVNvhImMjAwXzTLsVOdQL9x52nzKETLjJVi8FviAUNXeqF2SB+j
        OY/wprQ/K0nYHogSgBcZ8NIYOg==
X-Google-Smtp-Source: APXvYqwkDEN5ViwUhtjeUodU3pfOZQ1pY/mLl+5Nf3Rvnz+8uPjdcVebnc1VS0CfP684+zNGbbjsZw==
X-Received: by 2002:a63:ff0c:: with SMTP id k12mr31032943pgi.32.1559127410770;
        Wed, 29 May 2019 03:56:50 -0700 (PDT)
Received: from localhost.localdomain ([49.206.202.218])
        by smtp.gmail.com with ESMTPSA id 184sm18974479pfa.48.2019.05.29.03.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 03:56:50 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com,
        Sergey Suloev <ssuloev@orpaltech.com>,
        Ryan Pannell <ryan@osukl.com>, bshah@mykolab.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v9 2/9] dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
Date:   Wed, 29 May 2019 16:26:08 +0530
Message-Id: <20190529105615.14027-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190529105615.14027-1-jagan@amarulasolutions.com>
References: <20190529105615.14027-1-jagan@amarulasolutions.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 9877398be69a..d0ce51fea103 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -38,6 +38,7 @@ D-PHY
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-mipi-dphy
+    * allwinner,sun50i-a64-mipi-dphy, allwinner,sun6i-a31-mipi-dphy
   - reg: base address and size of memory-mapped region
   - clocks: phandles to the clocks feeding the DSI encoder
     * bus: the DSI interface clock
-- 
2.18.0.321.gffc6fa0e3

