Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E16C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD59A2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="p9L7TRcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbfHHLlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 07:41:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36206 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbfHHLlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:41:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so2093261wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 04:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FvEHw13SSjNx0rO+Eb5GpaVPObzVB7Z/B/DYj0wmNjo=;
        b=p9L7TRcusWrL03ffcFUatHnu7a3wC88l/KhBLtA+5SK9PFmIMqlVSYH30UPzwIb8OO
         AA1Lnk1arUdN+6hDPDkXQFBLiDuOKO3qx7BQJNrxakZnrnwZdGgJl/fchkidNPmnoadz
         Co6BvOtphLt0hmzPBssqtTHX6KLQR3A4XbkT7liTQUasJpNlM49mPSwB9RKGYpLwEI7B
         HjFxhgKPGz2gi1GR+ReHnuQ78D/NCeeiPEeG6JHa2PosCVkmUiU6oF1SGjrWdFGITNOU
         08aVw/N2Ivy201GalDcBQ94wweclM56AfVzFh+hqTLHTxDjXkNBOvTbkra2hUVgzy/zX
         FqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FvEHw13SSjNx0rO+Eb5GpaVPObzVB7Z/B/DYj0wmNjo=;
        b=ok8snxvTaS692MchVdB/O5iN/n6BhoLbMnPSkTKkzUJOzbeE5GNho8mVDr2/U8vuLj
         bKLkE73cgwFJjrihpiPFSRDRLG1DO+6OKBdHndkYdrSZYd5zdulHThJKilDBBvhC6YvW
         qs8zIfbGRlQXsHAtKN8SD8rj8CSKPGQmd3wz/KMQSYNG+Vfi24e+y9y09/JqUAyLbYla
         aLFBwHJ4JxQjCclkmvhSDiDUkj3c28fe4gQfLyLs7/UIPVZypwYCkKjSZXDuhY3cjmlS
         HSH5+GKcmwtnoSk3OtM9jCNehilei4lxaz8OH88BsE54J9aXUvs1mMJT1U3cTW1nSZd2
         W+YA==
X-Gm-Message-State: APjAAAVKofTJFSKxTadJjhZPCpuArb33KiaNEuHSeRPq40VtFqQm19gd
        VOsaXr2SDyeoG7axKgSvGQjwtw==
X-Google-Smtp-Source: APXvYqwwQF4nEozwvl1ltX1EUHmBeoypnEtCvb7R92cEQ+NaOXqnoC9eAitquC1kL/PNebqoN8UHpQ==
X-Received: by 2002:a1c:2c41:: with SMTP id s62mr3995039wms.8.1565264464549;
        Thu, 08 Aug 2019 04:41:04 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f12sm104555882wrg.5.2019.08.08.04.41.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 04:41:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 1/2] dt-bindings: net: snps,dwmac: update reg minItems maxItems
Date:   Thu,  8 Aug 2019 13:41:00 +0200
Message-Id: <20190808114101.29982-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808114101.29982-1-narmstrong@baylibre.com>
References: <20190808114101.29982-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson DWMAC glue bindings needs a second reg cells for the
glue registers, thus update the reg minItems/maxItems to allow more
than a single reg cell.

Also update the allwinner,sun7i-a20-gmac.yaml derivative schema to specify
maxItems to 1.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../devicetree/bindings/net/allwinner,sun7i-a20-gmac.yaml      | 3 +++
 Documentation/devicetree/bindings/net/snps,dwmac.yaml          | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.yaml
index 06b1cc8bea14..ef446ae166f3 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.yaml
@@ -17,6 +17,9 @@ properties:
   compatible:
     const: allwinner,sun7i-a20-gmac
 
+  reg:
+    maxItems: 1
+
   interrupts:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 76fea2be66ac..4377f511a51d 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -61,7 +61,8 @@ properties:
         - snps,dwxgmac-2.10
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     minItems: 1
-- 
2.22.0

