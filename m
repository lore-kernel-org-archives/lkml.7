Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE93FC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDF62064A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="neSqcjcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfDDPFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:05:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37025 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbfDDPFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:05:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so3815110wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 08:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EC6v0kUAyj/2brMf9x5R3hSBJyp+HfoUAkCNqMMNaGo=;
        b=neSqcjcWcOTg4CxJjx0bPJ+Z0UrOrGMM8WWcp7SMFfogJ2HZ9h+k5PzEH+Gd96Lspe
         qoey72dClXI7dDEVrMCopSgyexgFvwhBhNdJSxEPrIZwy1R18yzsizrd22MNiWkYaCUi
         Y73zwPgsx0X5qxN1YsoJO672Nj3IY9e/rOWACP9BMFnKNV5nVMZo9plt2He4WkQYU6aa
         9Rc8w9JybwViBKGGLTxZdHV0W/0BizVg5zXDDKITJyyXHu8nlC3Jasv2VWmUvE6gRE9z
         rC9HKFQSzrJQWLrQB+6QQDzqfvzpaVIBOjC7EpBWWB87EjNOvejUQbDMup3xPrB3JsPc
         NR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EC6v0kUAyj/2brMf9x5R3hSBJyp+HfoUAkCNqMMNaGo=;
        b=nGUygmwr8yh9SyUW4lG/pi+Cok26Ngvvtf0LjYf7o9QjH6MO3ju72/n92bmTz2Nydp
         XxEDp5RpUfKnMc1+Urs6d8bk4UNra5BHMh6n4CWWOONbaALbxGGuZ/xGWQvgbwiennFK
         dvJ/ytezOKZHSrmTiTxFNhUUu/o5ZuV1wsHaVGnLZLjKrPAfwP/0CSxLhY8n3nUZjomj
         5fDPag9KSjhJ+3g9PhuKwlqWidpP6gWsbTrMEj76t36+GLFlqcm+/iSJbF76a5xeYq6T
         qBUsZnfcIP6nRQI7rT9Tev0K8zdijikm7aHFFnZU43DOG7uhpP5/HzxqwO4bOPouogUx
         gicA==
X-Gm-Message-State: APjAAAXF7qvtv0cR15icirfllebjbbfSLpaauXF48zKtGJJoDMQ4xKyU
        lr68pzPH+8sNeTwjv9XBwVfzWg==
X-Google-Smtp-Source: APXvYqwNrtT4Iy+KiT7gIRwgMQEWnjGx8a4S9AWXpbrQ/tSPSTGTpO4w8Mmvm92gOzMt28npD0aIyQ==
X-Received: by 2002:a05:600c:2309:: with SMTP id 9mr4636858wmo.52.1554390348857;
        Thu, 04 Apr 2019 08:05:48 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id z23sm9880981wma.0.2019.04.04.08.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 08:05:47 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org,
        jbrunet@baylibre.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4/6] dt-bindings: arm: amlogic: add G12B bindings
Date:   Thu,  4 Apr 2019 17:05:16 +0200
Message-Id: <20190404150518.30337-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404150518.30337-1-narmstrong@baylibre.com>
References: <20190404150518.30337-1-narmstrong@baylibre.com>
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

