Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51114C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58E622DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SvLo7b5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfHTXGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:06:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42923 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHTXGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so145804pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ryVGrG9e9TLG77G8C99Y8FHgpTFEkxY3w2ym7UqLajQ=;
        b=SvLo7b5oXDEKoxq5CyyOKxHb8DjsMtSbtA+l64JS8PbQNprKp/5rKAwnjVaSRZej+N
         5Y3joc/TwMsyRDh16VqIEl6OBEI20tBiWPll08s3F1SbHMKu5AOlm4m5p+1Q5UKHL+WJ
         IPC+nrI6EGoq+9OmY+LOcNZI2XtInSONlxh6ltFePerDnpUEe6pirUOW8cJyTWm36jKg
         cMghCRZDgHGkFLH8r2R12DD/QymlYfiGCH6e9qwQliJEDNgKpm1qih8xo9A5SbuZTDC3
         SC5QCdMJ/YAZ80sK7XDYPUerY3h7a2t8tcwKX1wjS2ImDSTFQhhsFNT8GR5bPzeKQU7P
         QfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ryVGrG9e9TLG77G8C99Y8FHgpTFEkxY3w2ym7UqLajQ=;
        b=HuP+2blT26FrzwAYBK8/vNUgJib0rFr3b6btt81KwXhftBFZwX9QyGusU5ia6Zj2dy
         wHNyPvoskFxsj4ZcQEc1A4rb4Gg7dY00Y96fSVbUQdFTbhG8qtqnsS6zc716wWW8Sdk8
         37oKjTSj0JZHuScO2EbCLVXyAuBX/YSY0cKaT9zGc9GYIYn9p8hLgbKTIoxBBHCzOQcS
         /CeS6SgDVhLpHbSVUza8T2rVLqc0fGJHUkgX5tK+0mT6onMFsUUD9MpjswZPLMmTPnk3
         ZQJou8BRAj5CcVznhp/PPyiF8/heiMnrjIBDOpDUC9KqTiN4dQbJgdagiDi6HIPKLnH1
         NJ0A==
X-Gm-Message-State: APjAAAX3/c6XfjQvS6nBFinpfIWzDtXz2/BeOAOHkBwlrzwtH+EZGK31
        xjKjnqXeXmHSYnOycCQxtQlO4umJxlc=
X-Google-Smtp-Source: APXvYqxbdTcern/qekwcKh1V7jWD3jUbS4fVYztkrvYCDaXS4gUd4pNM6l5b7XRrj8Vc34pnD8zU3A==
X-Received: by 2002:aa7:8106:: with SMTP id b6mr32592440pfi.5.1566342390162;
        Tue, 20 Aug 2019 16:06:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:29 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v5 00/25] drm: Kirin driver cleanups to prep for Kirin960 support
Date:   Tue, 20 Aug 2019 23:06:01 +0000
Message-Id: <20190820230626.23253-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending this out again (apologies!), to address a few issues Sam
found.

This patchset contains one fix (in the front, so its easier to
eventually backport), and a series of changes from YiPing to
refactor the kirin drm driver so that it can be used on both
kirin620 based devices (like the original HiKey board) as well
as kirin960 based devices (like the HiKey960 board).

The full kirin960 drm support is still being refactored, but as
this base kirin rework was getting to be substantial, I wanted
to send out the first chunk, so that the review burden wasn't
overwhelming.

The full HiKey960 patch stack can be found here:
  https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/hikey960-mainline-WIP

thanks
-john


New in v5:
* Whitespace changes and few logic simplifications to get
  checkpatch.pl --strict to pass, as noted by Sam
* Fix for one of my patches which broke building the kirin
  driver as a module. Again noted by Sam.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>

Da Lv (1):
  drm: kirin: Fix for hikey620 display offset problem

John Stultz (3):
  drm: kirin: Remove HISI_KIRIN_DW_DSI config option
  drm: kirin: Remove unreachable return
  drm: kirin: Move workqueue to ade_hw_ctx structure

Xu YiPing (21):
  drm: kirin: Remove uncessary parameter indirection
  drm: kirin: Remove out_format from ade_crtc
  drm: kirin: Rename ade_plane to kirin_plane
  drm: kirin: Rename ade_crtc to kirin_crtc
  drm: kirin: Dynamically allocate the hw_ctx
  drm: kirin: Move request irq handle in ade hw ctx alloc
  drm: kirin: Move kirin_crtc, kirin_plane, kirin_format to
    kirin_drm_drv.h
  drm: kirin: Reanme dc_ops to kirin_drm_data
  drm: kirin: Move ade crtc/plane help functions to driver_data
  drm: kirin: Move channel formats to driver data
  drm: kirin: Move mode config function to driver_data
  drm: kirin: Move plane number and primay plane in driver data
  drm: kirin: Move config max_width and max_height to driver data
  drm: kirin: Move drm driver to driver data
  drm: kirin: Add register connect helper functions in drm init
  drm: kirin: Rename plane_init and crtc_init
  drm: kirin: Fix dev->driver_data setting
  drm: kirin: Make driver_data variable non-global
  drm: kirin: Add alloc_hw_ctx/clean_hw_ctx ops in driver data
  drm: kirin: Pass driver data to crtc init and plane init
  drm: kirin: Move ade drm init to kirin drm drv

 drivers/gpu/drm/hisilicon/kirin/Kconfig       |  10 +-
 drivers/gpu/drm/hisilicon/kirin/Makefile      |   3 +-
 .../gpu/drm/hisilicon/kirin/kirin_ade_reg.h   |   1 +
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 351 +++++++-----------
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   | 250 +++++++++----
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   |  48 ++-
 6 files changed, 367 insertions(+), 296 deletions(-)

-- 
2.17.1

