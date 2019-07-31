Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0370AC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3BF208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DhP64lAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfGaMkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:40:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34208 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbfGaMkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:40:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so1220053wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vlLAZG3376vvQfzbiUNES3FqbulnmazxfSm05rud9uw=;
        b=DhP64lAedWvamo5W5NN3GbWU9atBaCuUKmKTJnuEu3/Q6NUXbc5eQ/QJshDzy0Otjh
         /owLX8DA1RrZS89bHOW8e1LI53M7I9FuQMgCNi829xpzCzFcbB0rCmqHrnD/fBUeCVO5
         qCdACesG6Sm21tnByeCJSWeD9JXw/1MyIBydetMPrQHz12+VKhTZJn5BVKn7hSTlc8uo
         AObZiLM7xMJb6jqTP7riFTsok5p2fqw9Mxq/lVLcXlPAMUsBpsx7KerNv0DZ2b9BpikY
         iAaXHGM2U0CsVTUVwMtc8fFV7DLMtP2iXcYfCdoZxraBQ+A/7J/yVAQN26sZDlrI29Rv
         ub6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vlLAZG3376vvQfzbiUNES3FqbulnmazxfSm05rud9uw=;
        b=s0SR8MQkDF01w0uGhHiyRuBWjtB3XSg2DEdF6myjqjsgKyDCr/Dp6qvHI+zKwg4LR/
         HlBrhd2lfvKzdth6NgyZaPFG5Koaasds5potxNRaGsVKKK8cbVstEvl6nwTra32MPk2i
         3TDHRvIUoPDTGp3UDukDpHx79JjQ2kMbXzGi99y7y2iZr/s7g1UQR7yjbax2NWVTKDVi
         JuCIYHlzubdh8Kwvq1ZLmIhgUPxJFmfFZ4F4bgcy4VtIc8VCf/sNyywa+0LSU38y39MX
         O/knZV5z0Aapeqs+9n853iDzPI8i9hJhUCSu+b95VL9s9Ipz4m1TdQbfKuXjRP/y6T62
         0z+w==
X-Gm-Message-State: APjAAAWdQAgvg72a9OjtKhgk0uamPOGVLbOvzRSO6yH8PZUYx0QT3U/l
        bcYdfHUk88kWGfqWQiMnk/7XKg==
X-Google-Smtp-Source: APXvYqwdhbsgWyNma56uwz+SEJ9Te+cQwX4Tmf9Ld57twlw4YO82/Yo6aO7smXGtz7lwTn98lqEPIw==
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr116321019wmj.31.1564576805437;
        Wed, 31 Jul 2019 05:40:05 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x185sm62504271wmg.46.2019.07.31.05.40.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:40:04 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com
Subject: [PATCH 2/6] dt-bindings: arm: amlogic: add bindings for G12B based S922X SoC
Date:   Wed, 31 Jul 2019 14:39:56 +0200
Message-Id: <20190731124000.22072-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731124000.22072-1-narmstrong@baylibre.com>
References: <20190731124000.22072-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a specific compatible for the Amlogic G12B family based S922X SoC
to differentiate with the A311D SoC from the same family.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 325c6fd3566d..3c3bc806cd23 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -139,6 +139,7 @@ properties:
         items:
           - enum:
               - hardkernel,odroid-n2
+          - const: amlogic,s922x
           - const: amlogic,g12b
 
 ...
-- 
2.22.0

