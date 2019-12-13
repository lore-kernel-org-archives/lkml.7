Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7662AC2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398652077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjaxPKe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLMHFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 02:05:00 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35181 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfLMHE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 02:04:59 -0500
Received: by mail-lf1-f67.google.com with SMTP id 15so1177444lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 23:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=9cpHi5pAwgnvuftBabScfjMi8lJrH1/1dN3qcQeAP/g=;
        b=DjaxPKe1RyqMTrzEcJfhflje9CcEJwJNxp8ZfOkF/1Uc47AfkhEBsKC7pcgsjhe6Tu
         ghkshyhjwmqNYiRZYLWs8QmhigLineoUoZy7RqB04FWwV/2ui5lxHReJ4awTht+PDnkV
         aCthjGZqGRmBSqHobyJoImFIlkfBdmHSg4lILYMpLJuVHAtKp6CzAWcd/JwiXCZXSkbd
         xAxCc/OgvwHkDluQu5w0TQJ5O6BoIkk3hkT19hyYejTQUtXhVXxNKSypicKHUwClD0v0
         izLcJrpuytbxOYJi0rvGzZ3flXDpYZ91yoXpY+Z7HXoCeoYZZedHo6i2DRFC+5MeM6qL
         fHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=9cpHi5pAwgnvuftBabScfjMi8lJrH1/1dN3qcQeAP/g=;
        b=VsCm08eNru0UOauYR43XedEU1djRa3MHxfveAlrieODgiqn9crHPF6EggfYlmtqmyx
         nYMXNgd7xHV2hVstBMHLTzdGmlq+NwKSyzwXzKGDf1et9IX5jM+BLAGRBZQWx1Hl/K7a
         YgyooEVhsdIbDpcRJg/eqngR7Gi7kHJoaEeX6NHKHqqNLol3WFTPZy4zC78hE4NtaD89
         7MbYBtxXutOXXEzovBy5mecWS+6dG2ilBLZvhESkUaVTLAmEhFXv3p6NCdc/34Li8h4N
         qN2ZNPTHixaZjy7XtBARogu1tu2zSTX+68q9DiflJmSyZK0aSfnOiaFXqxPT5TA45JO4
         ftRg==
X-Gm-Message-State: APjAAAWah/HzpRyaxwiec/19BKCpQ1pTb8LToob0IQRjy6hcNLN66B44
        rTZStltoOreWC/wNusezI0MOdkAWuYhTQJug4H8=
X-Google-Smtp-Source: APXvYqyY9VazpkFtBaUwwCVJfCR5JDvxJAGTRBMQmm3g0098ROh41OSTqLkg94a1AXPmRL9EOo65Hh/MLumby7vgzOs=
X-Received: by 2002:ac2:531b:: with SMTP id c27mr7848035lfh.91.1576220695567;
 Thu, 12 Dec 2019 23:04:55 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 13 Dec 2019 17:04:44 +1000
Message-ID: <CAPM=9ty-Cn1SRGkXWkYN9L8F2oe-mwA77cvpSz3iJUutQQcrwA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.5-rc2
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

Usual round of rc2 fixes, i915 and amdgpu leading the charge, but a
few others in here, including some nouveau fixes, all seems pretty for
rc2, but hey it's a Fri 13th pull so I'm sure it'll cause untold bad
fortune.

Regards,
Dave.

drm-fixes-2019-12-13:
drm fixes for 5.5-rc2

dma-buf:
- memory leak fix
- expand MAINTAINERS scope

core:
- fix mode matching for drivers not using picture_aspect_ratio

nouveau:
- panel scaling fix
- MST BPC fix
- atomic fixes

i915:
- GPU hang on idle transition
- GLK+ FBC corruption fix
- non-priv OA access on Tigerlake
- HDCP state fix
- CI found race fixes

amdgpu:
- renoir DC fixes
- GFX8 fence flush alignment with userspace
- Arcturus power profile fix
- DC aux + i2c over aux fixes
- GPUVM invalidation semaphore fixes
- gfx10 golden registers update

mgag200:
- expand startadd fix

panfrost:
- devfreq fix
- memory fixes

mcde:
- DSI pointer deref fix
The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a=
:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-12-13

