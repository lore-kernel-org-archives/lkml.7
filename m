Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA3CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71B72083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrx5JbVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfDLEEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 00:04:25 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45795 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfDLEEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 00:04:24 -0400
Received: by mail-qk1-f194.google.com with SMTP id z76so4858219qkb.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 21:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=83ljcFtdGCXaQOnPe6Mc6iuy0HUAwW9vBo+vDizkEZk=;
        b=nrx5JbVpuaH8jXcgK5DUAhx+C3HnS+GJgIO9nz7dwBmphWF7h/J34PnTe7AhS8Zk59
         lJkJ91VBFDtdpbpD4+psQQKaJWjYsq3bVzGqC2ES59+rqIjeGid8tVgO62nZ1hIMu5LN
         AdwQ9bA1/UdSXy+DCx7Nn61SZMqlR5DDWXbwshRn2e0qYIB5WX89RuTcYTtHMJczoQwn
         qoRYNqT1TNYdPt4wkPHeULe6YMyCxweDtzIEPufiFGRV1IGBJG4iCQBoA2WeUrI0Xs4/
         wi35qzkOGuYYm+uuQTT9LILTlR3Nu/SY2EFi5BZaK9/pUczqj/cPr5jVU6S+axlwqTGl
         2tQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=83ljcFtdGCXaQOnPe6Mc6iuy0HUAwW9vBo+vDizkEZk=;
        b=uEFjXptrFdock31M9ILK9wy7zc4SwETsUCXg9mnohQGahMBCzkUnT8PLZraNLHMKi0
         9BWoryCCuAVZcW0k0ORKis24NYvs3tqnxnyIE7/JYHSEG/x+L89zg7JwrzQEQT4PTfF5
         m7JYFrEYJwnQRvxHQrAHnkF35YB5l+vF0k/37lAgv39bCeBEIWWM3vyCk4dyRy5Gp3K8
         d4WGM1NDqVf04hc+qRjLjx3LCBu2oBnnQj5x9Bqqdt65HZdlFNuvBvNkKZlf8uY6Onf8
         ymppoqNHMn663IJxP2k5SBMnUsl9NfiOxVM8Lz8DjwpKkSl205ipxaQuFhYstp2MSYPt
         Mymw==
X-Gm-Message-State: APjAAAUbXAaDQwE8kguavgCVZJYzweuOvcBmOyD1ooDReKGrciHKU229
        d1HM6c2YXTnWSPcfA/G4TMwR/cGY7Sc5PIB1YZM=
X-Google-Smtp-Source: APXvYqyzERdGDZ4CZUFlEEioW5BsIZGqLrlYWL+CHBlIsC+8tz1A1gDvcIOMTTKeus6G8O7lWL8wUKqqTc0WmNRrMGY=
X-Received: by 2002:a05:620a:15ef:: with SMTP id p15mr39794697qkm.317.1555041863353;
 Thu, 11 Apr 2019 21:04:23 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 12 Apr 2019 14:04:12 +1000
Message-ID: <CAPM=9tw5ALn3-+TNW2khkAk9oHdks=paxXu=fqO40onohrvxyA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.1-rc5
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

Fixes across the driver spectrum this week, the mediatek fbdev support
isn't very large and might be a bit late for this round, but I looked
over it and it's not very large and seems like a useful feature for
them.

Otherwise the main thing is a regression fix for i915 5.0 bug that
caused black screens on a bunch of Dell XPS 15s I think, I know at
least Fedora is waiting for this to land, and the udl fix is also for
a regression since 5.0 where unplugging the device would end badly.

core:
- make atomic hooks optional

i915:
- Revert a 5.0 regression where some eDP panels stopped working
- DSI related fixes for platforms up to IceLake
- GVT (regression fix, warning fix, use-after free fix)

amdgpu:
- Cursor fixes
- missing PCI ID fix for KFD
- XGMI fix
- shadow buffer handling after reset fix

udl:
- fix unplugging device crashes.

mediatek:
- stabilise MT2701 HDMI support
- fbdev support

tegra:
- fix for build regression in rc1.

sun4i:
- Allwinner A6 max freq improvements
- null ptr deref fix

dw-hdmi:
- SCDC configuration improvements

omap:
- CEC clock management policy fix

drm-fixes-2019-04-12:
drm i915, amd, dw-hdmi, omap, mediatek, tegra, udl fixes
The following changes since commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d=
:

  Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-04-12

for you to fetch changes up to 788f07ebe040922c89e38f609b7890ba52a09db2:

  Merge tag 'drm-intel-fixes-2019-04-11' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2019-04-12
13:39:32 +1000)

----------------------------------------------------------------
drm i915, amd, dw-hdmi, omap, mediatek, tegra, udl fixes

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdkfd: Add picasso pci id

CK Hu (2):
      drm/mediatek: Implement gem prime vmap/vunmap function
      drm/mediatek: Add Mediatek framebuffer device

Chris Wilson (2):
      drm/i915/gvt: Annotate iomem usage
      drm/i915/gvt: Prevent use-after-free in ppgtt_free_all_spt()

Dan Carpenter (1):
      drm/mediatek: Fix an error code in mtk_hdmi_dt_parse_pdata()

