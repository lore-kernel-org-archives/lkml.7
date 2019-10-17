Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC64ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 20:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B01920869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 20:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6340OvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437736AbfJQUyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 16:54:12 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:43323 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbfJQUyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 16:54:11 -0400
Received: by mail-lj1-f169.google.com with SMTP id n14so3969363ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6K4BDIRyXWQCZ6QNn62bC23ox9ewRSy9YoKRVJVBJXk=;
        b=q6340OvYv2PuKrWkVRq4qY8YRH9gHbgT9uhknfP5swVZWoq2m1ojHP08YJjVR67utQ
         CxGRYADGXA/2wrQmBo5i1WJgKhFlLQczUhGrq0bewEDvtmpHLMvn2jEBDuIMpY984VkB
         xlW+qA1uT7nW6cTmqzif0PMXikezlGxwdEnXbVEPq47DxBFHJGv3dHXk+evJT/DHMndc
         0qHkRGVZK4iLXHiBr6GTYvnFEit9ZT26TWN2nDbmi/T6E941ufFvEX7FmTsdGjoY1isw
         865Iu+/53UhEtJ+RnH+YRq32OA+DOXts4iYMf3RZmUMZOZHSOXOsKHRrxw88N7Rkn2xJ
         IlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6K4BDIRyXWQCZ6QNn62bC23ox9ewRSy9YoKRVJVBJXk=;
        b=NLO9WcBrhiOwx+luz7TiV6AmYg/lW22kgks6dNSivhm2fver6uzg9gwvcHvXoyPpBX
         LKpzl4RNoJi4xsBMdUYiFd7XGUeG6HLD/Wl4/Z99VKPtKAXcz7LxDsWcIqppvlLrM09t
         n81uIDFPkj4Mcxe5LA4UH+88NS07cO8MTeOPzsCKQgWVYzrtyJZSx7I4zg6JNvqeoK6y
         rsm+aMYSeNNJKzbAFyfrtO++H3/Z1cZVKYND/96zEnIGbiPmE47eeVwE27BRnleA+Tvo
         WfHHkMwyKMi/OXZxAnwtyQRc7JsmnrcIA72/S7kxFfEijrbbCeFNmcxlP9c1BC5ScfWQ
         25kw==
X-Gm-Message-State: APjAAAUlRo5nFUcRkWMVSjx62lpDONkxEjQ9XD0LEo7yQyo+wbf914rK
        c1cK1v0vTAbwiCVf/fEzQMxvwAKlB500RKwC+4tDynY9
X-Google-Smtp-Source: APXvYqwxTr/o5DtlDH6p1jteQJfrAqeYdO361PVDS76c/f4+FwCXkbXqWoY4B47+CG7beRbZfMTgoQS2gTruQwhXZKc=
X-Received: by 2002:a05:651c:1068:: with SMTP id y8mr59798ljm.223.1571345647032;
 Thu, 17 Oct 2019 13:54:07 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 18 Oct 2019 06:53:55 +1000
Message-ID: <CAPM=9twCjJ3XuEk4UDZYa_c8BR4K6D0DEVktay-Soaxrwkek6A@mail.gmail.com>
Subject: [git pull] drm fixes for 5.4-rc4
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

This is this weeks fixes for drm, the dma-resv one is probably the
more important one a fair few people have reported it, besides that
it's a couple of panfrost, a few i915 and a few amdgpu fixes. One
radeon patch to fix some ppc64 related issues caused an x86 regression
so is getting reverted for now.

Thanks,
Dave.

drm-fixes-2019-10-18:
drm fixes for 5.4-rc4

dma-resv:
- shared fences for lima/panfrost

ttm:
- prefault regression fix
- lifetime fix

panfrost:
- stopped job timeout fix
- missing register values

amdgpu:
- smu7 powerplay fix
- bail earlier for cik/si detection
- navi SDMA fix

radeon:
- revert a ppc64 shutdown fix that broke x86

i915:
- VBT information handling fix
- Circular locking fix
- preemption vs resubmission virtual requests fix
The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675=
:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-10-18

for you to fetch changes up to 5c1e34b5159ec65bf33e2c1a62fa7158132c10cf:

  Merge tag 'drm-misc-fixes-2019-10-17' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2019-10-18
06:40:28 +1000)

----------------------------------------------------------------
drm fixes for 5.4-rc4

dma-resv:
- shared fences for lima/panfrost

ttm:
- prefault regression fix
- lifetime fix

panfrost:
- stopped job timeout fix
- missing register values

amdgpu:
- smu7 powerplay fix
- bail earlier for cik/si detection
- navi SDMA fix

radeon:
- revert a ppc64 shutdown fix that broke x86

i915:
- VBT information handling fix
- Circular locking fix
- preemption vs resubmission virtual requests fix

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu/powerplay: fix typo in mvdd table setup
      Revert "drm/radeon: Fix EEH during kexec"

Chris Wilson (3):
      drm/i915/execlists: Refactor -EIO markup of hung requests
      drm/i915/userptr: Never allow userptr into the mappable GGTT
      drm/i915: Fixup preempt-to-busy vs resubmission of a virtual request

Christian K=C3=B6nig (2):
      drm/ttm: fix busy reference in ttm_mem_evict_first
      drm/ttm: fix handling in ttm_bo_add_mem_to_lru

Dave Airlie (3):
      Merge tag 'drm-intel-fixes-2019-10-17' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-fixes-5.4-2019-10-16' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2019-10-17' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Hans de Goede (1):
      drm/amdgpu: Bail earlier when amdgpu.cik_/si_support is not set to 1

Jeffrey Hugo (1):
      drm/msm/dsi: Implement reset correctly

Kai-Heng Feng (1):
      drm/edid: Add 6 bpc quirk for SDC panel in Lenovo G50

Qiang Yu (1):
      dma-buf/resv: fix exclusive fence get

Steven Price (2):
      drm/panfrost: Add missing GPU feature registers
      drm/panfrost: Handle resetting on timeout better

Thomas Hellstrom (1):
      drm/ttm: Restore ttm prefaulting

Ulf Magnusson (1):
      drm/tiny: Kconfig: Remove always-y THERMAL dep. from TINYDRM_REPAPER

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Favor last VBT child device with conflicting AUX ch/DDC pin

Xiaojie Yuan (1):
      drm/amdgpu/sdma5: fix mask value of POLL_REGMEM packet for pipe sync

 drivers/dma-buf/dma-resv.c                         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 35 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            | 35 ------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |  2 +-
 .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    |  2 +-
 .../gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c    |  2 +-
 drivers/gpu/drm/drm_edid.c                         |  3 ++
 drivers/gpu/drm/i915/display/intel_bios.c          | 22 +++++---
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |  7 +++
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |  6 +++
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h   |  3 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        |  1 +
 drivers/gpu/drm/i915/gt/intel_lrc.c                | 63 +++++++++++++++---=
----
 drivers/gpu/drm/i915/i915_gem.c                    |  3 ++
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  6 ++-
 drivers/gpu/drm/panfrost/panfrost_gpu.c            |  3 ++
 drivers/gpu/drm/panfrost/panfrost_job.c            | 16 ++++--
 drivers/gpu/drm/radeon/radeon_drv.c                |  8 ---
 drivers/gpu/drm/tiny/Kconfig                       |  1 -
 drivers/gpu/drm/ttm/ttm_bo.c                       |  9 ++--
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    | 16 +++---
 21 files changed, 150 insertions(+), 95 deletions(-)
