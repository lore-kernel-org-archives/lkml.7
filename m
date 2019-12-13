Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0270CC2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7D6214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gl+emP7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLMXqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:46:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35893 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLMXqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:46:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id x184so2299309pfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 15:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m3tnYNjZklrCNxszO/0kPGsUfQeQByiJ9rpXVmlPYMQ=;
        b=Gl+emP7qUPXPO55j3ZdogAAGaBmB1tfWrfMpr9B+Ioe1vF0uy6ZqocA9OMUB5JfstB
         2bs+j0bHQBm7QsrZOv5xBgerkhrIe0uYNSi9r/+uKT6ZXAbYeRIqfLI4sp0WwtDAjmKe
         Ci8Ckj76NCLRfPWwogRmjjbe5zkYOVRqNL0hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m3tnYNjZklrCNxszO/0kPGsUfQeQByiJ9rpXVmlPYMQ=;
        b=U3nPhFPQIO83YPDyf+9qh6MNoP34plyyvc8YyKAohl4Q/uqolqzLplgrwYHepiitX8
         SFlJAjTDnfWNYC05tTpD/oOzkzqqdrf0dTJyiQtv1OE00GRx25e1gzT+G+fieusbi+mu
         WESIQLQK6ICFtgJ3aL4YrwpLQt3ccGYjSarGSbGKFS0Kg1sBQ9m7Kugsy2d2tqLm2zto
         VqMlck5wlh6OfZr+IDaF91MaLOXLvFTVrKRR0K1cBkv9pMNBpRHmIk3bfWt0nc9Cx75q
         d4e+6w+lE4BRSQquAI6qBkjS6d8sdPkUztq63gMMVlfdZECFgoDfTiRwn0cSbzh0RjFA
         ELLg==
X-Gm-Message-State: APjAAAX3J8qw48yfSY4mXhHy9CbWzrNHIfwIyJpgQESLF+Cw7CWVTPXc
        OmkYLzEp6jo/SYpS55AQSyZzOA==
X-Google-Smtp-Source: APXvYqwBnveObOq5rcN+uDkJGNGx9NFxQRCx/ISNhTEX/rA3Xqyawp1B4t3Q0KWqNaayvlxYUUaGVg==
X-Received: by 2002:a62:c541:: with SMTP id j62mr2389128pfg.237.1576280763829;
        Fri, 13 Dec 2019 15:46:03 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id z19sm12282905pfn.49.2019.12.13.15.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:46:03 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        seanpaul@chromium.org, bjorn.andersson@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 0/9] drm/bridge: ti-sn65dsi86: Improve support for AUO B116XAK01 + other low res DP
Date:   Fri, 13 Dec 2019 15:45:21 -0800
Message-Id: <20191213234530.145963-1-dianders@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a pile of patches that was created to support
hooking up the AUO B116XAK01 panel to the eDP side of the bridge.  In
general it should be useful for hooking up a wider variety of DP
panels to the bridge, especially those with lower resolution and lower
bits per pixel.

The overall result of this series:
* Allows panels with fewer than 4 DP lanes hooked up to work.
* Optimizes the link rate for panels with 6 bpp.
* Supports trying more than one link rate when training if the main
  link rate didn't work.

It's not expected that this series will break any existing users, but
it is possible that the patch to skip non-standard DP rates could mean
that a panel that used to use one of these non-standard link rates
will now run at a higher rate than it used to.  If this happens, the
patch could be reverted or someone could figure out how to decide when
it's OK to use the non-standard rates.

To support the AUO B116XAK01, we could actually stop at the ("Use
18-bit DP if we can") patch since that causes the panel to run at a
link rate of 1.62 which works.  The patches to try more than one link
rate were all developed prior to realizing that I could just use
18-bit mode and were validated with that patch reverted.

The patch to try more than one rate was validated by forcing the code
to try 2.16 GHz (but still skip 2.43 GHz, which trains but shows
garbage on AUO B116XAK01) and seeing that we'd try 2.16 GHz (and fail)
and then eventually pass at 2.7 GHz and show a pretty screen.

These patches were tested on sdm845-cheza atop mainline as of
2019-12-13 and also on another board (the one with AUO B116XAK01) atop
a downstream kernel tree.

This patch series doesn't do anything to optimize the MIPI link and
only focuses on the DP link.  For instance, it's left as an exercise
to the reader to see if we can use the 666-packed mode on the MIPI
link and save some power (because we could lower the clock rate).

I am nowhere near a display expert and my knowledge of DP and MIPI is
pretty much zero.  If something about this patch series smells wrong,
it probably is.  Please let know and I'll try to fix it.


Douglas Anderson (9):
  drm/bridge: ti-sn65dsi86: Split the setting of the dp and dsi rates
  drm/bridge: ti-sn65dsi86: zero is never greater than an unsigned int
  drm/bridge: ti-sn65dsi86: Don't use MIPI variables for DP link
  drm/bridge: ti-sn65dsi86: Config number of DP lanes Mo' Betta
  drm/bridge: ti-sn65dsi86: Read num lanes from the DP sink
  drm/bridge: ti-sn65dsi86: Use 18-bit DP if we can
  drm/bridge: ti-sn65dsi86: Group DP link training bits in a function
  drm/bridge: ti-sn65dsi86: Train at faster rates if slower ones fail
  drm/bridge: ti-sn65dsi86: Skip non-standard DP rates

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 230 +++++++++++++++++++++-----
 1 file changed, 187 insertions(+), 43 deletions(-)

-- 
2.24.1.735.g03f4e72817-goog

