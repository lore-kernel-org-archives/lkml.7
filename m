Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16FFC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC6B20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XYnYivhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfFMSxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:53:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41697 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729462AbfFMSxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:53:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id s24so8506040plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8d7m1DDnqH/bUU0S136tJmuahNrjwjbhZ2wXcmIkdw=;
        b=XYnYivhjrL8PvMkvcXOzIdoB8lf1mxtbUYycZaEG3qDzZOBTZW8NEM4v6Fq3KNpMR1
         V9M4+v2ssLCBbmr5ZhabNGscBCasuvkwnhUqZ54hKPn1YDbi6BS99GW/25z7RJoSLomS
         zMZ0+g/bDTm+xsqCnr1Clt8/yhkTCEp0Kf8g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8d7m1DDnqH/bUU0S136tJmuahNrjwjbhZ2wXcmIkdw=;
        b=gvRYt2WeNxFn3Jrv8scKw2Rw3uSXXhWPa5hos/vGjnSFo23Q5Rkeu3YpPXaR4Grm7o
         8//f2/qIohKQql4LJz7gFA0UBxAgFBX1GejjZJy9ntbUct9+aa3jQHAKEth4gB4p2rgw
         /+dJ9DsFzb3kMN7nX8AaBPLAi3W+zuTV0LWLCwD1x+xyv5jz5rQSEKKbdw8N4tWSG9YR
         55S6lhDKzp+FG8Ou3npLBJF1OLR5yzL72xCKMkkMlENFSOdhVPWzzklXTZj9M2VktxEB
         WUkXw61O4X4ERsAsRhZGzMv/5Zw/8WjxefLx5hSgGb4bcpW5MAiQjNQNB/sqYOJj0zDy
         Qygw==
X-Gm-Message-State: APjAAAVdeWJ3u8oFcp0IQaZtpM+LInExacrBphs8fW6vyrPgYmMV/Px1
        aDcOGLvdpHtDlRBs1SChwTOFcQ==
X-Google-Smtp-Source: APXvYqxKp7XuhbcSPIGuqB4Br4J+FEyezdRc8LcQCzcSqRvzjXK5pGpx+EH6W3hDqkSMxv54g7UEGQ==
X-Received: by 2002:a17:902:a5c5:: with SMTP id t5mr90864681plq.288.1560452026080;
        Thu, 13 Jun 2019 11:53:46 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.18])
        by smtp.gmail.com with ESMTPSA id p43sm946314pjp.4.2019.06.13.11.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 11:53:45 -0700 (PDT)
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
Subject: [PATCH 0/9] drm/sun4i: Allwinner R40 MIPI-DSI support
Date:   Fri, 14 Jun 2019 00:22:32 +0530
Message-Id: <20190613185241.22800-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is initial version for supporting MIPI-DSI on Allwinner R40.

The controller look similar like, Allwinnwe A64 so it has
dependencies with A64 MIPI DSI changes, DSI fixes and R40 pwm 
driver [1] [2] [3] 

PLL-MIPI, dclk divders logic bpp/lanes are properly work for R40,
like A31, A64.

patch 1, 2: TCON LCD support

patch 3, 4: Use clock index macros instead of numbers

patch 5: Add tcon top lcd clocking

patch 6, 7: Add dt-bindings for r40 dsi, dphy

patch 8: Add R40 MIPI DSI pipeline

patch 9: Overlay patch to test it on BPI-M2U

[1] https://patchwork.freedesktop.org/series/61310/
[2] https://patchwork.freedesktop.org/series/60847/ 
[3] https://lore.kernel.org/patchwork/cover/862766/ 

Jagan Teki (9):
  dt-bindings: display: Add TCON LCD compatible for R40
  drm/sun4i: tcon: Add TCON LCD support for R40
  ARM: dts: sun8i: r40: Use tcon top clock index macros
  drm/sun4i: tcon_top: Use clock name index macros
  ARM: dts: sun8i: r40: Add TCON TOP LCD clocking
  dt-bindings: sun6i-dsi: Add R40 MIPI-DSI compatible (w/ A64 fallback)
  dt-bindings: sun6i-dsi: Add R40 DPHY compatible (w/ A31 fallback)
  ARM: dts: sun8i: r40: Add MIPI DSI pipeline
  [DO NOT MERGE] ARM: dts: sun8i-r40: bananapi-m2-ultra: Enable Bananapi S070WV20-CT16 DSI panel

 .../bindings/display/sunxi/sun4i-drm.txt      |  1 +
 .../bindings/display/sunxi/sun6i-dsi.txt      |  2 +
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 36 ++++++++
 arch/arm/boot/dts/sun8i-r40.dtsi              | 84 +++++++++++++++++--
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |  7 ++
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c        | 13 +--
 include/dt-bindings/clock/sun8i-tcon-top.h    |  2 +-
 7 files changed, 134 insertions(+), 11 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

