Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDEEC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D5D2070C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xarmdgAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732166AbfHFHz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:55:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45990 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHFHz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:55:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1so574400wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 00:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NZRqT8V+HbaNyUlq3PdBNLAEq/GOVw1hFRgyTGAZtYU=;
        b=xarmdgAb/WJ9uvxeIe7Vvnuil2dEKchf6tYjy8/jZl8nFLLjSJPqAS0O5pOi/iLqEP
         LNTPcNvW/M+iilAxfnXWBex9Gej95dQnl8JyhGtmVJjcOCe1bM1fTpkGTxdABhKl8Lbd
         i7h607XcKNy/vmaj9QEeMNQRJHB4XjeCEXcRe62ehN+bjsC6uoW7Doqy+hsTr91TUg0w
         HTpi3lWeBPbGzHmKNxlDrENj91LydNecOWqUNEAeNMtx4KYRndhdjatqBgUl8hobEd2S
         90f5DI8yESaDekqlY00MwIwgEMyfrabfwIpXEmHYw5OTqIZyFncYfjFWNv74xCxekTie
         Uu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NZRqT8V+HbaNyUlq3PdBNLAEq/GOVw1hFRgyTGAZtYU=;
        b=VdHAE1lBEsc2HjE7BiSlOXM1J+fmsSd39T8T81sfGfjLl6IH1ShnVjEc2d/P5s/fpV
         MID4/QGBwaYb/JkQk5yhU8+utMDuOG99T8U0KdvfeNLFWKrYmTsnEi7CEknISVlarLx2
         qKUFEnjGf/SBUlNXm3khjE3P58RJsU9WXnpUyDUw3VWqREjWjsh1sC2MXJ6gpX/f3/TL
         O0YRtGDjUE0Fyr6pwP3HAmSHDXXW1O8hjBScX/aZamklZVokispRz5GmxyUu5ib4AQp/
         YHHepnwCMRv8BiFw7FzRlVY4OudQkg57lR+dQTvdTO4O9aEPQBfIrm40Mi17WQURo4o2
         KYuw==
X-Gm-Message-State: APjAAAWqVhL1tZQ3uaVa3zO6+Kb76mphFmp80/qGjuip3lHcMXW775yX
        /ojjLHw47YXnueUCXXZWI4LVXA==
X-Google-Smtp-Source: APXvYqzfaTBkqaGB//oMRTCwkGNn27u+6JoIXAVBcyBbQWY0HtlhPHe6dXf75sino24ZgDU9UIpu+A==
X-Received: by 2002:a05:6000:1007:: with SMTP id a7mr3111062wrx.172.1565078123923;
        Tue, 06 Aug 2019 00:55:23 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q18sm107379252wrw.36.2019.08.06.00.55.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 00:55:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] dt-bindings: arm: amlogic: fix x96-max/sei510 section in amlogic.yaml
Date:   Tue,  6 Aug 2019 09:55:20 +0200
Message-Id: <20190806075520.14652-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

Move amediatech,x96-max and seirobotics,sei510 to the S905D2 section and
update the S905D2 description to S905D2/X2/Y2.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 325c6fd3566d..4668064dd7e5 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -91,13 +91,11 @@ properties:
       - description: Boards with the Amlogic Meson GXL S905X SoC
         items:
           - enum:
-              - amediatech,x96-max
               - amlogic,p212
               - hwacom,amazetv
               - khadas,vim
               - libretech,cc
               - nexbox,a95x
-              - seirobotics,sei510
           - const: amlogic,s905x
           - const: amlogic,meson-gxl
 
@@ -129,10 +127,12 @@ properties:
           - const: amlogic,a113d
           - const: amlogic,meson-axg
 
-      - description: Boards with the Amlogic Meson G12A S905D2 SoC
+      - description: Boards with the Amlogic Meson G12A S905D2/X2/Y2 SoC
         items:
           - enum:
+              - amediatech,x96-max
               - amlogic,u200
+              - seirobotics,sei510
           - const: amlogic,g12a
 
       - description: Boards with the Amlogic Meson G12B S922X SoC
-- 
2.22.0

