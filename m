Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DA4ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 04:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588092084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 04:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM71Ccqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfJKEgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 00:36:19 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:38233 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfJKEgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 00:36:18 -0400
Received: by mail-lf1-f42.google.com with SMTP id u28so6019912lfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 21:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=KNSNoBPQQx9fqpPOoK/mfwOVAUytK93UoAni33Zo2cQ=;
        b=FM71CcqaXhngvvBEZwOb2URsUo1MTk8FsuHpRW16MMEMJKqS/vSq06uNaXpxehxeco
         07NwdkA0aZqxWPWGbbUwd6bKLFT19jeaHQHbl2ZnUIyFPz6sPz4At0LOePoQDYwZY9kC
         /p/pZgobdlFstiL4azMkSfoOcQGYBKfY7SGie8rL3HF5Gyld5hC87fpMdNeyv5Y5yHJR
         hRXzCwhFx5zkpJLCQcXlEyOpXnSxRuzO7I5SaxBWcP2UIQLE51s1eYwar0gqlKFdqtlW
         JdmdYU7JbVn5oe5BSzfiLI55F7KAF+JyyBIAohZcaEuJvEMo/92onOEAxbWxuCMWZ5NO
         rrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=KNSNoBPQQx9fqpPOoK/mfwOVAUytK93UoAni33Zo2cQ=;
        b=UnjQ5FXFr2WaW0MlL0TuE1m4RAXj551X60ydmGhCs9A0Snj9N5JyNzxIrWi0s05Bvw
         CtmJhl9zyBncXoj7Kpfxw2tD0HzZshlavlpBZskDqUE7/N3uDCsXtp8VIFv6YJZyMQ/E
         Fhf+YUJuZMR+0As/mP5B8CZ9YQRreUBBxwPlGiJBLuIMeD/NCvDUxtpwtXIiSqbwWgbN
         gG0EjCPatAt/Tyff38lFDKCuVg2mJyMeCqWMifhcOxqj6AhoD8/kjZZjznWt8e1SJ7uM
         ltCNXr1lmKggZWjJlCdWife5+vjYmqhoo5wp4aKaOdfaqjaIwAYtrNKFNKH7YQbex5S0
         7rBg==
X-Gm-Message-State: APjAAAXVFr983luOT6DbS+zQxTNEv/wPG4BJOr0tBpbuQX6KjCv1bcBI
        9l+6zHDoR5W219xngyEaXhgMFqsRoSNiqgdaHEM=
X-Google-Smtp-Source: APXvYqwoDrqfgsXNyzM+6S96f9RyWcJcFsnKBy4k816CRge7M8uxYjmA2ILzoxxVPX6E+Pk6gljfpF6/ipceJh6Qd5Q=
X-Received: by 2002:a19:ae05:: with SMTP id f5mr7507308lfc.165.1570768574635;
 Thu, 10 Oct 2019 21:36:14 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 11 Oct 2019 14:36:03 +1000
Message-ID: <CAPM=9ty05BvFP8P0UB+uNupSbe7XTwO8My7XnXQC0iucBxw=rQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.4-rc3
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

Hey Linus,

The regular fixes pull for rc3. The i915 team found some fixes they
(or I) missed for rc1, which is why this is a bit bigger than usual,
otherwise there is a single amdgpu fix, some spi panel aliases, and a
bridge fix.

drm-fixes-2019-10-11:
drm fixes for 5.4-rc3

i915:
- execlist access fixes
- list deletion fix
- CML display fix
- HSW workaround extension to GT2
- chicken bit whitelist
- GGTT resume issue
- SKL GPU hangs for Vulkan compute

amdgpu:
- memory leak fix

panel:
- spi aliases

tc358767:
- bridge artifacts fix.
The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce=
:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-10-11

for you to fetch changes up to 4adbcff22e676d28de185dfd391a6fe56b3e6284:

  Merge tag 'drm-intel-fixes-2019-10-10' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2019-10-11
10:09:15 +1000)

