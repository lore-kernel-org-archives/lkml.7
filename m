Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A167C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031432186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HaGtERc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfCONIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:08:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39804 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfCONIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:08:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id h8so6446511pgp.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MCAsq1unmy/u9MR2Tb3vIzLidQD5Rpkalik1aaNmBV0=;
        b=HaGtERc1qVWgovorqE6ioBRI86D7lQLQcVJpD3+rJ8FQbYA553LlqrpYID5XU6L4PG
         FIK6PefcXGw6bZ8jxROK/vJ2lDrlvTdUMqWuqdslYymLbGx2XtsGd2AC/uhfZsUkQpLc
         oZ4UpPONsz/EEfB97X1fGuMMfz18zVgLL3MtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MCAsq1unmy/u9MR2Tb3vIzLidQD5Rpkalik1aaNmBV0=;
        b=EZxlRCMZM9XdmtWU0e4BYEO2xu9DaRKbAAKWAa3AwlgXfjoRfsvpEotAavTTw1Y68C
         eSwmOAtqc/OaY0mO9N1bvtVgPgqQGvj8tn5oLYRbSmW7Ww+v0csCAmVLnf2k9+xfxbOj
         XCz/ngoJIxkGclJ4oa1H9xiGjh3ldvC7Z5n/Y3gJIGF1hlmDH+3/4GScI57J17o0MDeo
         KKCsSdPU3vLIXHhchGUGJNw6O3mz0mu8KLHkpIL3QZdxE4JNE6INpLzJZbuEKwsoQLUi
         7kzLNrrETm0UlhSzBzZa6b/+5zZ3tWz9o+I7z8hQ2KummlEm4fbxqKjPK+zFzkY7tp/p
         Ak1A==
X-Gm-Message-State: APjAAAUhkCRsrGKYR4BGH4vlzgDvxkeCvYe+D4BS/PMGeIiMso0OVjsb
        pcbNyvhzDdF7u0XOHOV1vdFb5g==
X-Google-Smtp-Source: APXvYqzasR/PuWyWi8ODkyuiPoNON4uV0lo0p9u87IZi9Xzt1VgyHjvVgOXXgGqKc3Yep6QEOGVkiA==
X-Received: by 2002:a17:902:2e01:: with SMTP id q1mr4234447plb.253.1552655317200;
        Fri, 15 Mar 2019 06:08:37 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.185])
        by smtp.gmail.com with ESMTPSA id e2sm854008pfa.64.2019.03.15.06.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 06:08:36 -0700 (PDT)
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
Subject: [PATCH 0/6] drm/bridge: Add ICN6211 MIPI-DSI/RGB bridge
Date:   Fri, 15 Mar 2019 18:38:19 +0530
Message-Id: <20190315130825.9005-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series support Chipone ICN6211 DSI/RGB bridge support.

This ICN6211 bridge is taking flexible configuration of MIPI DSI
signal input and produce RGB565, RGB666, RGB888 output format 
and it is present in the Bananapi s070wv20-ct16 panel.

Initially similar support is written as dsi panel driver, but 
based on the discussion from this thread [1] and input from 
"Andrzej Hajda" I would ended-up writing bridge driver.

patch 1, 2: export drm_bridge_detach

patch 3: bridge support on Allwinner DSI controller

patch 4: ICN6211 dt-bindings

patch 5: ICN6211 bridge driver

patch 6: overlay to enable bridge and panel on BPI-M64, this would
eventually depends on 'Allwinner A64 MIPI-DSI" support [2]

[2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=90117
[1] https://patchwork.kernel.org/patch/10657579/

Any inputs?
Jagan.

Jagan Teki (6):
  drm/bridge: Export drm_bridge_detach
  drm/exynos: dsi: Use drm_bridge_detach
  drm/sun4i: dsi: Add bridge support
  dt-bindings: display: bridge: Add ICN6211 MIPI-DSI to RGB convertor
    bridge
  drm/bridge: Add Chipone ICN6211 MIPI-DSI/RGB convertor bridge
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Enable S070WV20-CT16 DSI panel

 .../display/bridge/chipone,icn6211.txt        |  36 +++
 MAINTAINERS                                   |   6 +
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  63 ++++
 drivers/gpu/drm/bridge/Kconfig                |  10 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/chipone-icn6211.c      | 275 ++++++++++++++++++
 drivers/gpu/drm/drm_bridge.c                  |   1 +
 drivers/gpu/drm/exynos/exynos_drm_dsi.c       |   3 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        |  65 +++--
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |   1 +
 include/drm/drm_bridge.h                      |   1 +
 11 files changed, 443 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
 create mode 100644 drivers/gpu/drm/bridge/chipone-icn6211.c

-- 
2.18.0.321.gffc6fa0e3

