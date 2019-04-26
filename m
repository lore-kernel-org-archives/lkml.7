Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB69FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A592084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMFJtonL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbfDZAqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:46:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40758 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbfDZAqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 20:46:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id y49so2301197qta.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 17:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Q/IGZswbErsdoxQFrg8dnejyol0uABpij6q/Q+HtAFo=;
        b=KMFJtonLZf98FCePxhUxhQ9YNwApbex0ES7Y9VDlMF9sP4uj80//qk3z08gQKeIkWj
         PQD+JwGtKXLvGazFwPqpuJEdG7wOKwECKsGOq43rSyCRU9cyRO7yo4D01eyGDr2MwPez
         z+gSGyGINI5az7WgJ7CJzYucQMdAbbi7qWnRczwaK4ii620MLJoK6HM1+4nxfO+VZ3YO
         XJqoflnyz80UR35TUm5tVIl88swc2uAgutQTeqazYBZJYcPRamT6q7yJj/0AaChnynVd
         FJglpPk3Wd/tpSkIUDHeuVO3NVxUHGmOD46bwEhpOfF2OroCi+Pk8t2dCClLxQ8YVB9v
         T7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Q/IGZswbErsdoxQFrg8dnejyol0uABpij6q/Q+HtAFo=;
        b=OJYffPLNxzpc3SP3bSKovBqmiEe1FmgGc1PBeN6kxMbkYWuXydYhE44iFqqDPhnpOR
         cThiXLbwVsrPFLqPmdcrd5PnQ+XEbLQggcBs3Pjiv4OkTS79qut3+kISRUQsjmMMyyAe
         dnC6ZP4Xqn9IC77IV6l9wtdljr7chcs+OrZvtCbo2TF+a6fROx+w9oRBICo8aiDRP1HY
         kN0Lkj3kxWzxBXL/EvovzE0v1TyqTQzxk0ps+r8A+/0ek34/mecCtGCnn/pKNLSovV9Q
         08AIFXH+BSRRLiXjN9BbybX0x+2l717OcKjnHgL2YmmD6PYQp/6SG12fdw9qsQA7Wj0M
         xFKQ==
X-Gm-Message-State: APjAAAUkQ02kKbR9NNNFjALRmGT0v4MWk/QecT5kdxdPObbqXsb5DRPb
        +7J5eerLxoY2laPV8KNiEtL1N0QG3iZ4H6C6owc=
X-Google-Smtp-Source: APXvYqzOxJ3Xqb4At5LDUQXfV86nQayBI9OUpgMtJv5ASu9CJ3bJLEWfaQI6kRKPbMc8YPynt/fTnvdXxDeR1fbq8M0=
X-Received: by 2002:a0c:ab44:: with SMTP id i4mr7389993qvb.64.1556239602104;
 Thu, 25 Apr 2019 17:46:42 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 26 Apr 2019 10:46:30 +1000
Message-ID: <CAPM=9twJ1AQ2Nt-+HUFJa6a_Z7F-kxxMtTgaafRRWtYpgFYkBA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.1-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Regular drm fixes pull, nothing too outstanding, I'm guessing Easter
was slowing people down.

i915:
- FEC enable fix
- BXT display lanes fix

ttm:
- fix reinit for reloading drivers regression

imx:
- DP CSC fix

sun4i:
- module unload/load fix

vc4:
- memory leak fix
- compile fix

dw-hdmi:
- rockchip scdc overflow fix

sched:
- docs fix

vmwgfx:
- dma api layering fix.

Dave.

drm-fixes-2019-04-26:
drm: i915, sched, sun4i, vmwgfx, vc4, imx, dw-hdmi fixes
The following changes since commit a0cecc23cfcbf2626497a8c8770856dd56b67917=
:

  Revert "drm/virtio: drop prime import/export callbacks" (2019-04-24
10:52:52 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-04-26

for you to fetch changes up to 6db71bea59f964d241bdcf1e73e47aebb7427888:

  Merge tag 'imx-drm-fixes-2019-04-25' of
git://git.pengutronix.de/pza/linux into drm-fixes (2019-04-26 10:33:33
+1000)

----------------------------------------------------------------
drm: i915, sched, sun4i, vmwgfx, vc4, imx, dw-hdmi fixes

----------------------------------------------------------------
Christian K=C3=B6nig (1):
      drm/ttm: fix re-init of global structures

Dave Airlie (5):
      Merge tag 'drm-intel-fixes-2019-04-24' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge branch 'drm-fixes-5.1' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2019-04-25' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'vmwgfx-fixes-5.1' of
git://people.freedesktop.org/~thomash/linux into drm-fixes
      Merge tag 'imx-drm-fixes-2019-04-25' of
git://git.pengutronix.de/pza/linux into drm-fixes

Jonas Karlman (2):
      drm: bridge: dw-hdmi: Fix overflow workaround for Rockchip SoCs
      drm/bridge: dw-hdmi: fix SCDC configuration for ddc-i2c-bus

Jonathan Neusch=C3=A4fer (1):
      drm/sched: Fix description of drm_sched_stop

Lucas Stach (2):
      gpu: ipu-v3: dp: fix CSC handling
      drm/imx: don't skip DP channel disable for background plane

Maarten Lankhorst (2):
      drm/vc4: Fix memory leak during gpu reset.
      drm/vc4: Fix compilation error reported by kbuild test bot

Paul Kocialkowski (4):
      drm/sun4i: Add missing drm_atomic_helper_shutdown at driver unbind
      drm/sun4i: Set device driver data at bind time for use in unbind
      drm/sun4i: Fix component unbinding and component master deletion
      drm/sun4i: Unbind components before releasing DRM and memory

Thomas Hellstrom (1):
      drm/vmwgfx: Fix dma API layer violation

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Do not enable FEC without DSC
      drm/i915: Restore correct bxt_ddi_phy_calc_lane_lat_optim_mask()
calculation

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 16 +++++++++++----
 drivers/gpu/drm/i915/intel_ddi.c          |  6 ++++--
 drivers/gpu/drm/i915/intel_dp.c           |  6 +++---
 drivers/gpu/drm/imx/ipuv3-crtc.c          |  2 +-
 drivers/gpu/drm/scheduler/sched_main.c    |  3 +--
 drivers/gpu/drm/sun4i/sun4i_drv.c         |  9 +++++++++
 drivers/gpu/drm/ttm/ttm_bo.c              | 10 +++++-----
 drivers/gpu/drm/ttm/ttm_memory.c          |  5 +++--
 drivers/gpu/drm/vc4/vc4_crtc.c            |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c       | 33 +++++----------------------=
----
 drivers/gpu/ipu-v3/ipu-dp.c               | 12 ++++++++---
 include/drm/ttm/ttm_bo_driver.h           |  1 -
 12 files changed, 53 insertions(+), 52 deletions(-)
