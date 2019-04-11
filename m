Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9E9C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD8820850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGjkv/AW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfDKVpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:45:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40608 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDKVpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:45:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so8505587wmi.5;
        Thu, 11 Apr 2019 14:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2wr/p0D10xFIIpnKwI96croYPKLKiRxARTqv9EDdHM=;
        b=cGjkv/AWjzj7FUd6tnaBxt1L4ZCeo2CHHgZx8IccyJRhTnJdkJgAQDZKU2bdnTo8+H
         wGnncQaFHzp5bmSfawg2hxaDl0/idYyMjmvhlqZ36mnv5cAtjM+cUYwJ6AcNVGHMSnD1
         ryQaQOVDol+xY+WPqXJ1nPiFwSFaJHTBAPKQx7otV3VRGJtwar/ZEYybhhUqg60HmXtr
         T3bRc4Nqy1ww+iPhfHwaRya2xN8Bwl4m3x6Sr/jNKBC2I8VsWlOG0k5aWyjev0ZdUVyG
         K6dsjaRp75AiGdZueobAg7zLX21TDlip0F+INPy5noFAI8nau36JR8dKfn0zL5J8DEa3
         KN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2wr/p0D10xFIIpnKwI96croYPKLKiRxARTqv9EDdHM=;
        b=BnE+SpEUeGZZ05dhLu4ev6Ijh+6VD+WMCFQINR+4vFcLr31oJVBjs31pMzTuKY3zSA
         d5iLjXaD6BjxjlUIC7p3ohq7rxVqKoq7ZmF1hFOMqLIARBVmPxlXZJPR94nPlA5Nl7C0
         +fU5LNb8G+cx9sJDt1N6W17YMqPuT3GLQT/pPFh9cuxLE8+u+0yiaWYBjlNgz8OU9I44
         kW9qvqdDFy2Tko4szJhkUB387S/lGmGmBkf05DhNo2fETY9SkbOP1hNP7Wq3IoVWc1BM
         8ObBeJG7gvsPPvS9CpjjJyGCfcMI5A6wYLyvmv/Tsotxjvvmc5h18mMPgLUqjR1eNDRs
         6JZw==
X-Gm-Message-State: APjAAAVJEIJTlYQIwKqFu3yrepnpSXpbcvyKDOrvb/q5kt2ggzUr0BXy
        wrXEtY94pPGkXNMpJJBBIf04jVARVOnK+w==
X-Google-Smtp-Source: APXvYqy7IGTKaTswNq9oenyWUVi9KhQCPhtuFQo+5B4MukKXlYwlrQmgCLRfUrxUR9DOnUMmhV9m3Q==
X-Received: by 2002:a7b:c347:: with SMTP id l7mr8078386wmj.70.1555019099587;
        Thu, 11 Apr 2019 14:44:59 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id a22sm5952961wmj.44.2019.04.11.14.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 14:44:59 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 1/4] dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
Date:   Thu, 11 Apr 2019 23:44:19 +0200
Message-Id: <20190411214422.2267-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411214422.2267-1-peron.clem@gmail.com>
References: <20190411214422.2267-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 has a SPDIF controller with an increase of the fifo
size and the possibility to output the master clock.
However it's still compatible with the already existing driver for
Allwiner H3.

Add this compatible in the device-tree bindings documentation.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
index 0c64a209c2e9..e33180354dce 100644
--- a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
+++ b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
@@ -7,10 +7,11 @@ For now only playback is supported.
 
 Required properties:
 
-  - compatible		: should be one of the following:
+  - compatible		: Should be one of the following:
     - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
     - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
     - "allwinner,sun8i-h3-spdif": for the Allwinner H3 SoC
+    - "allwinner,sun50i-h6-spdif", "allwinner,sun8i-h3-spdif": for H6 SoC
 
   - reg			: Offset and length of the register set for the device.
 
-- 
2.17.1

