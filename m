Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13789C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BC4207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JNRNyjPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLaNFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 08:05:43 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36943 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfLaNFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 08:05:42 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so1211822pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 05:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G8ue1C52c6GMFo3Ro49/gUAlsKHzYRxfbPWqTGCIbyw=;
        b=JNRNyjPnuWa3Uwbq0Q5tiy7txraP03SundwCX4/YlAxMeSUJ4lClB9jb44eLtO6iRF
         HrhyZr5cz1P8LDTX+KBc7DI8GMWWZ3FX2v3iPLpHt1LvH4grZql1KQkDA45kcp8pSkdK
         TBDBQ2HMrNmRsko3h5ah/l328CIQUspldKC0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G8ue1C52c6GMFo3Ro49/gUAlsKHzYRxfbPWqTGCIbyw=;
        b=m400+uTpMpiMEcMNrPQf54XoUERPUbm5+b95PvMF8xvzMf3w6vi5fruYlau+ZHRZua
         g0v+/xjcTR9e4ygbnpurs7lzOZJ57yhbR7l0XucytdBjbpmHzgESFxr/gHO/OrzRDfKQ
         qa0Q8X5G2gTiSCwCC8Llv1DFnmUC2SnTqofHssZJA7JITnrlnfy4orbYWjyjMAIS7axV
         uzuCaU801EdeeAbVqUjCSW2/ghjDgJTylfcBh4d5u1YZK0TH1QYlAuCgXCHxR7h46Yx9
         37MbwTEQevmhmAnHOF8CLeQyoBQ6v3yYSJ1JOKe/sxrBYYpDn2xQ0kjrqDh3RSUD/Gti
         ip+Q==
X-Gm-Message-State: APjAAAXnZH8Dvs2u5b3Y82Wu2ChOfPWjcS/CyoZFCojSlu9kko3rvsm+
        V+2466C8tdu6FZZ4z9X8d+tI5A==
X-Google-Smtp-Source: APXvYqxXkYxsyd0ZyZlBKsAKlLynOFIBkeSMyKHk4J7/GJzGsj4UxrrFoX57Z2SFZ8ziy3NWHt7NsA==
X-Received: by 2002:a17:902:bf0c:: with SMTP id bi12mr47277055plb.208.1577797541340;
        Tue, 31 Dec 2019 05:05:41 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.115])
        by smtp.gmail.com with ESMTPSA id i3sm55204089pfg.94.2019.12.31.05.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 05:05:40 -0800 (PST)
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
Subject: [PATCH v3 0/9] drm/sun4i: Allwinner R40 MIPI-DSI support
Date:   Tue, 31 Dec 2019 18:35:19 +0530
Message-Id: <20191231130528.20669-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v3 version for supporting MIPI-DSI on Allwinner R40 from
initial version[1].

The controller look similar like, Allwinner A64 but with associated
R40 TCON TOP for DSI pipeline.

Changes for v3:
- collect Rob, Chen-Yu r-b, a-b tags
- move tcon top reset control methods into probe
- rebase on drm-misc
Changes for v2:
- drop tcon top lcd clock patch
- add TODO text while adding tcon lcd support
- add patch for registering tcon top clock gates in probe
- change tcon-ch0 in tcon_lcd0 to CLK_TCON_LCD0
- change mod clock in dphy to tcon_top with index 3 

[1] https://patchwork.freedesktop.org/series/62062/

Any inputs?
Jagan.

Jagan Teki (9):
  dt-bindings: display: Add TCON LCD compatible for R40
  drm/sun4i: tcon: Add TCON LCD support for R40
  ARM: dts: sun8i: r40: Use tcon top clock index macros
  drm/sun4i: tcon_top: Use clock name index macros
  drm/sun4i: tcon_top: Register reset, clock gates in probe
  dt-bindings: sun6i-dsi: Add R40 DPHY compatible (w/ A31 fallback)
  dt-bindings: sun6i-dsi: Document R40 MIPI-DSI controller (w/ A64
    fallback)
  ARM: dts: sun8i: r40: Add MIPI DSI pipeline
  [DO NOT MERGE] ARM: dts: sun8i-r40: bananapi-m2-ultra: Enable Bananapi S070WV20-CT16

 .../display/allwinner,sun6i-a31-mipi-dsi.yaml |  8 +-
 .../bindings/display/sunxi/sun4i-drm.txt      |  1 +
 .../phy/allwinner,sun6i-a31-mipi-dphy.yaml    |  1 +
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 37 +++++++++
 arch/arm/boot/dts/sun8i-r40.dtsi              | 77 ++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |  8 ++
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c        | 50 ++++++------
 7 files changed, 154 insertions(+), 28 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

