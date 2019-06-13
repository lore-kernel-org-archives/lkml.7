Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E160C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090E321721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="j9mr7D0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfFMSx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:53:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44707 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729462AbfFMSxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:53:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so12370843pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T43YpeB6KPwzAeP2AJF/MUSVY3ntDzP4uFwV6vk6NQg=;
        b=j9mr7D0Q6WW70PaeAtZuQL8G13f13pQs9IWPwKl+tPlMpbbUYNHSA7/2znZNRp4i6f
         xuPGM5N8BaXMZD4k9kcCOJvheE6bxtkD9vhqrtzOQlUR2aj++rY26vh/QPKy1Nx4sSA1
         k6tcIi7x5mhhp3NQyTlU98pZFu5OqX4r0AHls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T43YpeB6KPwzAeP2AJF/MUSVY3ntDzP4uFwV6vk6NQg=;
        b=C0uZJcm1/0iW9R00DIHuwvbhsuZN0dMq2CMYf6FvwJ5AOOGU/kErcsqxqBkI74/SRy
         IGYYLhnAvkwSdpPwZQCRHly4LqmSt5AmqvUCsZDXm+pHz94hXtD/4O9oCigHimcVz56B
         O08R54k0Mc5UWBomCngJcGMCDWSbgdu15ewJ1jNeBrHb7UxNrmmdwRdFu9e4CZZU5qj9
         e4qxSTYuwnVt6F5uxvOpZTXNI4MRJSTlXSaeQncj3szkcjkROMcif3jzugbUQpfU6BFl
         qZcDSXYxL1/v9/rfaj5bhi5T7Vp3umX0C5S4BHPmTQPkncyial4dwv6m4YtYaL7hWgH5
         sP9g==
X-Gm-Message-State: APjAAAXpD4FoJfX0YXDf9ZRB0V0VG0jT+jmdbPt4outyYAoaIuZXUndM
        A6iktapWJ2biKHYmXBjsFAKhLJvMSd0=
X-Google-Smtp-Source: APXvYqyVfFXF+RWaOpNVOg11XNoCvv+xPHrf1CT9JUGH0iqGtinHj2ErGGLnXkVZWEBC2hZlm3HTDg==
X-Received: by 2002:a63:d008:: with SMTP id z8mr32305004pgf.335.1560452031872;
        Thu, 13 Jun 2019 11:53:51 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.18])
        by smtp.gmail.com with ESMTPSA id p43sm946314pjp.4.2019.06.13.11.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 11:53:51 -0700 (PDT)
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
Subject: [PATCH 1/9] dt-bindings: display: Add TCON LCD compatible for R40
Date:   Fri, 14 Jun 2019 00:22:33 +0530
Message-Id: <20190613185241.22800-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190613185241.22800-1-jagan@amarulasolutions.com>
References: <20190613185241.22800-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like TCON TV0, TV1 allwinner R40 has TCON LCD0, LCD1 which
are managed via TCON TOP.

Add tcon lcd compatible R40, the same compatible can handle
TCON LCD0, LCD1.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 31ab72cba3d4..9e9c7f934202 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -160,6 +160,7 @@ Required properties:
    * allwinner,sun8i-a33-tcon
    * allwinner,sun8i-a83t-tcon-lcd
    * allwinner,sun8i-a83t-tcon-tv
+   * allwinner,sun8i-r40-tcon-lcd
    * allwinner,sun8i-r40-tcon-tv
    * allwinner,sun8i-v3s-tcon
    * allwinner,sun9i-a80-tcon-lcd
-- 
2.18.0.321.gffc6fa0e3

