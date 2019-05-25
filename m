Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FABC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D373C20862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giSZXQt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfEYQXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 12:23:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45523 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfEYQXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 12:23:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id b18so12774066wrq.12;
        Sat, 25 May 2019 09:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bs0GZbXZnXWtuyaAPHUlYLzvVYGzvS4bd3eSLwNHTuY=;
        b=giSZXQt0MWlK2fHUjWgOUBvx8c/keasY+/8yTFoSbFYY9tC6K36oK4UShXl4+A3HX9
         Eiaxz8OwyLrYB2+rhcZ9ocu7QTj+KKenYUgfgK9wZdZzzwNnt10Wk9nr30mbXvXRCCwN
         BYqnXEqgr6uBUAtah3FOMG3ShB8A7Jg3bKJk4ZSlS15SBRzratMuquEAkFI59WrweZin
         u8Zbt27nMmkeP+73J2MIylL93doVtr/2IpdCEp3ICmqO//TPqcVOVWDP8d6x8Q/AZ/9r
         LUydzhApeB5QU785RgFXuxzG619sMvNO5ufYUPeiy0qBr/7XEsv8gQWfdQQnBosaauO8
         ePUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bs0GZbXZnXWtuyaAPHUlYLzvVYGzvS4bd3eSLwNHTuY=;
        b=JzgbkY1+z85tW8k3wIYVl48VxaDx03+vp7ePfUOX9ypZN17UdJCEYwUgC1k+UcAOFU
         4oQwxnNHUXySGtWRoPXQTJVRaxF5yuO3PNxFhqhyl+rgr0SVABEr1Ipl8VC96OyYZbg5
         W5Lss3eNMQXv/ohhBAxe0hMzSqGpH72rZCkhtNmpVoibFRFjmxeo18Z/xMA4Ijbn4CHx
         5CvvzulkebqTK9IuJrjxFGzNJXFZoT9v1T2tIjpBiBFG+ctYE1G1ZRBXLxlqNmFK7CNA
         d/bCxT4lRLHDFnfVdO8sF9df5MwqpI6YiIfiL2AoVhXoIUFtuNaKW6KStzH5/8/BykHo
         eNdg==
X-Gm-Message-State: APjAAAVS+gAdHsmG+A1YFekmt4DBtfhuTCGhPQR+z6IwhYeAhm6sAv5i
        Ro4sTmO7TB4+OSaTcKJ5Nmc=
X-Google-Smtp-Source: APXvYqyj8HVx5lOCz7RholqarzDrKbt7byE/t3isboLhVRwX4Won+3vr3HChJcAYfxYvT9D3qtImPg==
X-Received: by 2002:adf:fc4b:: with SMTP id e11mr4209008wrs.340.1558801412178;
        Sat, 25 May 2019 09:23:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id k184sm13194409wmk.0.2019.05.25.09.23.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 09:23:31 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/7] dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
Date:   Sat, 25 May 2019 18:23:17 +0200
Message-Id: <20190525162323.20216-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525162323.20216-1-peron.clem@gmail.com>
References: <20190525162323.20216-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 has a SPDIF controller with an increase of the fifo
size and a sligher difference in memory mapping compare to H3/A64.

This make it not compatible with the previous generation.

Introduce a specific bindings for H6 SoC.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
index 0c64a209c2e9..c0fbb50a4df9 100644
--- a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
+++ b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
@@ -7,10 +7,11 @@ For now only playback is supported.
 
 Required properties:
 
-  - compatible		: should be one of the following:
+  - compatible		: Should be one of the following:
     - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
     - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
     - "allwinner,sun8i-h3-spdif": for the Allwinner H3 SoC
+    - "allwinner,sun50i-h6-spdif": for the allwinner H6 SoC
 
   - reg			: Offset and length of the register set for the device.
 
-- 
2.20.1

