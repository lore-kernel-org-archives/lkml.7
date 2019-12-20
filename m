Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DF6C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 23:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F162063A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 23:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkebdDQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLTX6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 18:58:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34001 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfLTX6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 18:58:38 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so99569lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 15:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6Z1dh6bnbsEkY8S0dVTC3PpJSu11QwilCxwQ2MjD6mk=;
        b=SkebdDQXc+gBstVUilswXNbofg1XQNAn0rXtYJ2ed1u8h1yCLBxTe5jXSOyiOwgLiK
         C0LA0TsPLotyhsGPJGASiLm1FD//4/enkTO587F9sBhtKdyhiXw3NyNKggxmgMcEuSgu
         pD42ie1ei8Nher4vAt1Bb2+W+6q1UWfMs7ZvPYE71H8FwDTSeYN6G1jjJ++dLPRMfFyl
         cxgYh+n9AE9+Yn7ugEFrW8hmZ5+eTf7MLOPNe4qE9avJ8sV/CRfUiGfzlD8UOyaBLSNN
         dlQSpla7RPKlZ4ojO+sqHqZo1X19uESjJt2GGsmA5wi7K3LUHpxcJ7GTa0uZCehHatu7
         x9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6Z1dh6bnbsEkY8S0dVTC3PpJSu11QwilCxwQ2MjD6mk=;
        b=qjzpWFLVF2XS+AlKlWMWZbbLQFKyPwhfOxqhzna2GunpwW+2Xyao7GcopdBcM7y3+/
         9aTeOMZoevO+A9qljz/oQZooa1x0H0mrXxFXwbXKKpwW8ixgr5Z3r7IQ++VDaFQ/JLnv
         PKbdXJ48MyGNYi0RQFf1gCgDeTLQIqRs6LPjtU94R0yrEN+IV11PDO1hVPJaFk/EOGJj
         jEZliGnkTi4bawvhgiuKX9+HeGGGaLnRKjq1vkrxPygp6CubrbLxAvsC7s3yW+UARnfD
         8v/EqGsGN8UxblPZIl9KQn6JmCUWoun/IgtUdMIBMRf4j14vKlKUktpaPLOcppgyMLCZ
         GTRw==
X-Gm-Message-State: APjAAAWiO1ssGZzjmWRRykq7pKXj/Bdbg7f8MJAE+ZqAZZ6bhPhkOMEg
        7bVSMe/8vjot+//uCz8Pvg3zVYRfuLcN5bL/7aM=
X-Google-Smtp-Source: APXvYqxlcZLPNKNnxvXP66UYDBM/BdHTjJkK6wj3qVnsUMKn/2X3pMfH/q2ta5vlC3IeIr+0N62GVz9WKOzCqY1h/Xo=
X-Received: by 2002:a19:784:: with SMTP id 126mr10353027lfh.191.1576886314876;
 Fri, 20 Dec 2019 15:58:34 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 21 Dec 2019 09:58:23 +1000
Message-ID: <CAPM=9tzUbs3a7_QYgR5X_vsY8uvaMwLExcO_v2s=xDECd2rxWw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.5-rc3 (resend with cc)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

(Linus pointed out I forgot to cc everyone).

Probably the last one before Christmas, I'll see if there is much
demand over next few weeks for more fixes, I expect it'll be quiet
enough.

This has one exynos fix, and a bunch of i915 core and i915 GVT fixes.

Dave.

drm-fixes-2019-12-21:
drm fixes for 5.5-rc3

exynos:
- component delete fix

i915:
- Fix to drop an unused and harmful display W/A
- Fix to define EHL power wells independent of ICL
- Fix for priority inversion on bonded requests
- Fix in mmio offset calculation of DSB instance
- Fix memory leak from get_task_pid when banning clients
- Fixes to avoid dereference of uninitialized ops in dma_fence tracing
  and keep reference to execbuf object until submitted.
- vGPU state setting locking fix (Zhenyu)
- Fix vGPU display dmabuf as read-only (Zhenyu)
- Properly handle vGPU display dmabuf page pin when rendering (Tina)
- Fix one guest boot warning to handle guc reset state (Fred)
The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-12-21

for you to fetch changes up to 0c517e6ced039b389bbe2d6be757525e52442f64:

  Merge tag 'drm-intel-fixes-2019-12-19' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2019-12-21
06:08:20 +1000)

----------------------------------------------------------------
drm fixes for 5.5-rc3

exynos:
- component delete fix

i915:
- Fix to drop an unused and harmful display W/A
- Fix to define EHL power wells independent of ICL
- Fix for priority inversion on bonded requests
- Fix in mmio offset calculation of DSB instance
- Fix memory leak from get_task_pid when banning clients
- Fixes to avoid dereference of uninitialized ops in dma_fence tracing
  and keep reference to execbuf object until submitted.
- vGPU state setting locking fix (Zhenyu)
- Fix vGPU display dmabuf as read-only (Zhenyu)
- Properly handle vGPU display dmabuf page pin when rendering (Tina)
- Fix one guest boot warning to handle guc reset state (Fred)

----------------------------------------------------------------
Animesh Manna (1):
      drm/i915/dsb: Fix in mmio offset calculation of DSB instance

Chris Wilson (3):
      drm/i915: Copy across scheduler behaviour flags across submit fences
      drm/i915: Set fence_work.ops before dma_fence_init
      drm/i915/gem: Keep request alive while attaching fences

Chuhong Yuan (1):
      drm/exynos: gsc: add missed component_del

Dave Airlie (2):
      Merge tag 'exynos-drm-fixes-for-v5.5-rc3' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-fixes
      Merge tag 'drm-intel-fixes-2019-12-19' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Gao Fred (1):
      drm/i915/gvt: Fix guest boot warning

Joonas Lahtinen (1):
      Merge tag 'gvt-fixes-2019-12-18' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Matt Roper (2):
      drm/i915/ehl: Define EHL powerwells independently of ICL
      drm/i915/tgl: Drop Wa#1178

Tina Zhang (1):
      drm/i915/gvt: Pin vgpu dma address before using

Tvrtko Ursulin (1):
      drm/i915: Fix pid leak with banned clients

Vandita Kulkarni (1):
      drm/i915: Fix WARN_ON condition for cursor plane ddb allocation

Zhenyu Wang (2):
      drm/i915/gvt: use vgpu lock for active state setting
      drm/i915/gvt: set guest display buffer as readonly

 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |   1 +
 drivers/gpu/drm/i915/display/intel_display_power.c | 153 ++++++++++++++++++++-
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |   3 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |   2 +
 drivers/gpu/drm/i915/gvt/dmabuf.c                  |  64 ++++++++-
 drivers/gpu/drm/i915/gvt/handlers.c                |  16 +++
 drivers/gpu/drm/i915/gvt/hypercall.h               |   2 +
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |  23 ++++
 drivers/gpu/drm/i915/gvt/mpt.h                     |  15 ++
 drivers/gpu/drm/i915/gvt/vgpu.c                    |   4 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   6 +-
 drivers/gpu/drm/i915/i915_request.c                | 114 +++++++++++----
 drivers/gpu/drm/i915/i915_scheduler.c              |   1 -
 drivers/gpu/drm/i915/i915_sw_fence_work.c          |   3 +-
 drivers/gpu/drm/i915/intel_pm.c                    |   4 +-
 15 files changed, 366 insertions(+), 45 deletions(-)
