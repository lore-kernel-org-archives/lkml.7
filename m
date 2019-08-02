Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD94FC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A732067D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Qk6E0oG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391555AbfHBTGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 15:06:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40962 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfHBTGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:06:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id p15so73328478eds.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 12:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=X6PoRs34UrHN4x7OJiS3iDiKcgsKpInRFIVQaxFLMi4=;
        b=Qk6E0oG+4gC0DnTy3Rm2o1Plk+FEwh+0O74jPGx7xgo4BiQzxKYBA/sMHreYfj+7IF
         bc4WoBLU3FNVO7IhLuopr0Tg3Lv7pr/F49cj8tH/HIa3in4uzi+FUXOYzeEe/92TAYOT
         4YUQH4cfqF9whgqddcYhj4dq3ir7c9IxAcyGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=X6PoRs34UrHN4x7OJiS3iDiKcgsKpInRFIVQaxFLMi4=;
        b=owsXFiG76sVmCoGzGKuXqG06eiEpfuOZQl92YrvfrwJwYVVezN+bAK7+BT/Q50SUIJ
         l9s4I5GfGnH2pdee5XKeLnXvEyA4KnQqsEyjluFNrt73gm1Hkcf+Svz7xR/asMa32uEK
         fjp53SOQwlnx7WEtk2Cxpi1zHc4uP7CaL+b+NICb+LtImtmNlefQYluxhjEVnwjZ6oJT
         94YjXS6lNfcoeOJjmrgcoynRluUJ7ljgFDNMS7V74xIgGEkqHk74qG/buvfbOZ5t/2Rl
         h6Sy57pUURsq4ILlR/RFgY6rY7n5N4ww5QQJujd0Kwxtb/YguUjfOpiRTq1Mncze8nX5
         ulxg==
X-Gm-Message-State: APjAAAU0M7MzpgLkkCoVGYQNcNdW0TBMRFw3WKEHMV7i9RLrUwbadiqM
        SElWtl6liF9x+CFAHTf0bjsPbhWD9cw=
X-Google-Smtp-Source: APXvYqzBiBMb+WS8pwlaaT9/J1taAwGRoTE5YtxqlIobBzoJqxWVTYMH/gBnm2KeB+2HbXSf9wCA5A==
X-Received: by 2002:a17:906:1e85:: with SMTP id e5mr105764868ejj.200.1564772758603;
        Fri, 02 Aug 2019 12:05:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id by12sm13256946ejb.37.2019.08.02.12.05.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 12:05:57 -0700 (PDT)
Date:   Fri, 2 Aug 2019 21:05:52 +0200
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>
Subject: [PULL] drm-fixes for -rc3, part 2
Message-ID: <20190802190552.GA12933@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Dave sends his pull, everyone realizes they've been asleep at the wheel
and hits send on their own pulls :-/ Normally I'd just ignore these all
because w/e for me and Dave. But this time around the latecomers also
included drm-intel-fixes, which failed to send out a -fixes pull thus far
for this release (screwed up vacation coverage, despite that 2/3
maintainers were around ... they all look appropriately guilty), and that
really is overdue to get landed.  And since I had to do a pull request
anyway I pulled the other two late ones too.

Cheers, Daniel

drm-fixes-2019-08-02-1:
drm-fixes for 5.3-rc3, take 2

