Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B657C742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6947A21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FKtfQs2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfGKUpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 16:45:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46176 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbfGKUpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:45:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so3608665plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PiSze+b8RyOCrdrl4z9soZ+cov9nAQWtcb1gx4qZEko=;
        b=FKtfQs2vO8puHfi8u5Itf2xIOrp80ctPquUf87JLqr/dE/UjPpoKuPH3lPJMtzczUv
         qmsjAe/JpyaR86mjQ3YQ6oLOQzCVzw9LlXoWOuuN3PkzIRWDV2tgKRefTsRzAfV8Rb2/
         p+p1+DcWIo7mGUqiAZNYCbJwDivBgkEvwYPJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PiSze+b8RyOCrdrl4z9soZ+cov9nAQWtcb1gx4qZEko=;
        b=F6u90SqGE5j+vyAvC8C2azII81nCfuSA7obBDMNmdBkT6q0ECAHTHvsN7UWqpPa0MF
         +b7MRTM6CmVAlwr+W7qWmxZ0WkxOQCTs4CQUWwBwtlppJzJFjPBmmIwNqG08pU16fZv3
         QPNM/s0MgptdnJszPCgCmOhh5jy9RayKcC+cw0WTONYKNZKCMvdS0oNHLac6zwyR8dNN
         EBcZ+dAYtkHNNQo78HU3/3uxaQQeRoC4YmeL/2uPU+H1I2ghz02mjqvC1gvpOCsmEuQK
         qADd6ZWQm1JI+LZ2iWfiAC8qxJH+cOrr/ftnbNc9C2dBLuDDsap0FJBjlnB+iwpbyaPO
         eOeg==
X-Gm-Message-State: APjAAAUsNQt/nfibbjG8dmfX9XSfrQD1fp9CEaEYrW+rVDFQL/ldqAdj
        4vu1tGN6ZgxCb4ijVYVrG3tQQA==
X-Google-Smtp-Source: APXvYqx5OMVKLfuzSjyyKQdK5nWwU4ixzYuYMZrGSFfkXAOPPnXjXzBfWibAgOkF0K9yIsJfpGBE9Q==
X-Received: by 2002:a17:902:9898:: with SMTP id s24mr6688486plp.226.1562877899981;
        Thu, 11 Jul 2019 13:44:59 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id f17sm5320110pgv.16.2019.07.11.13.44.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 13:44:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        mka@chromium.org, Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v6 0/3] drm/panel: simple: Add mode support to devicetree
Date:   Thu, 11 Jul 2019 13:34:52 -0700
Message-Id: <20190711203455.125667-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm reviving Sean Paul's old patchset to get mode support in device
tree.  The cover letter for his v3 is at:
https://lists.freedesktop.org/archives/dri-devel/2018-February/165162.html

v6 of this patch is just a repost of the 3 DRM patches in v5 rebased
atop drm-misc.  A few notes:
- I've dropped the bindings patch.  Commit 821a1f7171ae ("dt-bindings:
  display: Convert common panel bindings to DT schema") has landed and
  Rob H said [1] that when that landed the bindings were implicitly
  supported.
- Since the bindings patch was dropped I am assuming that Heiko
  can just pick up the .dts patches from the v5 series.  I
  double-checked with him and he confirmed this is fine.  Thus I
  have left the device tree patches out of this version.

There were some coding style discussions on v5 of the path but it's
been agreed that we can land this series as-is and after it lands we
can address the minor style issues.

[1] https://lkml.kernel.org/r/CAL_JsqJGtUTpJL+SDEKi09aDT4yDzY4x9KwYmz08NaZcn=nHfA@mail.gmail.com

Changes in v6:
- Rebased to drm-misc next
- Added tags

Changes in v5:
- Added Heiko's Tested-by

Changes in v4:
- Don't add mode from timing if override was specified (Thierry)
- Add warning if timing and fixed mode was specified (Thierry)
- Don't add fixed mode if timing was specified (Thierry)
- Refactor/rename a bit to avoid extra indentation from "if" tests
- i should be unsigned (Thierry)
- Add annoying WARN_ONs for some cases (Thierry)
- Simplify 'No display_timing found' handling (Thierry)
- Rename to panel_simple_parse_override_mode() (Thierry)
- display_timing for Innolux n116bge new for v4.
- display_timing for AUO b101ean01 new for v4.

Changes in v3:
- No longer parse display-timings subnode, use panel-timing (Rob)

Changes in v2:
- Parse the full display-timings node (using the native-mode) (Rob)

Douglas Anderson (2):
  drm/panel: simple: Use display_timing for Innolux n116bge
  drm/panel: simple: Use display_timing for AUO b101ean01

Sean Paul (1):
  drm/panel: simple: Add ability to override typical timing

 drivers/gpu/drm/panel/panel-simple.c | 171 ++++++++++++++++++++++-----
 1 file changed, 139 insertions(+), 32 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

