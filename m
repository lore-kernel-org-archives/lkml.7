Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F71C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0810206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y1iVdTDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfHADor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:44:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38070 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfHADor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:44:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id f5so24455051pgu.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3J53VNWVJBsGu++2k8+xv87EgCNc+PbFLaNFsCRi7RQ=;
        b=y1iVdTDcBUa0wFaA/SURtNmg482d/Gqz0ErVvPR52MUAP3TmRHvMrYgPon2HSmbIXR
         ldTM9+Jj23uaZCMo7XuO7iZ5nSzgKpD2vyT3tIHCwGiV8LWJgjhxxE8kyMsN82n9npD+
         Gbhu79TbuSbbVM2RHq/yt6PJQVhFDvtTdcmsw1WzGyqV9g+wMDfFXDZmBCcqr2CQ6i6Z
         vVdQWYGbCqQDN4gV9vPXAGXnfvwFWPP9Wc9TiD/kl3vtlUFNn53yKRBB/pGn3E268/Y+
         ZP0bvLWWNu6eiIBlu9c//MM/69xgvI30ytxI9nPTx3sLTM/Lbh01qvq3uPrIPKsi3tgb
         uscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3J53VNWVJBsGu++2k8+xv87EgCNc+PbFLaNFsCRi7RQ=;
        b=AIuyV/QIEBdO8ZUYeXLzyMW/ZXysSWS0siEaqdI7rpHAzfVvMgqWRtGPyqNynRISVc
         OeUV3FI5NtzByzk3rAN5W6XfvcXFhm21X0GG+GIGreSA735AJAZFldDfwwU7vYg3jNxz
         Co8wbUJlj8c+8fNKVWL33NRAjHmHt3/eOqCb415GwYatr0cceKhjmFJzTHVUF1JQ7rSu
         /P50VL1YJ4hr4pXvvyC3Cehjuw5yEC6Rlr0Ir+305jmBeAAxT5DNMcx/kRbvcYBQ+phU
         uTDqTsqZ272iW7ET8SUWbcDOsag0TSsNOxS29t67FSqn1PF6QcqVpfQgXBUKjS+3Nbky
         qxoA==
X-Gm-Message-State: APjAAAWYEbFUW4BlZdigvunTQdhTHwlSyGYpJTxxRnsdmhVwQX57Hzz+
        5l2zoEHVj1/mZFK3eNi4qzuwtajsYNU=
X-Google-Smtp-Source: APXvYqyjuNTweoqvOn8fmgje5hXZaV37WmEMLBmbgR+UP13FrngVGkWMmaQRJ58Ci0K3hy8O+LDFFg==
X-Received: by 2002:a17:90a:b394:: with SMTP id e20mr6225886pjr.76.1564631085830;
        Wed, 31 Jul 2019 20:44:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.44.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:44:45 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 00/26] drm: Kirin driver cleanups to prep for Kirin960 support
Date:   Thu,  1 Aug 2019 03:44:13 +0000
Message-Id: <20190801034439.98227-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was reminded I had sent this out a few months ago, but forgot
all about it! Apologies! Anyway, I wanted to resubmit this patch
set so I didn't have to continue carrying it forever to keep the
HiKey960 board running.

This patchset contains one fix (in the front, so its easier to
eventually backport), and a series of changes from YiPing to
refactor the kirin drm driver so that it can be used on both
kirin620 based devices (like the original HiKey board) as well
as kirin960 based devices (like the HiKey960 board).

The full kirin960 drm support is still being refactored, but as
this base kirin rework was getting to be substantial, I wanted
to send out the first chunk for some initial review, so that the
review burden wasn't overwhelming.

The full HiKey960 patch stack can be found here:
  https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/hikey960-mainline-WIP


Feedback would be greatly appreciated!

thanks
-john

Cc: Rongrong Zou <zourongrong@gmail.com>
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