----------------------------------------------------------------
drm fixes for 5.4-rc3

i915:
- execlist access fixes
- list deletion fix
- CML display fix
- HSW workaround extension to GT2
- chicken bit whitelist
- GGTT resume issue
- SKL GPU hangs for Vulkan compute

amdgpu:
- memory leak fix

panel:
- spi aliases

tc358767:
- bridge artifacts fix.

----------------------------------------------------------------
Chris Wilson (12):
      drm/i915/execlists: Remove incorrect BUG_ON for schedule-out
      drm/i915: Perform GGTT restore much earlier during resume
      drm/i915: Don't mix srcu tag and negative error codes
      drm/i915: Extend Haswell GT1 PSMI workaround to all
      drm/i915: Verify the engine after acquiring the active.lock
      drm/i915: Prevent bonded requests from overtaking each other on preem=
ption
      drm/i915: Mark contents as dirty on a write fault
      drm/i915/execlists: Drop redundant list_del_init(&rq->sched.link)
      drm/i915: Only enqueue already completed requests
      drm/i915: Fixup preempt-to-busy vs reset of a virtual request
      drm/i915/execlists: Protect peeking at execlists->active
      drm/i915/gt: execlists->active is serialised by the tasklet

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2019-10-10' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-fixes-5.4-2019-10-09' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2019-10-10' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Kenneth Graunke (1):
      drm/i915: Whitelist COMMON_SLICE_CHICKEN2

Laurent Pinchart (5):
      drm/panel: lg-lb035q02: Fix SPI alias
      drm/panel: nec-nl8048hl11: Fix SPI alias
      drm/panel: sony-acx565akm: Fix SPI alias
      drm/panel: tpo-td028ttec1: Fix SPI alias
      drm/panel: tpo-td043mtea1: Fix SPI alias

Matt Roper (1):
      drm/i915/cml: Add second PCH ID for CMP

Nirmoy Das (1):
      drm/amdgpu: fix memory leak

Tomi Valkeinen (1):
      drm/bridge: tc358767: fix max_tu_symbol value

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Bump skl+ max plane width to 5k for linear/x-tiled

 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c  |  14 ++--
 drivers/gpu/drm/bridge/tc358767.c            |   7 +-
 drivers/gpu/drm/i915/display/intel_display.c |  15 +++-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c     |  12 ++--
 drivers/gpu/drm/i915/gem/i915_gem_pm.c       |   3 -
 drivers/gpu/drm/i915/gt/intel_engine.h       |  14 ++++
 drivers/gpu/drm/i915/gt/intel_engine_cs.c    |  16 ++---
 drivers/gpu/drm/i915/gt/intel_lrc.c          | 101 +++++++++++++++++------=
----
 drivers/gpu/drm/i915/gt/intel_reset.c        |  12 ++--
 drivers/gpu/drm/i915/gt/intel_reset.h        |   2 +-
 drivers/gpu/drm/i915/gt/intel_ringbuffer.c   |   2 +-
 drivers/gpu/drm/i915/gt/intel_workarounds.c  |   3 +
 drivers/gpu/drm/i915/i915_drv.c              |   5 ++
 drivers/gpu/drm/i915/i915_gem.h              |   6 ++
 drivers/gpu/drm/i915/i915_request.c          |  69 ++++++++++++++----
 drivers/gpu/drm/i915/i915_request.h          |   2 +-
 drivers/gpu/drm/i915/intel_pch.c             |   1 +
 drivers/gpu/drm/i915/intel_pch.h             |   1 +
 drivers/gpu/drm/i915/selftests/i915_gem.c    |   6 ++
 drivers/gpu/drm/panel/panel-lg-lb035q02.c    |   9 ++-
 drivers/gpu/drm/panel/panel-nec-nl8048hl11.c |   9 ++-
 drivers/gpu/drm/panel/panel-sony-acx565akm.c |   9 ++-
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c |   3 +-
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c |   9 ++-
 24 files changed, 234 insertions(+), 96 deletions(-)