Dave Airlie (6):
      drm/udl: add a release method and delay modeset teardown
      Merge tag 'drm/tegra/for-5.1-rc5' of
git://anongit.freedesktop.org/tegra/linux into drm-fixes
      Merge branch 'mediatek-drm-fixes-5.1' of
https://github.com/ckhu-mediatek/linux.git-tags into drm-fixes
      Merge branch 'drm-fixes-5.1' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2019-04-11' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2019-04-11' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Imre Deak (1):
      drm/i915: Get power refs in encoder->get_power_domains()

Jani Nikula (1):
      drm/i915/dp: revert back to max link rate and lane count on eDP

Jernej Skrabec (1):
      drm/sun4i: DW HDMI: Lower max. supported rate for H6

Matteo Croce (1):
      drm/omap: fix typo

Maxime Ripard (1):
      Merge drm/drm-fixes into drm-misc-fixes

Neil Armstrong (2):
      drm/bridge: dw-hdmi: disable SCDC configuration for invalid setups
      Revert "Documentation/gpu/meson: Remove link to meson_canvas.c"

Nicholas Kazlauskas (1):
      drm/amd/display: Fix negative cursor pos programming (v2)

Ondrej Jirman (1):
      drm/sun4i: tcon top: Fix NULL/invalid pointer dereference in
sun8i_tcon_top_un/bind

Rodrigo Siqueira (1):
      drm/atomic-helper: Make atomic_enable/disable crtc callbacks optional

Rodrigo Vivi (1):
      Merge tag 'gvt-fixes-2019-04-11' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Sean Paul (1):
      Documentation/gpu/meson: Remove link to meson_canvas.c

Stefan Agner (1):
      gpu: host1x: Fix compile error when IOMMU API is not available

Tony Lindgren (1):
      drm/omap: hdmi4_cec: Fix CEC clock handling for PM

Vandita Kulkarni (2):
      drm/i915/icl: Ungate ddi clocks before IO enable
      drm/i915/icl: Fix port disable sequence for mipi-dsi

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix pipe_bpp readout for BXT/GLK DSI

Wangyan Wang (5):
      drm/mediatek: fix the rate and divder of hdmi phy for MT2701
      drm/mediatek: make implementation of recalc_rate() for MT2701 hdmi ph=
y
      drm/mediatek: remove flag CLK_SET_RATE_PARENT for MT2701 hdmi phy
      drm/mediatek: using new factor for tvdpll for MT2701 hdmi phy
      drm/mediatek: no change parent rate in round_rate() for MT2701 hdmi p=
hy

Wen Yang (1):
      drm/mediatek: fix possible object reference leak

Xiong Zhang (1):
      drm/i915/gvt: Roundup fb->height into tile's height at calucation fb-=
>size

shaoyunl (1):
      drm/amdgpu: Adjust IB test timeout for XGMI configuration

tiancyin (1):
      drm/amd/display: fix cursor black issue

wentalou (1):
      drm/amdgpu: amdgpu_device_recover_vram always failed if only one
node in shadow_list

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 13 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c            |  3 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c           |  1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 23 +-------
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c         | 34 +++++++++--
 drivers/gpu/drm/drm_atomic_helper.c               |  5 +-
 drivers/gpu/drm/i915/gvt/dmabuf.c                 |  9 ++-
 drivers/gpu/drm/i915/gvt/gtt.c                    | 12 +++-
 drivers/gpu/drm/i915/gvt/kvmgt.c                  |  6 +-
 drivers/gpu/drm/i915/icl_dsi.c                    | 48 +++++++++-------
 drivers/gpu/drm/i915/intel_ddi.c                  | 23 ++++----
 drivers/gpu/drm/i915/intel_display.c              |  6 +-
 drivers/gpu/drm/i915/intel_dp.c                   | 69 ++++---------------=
----
 drivers/gpu/drm/i915/intel_drv.h                  | 10 ++--
 drivers/gpu/drm/i915/vlv_dsi.c                    | 24 ++++++++
 drivers/gpu/drm/mediatek/mtk_dpi.c                |  8 +--
 drivers/gpu/drm/mediatek/mtk_drm_drv.c            |  7 +++
 drivers/gpu/drm/mediatek/mtk_drm_gem.c            | 46 +++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_gem.h            |  3 +
 drivers/gpu/drm/mediatek/mtk_hdmi.c               |  2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c           | 35 ++----------
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h           |  5 +-
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c    | 49 ++++++++++++++--
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c    | 23 ++++++++
 drivers/gpu/drm/omapdrm/dss/hdmi4_cec.c           | 26 ++++++---
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.c          |  2 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c             |  9 ++-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c            |  5 +-
 drivers/gpu/drm/udl/udl_drv.c                     |  1 +
 drivers/gpu/drm/udl/udl_drv.h                     |  1 +
 drivers/gpu/drm/udl/udl_main.c                    |  8 ++-
 drivers/gpu/host1x/hw/channel_hw.c                |  2 +-
 include/drm/drm_modeset_helper_vtables.h          |  4 ++
 34 files changed, 321 insertions(+), 202 deletions(-)
