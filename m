Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C8C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EBC206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Lab7Tm7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfDWJPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:15:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40540 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfDWJPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:15:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so17965338wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EC6v0kUAyj/2brMf9x5R3hSBJyp+HfoUAkCNqMMNaGo=;
        b=Lab7Tm7nF9QRs6JBbo51tx+bcO5b4j2yDygfjjpYi+XjeGi0JTEI3bbic6Nt77CpvJ
         Ft27qMsxK/DXYPaEAwodn7V2vUFWvxMOutJ6d7RK/7pjSpfn1hCBUeCKsqZ+A1CjQwP4
         joJn6Qswevb2g6wrRjhwZ2xRI1HhLI2xWnGJkpj/zGijaj5u4qBX57nZGAGHmxFv/qx0
         WclxwHEKLhqpLXa5xnODHnifxraP/KDX9G3qnVEnqVqVybCRdYZQEjk2bwO1VwJYzkwd
         OwpK0mNtRqw4oKTAkp6ShwqxzgRzouhrM3ol/7xUmGb9eNFSgxnlK1w720UDKdWizAiD
         yCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EC6v0kUAyj/2brMf9x5R3hSBJyp+HfoUAkCNqMMNaGo=;
        b=nhyfushF+V5E/rbFRWrjGraAHgcsTv7oNdsvZs2v0H6sMizeU4lXCxyla/O7LtuYxr
         DRYMGw21Xkmh63DxkU1AD/kOTbYQaeOh89gORkN+hsMOmksc3yV67y3w/Mcf7y2Hv1PY
         zm3BJse8gwOAKQUp0zMgxrEYwMqe2HWzCn7cS1PWPqqB6V4f1SSeGzkQtrc3IPL4C+dT
         EAMCAl8Bb07Ih7spcG+jWO/yk2LENFIUa0nVnsEaM40tppHgt7bwEntVg5iD23i3dhE/
         zUVtVtsnizCJCpDe+EP1S6Zg8XysGcQEekWerxqKt2LTtTjU1EWY/SBp1lh5pMrvxzTg
         /0wA==
X-Gm-Message-State: APjAAAVkp8Guaiex8e8S5OQ1gKk7XtWLczF4uGXdHbpHaVzJRCseRpQj
        15A5Kp3oyGkjGrSkXSRSvIu1VA==
X-Google-Smtp-Source: APXvYqw+xNP3dzeZOjMjukP4lbpIKy8d0ouYgm4rGBsLaMjZvgWtx2MuJn0e1dY1LrkUXGLUnq+50g==
X-Received: by 2002:a05:600c:220b:: with SMTP id z11mr1483409wml.73.1556010912638;
        Tue, 23 Apr 2019 02:15:12 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t17sm12241272wrr.26.2019.04.23.02.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 02:15:11 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org,
        jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 4/6] dt-bindings: arm: amlogic: add G12B bindings
Date:   Tue, 23 Apr 2019 11:15:01 +0200
Message-Id: <20190423091503.10847-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423091503.10847-1-narmstrong@baylibre.com>
References: <20190423091503.10847-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the Amlogic G12B SoC, sharing most of the
features and architecture with the G12A SoC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

