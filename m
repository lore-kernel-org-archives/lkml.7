Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9F3C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00F820644
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bSPoeIkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfHSXD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:03:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37346 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfHSXD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id 129so2079152pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NGWuQi2OFDXkoc4uHO6pNsanjgo7YeBnBRfiQonI2H0=;
        b=bSPoeIkUgmIhgKRkg16czJLsntFR+sgonGuvg9tqqk+A3C3tMJlFv7E/8T9ThNLBVh
         vzwxh+KZ7e7YKQkcWny3z4vvA3koFpoHcdqyjygQpaR2iIgRSv7iUY1xNxjMHAxPg/JE
         z17GYAzvPGTYlQItGVHcBdTWc5rXfoUaRQ7YWYXjI4dXavxXwWOVRBOj+idE7ajshT0q
         JR1ij4jJmsyensJMw0HjCrL+O4edLFexSCwqEXCe8zxJzpVeWXaX+nsLDJCuZgJnmYgX
         VhpxSk+uf5THOd9+gAA57F54nlXWjtA6b3HGl+NwinJzpsaL2DA3MJ+a5d17l2Ye0YMC
         2uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NGWuQi2OFDXkoc4uHO6pNsanjgo7YeBnBRfiQonI2H0=;
        b=Vy4QIVT0A6br8nQj2Vf2pwhGHmdMxYg4vVAfLNqeZyweZ5gVfIR4pbzYqugaDwlV42
         RLZMCCEA4DxkJj+urqcPSDuD48zkVEO5Eit0jSX6hvbcLcEG9xvB1p6oKrxKnxdpAdoS
         mZYLJ3BKhbZDr/dIpEVzHxnPlNJhpIX1XCIwYKqSzX6xqJkX713pBvR/zzZyfwPDDAgl
         Re4fLPzKdEo7T7le4E++DHr7auO3r8CWKx2Q8o8InBLB++DqxO7a/yQ7aIJ8/sVuahE0
         PbvrMOwwNTNiHg59EOkNeI2Xfz7SgQfao67OnFc9QqRnrUY+4XZzesYFcjiN/AdE/d32
         uuNQ==
X-Gm-Message-State: APjAAAV2nT0zifNnvRpFZ+A+YKCQZjNK+cEMnYfAh5lew+nbFIzo81Z6
        +C1eqsjERRQbqK9i8bs7j7TeaVlInG8=
X-Google-Smtp-Source: APXvYqwBpcZXQemDrzGXVpe6NlOGvFce2KdFXtlDnxd5tTtST+SL0gIm0SWTpVaSRoFam6HdNk1teg==
X-Received: by 2002:a63:89c2:: with SMTP id v185mr21985168pgd.241.1566255805379;
        Mon, 19 Aug 2019 16:03:25 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:24 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v4 00/25] drm: Kirin driver cleanups to prep for Kirin960 support
Date:   Mon, 19 Aug 2019 23:02:56 +0000
Message-Id: <20190819230321.56480-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending this out again, to get it based on drm-misc-next.

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


New in v4:
* Rebased to drm-misc-next, minor tweaks to merge changes
* Dropped "drm: kirin: Get rid of drmP.h includes" as similar change
  was already in drm-misc next
* Added acked-by tag from Xinliang


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
 drivers/gpu/drm/hisilicon/kirin/Makefile      |   4 +-
 .../gpu/drm/hisilicon/kirin/kirin_ade_reg.h   |   1 +
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 351 +++++++-----------
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   | 250 +++++++++----
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   |  48 ++-
 6 files changed, 368 insertions(+), 296 deletions(-)

-- 
2.17.1

