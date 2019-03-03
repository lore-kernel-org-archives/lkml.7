Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70009C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2A920866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Epywo948"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfCCRgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:36:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38830 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCCRgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:36:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id m2so1361078pgl.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 09:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Gqk0T4ZxltYjBojSOznYbTojuJQE8paXlZHFfV+0JE=;
        b=Epywo948Vw2kg0WZEcZII1DLuDkTg37+DyKKb/nyBhWOnAErSFrNEfX3e3UueGyBmL
         +xilDgWpoE+H9321eCylwQUEUmRvS9O11v6ueeaTaEIzknWYNjzGtnpX5+Ybuh2PAnYa
         xewLi6AO8YLs1clnTVBHUU+Ptm/vkC9Y5Ar7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Gqk0T4ZxltYjBojSOznYbTojuJQE8paXlZHFfV+0JE=;
        b=VnGsa2BZR5cyyWq9qOw7H5HTpgne9n0siL7gn5rnArrkk8sn2iDzfU4eA86o5l8pxT
         7yw1lFajEcDYJk3BmPE21GHYzXBvIjy+85sUwn4TsV3SmxgK1dA8Y6pKKxeM95Oeug78
         YIH/QAUvtiRtSDwxmrdG+I77XNsaXeeCEKOTQGOToxahtb9gSF9/+mryGaLble7+lsHJ
         H16bY1x+QVCqdbfnqxrvmcWjQ1G5b+MVjgym7BJUQ0pXj6xXs6TZMcW/Z6H+X7NEUhOx
         0XkeCrsXl50O89j5D3CYc5axGnfeQ/yyqjJIDCX7opdpx9LEhU8l9KqJE2dJEvqKEdsw
         neBA==
X-Gm-Message-State: APjAAAVUvwNZ8I501SHvdExOp/R3MynAabtgOqb5uoM9BPeJ4LARtd4U
        lUaPfL6/dCnpTONZqhqXPy523g==
X-Google-Smtp-Source: APXvYqwMCnKE0sRV68FKYS1PAQyUH6bxq5a6ac5iJWv7Xe4zkgZIi1GCpNeY77AlOHbYrfTYL6LZOQ==
X-Received: by 2002:a63:7403:: with SMTP id p3mr14608337pgc.343.1551634571036;
        Sun, 03 Mar 2019 09:36:11 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id d129sm5614737pgc.59.2019.03.03.09.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:36:10 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v9 0/5] drm/sun4i: sun6i_mipi_dsi: Fixes/updates
Date:   Sun,  3 Mar 2019 23:05:22 +0530
Message-Id: <20190303173527.31055-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately due to various reasons[3] the previous fixes[1] and burst[2]
changes are failed to apply.

So, this series is filtered version of previous [1] and [2] changes on top
of drm-misc.

patch-1: Fix for burst mode instruction delay computation

patch-2: Fix for TCOn DRQ set bits

patch-3: Support vblk timing for 4-lane devices

patch-4: GENERIC_SHORT_WRITE_2 dsi transfer support

patch-5: Code simplification for dsi timings   

Changes for v9:
- rebase on drm-misc
- update commit messages
- add hsync_porch overflow patch
Changes for v8:
- rebase on master
- rework on commit messages
- rework video start delay
- include drq changes from previous version
Changes for v7:
- rebase on master
- collect Merlijn Wajer Tested-by credits.
Changes for v6:
- fixed all burst mode patches as per previous version comments
- rebase on master
- update proper commit message
- dropped unneeded comments
- order the patches that make review easy
Changes for v5, v4, v3, v2:
- use existing driver code construct for hblk computation
- create separate function for vblk computation 
- cleanup commit messages
- update proper commit messages
- fixed checkpatch warnings/errors
- use proper return value for tcon0 probe
- add logic to get tcon0 divider values
- simplify timings code to support burst mode
- fix drq computation return values
- rebase on master

[1] https://patchwork.kernel.org/cover/10813573/
[2] https://patchwork.kernel.org/cover/10813623/
[3] https://patchwork.kernel.org/cover/10805995/

Any inputs?
Jagan.

Jagan Teki (5):
  drm/sun4i: sun6i_mipi_dsi: Fix hsync_porch overflow
  drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
  drm/sun4i: sun6i_mipi_dsi: Support vblk timing for 4-lane devices
  drm/sun4i: sun6i_mipi_dsi: Support DSI GENERIC_SHORT_WRITE_2 transfer
  drm/sun4i: sun6i_mipi_dsi: Simplify dsi setup timings code

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 114 +++++++++++++++----------
 1 file changed, 67 insertions(+), 47 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

