Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C772C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F8D21852
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LIsCva+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfGZTqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:46:04 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38114 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfGZTqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:46:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so19407812edo.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=L4t9Gb5wdpUDJu8Ctky1K9stmJHDUUhq/Em1BqaX6Lo=;
        b=LIsCva+4FPEUMRRogwio+q/TYlTcXvFkQ4UENfmrnQKFprCT7lqmoWognT8wuz//J5
         gk3rSQY2pkQ/JLqlw6coDQjO5KfE8IhHm1ZlpcBlTVjB5eACgi87XxKzmcPHB1jHKe80
         sfQ7XyVvKuAaGGxCVQhxVaZxDdfURi3jYZ7xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=L4t9Gb5wdpUDJu8Ctky1K9stmJHDUUhq/Em1BqaX6Lo=;
        b=odcMDrOGEWw/F+ibA8qLRpkTM6w2Mb9X0HWWIj91KrRjjNG+pb/8TboBThztgLZtG1
         Ulm+GiYtHKiV277QL8nzeWmMQMYeM5C+qf41GaTLfrSCDJL/CcOJ2ka6BhLu5EUo4F1g
         VMQaXRK1IZkIOeVnqueagLPhZ823DSVhKBq3taIP4JRc3Ix9jJ03FDnkBBiAHlUntz1i
         EofmPblaFjQTzfWih+xePgEvL4pr5kTZaCJYkDEffbNERiGgs9BI49NATyAdgsIjZAXi
         P3JStTSr+SJ2MMVekrhgBMI6ucRGc7+AvGeIDdSwmCg7SVwC29QFt/ha6JGrHzE9RL6T
         VETw==
X-Gm-Message-State: APjAAAWrXpLQkmFAQlOdfPW5PWfUWGFKDIJ92Ru4pX5FKdK0izBXDxEY
        +JZkdjuDpQ0kYNVVQw5tIyg=
X-Google-Smtp-Source: APXvYqys/q+lV2dfzJrgKok7uN3eGVvkDXAkitQeEW3idm97yZupbR6TgJ3TKnxLBjfAK0T1kYdZHg==
X-Received: by 2002:a50:8828:: with SMTP id b37mr84119656edb.266.1564170361846;
        Fri, 26 Jul 2019 12:46:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id r44sm14432041edd.20.2019.07.26.12.46.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 12:46:00 -0700 (PDT)
Date:   Fri, 26 Jul 2019 21:45:55 +0200
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>
Subject: [PULL] drm-fixes
Message-ID: <20190726194555.GA30301@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Dave seems to collect an entire streak of things happening, so again me
typing pull summary. Nothing nefarious here, most of the fixes are for new
stuff or things users won't see. The amd-display patches are a bit
different, and very much look like they should have at least some cc:
stable tags. Might be amd is a bit too comfortable with their internal
tree and not enough looking at upstream. Dave&me are looking into this,
in case something needs rectified with process here.

Also no intel fixes pull, but intel CI is general become rather good,
still I guess expect a notch more for -rc3.

Cheers, Daniel

PS: I checked, no :w bird emoij in here this time around.

drm-fixes-2019-07-26:
drm-fixes for 5.3-rc2:

amdgpu:
- fixes for (new in 5.3) hw support (vega20, navi)
- disable RAS
- lots of display fixes all over (audio, DSC, dongle, clock mgr)

ttm:
- fix dma_free_attrs calls to appease dma debugging

msm:
- fixes for dma-api, locking debug and compiler splats

core:
- fix cmdline mode to not apply rotation if not specified (new in 5.3)
- compiler warn fix

Cheers, Daniel

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-07-26

for you to fetch changes up to 4d5308e7852741318e4d40fb8d43d9311b3984ae:

  Merge tag 'drm-fixes-5.3-2019-07-24' of git://people.freedesktop.org/~agd5f/linux into drm-fixes (2019-07-26 14:10:26 +1000)

----------------------------------------------------------------
drm-fixes for 5.3-rc2:

amdgpu:
- fixes for (new in 5.3) hw support (vega20, navi)
- disable RAS
- lots of display fixes all over (audio, DSC, dongle, clock mgr)

ttm:
- fix dma_free_attrs calls to appease dma debugging

msm:
- fixes for dma-api, locking debug and compiler splats

core:
- fix cmdline mode to not apply rotation if not specified (new in 5.3)
- compiler warn fix

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/smu: move fan rpm query into the asic specific code

Alvin Lee (3):
      drm/amd/display: Disable Audio on reinitialize hardware
      drm/amd/display: Wait for flip to complete
      drm/amd/display: Only enable audio if speaker allocation exists

Brian Masney (1):
      drm/msm: correct NULL pointer dereference in context_init

Dale Zhao (1):
      drm/amd/display: handle active dongle port type is DP++ or DP case

