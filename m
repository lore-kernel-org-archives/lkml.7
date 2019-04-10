Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96422C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6729120820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxAiqn45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfDJXPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:15:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36017 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfDJXPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:15:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so4862435wrd.3;
        Wed, 10 Apr 2019 16:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1WIGTjZh4mIwUZpoXVfzkYofixlglZX9sKei53EYiYk=;
        b=qxAiqn45+6Y6QrCOAT+10PSRnzGB7LKozH2AtUj3cvq3JTe3BuLLc8gW8tWe8jgGK9
         F8WgiV+wHUZr7Szgs/hXyn/Kb6CG4qFa7KvqU41D3nv5KpxhSxjF9JOc7xk+SyQOC6Ef
         dX/8J6RtKAt+5N1ShFj/WWehH6LqnkvbKXkrySPorA7zNZoIPZnIWsErsrTDR4N/m8cO
         DzATr/BmWuSG6QJB/tGjjDqufAA6bVgApA1rQqPhmYjznCapn6edBoCCK4lzgE01LPtT
         EHoRYtvMVKHONdJllWICY121+zQAMrLzD6sa+mnUkn1dJAYc7tQgC5QwqUYIddGAxUwR
         /SFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1WIGTjZh4mIwUZpoXVfzkYofixlglZX9sKei53EYiYk=;
        b=Odhp8aGWTIJk5Vd98qOz4L9rXgM79g+QBIzVjFx9lMAuv0CUzk87zaBS+lJOc0q8vH
         zH44TQbvmxaMvdX7Mh8FhIP5VR55SBNeW3UW/D+rBOyRjY+ZHquYGnRPc7JMKX2681cS
         Sl47zkPOVHW5DhfqmK405RIhQYAK5GTUkKTdIzga6o95MXsB167vInkMypw6RqYows8y
         ++WSHZQzX15gH+h/VgIqWewvLKAW2QtV87/238CjuBHZQrTNyzIBwdUNYpHJtMBAfmSX
         ZAOvuUqb/JGneY5GlT26oLZYhU1efx6XzwtrCOLZQJIWZxj4DIy+owCgOnRvCk9yH8zX
         TW4A==
X-Gm-Message-State: APjAAAUxeuAYkeNiSTB1cZVcA1+OYL6eX+9alYblV9Nq3EWcVD5BqUMi
        FOcI4L5uWchN13EEe8moeZg=
X-Google-Smtp-Source: APXvYqwga4OsIaHauAmhG+osyPhw8HMrpAIGBiK0NmNh8Kv9TJ2rK2/SwoIBlX/GD+Fc1GjJaDrMaQ==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr24041248wro.2.1554938129907;
        Wed, 10 Apr 2019 16:15:29 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id n6sm8504947wmn.48.2019.04.10.16.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:15:29 -0700 (PDT)
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
Subject: [PATCH 1/8] dt-bindings: gpu: mali-midgard: Add resets property
Date:   Thu, 11 Apr 2019 01:25:36 +0200
Message-Id: <20190410232543.13297-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410232543.13297-1-peron.clem@gmail.com>
References: <20190410232543.13297-1-peron.clem@gmail.com>
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

