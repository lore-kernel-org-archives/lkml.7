Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854E9C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE0520B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fBsDzS4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfFMSyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:54:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39096 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfFMSyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:54:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so3485067pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sk+uYjhqJHAw964SCFGOxu5y7oNB40UpzgVh7GqXmwg=;
        b=fBsDzS4JeqKEhAEeQoe57Gg6zI4DRJe+6X0Jpla0pRzUX5dwOlDJ0aTXE9tGmj1KTb
         dThn0C4kaitvtTYciol0iT8B+ePfWv7AlL58S8oQHnLqu4EhB33n+WSObLFlu9V+XrDX
         nx2ai8wBzG3Q7T7EGeD5ShFcX+LnCdLUk1rMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sk+uYjhqJHAw964SCFGOxu5y7oNB40UpzgVh7GqXmwg=;
        b=NZqau5bBhhFpM9qx84b03NM8W2Rh/jWqtnd7qoRh7LW8dO71orGTQVQYOqAfbltcOV
         J75onPg4bmLHh/nXt3//4t6nLHbbkbSpLXbnSOGjyzM2FLymP4eLjhSqHExrW7/XXZOs
         rXPLVw7K0mZIL/Wv5z2aas1cWLsR1XrvCfRj1J/P8mEosrfNGd+7fpTzvJLUfb1TNXbc
         E6dq0/Jt4L/V1l0SNxalMM8SyXcIsYO8/1hQ9zi6gYhDTN9bNwZvY1RIcy0tW0r+g+ZU
         7IPOmV/bUomX+jq7ZIfkD2n+rA8QCEWGFzt1nfZFgBTrTw9QEl5RDSiumxapBNgZR4V7
         1k0g==
X-Gm-Message-State: APjAAAWDI2b1UaVV72DOp7OWZ1x7Z2xCUkRbnoFMvXtaARmU+v6Zzjea
        2vcr5p1RTkzmreVzzjh7dSyDQQ==
X-Google-Smtp-Source: APXvYqxdCbhYLN1KvxrQ0Bk6AS/+DAcgn/aZPji8xl3m3SbFHzYoliwV48IHU6lpqn7tNm9669WzBA==
X-Received: by 2002:a17:902:6acc:: with SMTP id i12mr12248821plt.214.1560452060308;
        Thu, 13 Jun 2019 11:54:20 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.18])
        by smtp.gmail.com with ESMTPSA id p43sm946314pjp.4.2019.06.13.11.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 11:54:19 -0700 (PDT)
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
        Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 7/9] dt-bindings: sun6i-dsi: Add R40 DPHY compatible (w/ A31 fallback)
Date:   Fri, 14 Jun 2019 00:22:39 +0530
Message-Id: <20190613185241.22800-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190613185241.22800-1-jagan@amarulasolutions.com>
References: <20190613185241.22800-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI PHY controller on Allwinner R40 is similar
on the one on A31.

Add R40 compatible and append A31 compatible as fallback.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
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

