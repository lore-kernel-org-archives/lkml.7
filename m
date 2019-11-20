Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA70AC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940AF22419
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="O/HEsdnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfKTLk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:40:58 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:43950 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfKTLk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:40:58 -0500
Received: by mail-pj1-f67.google.com with SMTP id a10so4002867pju.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 03:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yHZJJcR8mQcwZhglzTTNiD4pcvMUD6TZgTIsDzGcbBA=;
        b=O/HEsdnxbKlIlsJpB2ra2/mVGYc1rj4DW0nHmoCdsMI4cTu8vENjQz1WZRXh7PGr1T
         nbaXbK6Y0F0/0Yw5P4oTe5UxN4inv6vEztY8YbaC8WJb5NPJxIrPSbXl9BQ1VsUu/IOF
         svc3eGcAHkOu5T4IyjVxlxLNBuBWeqwzGmYD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHZJJcR8mQcwZhglzTTNiD4pcvMUD6TZgTIsDzGcbBA=;
        b=HAORJGjzRxXWjUH8gSfEERk2AJif1ELPrz3t/YijGSiGnjpTyHUASj6fLa97+1cQAR
         IG6nDJ3O9TUgQ3e1P2kbPb5l7A2LKgk/TmvEcesoJjj+k0Yr60R9THlMTRJxXU4LC5iq
         TYhWh9JZc0JdE9uuwpFdY2X1gtEOZM2wMf/e6RywaGUNArk/Wag63gLWw7eH4mJ87bX+
         AnH1XoJp5WrMOurAk7XYmmvRbfvqsSCYW5bu72PEgpZPUgdgKeHlbXkBOJL3IBD7knHl
         poyH9GPrILkBDkrINdHfVb+NGZPIciJQ2MewAhJ9WcdcHpxz7BCBJY8Q0ZbRJxyCmV1+
         +uDw==
X-Gm-Message-State: APjAAAWVV97sHZvrPOcUdsHsGuET9mW56h2iS3FiKTGoQAnjF2bRtJSG
        9A6KOuwRb8WKqvZbdzKH/KSHvA==
X-Google-Smtp-Source: APXvYqwL2xPmmw1S2n1DQYZu6NRmfHVe+rkrUT1QBX8EbWfOnLIX2lPO1PF3wh68DFJwzes/lU90sg==
X-Received: by 2002:a17:902:8f98:: with SMTP id z24mr2554339plo.35.1574250057480;
        Wed, 20 Nov 2019 03:40:57 -0800 (PST)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id h185sm13492850pgc.87.2019.11.20.03.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 03:40:56 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Gajjar <akash@openedev.com>, Tom Cubie <tom@radxa.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/5] dt-bindings: arm: rockchip: Add VMARC RK3399Pro SOM binding
Date:   Wed, 20 Nov 2019 17:09:19 +0530
Message-Id: <20191120113923.11685-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191120113923.11685-1-jagan@amarulasolutions.com>
References: <20191120113923.11685-1-jagan@amarulasolutions.com>
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

