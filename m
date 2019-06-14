Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80752C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518242184C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rlf58sMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfFNQoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:44:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42625 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfFNQoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:44:10 -0400
Received: by mail-pl1-f194.google.com with SMTP id go2so1237547plb.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 09:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Non2BoMSGZisQGcDqDX68GAJtDt89o/Y1pHahHZtkpw=;
        b=rlf58sMSEWIwoOxw02uP0n9MWyrboVK4lgcIbkTGWCNuEqHmEw5+ENdEnc8yUBy6YL
         xa/7xTOfw1ZONqMy2w3bDcUqg1fLro2oBI55f6/OjyxCUGqfHeNcHerAQ18EUyWzTARQ
         ssBd0pQ5ionYtuuJrkkeGT/Sqks/rUU0lQpEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Non2BoMSGZisQGcDqDX68GAJtDt89o/Y1pHahHZtkpw=;
        b=clKYwJFJl2+0CYTspTiMlsLuMKMdtPYc/LQ9K4y+xzTifD9aQscbjvwGxQUBi+pq3C
         xbDHYjp6HsjMhnywUVX56KGAAzh1ZprUzBjmUcb4KRv1VzHQL+mbPIP6WpjJ9ZqqPH/2
         BnWQxXg5l3oacRPm+dhRTqAXr6PLvxrV5ZKcCQkKzYyvFJc9vSUg+R1003cxOUOuc0b0
         Fz3n+0P0POnsdbBaKlZ570kxRcvunrWFrzospBkueEzIBOKMevHB+m7f+s7Ijognar6h
         lKFvhxMtg+aJdnPs7r5K4eNVtnbCcqY9m78PLjUH1IQnk8V+JolSCZu4LKfzNzmWHe5K
         ec/Q==
X-Gm-Message-State: APjAAAU6Y8Gknd/Q0fHxIun1rrY1guIQz08b9fKGJKAfFQiQ0s+Tq9JK
        nHqPrwFgLcEBjkrRh6fAM8Wr/iKLc08=
X-Google-Smtp-Source: APXvYqw1QUf2Sqj4sT+KEQY5pTkiZm664fbyXbkXHmgQeP2NDpkJ5pMLTivt3XLzm0hRDnHdWl7B9g==
X-Received: by 2002:a17:902:7086:: with SMTP id z6mr11655193plk.196.1560530649787;
        Fri, 14 Jun 2019 09:44:09 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.18])
        by smtp.gmail.com with ESMTPSA id 85sm1639583pfv.130.2019.06.14.09.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 09:44:08 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 7/9] dt-bindings: sun6i-dsi: Add R40 DPHY compatible (w/ A31 fallback)
Date:   Fri, 14 Jun 2019 22:13:22 +0530
Message-Id: <20190614164324.9427-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190614164324.9427-1-jagan@amarulasolutions.com>
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI PHY controller on Allwinner R40 is similar
on the one on A31.

Add R40 compatible and append A31 compatible as fallback.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 438f1f999aeb..b7ad1be33008 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -40,6 +40,7 @@ Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-mipi-dphy
     * allwinner,sun50i-a64-mipi-dphy, allwinner,sun6i-a31-mipi-dphy
+    * allwinner,sun8i-r40-mipi-dphy, allwinner,sun6i-a31-mipi-dphy
   - reg: base address and size of memory-mapped region
   - clocks: phandles to the clocks feeding the DSI encoder
     * bus: the DSI interface clock
-- 
2.18.0.321.gffc6fa0e3