for you to fetch changes up to d16f0f61400074dbc75797ca5ef5c3d50f6c0ddf:

  Merge tag 'drm-fixes-5.5-2019-12-12' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2019-12-13
14:50:01 +1000)

----------------------------------------------------------------
drm fixes for 5.5-rc2

dma-buf:
- memory leak fix
- expand MAINTAINERS scope

core:
- fix mode matching for drivers not using picture_aspect_ratio

nouveau:
- panel scaling fix
- MST BPC fix
- atomic fixes

i915:
- GPU hang on idle transition
- GLK+ FBC corruption fix
- non-priv OA access on Tigerlake
- HDCP state fix
- CI found race fixes

amdgpu:
- renoir DC fixes
- GFX8 fence flush alignment with userspace
- Arcturus power profile fix
- DC aux + i2c over aux fixes
- GPUVM invalidation semaphore fixes
- gfx10 golden registers update

mgag200:
- expand startadd fix

panfrost:
- devfreq fix
- memory fixes

mcde:
- DSI pointer deref fix

----------------------------------------------------------------
Alex Deucher (4):
      drm/amdgpu: add header line for power profile on Arcturus
      drm/amdgpu/display: add fallthrough comment
      drm/amdgpu: fix license on Kconfig and Makefiles
      Revert "drm/amdgpu: dont schedule jobs while in reset"

Amanda Liu (1):
      drm/amd/display: Fix screen tearing on vrr tests

Arnd Bergmann (2):
      drm/amd/display: fix undefined struct member reference
      drm/amd/display: include linux/slab.h where needed

Ben Skeggs (1):
      drm/nouveau/kms/nv50-: fix panel scaling

Boris Brezillon (4):
      drm/panfrost: Fix a race in panfrost_ioctl_madvise()
      drm/panfrost: Fix a BO leak in panfrost_ioctl_mmap_bo()
      drm/panfrost: Fix a race in panfrost_gem_free_object()
      drm/panfrost: Open/close the perfcnt BO

Brandon Syu (1):
      drm/amd/display: fixed that I2C over AUX didn't read data issue

Chris Wilson (3):
      drm/i915/gt: Save irqstate around virtual_context_destroy
      drm/i915/gt: Detect if we miss WaIdleLiteRestore
      drm/i915: Serialise with remote retirement

Daniel Vetter (1):
      MAINTAINERS: Match on dma_buf|fence|resv anywhere

Dave Airlie (6):
      Merge tag 'drm-misc-fixes-2019-11-25' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-misc-fixes-2019-12-11' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'linux-5.5' of git://github.com/skeggsb/linux into drm-f=
ixes
      Merge tag 'drm-misc-next-fixes-2019-12-12' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2019-12-12' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-fixes-5.5-2019-12-12' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

David Galiffi (1):
      drm/amd/display: Fixed kernel panic when booting with DP-to-HDMI dong=
le

Eric Yang (2):
      drm/amd/display: update sr and pstate latencies for Renoir
      drm/amd/display: update dispclk and dppclk vco frequency

George Shen (1):
      drm/amd/display: Increase the number of retries after AUX DEFER

Guchun Chen (1):
      drm/amdgpu: add check before enabling/disabling broadcast mode

Hans de Goede (2):
      drm/nouveau: Move the declaration of struct nouveau_conn_atom up a bi=
t
      drm/nouveau: Fix drm-core using atomic code-paths on pre-nv50 hardwar=
e

Joseph Gravenor (3):
      drm/amd/display: fix DalDramClockChangeLatencyNs override
      drm/amd/display: populate bios integrated info for renoir
      drm/amd/display: have two different sr and pstate latency tables
for renoir

Leo (Hanghong) Ma (1):
      drm/amd/display: Change the delay time before enabling FEC

Lyude Paul (3):
      drm/nouveau/kms/nv50-: Call outp_atomic_check_view() before handling =
PBN
      drm/nouveau/kms/nv50-: Store the bpc we're using in nv50_head_atom
      drm/nouveau/kms/nv50-: Limit MST BPC to 8

Martin Blumenstingl (1):
      drm: meson: venc: cvbs: fix CVBS mode matching