intel fixes (didn't have any ever since the main merge window pull):
- gvt fixes (2 cc: stable)
- fix gpu reset vs mm-shrinker vs wakeup fun (needed a few patches)
- two gem locking fixes (one cc: stable)
- pile of misc fixes all over with minor impact, 6 cc: stable, others
  from this window

exynos:
- misc minor fixes

misc:
- some build/Kconfig fixes
- regression fix for vm scalability perf test which seems to mostly
  exercise dmesg/console logging ...
- the vgem cache flush fix for arm64 broke the world on x86, so that's
  reverted again

Cheers, Daniel

The following changes since commit f8981e0309e9004c6e86d218049045700c79d740:

  Merge tag 'msm-fixes-2019_08_01' of https://gitlab.freedesktop.org/drm/msm into drm-fixes (2019-08-02 10:17:25 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-08-02-1

for you to fetch changes up to 9c8c9c7cdb4c8fb48a2bc70f41a07920f761d2cd:

  Merge tag 'exynos-drm-fixes-for-v5.3-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into drm-fixes (2019-08-02 17:10:17 +0200)

----------------------------------------------------------------
drm-fixes for 5.3-rc3, take 2

intel fixes (didn't have any ever since the main merge window pull):
- gvt fixes (2 cc: stable)
- fix gpu reset vs mm-shrinker vs wakeup fun (needed a few patches)
- two gem locking fixes (one cc: stable)
- pile of misc fixes all over with minor impact, 6 cc: stable, others
  from this window

exynos:
- misc minor fixes

misc:
- some build/Kconfig fixes
- regression fix for vm scalability perf test which seems to mostly
  exercise dmesg/console logging ...
- the vgem cache flush fix for arm64 broke the world on x86, so that's
  reverted again

----------------------------------------------------------------
Arnd Bergmann (1):
      drm/exynos: add CONFIG_MMU dependency

Chris Wilson (9):
      drm/i915: Keep rings pinned while the context is active
      drm/i915/gtt: Defer the free for alloc error paths
      drm/i915/gtt: Mark the freed page table entries with scratch
      drm/i915/userptr: Acquire the page lock around set_page_dirty()
      drm/i915: Lock the engine while dumping the active request
      drm/i915: Lift intel_engines_resume() to callers
      drm/i915: Add a wakeref getter for iff the wakeref is already active
      drm/i915: Only recover active engines
      Revert "drm/vgem: fix cache synchronization on arm/arm64"

Colin Ian King (2):
      drm/exynos: remove redundant assignment to pointer 'node'
      drm/exynos: fix missing decrement of retry counter

Colin Xu (1):
      drm/i915/gvt: Adding ppgtt to GVT GEM context after shadow pdps settled.

Daniel Vetter (3):
      Merge tag 'drm-intel-fixes-2019-08-02' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2019-08-02' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'exynos-drm-fixes-for-v5.3-rc3' of git://git.kernel.org/.../daeinki/drm-exynos into drm-fixes

Dhinakaran Pandiyan (1):
      drm/i915/vbt: Fix VBT parsing for the PSR section

Fuqian Huang (1):
      drm/exynos: using dev_get_drvdata directly

Imre Deak (1):
      drm/i915: Fix the TBT AUX power well enabling

Jani Nikula (1):
      Merge tag 'gvt-fixes-2019-07-30' of https://github.com/intel/gvt-linux into drm-intel-fixes

Kenneth Graunke (1):
      drm/i915: Disable SAMPLER_STATE prefetching on all Gen11 steppings.

Lionel Landwerlin (6):
      drm/i915/perf: fix ICL perf register offsets
      drm/i915: fix whitelist selftests with readonly registers
      drm/i915: whitelist PS_(DEPTH|INVOCATION)_COUNT
      drm/i915/icl: whitelist PS_(DEPTH|INVOCATION)_COUNT
      drm/i915/perf: ensure we keep a reference on the driver
      drm/i915/perf: add missing delay for OA muxes configuration

Maarten Lankhorst (1):
      Merge tag 'v5.3-rc2' into drm-misc-fixes

Mika Kuoppala (1):
      drm/i915: Fix memleak in runtime wakeref tracking

Rob Clark (1):
      drm/vgem: fix cache synchronization on arm/arm64

Thomas Gleixner (1):
      drm/i810: Use CONFIG_PREEMPTION

Thomas Zimmermann (4):
      drm/client: Support unmapping of DRM client buffers
      drm/fb-helper: Map DRM client buffer only when required
      drm/fb-helper: Instanciate shadow FB if configured in device's mode_config
      drm/bochs: Use shadow buffer for bochs framebuffer console

Tvrtko Ursulin (1):
      drm/i915: Fix GEN8_MCR_SELECTOR programming

Ville Syrjälä (3):
      drm/i915: Fix various tracepoints for gen2
      drm/i915: Deal with machines that expose less than three QGV points
      drm/i915: Make sure cdclk is high enough for DP audio on VLV/CHV

Xiaolin Zhang (2):
      drm/i915/gvt: fix incorrect cache entry for guest page mapping
      drm/i915/gvt: grab runtime pm first for forcewake use

Xiong Zhang (3):
      drm/i915/gvt: Warning for invalid ggtt access
      drm/i915/gvt: Don't use ggtt_validdate_range() with size=0
      drm/i915/gvt: Checking workload's gma earlier

YueHaibing (2):
      drm/bridge: lvds-encoder: Fix build error while CONFIG_DRM_KMS_HELPER=m
      drm/bridge: tc358764: Fix build error

Zhenyu Wang (1):
      drm/i915/gvt: remove duplicate include of trace.h

 drivers/gpu/drm/Kconfig                            |  2 +-
 drivers/gpu/drm/bochs/bochs_kms.c                  |  1 +
 drivers/gpu/drm/bridge/Kconfig                     |  4 +-
 drivers/gpu/drm/drm_client.c                       | 60 +++++++++++++----
 drivers/gpu/drm/drm_fb_helper.c                    | 51 +++++++++++----
 drivers/gpu/drm/exynos/Kconfig                     |  1 +
 drivers/gpu/drm/exynos/exynos_drm_fimc.c           |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_scaler.c         |  4 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |  2 +-
 drivers/gpu/drm/i915/display/intel_bw.c            | 15 +++--
 drivers/gpu/drm/i915/display/intel_cdclk.c         | 11 ++++
 drivers/gpu/drm/i915/display/intel_display.c       |  4 +-
 drivers/gpu/drm/i915/display/intel_display_power.c | 11 +++-
 drivers/gpu/drm/i915/display/intel_vbt_defs.h      |  6 +-
 drivers/gpu/drm/i915/gem/i915_gem_pm.c             |  7 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        | 10 ++-
 drivers/gpu/drm/i915/gt/intel_context.c            | 27 +++++---
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          | 20 +++---
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          | 24 -------
 drivers/gpu/drm/i915/gt/intel_engine_pm.h          | 12 +++-
 drivers/gpu/drm/i915/gt/intel_engine_types.h       | 12 ++++
 drivers/gpu/drm/i915/gt/intel_gt_pm.c              | 21 +++++-
 drivers/gpu/drm/i915/gt/intel_gt_pm.h              |  2 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                | 10 +--
 drivers/gpu/drm/i915/gt/intel_reset.c              | 58 ++++++++++++-----
 drivers/gpu/drm/i915/gt/intel_ringbuffer.c         | 31 +++++----
 drivers/gpu/drm/i915/gt/intel_workarounds.c        | 38 ++++++++++-
 drivers/gpu/drm/i915/gt/mock_engine.c              |  1 +
 drivers/gpu/drm/i915/gt/selftest_reset.c           |  5 +-
 drivers/gpu/drm/i915/gt/selftest_workarounds.c     |  7 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c              | 10 ---
 drivers/gpu/drm/i915/gvt/fb_decoder.c              |  6 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |  9 +++
 drivers/gpu/drm/i915/gvt/kvmgt.c                   | 12 ++++
 drivers/gpu/drm/i915/gvt/scheduler.c               | 59 ++++++++++++-----
 drivers/gpu/drm/i915/gvt/trace_points.c            |  2 -
 drivers/gpu/drm/i915/i915_drv.h                    |  5 +-
 drivers/gpu/drm/i915/i915_gem.c                    | 25 ++++---
 drivers/gpu/drm/i915/i915_gem_gtt.c                |  8 ++-
 drivers/gpu/drm/i915/i915_gpu_error.c              |  6 +-
 drivers/gpu/drm/i915/i915_perf.c                   | 67 ++++++++++++-------
 drivers/gpu/drm/i915/i915_trace.h                  | 76 ++++++++++------------
 drivers/gpu/drm/i915/intel_runtime_pm.c            | 10 ++-
 drivers/gpu/drm/i915/intel_wakeref.h               | 15 +++++
 include/drm/drm_client.h                           |  2 +
 include/drm/drm_mode_config.h                      |  7 ++
 48 files changed, 526 insertions(+), 256 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
