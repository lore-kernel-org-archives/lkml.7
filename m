Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC61FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA1B20854
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdDrImZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfDSTOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:14:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38988 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfDSTOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:14:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so7966610wrn.6;
        Fri, 19 Apr 2019 12:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aqxEuO5Wa9TNowRy0k4ep3/SVha/dtjGZVLoJh0GNOs=;
        b=IdDrImZjfvTFcOS0wXsQD7ySNlwYcF15CQsiJooKs7WUZzEymiS8t1SOmb/s0j2Vqo
         fkJG23FA/ZUTYX9RMJwr+TPQIwE6zhdNkBnKlrcVvVgqaOXAU5U1DITtyt/rxQaIrXMS
         gos/qNewORkA5UmDKtfQf4dM7tbl7gNau1h9mqC5PAJIJrGSMn8Y2Pd92spqbtw2j/b3
         t38EtSgXjv4VBcJFioEHBf7dH3HhJeN15DvmsZ/8T/U4zGgwsc2bM7tVYXOB/+JjySwk
         lvWU+0R5b6qPBsalFqd2+VVxybiqoEf0iFE/N9LFpWDaG14UZvGSiWAHE68s0QcCFeMS
         D2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aqxEuO5Wa9TNowRy0k4ep3/SVha/dtjGZVLoJh0GNOs=;
        b=LgO9e3xZaerTwuZPRmWE3SV+9gLTYptbkG4UgY64NJUmkR+q88RnepfoiDxC4+vRkZ
         PB6WmCPekVOe5oeAmLvTpv/7Tlr8ydwmbPrTeJgNXG5gJ2Q1+mbRXffywU3oJltc9zLX
         TFEkaGkCGqddNGLQBQ9PkRJduyh8mXHShrMOU9WegYNE7sT6liUrKhSZRuBVZRQP+oVz
         31xaZ88AlYJ/1eTABdBtmHWkU/mdvchQ8iCOB4TH/pnxOlcc76lm3qu+S3cpULdZG/P+
         ALftPdY2aoNY5Oi7BA1Uk7P0rcgIznKt1rgv15zzSbLiy5R6fNFBuMSaxsrW9blWwBwp
         hn3Q==
X-Gm-Message-State: APjAAAVTn5sgW2XdT1xw2O9Fjp0sTA7dq16OQ47x6w1J7fyfObKQn60S
        5mGqHXW7TEuigVIXHndLKfwDT1Iy3UW58A==
X-Google-Smtp-Source: APXvYqxmTFSd8dtc1UTyylmRoEPgB2qijjF1d62J88FBGA45NqbedyiHyX/nNSUO4x5v5MnMa6irHQ==
X-Received: by 2002:adf:8bc5:: with SMTP id w5mr3972111wra.226.1555701258412;
        Fri, 19 Apr 2019 12:14:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id z18sm8131149wrr.90.2019.04.19.12.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 12:14:17 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 1/5] dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
Date:   Fri, 19 Apr 2019 21:17:26 +0200
Message-Id: <20190419191730.9437-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190419191730.9437-1-peron.clem@gmail.com>
References: <20190419191730.9437-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 has a SPDIF controller with an increase of the fifo
size and a sligher difference in memory mapping compare which
make it not compatible with the previous generation H3/A64.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
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
2.17.1

