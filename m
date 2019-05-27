Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FC4C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFBF2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fmx9pXSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfE0UKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:10:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46199 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfE0UKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:10:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so17846344wrr.13;
        Mon, 27 May 2019 13:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n14EincEgyhHeNXBeUTMMuX2+QPgu7HvYrDyP4chhcI=;
        b=Fmx9pXSzDyPlNYGqK+6K6rz5Arzts2WlpCEd3ci+ylhZxGPmFNMRPHmD9qXjT7aTmP
         r6fSs0AnQZ5yU5E3Zhc7CYlR0LEMh7WvbzVA6GCoQymo70F2bOeDUvUwHnWHkWrbZj0E
         zT2BLNWUsLSX/BQS7Wy+M4nZ6GF0JgfXxQAYpJhDh9WlbSFlcNK0Rp53cVruCNQLH4nQ
         ouYBIQouyrsJ5376q0NBRb8oxpnNfaMfoUhJjSF+QP6ZdfmtjpyRRRDTMlWsA+UnQb7u
         kxMeKzzEr5PmM/x/tGjvoczXHok5VOqZeTbgeoIq/9AxT4G17wBcWa0hGPUBDmjJ4tQS
         Avig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n14EincEgyhHeNXBeUTMMuX2+QPgu7HvYrDyP4chhcI=;
        b=bAUWOn+PXtdoESZh2+8tCnL8uVeU6oC2xZO4DAStLYiFAHmfg8r9d8M4K2+TqWa1KL
         Rcuakb3MR5duGpP2p862AWocGp1vMbGOUgYM8cNZWv8jKyexog1NMct1uAow8Nb1mqQy
         gFBBVMhzkGlg2AXcjfB0J8DzvPpZyC1pzq0p+afN86B+uR9/x/gPI3nGmP2BkBiqG05H
         gBXs5S11zl2GRmdKds23jr+hDyN8XZXA/u5oiLkVSGczac8GcUZTbWQHEqMGMsTsHkrM
         LkMKHWbKymrY99ALl64DGGkfPgUWlbjEJSem2+Xylf5uV5y6SWODYycxFgbZ54vng66D
         O8mg==
X-Gm-Message-State: APjAAAXoF7062b11E6VWUS58vTVeeFhLRKJfEBHDY3k/N7y+uOXCWk5A
        fbZRu9n2fT9TS0AI9Vw/s84=
X-Google-Smtp-Source: APXvYqx7MnbzwbceeHK9CTEcjMFASegph4tm3AEkWAL8pUfeZb/J7jGTQ1b3jiXW3bJTwlKcDKlMdw==
X-Received: by 2002:adf:fd0f:: with SMTP id e15mr12818497wrr.104.1558987813345;
        Mon, 27 May 2019 13:10:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id s127sm308523wmf.48.2019.05.27.13.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:10:12 -0700 (PDT)
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
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/7] dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
Date:   Mon, 27 May 2019 22:06:21 +0200
Message-Id: <20190527200627.8635-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527200627.8635-1-peron.clem@gmail.com>
References: <20190527200627.8635-1-peron.clem@gmail.com>
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
 .../devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
index a49ef2294a74..e0284d8c3b63 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
@@ -21,6 +21,7 @@ properties:
       - const: allwinner,sun4i-a10-spdif
       - const: allwinner,sun6i-a31-spdif
       - const: allwinner,sun8i-h3-spdif
+      - const: allwinner,sun50i-h6-spdif
       - items:
           - const: allwinner,sun8i-a83t-spdif
           - const: allwinner,sun8i-h3-spdif
-- 
2.20.1

