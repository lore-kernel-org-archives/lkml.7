Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B3DC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0EB21850
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KhdkuwhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390505AbfEXKlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:41:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42368 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390242AbfEXKlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:41:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id 33so1889852pgv.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 03:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0MxRnTCE9BXc+WmYpS8NriHcx2Lj8b3YSmcOc81bkk=;
        b=KhdkuwhLGFTGUIzjnoSXCcjRF1xudF+4rTPCNkNPO+riBV5qj6+YN/XmRVEm/HCRG5
         3Jn3cbkMmq2gMiGJaV6ndJJmu2lKue5pniic1qpViALZjk/6h4ANhWXPElMRyGyMwj0I
         jC9ZZh4aHfKNKmJ4whJ1tmXgtD1aztJzyF9N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0MxRnTCE9BXc+WmYpS8NriHcx2Lj8b3YSmcOc81bkk=;
        b=Q/CfjyexCjJz2PvvcWpRGyCzy+6y6ODhk5+6h5QBbZbgQGmlpee0zmYaFxosTQmYHO
         /pcVXGRXmtIK3CvBK0g0mFAVtjReRdv+OeVJh4z+wVAnUHcse2unwzGu55LsyzZSvVLx
         wM3u7pSYUNpSL9iaUboYa8ZtfsGvgDqFOVDOycDd340Uvsac0XPvwYJhqZfyxruZGLMq
         UEhgYCitAVyrCLSxtx+mYTjNOh6F+XR0etFVp5QvkngEd1kKeecQBMqtIvsBKk8lLdbS
         8ePtD8ouJN7W/vgTyUD6dmyt9MQMpQWwNrHPaHnEytei28fFYu2xW4Ny55BS6ur5vxn3
         lSmQ==
X-Gm-Message-State: APjAAAWipVFmAF9f56JeZe6zT/gQb2J+bIGav52PW15TSdowGGYspsS/
        9a+QdVZua/Fe6nb3LucIYJLubg==
X-Google-Smtp-Source: APXvYqz44Tfpkk+GdZoxymyVgoEhAr6weX4O6ILp2GFIiVeKdz6RAp1tuYQbqrGK2N425gP+pUQjVw==
X-Received: by 2002:a63:4a4f:: with SMTP id j15mr8692927pgl.338.1558694493926;
        Fri, 24 May 2019 03:41:33 -0700 (PDT)
Received: from localhost.localdomain ([183.82.227.60])
        by smtp.gmail.com with ESMTPSA id m72sm6550113pjb.7.2019.05.24.03.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 03:41:33 -0700 (PDT)
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
Subject: [PATCH v2 0/6] drm/bridge: Add ICN6211 MIPI-DSI/RGB bridge
Date:   Fri, 24 May 2019 16:11:09 +0530
Message-Id: <20190524104115.20161-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm/bridge: Add ICN6211 MIPI-DSI/RGB bridge

This is v2 series for supporting Chipone ICN6211 DSI/RGB bridge,
here is the previous version set[1]

The overlay patch, has Bananapi panel which would depends on,
previous MIPI DSI fixes series[2] to make the panel works.

Changes for v2:
- use panel_or_bridge for finding panel and bridge
- add panel overlay dts patch for port based panel enablement
- update the bridge sequence dynamically, by getting mode
  timings from panel-simple
- correct the brinding compatible
- add more information in binding example
- replace the bridge detach with proper ops
- add bridge overlay dts patch for port based panel enablement

[2] https://patchwork.freedesktop.org/series/60847/
[1] https://patchwork.freedesktop.org/series/58060/

Any inputs?
Jagan.

Jagan Teki (6):
  drm/sun4i: dsi: Use drm panel_or_bridge call
  [DO NOT MERGE] ARM: dts: sun8i: bananapi-m2m: Enable Bananapi S070WV20-CT16 DSI panel
  drm/sun4i: dsi: Add bridge support
  dt-bindings: display: bridge: Add ICN6211 MIPI-DSI to RGB converter bridge
  drm/bridge: Add Chipone ICN6211 MIPI-DSI/RGB converter bridge
  [DO NOT MERGE] ARM: dts: sun8i: bananapi-m2m: Enable Bananapi S070WV20-CT16 DSI panel

 .../display/bridge/chipone,icn6211.txt        |  78 ++++
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts  |  86 +++++
 drivers/gpu/drm/bridge/Kconfig                |  10 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/chipone-icn6211.c      | 344 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        |  67 +++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |   1 +
 8 files changed, 575 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
 create mode 100644 drivers/gpu/drm/bridge/chipone-icn6211.c

-- 
2.18.0.321.gffc6fa0e3

