Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEB4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D876C2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="msTIVlbZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lLCMZIkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfCATir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:38:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38124 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfCATiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:38:46 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 92BDC60F3F; Fri,  1 Mar 2019 19:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469125;
        bh=dfu1ST0yNnlyytyDMliEd2S/XprVBfQyYwcDG+8sbsQ=;
        h=From:To:Cc:Subject:Date:From;
        b=msTIVlbZaRNrZz1zVuBVl9K4jIel+W3ouDuyq+9/LrjkYfJocHZWZCQHX8SmOvrrs
         M5qipJAJ6JRkAfarAb/sYmTyqp8Cg82dSbcJby+GSN2haCBe0Zi2dOvQObZiF+wASW
         6CC8+wnrhy6gzuLUCqqRTsPs3GEkjXzDaL9VahuI=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0B3A6087A;
        Fri,  1 Mar 2019 19:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469123;
        bh=dfu1ST0yNnlyytyDMliEd2S/XprVBfQyYwcDG+8sbsQ=;
        h=From:To:Cc:Subject:Date:From;
        b=lLCMZIkKH2egp9k6czrZEoNal6WS+RcKX9ypDasgt5a0YQsZ27PRcaFlJnDv5f4uq
         gSEoubFHotoDri13WOsn8dSpn5f+BAwtY6BXjimJN2rQQX1Rpuic/4mKgW9e8NS4xs
         mllxatmB3cYg98gLHDun0Cn8lDG2E0di0DydRZ2U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0B3A6087A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        dianders@chromimum.org, hoegsberg@google.com,
        baolu.lu@linux.intel.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        iommu@lists.linux-foundation.org, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [RFC PATCH v1 00/15] drm/msm: Per-instance pagetable support
Date:   Fri,  1 Mar 2019 12:38:22 -0700
Message-Id: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the latest incarnation of per-instance pagetable support for the MSM GPU
driver. Some of these have been seen before, most recently [1].

Per-instance pagetables allow the target GPU driver to create and manage
an individual pagetable for each file descriptor instance and switch
between them asynchronously using the GPU to reprogram the pagetable
registers on the fly.

This is accomplished in this series by taking advantage of the multiple
IOMMU domain API from Lu Baolu [2] and all these patches are based on that
patch. This series is split into three parts:

Part one adds support for split pagetables. These are the same patches from the
previous attempts [1]. Split pagetables allow the hardware to switch out the
lower pagetable (TTBR0) without affecting the global allocations in the upper
one (TTBR1).

Part 2 adds aux domain support for arm-smmu-v2. New aux domains create a new
pagetable but do not touch the underlying hardware.  The target driver uses the
new aux domain to map and unmap memory through the usual mechanisms.

The final part is the support in the GPU driver to enable 64 bit addressing for
a5xx and a6xx, set up the support for split pagetables, create new per-instance
pagetables for a new instance and submit the GPU command to switch the pagetable
at the appropriate time.

This is compile tested but I haven't done much target testing as of yet. I
wanted to get this out in the world for debate while we work on fixing up the
minor issues. In particular, I want to make sure that this fits with the
current thinking about how aux domains should look and feel.

[1] https://patchwork.freedesktop.org/series/43447/
[2] https://patchwork.kernel.org/patch/10825061/


Jordan Crouse (15):
  iommu: Add DOMAIN_ATTR_SPLIT_TABLES
  iommu/arm-smmu: Add split pagetable support for arm-smmu-v2
  iommu/io-pgtable: Allow TLB operations to be optional
  iommu: Add DOMAIN_ATTR_PTBASE
  iommu/arm-smmu: Add auxiliary domain support for arm-smmuv2
  drm/msm/adreno: Enable 64 bit mode by default on a5xx and a6xx targets
  drm/msm: Print all 64 bits of the faulting IOMMU address
  drm/msm: Pass the MMU domain index in struct msm_file_private
  drm/msm/gpu: Move address space setup to the GPU targets
  drm/msm: Add support for IOMMU auxiliary domains
  drm/msm: Add a helper function for a per-instance address space
  drm/msm: Add support to create target specific address spaces
  drm/msm/gpu: Add ttbr0 to the memptrs
  drm/msm/a6xx: Support per-instance pagetables
  drm/msm/a5xx: Support per-instance pagetables

 drivers/gpu/drm/msm/adreno/a2xx_gpu.c     |  37 ++--
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c     |  50 ++++--
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c     |  51 ++++--
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c     | 163 +++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h     |  19 ++
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c |  70 ++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 167 +++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |   1 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c   |   7 -
 drivers/gpu/drm/msm/msm_drv.c             |  25 ++-
 drivers/gpu/drm/msm/msm_drv.h             |   5 +
 drivers/gpu/drm/msm/msm_gem.h             |   2 +
 drivers/gpu/drm/msm/msm_gem_submit.c      |  13 +-
 drivers/gpu/drm/msm/msm_gem_vma.c         |  53 +++---
 drivers/gpu/drm/msm/msm_gpu.c             |  59 +------
 drivers/gpu/drm/msm/msm_gpu.h             |   3 +
 drivers/gpu/drm/msm/msm_iommu.c           |  99 ++++++++++-
 drivers/gpu/drm/msm/msm_mmu.h             |   4 +
 drivers/gpu/drm/msm/msm_ringbuffer.h      |   1 +
 drivers/iommu/arm-smmu-regs.h             |  18 ++
 drivers/iommu/arm-smmu.c                  | 278 ++++++++++++++++++++++++++----
 drivers/iommu/io-pgtable-arm.c            |   3 +-
 drivers/iommu/io-pgtable.h                |  10 +-
 include/linux/iommu.h                     |   2 +
 24 files changed, 952 insertions(+), 188 deletions(-)

-- 
2.7.4

