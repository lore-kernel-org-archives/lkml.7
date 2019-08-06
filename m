Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F92C32754
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6094C20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="O3dE1DHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbfHFMuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:50:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52255 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730458AbfHFMuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:50:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so78057230wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yzbvwLA71SutNdcRHcgBexC8KRT0RQ0GJQYA84SLkGA=;
        b=O3dE1DHluIpu7fXmyotf13Fm6oEcfDpRu2r5FwuYeHLyxbncudzQIuUVO0dpLrlcPF
         tGM9uz0klewnYgo+rd6yN2F4qAq82UhQyCJRQxj6dtH4eMEcvzoremBWPJhmfINtmfzx
         upgt7GL6h3RkZUmi+HxHGedeta4NBcC2tNsg1pPlSkqkCRcQ++SGOobtwg91tWVaMbbU
         Bh9T0pYvxKSEdp0vvYRhP7h528nS6XSUJBLXObD//8iAITlP2THqfu7y5F87wRXlQMUE
         hU2mxHpNtD9Qxxog1+yr6cIIO6mnZnXBNXdRSyH8rFuH6r+8kh3o4CSGRLiTj54qJbcq
         iNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yzbvwLA71SutNdcRHcgBexC8KRT0RQ0GJQYA84SLkGA=;
        b=BWDtA7UeScR3p1trJJRHft+gpO+nOB1SXvPVaaQCRUjEk1xDttAxIeXbWUuGihy2e9
         npV2VtIRk7QqYVoqFzsSyusLStUYWXcZVRavXYvfDFWQDosSUteqOPB1ymZZ2b8zGjkP
         EfcLtqhcau4yiz/4UAODpzIoHLbqNbXC3onqM9m6Ht1GrdyAxRz0B2nNO1OGAua6zAQZ
         oCB75FjjlOSqRc2uNOm14TWFIKFuqryZC4jqIuOdHwTVPuW1RzTU+XrmVtJ4W7Zd3V9u
         DWsJAdozbSzin9bfbjRepR3kxDh5URrnf7gqtEaX4A+ZYmbdcTv4KVaMBDe11QIWS63H
         f6NA==
X-Gm-Message-State: APjAAAVOcFQE1iPzqd5TP3aSxhzNDKdS4jfIyQBP8zghFtn5NBA1cA+j
        rGNr59uxYcA/aQpq16wRL0rELw==
X-Google-Smtp-Source: APXvYqx80EosVrp9UyukzeR9aDnPspDjd/F40dn6Me7nABU+FtMHoLvpD/lZwMP5x40WKWnwAvJUJQ==
X-Received: by 2002:a1c:c14b:: with SMTP id r72mr4792277wmf.166.1565095844304;
        Tue, 06 Aug 2019 05:50:44 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e3sm109049221wrs.37.2019.08.06.05.50.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 05:50:43 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: net: snps,dwmac: update reg minItems maxItems
Date:   Tue,  6 Aug 2019 14:50:40 +0200
Message-Id: <20190806125041.16105-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190806125041.16105-1-narmstrong@baylibre.com>
References: <20190806125041.16105-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson DWMAC glue bindings needs a second reg cells for the
glue registers, thus update the reg minItems/maxItems to allow more
than a single reg cell.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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