Dave Airlie (2):
      Merge tag 'drm-misc-fixes-2019-07-25' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-fixes-5.3-2019-07-24' of git://people.freedesktop.org/~agd5f/linux into drm-fixes

Derek Lai (2):
      drm/amd/display: Read max down spread
      drm/amd/display: allocate 4 ddc engines for RV2

Dmitry Osipenko (1):
      drm/modes: Don't apply cmdline's rotation if it wasn't specified

Dmytro Laktyushkin (2):
      drm/amd/display: fix dsc disable
      drm/amd/display: Set default block_size, even in unexpected cases

Eric Yang (2):
      drm/amd/display: put back front end initialization sequence
      drm/amd/display: do not read link setting if edp not connected

Evan Quan (1):
      drm/amd/powerplay: report bootup clock as max supported on dpm disabled

Fatemeh Darbehani (1):
      drm/amd/display: Change min_h_sync_width from 8 to 4

Fuqian Huang (1):
      drm/ttm: use the same attributes when freeing d_page->vaddr

Harmanprit Tatla (1):
      drm/amd/display: No audio endpoint for Dell MST display

Hawking Zhang (4):
      drm/amdgpu: do not create ras debugfs/sysfs node for ASICs that don't have ras ability
      drm/amdgpu: disable GFX RAS by default
      drm/amdgpu: only allow error injection to UMC IP block
      drm/amdgpu: drop ras self test

Ilya Bakoulin (1):
      drm/amd/display: Check for valid stream_encode

Joseph Greathouse (1):
      drm/amdgpu: Default disable GDS for compute VMIDs

Julian Parkin (2):
      drm/amd/display: Poll for GPUVM context ready (v2)
      drm/amd/display: Fix dc_create failure handling and 666 color depths

Jun Lei (4):
      drm/amd/display: initialize p_state to proper value
      drm/amd/display: fix up HUBBUB hw programming for VM
      drm/amd/display: cap DCFCLK hardmin to 507 for NV10
      drm/amd/display: swap system aperture high/low

Kevin Wang (2):
      drm/amd/powerplay: change sysfs pp_dpm_xxx format for navi10
      drm/amd/powerplay: custom peak clock freq for navi10

Leo Liu (1):
      drm/amdgpu: use VCN firmware offset for cache window

Murton Liu (1):
      drm/amd/display: Clock does not lower in Updateplanes

Nicholas Kazlauskas (2):
      drm/amd/display: Copy max_clks_by_state after dce_clk_mgr_construct
      drm/amd/display: Set enabled to false at start of audio disable

Nikola Cornij (1):
      drm/amd/display: Set one 4:2:0-related PPS field as recommended by DSC spec

Qian Cai (1):
      drm: silence variable 'conn' set but not used

Rob Clark (1):
      drm/msm: stop abusing dma_map/unmap for cache

Samson Tam (1):
      drm/amd/display: skip retrain in dc_link_set_preferred_link_settings() if using passive dongle

Sean Paul (1):
      Merge drm-misc-next-fixes-2019-07-18 into drm-misc-fixes

Shubhashree Dhar (1):
      drm/msm/dpu: Correct dpu encoder spinlock initialization

SivapiriyanKumarasamy (1):
      drm/amd/display: Wait for backlight programming completion in set backlight level

Tai Man (2):
      drm/amd/display: use encoder's engine id to find matched free audio device
      drm/amd/display: Increase size of audios array

Wenjing Liu (1):
      drm/amd/display: wait for the whole frame after global unlock

Zhan Liu (1):
      drm/amd/display: drop ASSERT() if eDP panel is not connected

Zi Yu Liao (1):
      drm/amd/display: fix DMCU hang when going into Modern Standby

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  19 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   9 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |   9 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   9 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   9 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |   3 -
 .../amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c |   4 +-
 .../amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c |   4 +-
 .../amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c |   4 +-
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   |   3 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   6 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  30 ++++--
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  39 +++++--
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  11 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   3 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c       |   4 +
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  24 +++--
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  21 ++--
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c    |  18 ++--
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  22 +++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |   4 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c  |  37 +++++++
 drivers/gpu/drm/amd/display/dc/dsc/drm_dsc_dc.c    |   6 ++
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |   4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |   1 +
 drivers/gpu/drm/amd/display/include/dpcd_defs.h    |   2 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 100 ++++++++++++------
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |  10 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 114 +++++++++++++++++++--
 drivers/gpu/drm/amd/powerplay/navi10_ppt.h         |   4 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          |  18 ----
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c         |  20 +++-
 drivers/gpu/drm/drm_client_modeset.c               |   2 +-
 drivers/gpu/drm/drm_framebuffer.c                  |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   3 +-
 drivers/gpu/drm/msm/msm_drv.c                      |   2 +-
 drivers/gpu/drm/msm/msm_gem.c                      |   4 +-
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c           |   6 +-
 43 files changed, 443 insertions(+), 159 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
