Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F3FC2D0DC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C779205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Z9lmykbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfLaNFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 08:05:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42370 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfLaNFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 08:05:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id s64so19511601pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 05:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GHERosgBsujakP2B/I6YHrJDTfsLICVpu4z4584lwQw=;
        b=Z9lmykbL1nS45J4e96jiJrcedroR8CQp8/MeoSvUrSO/T8/6PwYaSv4AglTj72wHS8
         TEehWz56jErqgZn5HhjOH/Ea8HEBcam9LJPgZi8vJvfIbZO03k+uNYgiAnX/eFP938py
         Gcm3jjwouXbnUzeY6J7ALjylcPQEVRXGeFhyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GHERosgBsujakP2B/I6YHrJDTfsLICVpu4z4584lwQw=;
        b=ZORacnYEPtkjqaVwY6Q+aZ3O0kz5uG5B5C8SwwTbzH32rgkOzWVBPukauIMi5LgFkt
         dzvupc01pj5o3zEAuK0QdgLD9Mg6KXeQQeZWgLIkaAFvjUh3HH4OCbBh7o4tBdhdtdXa
         6dMEWVcsEVqqUI9+udLhZgnIWJYL36QsKQdMGD4nr+NvuaautKVb/me0L3gRiEGArLPJ
         XYcNwma0bki3nd+yw0dBWirJTLEbwbYtom6H1kmFJwtRc2b0EjXnXBVxq2kRPa90xEoc
         ZKAh+NOS0BkPHfjF852DDHKvIIoF+4oGpe3t+Zt3UZmG9OD+yV8xj7bkiHvBXMTTBp6D
         4ROA==
X-Gm-Message-State: APjAAAXLJrKeewEhTlaYVIvbN6fr13/f/LW555We+H5dbYgqpC0c4/yk
        v0Rj62YpTMqWPZVSjWAbBC2AmA==
X-Google-Smtp-Source: APXvYqw2sViAJoSwquTTS8URdM3Gc8OxZVcyoU64PLz9q9NvLdSS35ykWYOHT21Xmz7I1N3x+F2elA==
X-Received: by 2002:a62:a21e:: with SMTP id m30mr67506229pff.56.1577797546877;
        Tue, 31 Dec 2019 05:05:46 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.115])
        by smtp.gmail.com with ESMTPSA id i3sm55204089pfg.94.2019.12.31.05.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 05:05:46 -0800 (PST)
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
Subject: [PATCH v3 1/9] dt-bindings: display: Add TCON LCD compatible for R40
Date:   Tue, 31 Dec 2019 18:35:20 +0530
Message-Id: <20191231130528.20669-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191231130528.20669-1-jagan@amarulasolutions.com>
References: <20191231130528.20669-1-jagan@amarulasolutions.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v3:
- none

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

