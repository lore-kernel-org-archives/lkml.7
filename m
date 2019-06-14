Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED07BC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C022C21848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qYxsx+A6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfFNQnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:43:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36825 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfFNQnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:43:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so1797440pfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YB8tvQ/A4LBfMdy9uXKQQ4D0KlkqxcG44woQEGvz30s=;
        b=qYxsx+A6S9zLLNTdR52vMXSYNC4esdZSFUMNrOleaGkevIAAzDbqGuI9GvOfXHTW0t
         K6MWIOyfG3XEJvM8gDFnZbOcCzjNuRKhwawvyODHKOUMtD9GlufynwBgS84+Dr6eR6EN
         zVUtAhESJK8BH/wZD1lA5elxAzgdFRasq3A6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YB8tvQ/A4LBfMdy9uXKQQ4D0KlkqxcG44woQEGvz30s=;
        b=mFyZ9e/J4KwlI2B5YdF3qkbF0oJ7rY78NGd+mA7I+/qXBrYpO+MU9oe3CgZapj0UGn
         atMlYzkUaa/e36KhbnhMEjJEi5Ti8C48bhu56V+Cd0WIG5uuqqZ2MIjFv8gCO2coI/ve
         nKqOTrdwh1JZodAZww7tk7F2BmzYH8FfNaOAFV4Zg1aJOaQI51vJ97okbioQPZr8t5ZP
         aIs8fEkr7iiwPDIawNwxNmqVBXd5xWWjuWV4wkmQ7agmy4WlN9BdjJ/v5nnuVMmzG7X+
         N/HPLYtP7EFedgnG8IT97a/FpFkBxZbeZ/L34dHaexQJDnFuOWiv4f5Ox3KVKODQt4DI
         Zi8A==
X-Gm-Message-State: APjAAAXiTSXUosDnXsL3hif4//64CLTnZWJo5bfvEPAi8Yr2P/QdZit7
        vZO+bqEgJjveLTUDaAN0N00gjg==
X-Google-Smtp-Source: APXvYqwYXdTXpfDhGmQt8us4MjMKgpbr+c5sCD+q4V7paAN4sFr9nfOElG4ad8gQmXlIHo+aNGcOGQ==
X-Received: by 2002:aa7:8c0f:: with SMTP id c15mr73672184pfd.113.1560530619784;
        Fri, 14 Jun 2019 09:43:39 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.18])
        by smtp.gmail.com with ESMTPSA id 85sm1639583pfv.130.2019.06.14.09.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 09:43:38 -0700 (PDT)
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
Subject: [PATCH v2 0/9] drm/sun4i: Allwinner R40 MIPI-DSI support
Date:   Fri, 14 Jun 2019 22:13:15 +0530
Message-Id: <20190614164324.9427-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 version for supporting MIPI-DSI on Allwinner R40 from
initial version[4].

The controller look similar like, Allwinnwe A64 so it has
dependencies with A64 MIPI DSI changes, DSI fixes and R40 pwm 
driver [1] [2] [3]. 

PLL-MIPI, dclk divders logic bpp/lanes are properly work for R40,
like A31, A64.

Changes for v2:
- drop tcon top lcd clock patch
- add TODO text while adding tcon lcd support
- add patch for registering tcon top clock gates in probe
- change tcon-ch0 in tcon_lcd0 to CLK_TCON_LCD0
- change mod clock in dphy to tcon_top with index 3 

[1] https://patchwork.freedesktop.org/series/61310/
[2] https://patchwork.freedesktop.org/series/60847/ 
[3] https://lore.kernel.org/patchwork/cover/862766/ 
[4] https://patchwork.freedesktop.org/series/62062/

Any inputs?
Jagan.

Jagan Teki (9):
  dt-bindings: display: Add TCON LCD compatible for R40
  drm/sun4i: tcon: Add TCON LCD support for R40
  ARM: dts: sun8i: r40: Use tcon top clock index macros
  drm/sun4i: tcon_top: Use clock name index macros
  drm/sun4i: tcon_top: Register clock gates in probe
  dt-bindings: sun6i-dsi: Add R40 MIPI-DSI compatible (w/ A64 fallback)
  dt-bindings: sun6i-dsi: Add R40 DPHY compatible (w/ A31 fallback)
  ARM: dts: sun8i: r40: Add MIPI DSI pipeline
  [DO NOT MERGE] ARM: dts: sun8i-r40: bananapi-m2-ultra: Enable Bananapi S070WV20-CT16 DSI panel

 .../bindings/display/sunxi/sun4i-drm.txt      |   1 +
 .../bindings/display/sunxi/sun6i-dsi.txt      |   2 +
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  36 ++++++
 arch/arm/boot/dts/sun8i-r40.dtsi              |  78 ++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |   8 ++
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c        | 103 ++++++++++--------
 6 files changed, 178 insertions(+), 50 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

