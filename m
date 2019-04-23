Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEAAC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80BA218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hC4NW+8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfDWXVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:21:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40820 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfDWXVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so8244650pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NavZJnCijO9Xgd1fYNTsT4nFIUnXmDF4DUF9KLSKa8s=;
        b=hC4NW+8gok1RSfCxLS5C6T6hvAIPOhK5ittLcKshLPJZLJhMQtFc5FqObQZp0NyDjP
         D9inMf3uhkNleZV0LxB6pc77ChLOXfTiOoGQ9yX7vVYFKja9cZfE+I/ywuIvrHAl7hHD
         oaSRJpiOSxMZqVBZOOsfDklhgMwx/wYA8HYhJxcI5MkuNB8UkGPhPlE61XHgRR9yoHwv
         bW71bgtwlNRhP7/CPImdHmmAF4w0qLgbdxvY9/5XS4Fza0FgLNVrph08yKXwY1s7RsxV
         +jRMH0zdFc2VefaIpz+kbjJR24cJ1KQ3+s71kdf9yka3e1e7OIpqCu9agy68ZMchS7Tp
         64Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NavZJnCijO9Xgd1fYNTsT4nFIUnXmDF4DUF9KLSKa8s=;
        b=NVzEBmIdCx/0XGXn2OcGB0v3rnPeNWD1qgEG1fzBwpn9QOrtbGaOvVyMsj440K0fkE
         V75zmEh3W0tUy4LiYCSetmNNC8sHrbI4XAiDR6zqLQd4jUttqiTSX/5KCo9YSqwq5BRg
         IoOOHKejsFdktqtrreQA3nK8PCQMxYQ9EjVLac1q8nvi6phV8RfSjHf9vIuepGmsZlfV
         7Ant/ZDwa9FMDRzsuvMp05FUis/t2Koy00asJxAhlayY+HbzmOj1fJNxZyJF65Qp7GvW
         bx4OojjbZ2tFczIsGvKO18blmUSE5WX/7EJQHXY5m4sOSkx1I+IpqnV924bB5ARa+YcQ
         0Wdg==
X-Gm-Message-State: APjAAAXkN8OvFsfhyMBSaEziLm6EOzr+d8miyDXXFll9DVNZWhl2HfPz
        Pm86CRAFPLSjkplvHWU6u0hpGVhVN+U=
X-Google-Smtp-Source: APXvYqzD4QynVFTos1b3S6bLRazbb2S/EkNoO7qqGPhC/30BV19dHzRGKoO9sUU/B4YLIn1NZJSyEQ==
X-Received: by 2002:a65:63d5:: with SMTP id n21mr27387406pgv.330.1556061660095;
        Tue, 23 Apr 2019 16:21:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:20:59 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        YiPing Xu <xuyiping@hisilicon.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: [PATCH 00/25] drm: Kirin driver cleanups to prep for Kirin960 support
Date:   Tue, 23 Apr 2019 16:20:31 -0700
Message-Id: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


Cc: YiPing Xu <xuyiping@hisilicon.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>

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

 drivers/gpu/drm/hisilicon/kirin/Kconfig         |  10 +-
 drivers/gpu/drm/hisilicon/kirin/Makefile        |   4 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h |   6 +
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 354 ++++++++++--------------
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 253 ++++++++++++-----
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  48 +++-
 6 files changed, 376 insertions(+), 299 deletions(-)

-- 
2.7.4

