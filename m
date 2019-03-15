Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBCAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3D4218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EEr7kbm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfCONIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:08:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41101 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfCONIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:08:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id d25so6315422pfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NP9T09HEiV9lz6LnHjqB2XMYT7hhusLm/ZYVSxXup6g=;
        b=EEr7kbm4JScUqx4A4oujEtivANfVxlny5trpDbvGToZFduknY7uvBJOGtUXvUklyyI
         mYgVuKZ2qnBMvEqSEhwLq8+13FQza7H/G5r3CunAF3cviHpE3qt9hySo0/QVFTa7cy4s
         Rp7lpHcP2UhE2EDfJbptquEjM91CAHVTzwNOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NP9T09HEiV9lz6LnHjqB2XMYT7hhusLm/ZYVSxXup6g=;
        b=Bxgg+sXGRkqjU45NAZSfiAzK1h87fTrtA0YRBVns0u1BZMHdE2mlQ97XjB/su6CWP7
         Udh+2aizYoVie3VqLrurxSNigWOkCqpx5fDD7hdIftJUMcCSUdamtpJuOTX8mYZSxkeW
         RpFnfEUsAQIca0XyqkC3rVgfYtbBA2/5vxq5VOH5Er3jYHMjcbYQ/Y6SYaTW3q+Ylnij
         IgYBX5vhLlmudgifp86PuAp6lEvH37byWh9r8KdDPdEMtjez7ABMDMNNnCwkTHW0sgRE
         sYTvWdW/ivEebOLPRZMUn9BlKUXkpie5zoXHp+4rS/skUj08I7ZNJ3UytC4zJVtdn4XQ
         A+4A==
X-Gm-Message-State: APjAAAX3eAxnQ5VWNsCuQn1EtSD1JSxdDFo0zEOGfRj0moUTAukPWrgN
        X92+GiLko+1uWzOSdLikZrZ9nA==
X-Google-Smtp-Source: APXvYqwL+qZQkIGf8dCF8nSsgFBq32iO5p+TWJ2TYpdyylmsFWb0ti61kcJ07cVPtUKJfRHTzxxLPw==
X-Received: by 2002:aa7:85cc:: with SMTP id z12mr4016902pfn.196.1552655321804;
        Fri, 15 Mar 2019 06:08:41 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.185])
        by smtp.gmail.com with ESMTPSA id e2sm854008pfa.64.2019.03.15.06.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 06:08:41 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/6] drm/bridge: Export drm_bridge_detach
Date:   Fri, 15 Mar 2019 18:38:20 +0530
Message-Id: <20190315130825.9005-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190315130825.9005-1-jagan@amarulasolutions.com>
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export drm_bridge_detach from drm bridge core so-that it
can use on respective interface or bridge driver while
detaching the bridge.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/drm_bridge.c | 1 +
 include/drm/drm_bridge.h     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 138b2711d389..569d4f345429 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -159,6 +159,7 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 
 	bridge->dev = NULL;
 }
+EXPORT_SYMBOL(drm_bridge_detach);
 
 /**
  * DOC: bridge callbacks
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 9da8c93f7976..4955e3e50fa4 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -301,6 +301,7 @@ void drm_bridge_remove(struct drm_bridge *bridge);
 struct drm_bridge *of_drm_find_bridge(struct device_node *np);
 int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		      struct drm_bridge *previous);
+void drm_bridge_detach(struct drm_bridge *bridge);
 
 bool drm_bridge_mode_fixup(struct drm_bridge *bridge,
 			   const struct drm_display_mode *mode,
-- 
2.18.0.321.gffc6fa0e3

