Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D299C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 18:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2BB20C01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 18:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OFAoMYrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfELSln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 14:41:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41662 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfELSln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 14:41:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id l132so5922402pfc.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+4FJQrwxfW4iQ3D++ujgHoZ7fSNJSGSWELuM5mxXM0=;
        b=OFAoMYrjTKSrSw68dDWRRAa8d060sQJaewjsrrmuYlw7o0UTzedLE5cjsvyGvG6/lj
         XFe19ijnnSaSUUsxtTUcmuztKzK4FrkBnPr61fwbecvFpT8FD+xEs/TTVE3mTrT4M214
         GmkpotVhxepcWmHthgsbOF67lJkSrkiHKb8rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+4FJQrwxfW4iQ3D++ujgHoZ7fSNJSGSWELuM5mxXM0=;
        b=ZddMooARWqycreFqyVlfPGPd9TLdPuCkm1FJjo8l/B2HoMKXKafDnOJQReJjJLhYYb
         ZmiGAh3vj0BukURO4xrFenctHRzxs9kT1zaTCTUrLj40ERXlzsaNQjr6ziwiWX6Z4QOL
         jN+PUUAcQCplbjT7b0zxUTuPt0rapTWotXX2wIPYYO88WH4tmDftkoPuLbLaKjt/0YV1
         BJUQZU44iHTVgzbdqxCuu2asPN906my2AWSS9l4Qm8ajDI3PxNo177mzAHmIjC4j9Sf0
         VS/2CXoUD/HaM55BEKWxWV27NMn1qS0nHA4+YWrLMGkubYwDJPfAOAAqX6HidYT5Xgnb
         yv/Q==
X-Gm-Message-State: APjAAAWa9TBolH59dlIOdduq01ykclAHmhoC5BE4A38u5I0xBdvpa4KO
        mv9LgS0D9ZJSmBJ82jsYxgvctg==
X-Google-Smtp-Source: APXvYqxEjNVOEFw39liUe55Z6S+XNfP2Rf4kINCXCoKeJYUK6ImMO8g8xjL8UwoLXVRCynFgk9TW7A==
X-Received: by 2002:a63:4346:: with SMTP id q67mr26842320pga.241.1557686502441;
        Sun, 12 May 2019 11:41:42 -0700 (PDT)
Received: from localhost.localdomain ([115.97.185.144])
        by smtp.gmail.com with ESMTPSA id 37sm11041291pgn.21.2019.05.12.11.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 11:41:42 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v10 0/2] drm/sun4i: sun6i_mipi_dsi: Fixes/updates
Date:   Mon, 13 May 2019 00:11:25 +0530
Message-Id: <20190512184128.13720-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v10 for the previous series[1] and few pathes are dropped
as part of this series since it would require separate rework same
will send in separately or another series.

Changes for v10:
- rebased on linux-next
- dropped few patches
- add 150 multiplication on hsync_porch
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

[1] https://patchwork.kernel.org/cover/10837163/

Any inputs?
Jagan.

Jagan Teki (2):
  drm/sun4i: sun6i_mipi_dsi: Fix hsync_porch overflow
  drm/sun4i: sun6i_mipi_dsi: Support DSI GENERIC_SHORT_WRITE_2 transfer

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