Navid Emamdoost (1):
      dma-buf: Fix memory leak in sync_file_merge()

Nikola Cornij (2):
      drm/amd/display: Map DSC resources 1-to-1 if numbers of OPPs and
DSCs are equal
      drm/amd/display: Reset steer fifo before unblanking the stream

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: add cache flush workaround to gfx8 emit_fence

Stephan Gerhold (1):
      drm/mcde: dsi: Fix invalid pointer dereference if panel cannot be fou=
nd

Steven Price (1):
      drm/panfrost: devfreq: Round frequencies to OPPs

Thomas Zimmermann (1):
      drm/mgag200: Flag all G200 SE A machines as broken wrt <startadd>

Tianci.Yin (4):
      drm/amdgpu/gfx10: update gfx golden settings
      drm/amdgpu/gfx10: update gfx golden settings for navi14
      drm/amdgpu/gfx10: update gfx golden settings
      drm/amdgpu/gfx10: update gfx golden settings for navi14

Umesh Nerlige Ramappa (2):
      drm/i915/perf: Allow non-privileged access when OA buffer is not samp=
led
      drm/i915/perf: Configure OAR for specific context

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915/fbc: Disable fbc by default on all glk+
      drm/i915/hdcp: Nuke intel_hdcp_transcoder_config()

Yongqiang Sun (1):
      drm/amd/display: Compare clock state member to determine optimization=
.

changzhu (3):
      drm/amdgpu: avoid using invalidate semaphore for picasso
      drm/amdgpu: add invalidate semaphore limit for SRIOV and picasso in g=
mc9
      drm/amdgpu: add invalidate semaphore limit for SRIOV in gmc10

 MAINTAINERS                                        |   1 +
 drivers/dma-buf/sync_file.c                        |   2 +-
 drivers/gpu/drm/amd/acp/Kconfig                    |   2 +-
 drivers/gpu/drm/amd/amdgpu/Kconfig                 |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |   5 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c               |  38 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   6 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |  22 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |  29 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  32 +++-
 drivers/gpu/drm/amd/amdkfd/Kconfig                 |   2 +-
 drivers/gpu/drm/amd/display/Kconfig                |   2 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   1 +
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  | 134 ++++++++++----
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |   9 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |  33 +++-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile      |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  15 +-
 .../amd/display/dc/dcn20/dcn20_stream_encoder.c    |  12 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile      |   1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |  24 ++-
 drivers/gpu/drm/amd/display/dc/dsc/Makefile        |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |   2 +
 .../gpu/drm/amd/display/include/i2caux_interface.h |   2 +-
 .../drm/amd/display/modules/freesync/freesync.c    |  32 ++--
 .../gpu/drm/amd/display/modules/inc/mod_freesync.h |   1 -
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       |   5 +
 drivers/gpu/drm/i915/display/intel_ddi.c           |   5 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |   3 -
 drivers/gpu/drm/i915/display/intel_fbc.c           |   2 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c          |  26 +--
 drivers/gpu/drm/i915/display/intel_hdcp.h          |   5 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |   3 -
 drivers/gpu/drm/i915/gt/intel_lrc.c                |  51 +++---
 drivers/gpu/drm/i915/i915_gem.c                    |  26 ++-
 drivers/gpu/drm/i915/i915_perf.c                   | 204 ++++++++++++-----=
----
 drivers/gpu/drm/mcde/mcde_dsi.c                    |   6 +-
 drivers/gpu/drm/meson/meson_venc_cvbs.c            |  48 ++---
 drivers/gpu/drm/mgag200/mgag200_drv.c              |   3 +-
 drivers/gpu/drm/nouveau/dispnv50/atom.h            |   1 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c            | 108 ++++++-----
 drivers/gpu/drm/nouveau/dispnv50/head.c            |   5 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |  28 ++-
 drivers/gpu/drm/nouveau/nouveau_connector.h        | 116 ++++++------
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        |  19 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c            |  20 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c            |  19 +-
 drivers/gpu/drm/panfrost/panfrost_gem.h            |   4 +
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c        |  23 ++-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h        |   2 +-
 52 files changed, 707 insertions(+), 440 deletions(-)
