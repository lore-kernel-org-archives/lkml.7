Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0205CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCDC20842
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FqRrQeBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfJCGqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 02:46:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35127 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbfJCGqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 02:46:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so1097290pfw.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 23:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m2Ja4VwqADsNhG9MiI8QtGGRH5rBEepqA9PGguqW6g4=;
        b=FqRrQeBDI6qP7YisP5RPpa0YmsWFSjcm5FPhgn4pS9P0YW16mHp84zg7AXHhoqp6Cm
         gDgUpDzbc+PLtvk3hT6omYQpKhCPiie8zC0n6gkOM1ltXtIsdAuhYYixftzVoDlPeH2Q
         azkOMETcbN9z4/zdxXaLLTMbP8Eogw7NEGpo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m2Ja4VwqADsNhG9MiI8QtGGRH5rBEepqA9PGguqW6g4=;
        b=ADx6JIsYaEQBIMhlHIt5BDJVUQoOSbbjxUaGt/XSykXmO07WY8QrAAJixx/6Pc3y2b
         YeXzauzOwRe5qbvfE3XoE8joiTNx8hylOrZoE1qky8oqAaHs1rxXFwRc7ysDiKcETmC5
         8ywReJIFVMUcXRfh85e4+ikr7EBdj4+j37C+Tm2vMa0w8tfsUF7BbKtivq4BjkaMWplo
         loZyGDfubUOUi3vzKLcfb+swcbxAsxPjHHt7/rWoiKCJYZYIEegRMTQfAZyuq81GbJTT
         XcJzvrpyLZk0IDQ3d2lGA69bI3GOCEKwfWU4HrJLJWL7HjFWBNt9NWz1S77YhNqUPE/5
         kDYQ==
X-Gm-Message-State: APjAAAUobgT6Sxhgw9IxQOeHTQwCoYF7xVvdPmna+5zHvAST8PISSVMs
        MVPBjZWybLxqm1S/7z2kU6fukg==
X-Google-Smtp-Source: APXvYqxMytEbu1ysTV0gKAoMi1aynyZ8FC5X9e0oC1J/4KWj6EoCWYIBl53obU0Q0lCbqInhurgfxw==
X-Received: by 2002:a17:90a:a6f:: with SMTP id o102mr8682523pjo.103.1570085175903;
        Wed, 02 Oct 2019 23:46:15 -0700 (PDT)
Received: from localhost.localdomain ([49.206.203.121])
        by smtp.gmail.com with ESMTPSA id b18sm1423294pfi.157.2019.10.02.23.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 23:46:15 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v11 4/7] dt-bindings: sun6i-dsi: Add VCC-DSI supply property
Date:   Thu,  3 Oct 2019 12:15:24 +0530
Message-Id: <20191003064527.15128-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191003064527.15128-1-jagan@amarulasolutions.com>
References: <20191003064527.15128-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner MIPI DSI controllers are supplied with SoC DSI
power rails via VCC-DSI pin.

Some board still work without supplying this but give more
faith on datasheet and hardware schematics and document this
supply property in required property list.

Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
index 47950fced28d..9d4c25b104f6 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
@@ -36,6 +36,9 @@ properties:
   resets:
     maxItems: 1
 
+  vcc-dsi-supply:
+    description: VCC-DSI power supply of the DSI encoder
+
   phys:
     maxItems: 1
 
-- 
2.18.0.321.gffc6fa0e3

