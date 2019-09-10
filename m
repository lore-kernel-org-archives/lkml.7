Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3E7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17662208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfIJJLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:11:46 -0400
Received: from 8bytes.org ([81.169.241.247]:53750 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfIJJLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:11:45 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9816B386; Tue, 10 Sep 2019 11:11:44 +0200 (CEST)
Date:   Tue, 10 Sep 2019 11:11:42 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Adam Zerella <adam.zerella@gmail.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix sparse warnings
Message-ID: <20190910091142.GA10821@8bytes.org>
References: <20190907065812.19505-1-adam.zerella@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907065812.19505-1-adam.zerella@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 04:58:12PM +1000, Adam Zerella wrote:
> There was some simple Sparse warnings related to making some
> signatures static.

And unapplied both of your patches as they causes build failures:

arch/x86/events/amd/iommu.o: In function `perf_iommu_read':
iommu.c:(.text+0xba): undefined reference to `amd_iommu_pc_get_reg'
arch/x86/events/amd/iommu.o: In function `perf_iommu_start':
iommu.c:(.text+0x2df): undefined reference to `amd_iommu_pc_set_reg'
iommu.c:(.text+0x324): undefined reference to `amd_iommu_pc_set_reg'
iommu.c:(.text+0x36b): undefined reference to `amd_iommu_pc_set_reg'
iommu.c:(.text+0x3b0): undefined reference to `amd_iommu_pc_set_reg'
iommu.c:(.text+0x424): undefined reference to `amd_iommu_pc_set_reg'
arch/x86/events/amd/iommu.o:iommu.c:(.text+0x4e4): more undefined references to `amd_iommu_pc_set_reg' follow
arch/x86/events/amd/iommu.o: In function `amd_iommu_pc_init':
iommu.c:(.init.text+0xc): undefined reference to `amd_iommu_pc_supported'
iommu.c:(.init.text+0x131): undefined reference to `get_amd_iommu'
iommu.c:(.init.text+0x140): undefined reference to `amd_iommu_pc_get_max_banks'
iommu.c:(.init.text+0x14f): undefined reference to `amd_iommu_pc_get_max_counters'
drivers/char/agp/intel-gtt.o: In function `intel_gmch_probe':
intel-gtt.c:(.text+0x135d): undefined reference to `intel_iommu_gfx_mapped'
drivers/iommu/amd_iommu_init.o: In function `state_next':
amd_iommu_init.c:(.init.text+0x1ace): undefined reference to `amd_iommu_ops'
drivers/iommu/dmar.o: In function `dmar_parse_one_drhd':
dmar.c:(.text+0x125c): undefined reference to `intel_iommu_ops'
drivers/gpu/drm/i915/intel_device_info.o: In function `intel_device_info_runtime_init':
intel_device_info.c:(.text+0xd89): undefined reference to `intel_iommu_gfx_mapped'
drivers/gpu/drm/i915/gem/i915_gem_stolen.o: In function `i915_gem_init_stolen':
i915_gem_stolen.c:(.text+0x33a): undefined reference to `intel_iommu_gfx_mapped'
drivers/gpu/drm/i915/i915_gem_gtt.o: In function `i915_ggtt_probe_hw':
i915_gem_gtt.c:(.text+0x4f61): undefined reference to `intel_iommu_gfx_mapped'
i915_gem_gtt.c:(.text+0x5127): undefined reference to `intel_iommu_gfx_mapped'
i915_gem_gtt.c:(.text+0x52d1): undefined reference to `intel_iommu_gfx_mapped'
drivers/gpu/drm/i915/i915_gem_gtt.o:i915_gem_gtt.c:(.text+0x53b3): more undefined references to `intel_iommu_gfx_mapped' follow

Please compile-test your patches next time.
