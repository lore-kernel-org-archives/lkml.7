Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02DFC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955BE2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qyDQb+/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfFNQnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:43:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39306 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfFNQnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:43:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so1790539pfe.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vlwa0s5nqheQS3zabJv02XXNAZF54w3RCaO1lz7mJ5Q=;
        b=qyDQb+/76FQ6lTl+mdRWZykq7uCJj62GkbjTONISkaUVyPOfFAVxh65BAsgt6CPzut
         9ZhtdcgyXulLsQ1H3JMr+aIhTmdWStjDH33vZohhqIgSFCH9Bmt1KPxsjMRXuFEmqAAd
         VsjLDD8ARz48aonbrS/nKu3429nfJ9hSppYtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vlwa0s5nqheQS3zabJv02XXNAZF54w3RCaO1lz7mJ5Q=;
        b=qU5ofDOO8yO+wsp0MAhO2Qo589L+iUovRpsvMK23iP60EOG315MNtA0a8PhRadZ6t5
         sujpPCSh1d4VgEeB/k393haik9rLqfaKLXXUA9LTd2/k0luM7D6IkYKqvVMHfRtRi7Vy
         UgRmlYBbsXO0aqhzSso4+gOTB51kYG0+hafV+/jtIQQHRVUzzqWLrvEUt+xLfOIHdE22
         2SFQhBRGRD+lX6dU1LJwcvf0+Tn1sJZ90ai5KjnltVyOb2TvF3nk/RDvEHiN4fPHW1WR
         3WSFA0vfVLxewCaxLCvA/wdImJb9vcPfhlw+KtyYilDDYheJC9aEI5keQKZq6er6spNs
         eG1w==
X-Gm-Message-State: APjAAAVyPJuRupRlKUf+SXxEBP2Larm624jzwlkphI0pgBuKiPWntfCh
        egP30n6HuvB9pYYs/IMh3YyL+Q==
X-Google-Smtp-Source: APXvYqzxQKiNS3nurPOM/V2GvxzGm9mKdD7TK0cz5nTv+lySbEQRBjB51s0f2UVYbHxtO6KpqnOlHw==
X-Received: by 2002:a17:90a:af8e:: with SMTP id w14mr12320434pjq.89.1560530625092;
        Fri, 14 Jun 2019 09:43:45 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.18])
        by smtp.gmail.com with ESMTPSA id 85sm1639583pfv.130.2019.06.14.09.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 09:43:44 -0700 (PDT)
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
Subject: [PATCH v2 1/9] dt-bindings: display: Add TCON LCD compatible for R40
Date:   Fri, 14 Jun 2019 22:13:16 +0530
Message-Id: <20190614164324.9427-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190614164324.9427-1-jagan@amarulasolutions.com>
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
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

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
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

