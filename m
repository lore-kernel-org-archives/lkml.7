Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F91C2D0DC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E7320733
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="esmTNuuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfLaNGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 08:06:14 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36256 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfLaNGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 08:06:13 -0500
Received: by mail-pj1-f65.google.com with SMTP id n59so1213631pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 05:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LFRfv913MOD9bDVjn2WmuUvuBCX9q57n4nZIprY3VlY=;
        b=esmTNuuAHI5g0sdvenfWCCKOtxtWE8tDLrNoa4auzDAbZa4l0WWU2YmE1z+YTuH/f0
         IaUqnQ8uilEQG51LocZpc6sUqo2rv5Q0kEf0yj2MShhPDrhiyJqmCMHdbTTF25ImV4DJ
         CXhUToi3DDMDwcKcrKX0GuImPVYdLbeHPZgdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LFRfv913MOD9bDVjn2WmuUvuBCX9q57n4nZIprY3VlY=;
        b=UgNEyiLBV+o69U9bcuFH8i7gAv7TUQF0L+J0cjYdXh5IiE5ssbIbVc/hxxd9QsCwAO
         WlI+ybfK20FSg/HOUurklNpVEygUbBLIs52lk4oVBJ/JFViaAaPklV0IgrGeFh9uTXK3
         20XrTwSZzldxqqvNwjC3YkHiaM6N+3rDUTX6Ki7sdfIlMiNjdzcPNmrHKkuhT0Kficzl
         kDGSL3QbhLqY/8bQ07kNA2vcc4HYwzCSgoIG4rOoTxms7ZzwAMtJZ27fDZVfs41nHHDH
         L8JS35pPBtxI639geybRSWQnRB+SZu3QBH9Iwy0aWjppF3HGHy7zj8GIL5p7RqsrvIps
         RK8w==
X-Gm-Message-State: APjAAAU3NjkmaGJKu5Q7ci2KmMMmKr0req4FYVLE0VtwEo9pwvlfupAN
        Oe2/MOyBJYRzMRgXIF3Wqb5Lig==
X-Google-Smtp-Source: APXvYqy6wcZpyDi0ZQJ1b5xgNNOeiknVdIr1W72rN6UUlfZ38jAq6za4qzzEBbhB0lGRuoIihrO2IA==
X-Received: by 2002:a17:902:b68c:: with SMTP id c12mr40694609pls.160.1577797572591;
        Tue, 31 Dec 2019 05:06:12 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.115])
        by smtp.gmail.com with ESMTPSA id i3sm55204089pfg.94.2019.12.31.05.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 05:06:12 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 6/9] dt-bindings: sun6i-dsi: Add R40 DPHY compatible (w/ A31 fallback)
Date:   Tue, 31 Dec 2019 18:35:25 +0530
Message-Id: <20191231130528.20669-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191231130528.20669-1-jagan@amarulasolutions.com>
References: <20191231130528.20669-1-jagan@amarulasolutions.com>
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
Changes for v3:
- update the binding in new yaml format

 .../devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
index 8841938050b2..0c283fe79402 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
@@ -18,6 +18,7 @@ properties:
     oneOf:
       - const: allwinner,sun6i-a31-mipi-dphy
       - items:
+          - const: allwinner,sun8i-r40-mipi-dphy
           - const: allwinner,sun50i-a64-mipi-dphy
           - const: allwinner,sun6i-a31-mipi-dphy
 
-- 
2.18.0.321.gffc6fa0e3

