Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69524C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 06:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD71214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 06:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G1irwZRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfLKGTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 01:19:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38727 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfLKGTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 01:19:37 -0500
Received: by mail-pl1-f195.google.com with SMTP id a17so614886pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 22:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YRavSC33ZtK/7zUsAUhvwvnYf94ej0Wa3q2MGL/7bjE=;
        b=G1irwZRtD6I4pLurc23D+bW7EdIavtCQy5pnDmv2sZKR3/O+cZhA7VkC/0TGO6lA+B
         VhX8LuaIMGiSRxxTbduglep2ElbyfqkuWpYeYldOa9suu+nvv76Z7HLGqTgfMJH/VoqJ
         /jArc5qR+n+7P1pFQZiI63+xOzBPv904pg8q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YRavSC33ZtK/7zUsAUhvwvnYf94ej0Wa3q2MGL/7bjE=;
        b=fxfFL7/JrgBTCjpkAM6p2WohC9Y58sw42R8vABQno+G47oWHda4L1hdPwtE7oOTjs8
         FGfPZ4AfaVQylTl66QtM8QqmacF0eB/uJ8hUkuNbDX/DQ28jRBf5UPzMGPaFnDWiJGU1
         nPE+hWAW/a8KBxdorDsyzG47V8FMv3zLZEEkgG7ECmVBVmtr3vjcLbbBqqcBYi+DShZ3
         HVpOM4HUfiDNqBmwwMZhmhO9cxQJsT5bVyAExFZw58+8d/7nYkdlb19jT4F/MlY8mfPi
         CQnSLvwxdZzzUifWiGvk9taZnf+/oR/fsRZOKgxhxxVZH4Mh8lowCr6QHJNmBPh4sgxa
         B/iw==
X-Gm-Message-State: APjAAAXAcQpd2sW1xtOfQPlXnl435bftjxt3G433Py3wGvrmCPNeCdzI
        TEMC1cjlxkaU1x+d7uV6y8aaeI4samK6rA==
X-Google-Smtp-Source: APXvYqyyzVU6PmkPeOeBgKV6jY3bzTZPDmSqYSbUHfdlOt8oTvxIuNEEYVxyU8HYqS26xWZXbgMPvw==
X-Received: by 2002:a17:90b:124a:: with SMTP id gx10mr1680582pjb.118.1576045176977;
        Tue, 10 Dec 2019 22:19:36 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id h5sm1225579pfk.30.2019.12.10.22.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 22:19:36 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        p.zabel@pengutronix.de,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RESEND 0/4] drm: bridge: anx7688 and mux drivers
Date:   Wed, 11 Dec 2019 14:19:07 +0800
Message-Id: <20191211061911.238393-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of [1] with a few modification due to drm core function
changes and use regmap abstraction.

The gpio mux driver is required for MT8173 board layout:

                                  /-- anx7688
-- MT8173 HDMI bridge -- GPIO mux
                                  \-- native HDMI

[1] https://lore.kernel.org/lkml/1467013727-11482-1-git-send-email-drinkcat@chromium.org/

Nicolas Boichat (4):
  dt-bindings: drm/bridge: analogix-anx7688: Add ANX7688 transmitter
    binding
  drm: bridge: anx7688: Add anx7688 bridge driver support.
  dt-bindings: drm/bridge: Add GPIO display mux binding
  drm: bridge: Generic GPIO mux driver

 .../bindings/display/bridge/anx7688.yaml      |  60 ++++
 .../bindings/display/bridge/gpio-mux.yaml     |  89 +++++
 drivers/gpu/drm/bridge/Kconfig                |  19 ++
 drivers/gpu/drm/bridge/Makefile               |   2 +
 drivers/gpu/drm/bridge/analogix-anx7688.c     | 202 ++++++++++++
 drivers/gpu/drm/bridge/generic-gpio-mux.c     | 306 ++++++++++++++++++
 6 files changed, 678 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx7688.yaml
 create mode 100644 Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
 create mode 100644 drivers/gpu/drm/bridge/analogix-anx7688.c
 create mode 100644 drivers/gpu/drm/bridge/generic-gpio-mux.c

-- 
2.24.0.525.g8f36a354ae-goog

