Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B16C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EDA208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KxTJ3P6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfGAKrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:47:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46057 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfGAKrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:47:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so13231516wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 03:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/4UPHUJqymNIvh4OVWT1OKmRPEHJo2Lj3+lnzK2tYUo=;
        b=KxTJ3P6vYWvoeekgNvzAP9lc8MoxyqRuFej615Ayg2uLwsUgnldjA4vcnbkWTh1F8g
         R6PniMERSsAU2jYgMmLr5D1zAjKhcMC2G0N85ek4nuKexzSXjq2BjRk5W4OyfrWNNoOL
         3zM1yMgtPqw5Ws9mnYSgS3d563B7/ZyW61iNEecPKnewn3FDN476UWuVtwZu9Y1xCkkk
         eaKstKovBxwqapM2zW33zcUlP0k1Zx6nqmPTXFv+TwCLKNp8fzzzK8fK3jioJdwH3d7U
         8HnPbkxqIcJOhJynC7D85eWb0UDLSrBPRwmN16+OacU/uXtNoM2z16vG80xknbua7EIr
         4vNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/4UPHUJqymNIvh4OVWT1OKmRPEHJo2Lj3+lnzK2tYUo=;
        b=OBUji5LMBSo2orJjt76/g6LYtfXSwD1FOEiUo8gpHw/bmFVpKyEENALwGc2iueejIH
         xYY5u4zBb4xRTsudRBGrjqj3O9VH9zYDVTUvo9TB3QzC7nqAp3B3FRSq1Ntb4FKFJk4F
         brn+FwlPLTxu7wvn0/Huwf3oQbQH7Xx/267MS/HBVHQs+vwkuRgyVCeIkB38YGTAVTx+
         tn/QwLoCxN9Y0gHqzTfI7a6AXV+cwJKhYWjBf914vCwgbo0jeSBZpXjSLbqvPHrVYUAH
         NZKaODTt2BTeWFwkGiz2UG/+YZu0njWmQDQ1stdtFfPqxBO9dZOzNJmeyW5hSVU2WJH8
         ss6g==
X-Gm-Message-State: APjAAAUre7c+40PCij7IZJtk0q98gHgF53nMBNl4vkxy8EVEmvmM76EM
        IHottgcytOHxBwJbP7jxtMNC/A==
X-Google-Smtp-Source: APXvYqzGt+8nbW5RLL8NhHySbKn5TUNmB8G81MM3qlOxbnBA4I6WaZrShqXYcTWSlDjBoDCWjuK2Dg==
X-Received: by 2002:a5d:6b90:: with SMTP id n16mr7830338wrx.206.1561978054117;
        Mon, 01 Jul 2019 03:47:34 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d24sm11658802wra.43.2019.07.01.03.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 03:47:33 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC 09/11] dt-bindings: arm: amlogic: add SM1 bindings
Date:   Mon,  1 Jul 2019 12:47:03 +0200
Message-Id: <20190701104705.18271-10-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701104705.18271-1-narmstrong@baylibre.com>
References: <20190701104705.18271-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the new Amlogic SM1 SoC Family.

It a derivative of the G12A SoC Family with :
- Cortex-A55 core instead of A53
- more power domains
- a neural network co-processor
- a CSI input and image processor

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 325c6fd3566d..0b419fd0bac2 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -141,4 +141,7 @@ properties:
               - hardkernel,odroid-n2
           - const: amlogic,g12b
 
+      - description: Boards with the Amlogic Meson SM1 S905X3 SoC
+        items:
+          - const: amlogic,sm1
 ...
-- 
2.21.0

