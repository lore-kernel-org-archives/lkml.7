Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28107C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEE52184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+CPze15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfDKKrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:47:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40745 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKKrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:47:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so6085036wmi.5;
        Thu, 11 Apr 2019 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1WIGTjZh4mIwUZpoXVfzkYofixlglZX9sKei53EYiYk=;
        b=m+CPze15BXpmCnfHe7tC+npflErN9n978bF/GtAZ/nX87YZWIgkaiMAFrwvD1Nrjy+
         qlVaufbg7pJdUuYiibezwwJXcrv74A9kcUAJzI3Ir4CxYK5U815wQg3BO+aYXb712Zic
         EO7sNsV7fylxIQ4eTCq5aFi7Tj3AHGdVCjB8dNPf05XaDD0I5YHFoc+m0WfI5wYuP+6O
         iRfkka8jrKWj3VtFFiXQz1GzO95TsPBeo1xH7lTTR6jbTTw3wUsGelJEupKeedmQs4fL
         Jc0tWoQK3mtQ/oVVMwJy3m04B0HnJZhHVDZEprSuYTDsCwKTNyv1RRA4BXqmZAdryTxk
         0afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1WIGTjZh4mIwUZpoXVfzkYofixlglZX9sKei53EYiYk=;
        b=YVbXiRbR+iw9h1clW+8FHhh6mZRaS1lc6tw9s/CU7HcqQR7M17jwPCGjhw8bbGdFaz
         O/fgtHqoGjH3l5mPaoOI29hFAC+rERsKzyJYhlLnNPHXG2F6v/AWKTgyOmVywrUya5US
         rBGpDqIy7bNKKb/K5Tod60uxbeiUraZkRP8VU2+Zs5LXA99Ql9Hu6SqhxpI3dslyfs8q
         bd59tfLszA5fon4MYWJxVWHHEiMa+gQr+8YNmN4Yx2ljhzMlULkfAHJi/TTs2dss4tYb
         gVrDjhvusc3r8fX0Bh7Sjbi5U9olPHVpm7OPDzpy8R6E4htq55raix4HjrRUYdPDXF1Y
         L7/w==
X-Gm-Message-State: APjAAAVrG6+gdmOr/2fkd8SonEifxV8ozLjO3oohUFIb/RIz5eCMAQn/
        NOu1SkUKutRkDM/iTBbcd1E=
X-Google-Smtp-Source: APXvYqypVQbIptRxZbWO4OESOGCBjxgP1jLmEUbZYgewaa0EuMPpeITisCxAjn+XI/8xMN4HpeSQVw==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr5976460wmc.137.1554979657350;
        Thu, 11 Apr 2019 03:47:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id k4sm54987587wro.33.2019.04.11.03.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 03:47:36 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v2 1/8] dt-bindings: gpu: mali-midgard: Add resets property
Date:   Thu, 11 Apr 2019 12:57:13 +0200
Message-Id: <20190411105720.32357-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411105720.32357-1-peron.clem@gmail.com>
References: <20190411105720.32357-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

The Amlogic ARM Mali Midgard requires reset controls to power on and
software reset the GPU, adds these as optional in the bindings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 .../devicetree/bindings/gpu/arm,mali-midgard.txt   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
index 18a2cde2e5f3..1b1a74129141 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
@@ -37,6 +37,20 @@ Optional properties:
 - operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
   for details.
 
+- resets : Phandle of the GPU reset line.
+
+Vendor-specific bindings
+------------------------
+
+The Mali GPU is integrated very differently from one SoC to
+another. In order to accomodate those differences, you have the option
+to specify one more vendor-specific compatible, among:
+
+- "amlogic,meson-gxm-mali"
+  Required properties:
+  - resets : Should contain phandles of :
+    + GPU reset line
+    + GPU APB glue reset line
 
 Example for a Mali-T760:
 
-- 
2.17.1

