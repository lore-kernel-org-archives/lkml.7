Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B406C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F502068E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XaZsFsA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKUOPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:15:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38507 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUOPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:15:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id q18so1629222pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 06:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGzksxC3NHCBGYXLvWDH+iGdDwwXfnJhqh1w+RnVanc=;
        b=XaZsFsA+H3APrLs4/4C1VvAbNkguZdBO0cdjt38HSm0TtTBuvIEVqdYMSLRc7qsUZ0
         TTkFJQsWWY0rJ9XwAhp65jWXiwEwp4JbDv3fWTOMD8bZoVuccJJ4kwlPMQxKbMT63fq/
         CDDC5M2TKZq2/h0rxvIiF2SM/UsQWvLHAUBN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGzksxC3NHCBGYXLvWDH+iGdDwwXfnJhqh1w+RnVanc=;
        b=rgiaIqeGOkT4UIWmv4dCDDzFfRD2nqVwEeEHXvkL+VreARYbEK/CXNmWs4KlOvafGT
         Y5f8V4sBnn5JDIxKwargYu6OTVGU89FH8W1B3ccQriDmQrqCgdW+M3I+sE+muL4mm/Ht
         ll/o3KeVE24iAeIhzeAZbNu9pb7inze+ZmCQM6h7OYtW71wOrxRJRwDpkReHYc7mnSMX
         YVwzaQf/NxIflA1rysFaZYHlKZivoHK75G+7uMkM1k0rmm1Cuh8W08y08ct8Fzjp7yZa
         LBFjXSVzUkUxsyk9kSFJVYrlVCAKz/U1mUZralNDQNUUDvBZ4bVUTAfYt4sOzBwmkui2
         cqGg==
X-Gm-Message-State: APjAAAWPfO51ELj1ZO4PeGuUw5CBLHzxTFSBGmbxHI66P/S1dCRUqXik
        VGO0X/vrdD6za673cqh+cexWrA==
X-Google-Smtp-Source: APXvYqxpFu0QFdEqmYmMyXZkzw3516FXyoTT5uH4u8N5dkaFnOuJ8uIoxJBB06PvcglL3PV2cQ7eIQ==
X-Received: by 2002:a17:90a:380d:: with SMTP id w13mr11702168pjb.133.1574345707390;
        Thu, 21 Nov 2019 06:15:07 -0800 (PST)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id w138sm4072304pfc.68.2019.11.21.06.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 06:15:06 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Gajjar <akash@openedev.com>, Tom Cubie <tom@radxa.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 1/5] dt-bindings: arm: rockchip: Add VMARC RK3399Pro SOM binding
Date:   Thu, 21 Nov 2019 19:44:41 +0530
Message-Id: <20191121141445.28712-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191121141445.28712-1-jagan@amarulasolutions.com>
References: <20191121141445.28712-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VMARC RK3399Pro SOM is a standard SMARC SOM design with
Rockchip RK3399Pro SoC, which is designed by Vamrs.

Since it is a standard SMARC design, it can be easily
mounted on the supporting Carrier board. Radxa has
suitable carrier board to mount and use it as a final
version board.

Add dt-bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 45728fd22af8..51aa458833a9 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -526,4 +526,9 @@ properties:
         items:
           - const: tronsmart,orion-r68-meta
           - const: rockchip,rk3368
+
+      - description: Vamrs VMARC RK3399Pro SOM
+        items:
+          - const: vamrs,rk3399pro-vmarc-som
+          - const: rockchip,rk3399pro
 ...
-- 
2.18.0.321.gffc6fa0e3

