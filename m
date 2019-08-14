Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E601FC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0542173E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ieBmvOQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfHNSrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32866 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfHNSrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so54105491pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=e2lnOM0nFup0+pDAGMOKduOv8qYBIIuH1dlGE1F9sPs=;
        b=ieBmvOQNdM7BQd6Gca54c7f9RiF5MCWMIzSkw+wXsP2vjco7xd/LwS6OHt7Vh+UZ7e
         7X24Y6DGIMQVMarWETzWtvF3pDWJWSw1YKDBP8rmmDG7pP/GyO6pbbioIou35P4bC9bF
         /ELRg6ljWXtk4eXrayC3/WrpoC6NwCzClrkkIsqBD2sBlXMDpG0z63orWyQLi/7zZU2v
         6maY394hvg3TvFaqJlUdFc9s5xmIuQKjdjGQmWLr1VUlH1QFPoSa8q35I3WJoYfFuEXn
         8C2x/ZkXdmNPUKXBQznie/ercfyaygJhrUTnTAcWqdVCkqZVKPV62Jby73cv1LF5wEYw
         +PNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e2lnOM0nFup0+pDAGMOKduOv8qYBIIuH1dlGE1F9sPs=;
        b=n5odXARsN8UlMEo3W2FnYoxag4YOkyMaUdFKlnSm0lKTWJiQv7rd7vXki6ofv/5e+V
         khhsvFCgfff3Y3m91zeqH/mcWFSUY+gu1Bd1lRd2Mlr2eff9xjoA2RUjyPt6Wqi5WYDh
         mnDHaFZvnYi8HJfJZqZHFfYzAzbJNltf6d/U4qkZmnIIoKxfiqfn7YQzBLQnLyH4zoKB
         +17hX7CrzL1Vm0IZrUGRpNlQ+SZjAibopvvYmhEVL11kZsZufYEuZkHsBxWAM77yrzhC
         oisscvIljZwH6j+aNTAOK3qGFeJt5tZB2qS0fssOtee3VzEVa1l3ullNAJqLiQ2UnEXX
         +6/g==
X-Gm-Message-State: APjAAAXZeav+g2u5jCcfj0ZYYcE9Ee7LarEUYLcuuzXe3K0DBr7L8nDW
        OSBG/Tv3xIKzjnEffXbXpnZgBbqVAEY=
X-Google-Smtp-Source: APXvYqzCysw5Y/5dmalFUJZRxuOj2cWrLosCwl46s9aspUhN6WQQhOJ4b4h1iOtEIPC6cZFBiEMV7Q==
X-Received: by 2002:a63:3fc9:: with SMTP id m192mr471718pga.429.1565808426805;
        Wed, 14 Aug 2019 11:47:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:06 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [RESEND][PATCH v3 00/26] drm: Kirin driver cleanups to prep for Kirin960 support
Date:   Wed, 14 Aug 2019 18:46:36 +0000
Message-Id: <20190814184702.54275-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just wanted to resend this patch set so I didn't have to
continue carrying it forever to keep the HiKey960 board running.

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

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>

Da Lv (1):
  drm: kirin: Fix for hikey620 display offset problem

John Stultz (4):
  drm: kirin: Get rid of drmP.h includes
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
 drivers/gpu/drm/hisilicon/kirin/Makefile      |   4 +-
 .../gpu/drm/hisilicon/kirin/kirin_ade_reg.h   |   1 +
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 360 +++++++-----------
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   | 257 +++++++++----
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   |  48 ++-
 6 files changed, 379 insertions(+), 301 deletions(-)

-- 
2.17.1

