Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2511C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8225F2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vUTzQTaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733233AbfC0Kdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:33:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44905 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733197AbfC0KdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:33:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so13757608wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nPsAcmFFVoD/0RGDFe58K/8oQV3L3d1wViSopJ+f2wU=;
        b=vUTzQTaJ9/onoSesGv9BFZMJKoEoiyAjX4zttjsLFU132nIGb8tzwsIiUbbbzrETnQ
         Jx30MZ4o8Vzif/CAjvczaspcizjHwwwsIIxg2a1SdMovkBcBcDTapyDdfCfBr3QF5sqJ
         fT3v+TY+sAAliKBcvIbaeVH9FMJuaveM0HLAvRFL/cNnoKXSWV9fgruT76N1b7HkU8fJ
         DtGxn2AnWiKN4nxPyPc9PXTuV7kkk7YyxCP2akaZJAInM29mFAw2BQxckSWwX2MCgH5H
         sr1Xs8qZPl0jIl/w8ki2MYBR1KF/lf3Hjxn6apQQm7dfB4VhK5C8NcPI2kKI/4DRn1Ul
         VqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nPsAcmFFVoD/0RGDFe58K/8oQV3L3d1wViSopJ+f2wU=;
        b=YBVJf8WuV0F+dQwRBMKCFI9o38kyVAtYcgyGTTfVXH0roRPW+mariZpQbtCs1zXBkF
         xuxnnnt3l0WC9CYbKFYa3V5k5NjU18hk9tNgv2ogb5gLGevCW94wnbNhyZYs3lSmmfcF
         E7nnpAoFBFkJBdHEU5m9QGqWwiOGNhNbLNhpPluxOxa6zxaDousgRST2OOY31W7Yq0mg
         Pxoj9iA34jJ0VVc2p6xRVIX2qY0l/8dUPcnf3qyDuXoWUCbnmcdiDgj7PP5R7cwk7k4e
         G2uX7HelpS8pO5HyC6xR+mmlvOhQ5QgQuyqxk36Jx/5hKcNDGJy2Mdblbeu30Vjbdb3X
         qnBA==
X-Gm-Message-State: APjAAAW0Ticx+b/JaS9EoNTQnA5xG5CsWsJhkUaeBXVH4MDpJYvPQSiz
        ScdKVjvW5gsMOqCyc02jAxlAeA==
X-Google-Smtp-Source: APXvYqzPHdoMGWkCKEbtzbb9UbLgqZ92xIsgK4/GZ4MLmdzAQtza5TO2ezDhtZxSTc3+Hlm590Ezew==
X-Received: by 2002:a5d:4f11:: with SMTP id c17mr345185wru.34.1553682795104;
        Wed, 27 Mar 2019 03:33:15 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a20sm27017513wmb.17.2019.03.27.03.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Mar 2019 03:33:14 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 4/6] dt-bindings: arm: amlogic: add G12B bindings
Date:   Wed, 27 Mar 2019 11:33:06 +0100
Message-Id: <20190327103308.25058-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327103308.25058-1-narmstrong@baylibre.com>
References: <20190327103308.25058-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the Amlogic G12B SoC, sharing most of the
features and architecture with the G12A SoC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 061f7b98a07f..94bbcc646e10 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -61,6 +61,10 @@ Boards with the Amlogic Meson G12A S905D2 SoC shall have the following propertie
   Required root node property:
     compatible: "amlogic,g12a";
 
+Boards with the Amlogic Meson G12B S922X SoC shall have the following properties:
+  Required root node property:
+    compatible: "amlogic,g12b";
+
 Board compatible values (alphabetically, grouped by SoC):
 
   - "geniatech,atv1200" (Meson6)
-- 
2.21.0

