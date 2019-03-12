Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E91AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED20D2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414451;
	bh=FipTVCBHndGvnon2xyD2/dLzZY90Gik19ywchGNhqHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AUo6Y6lw6G8PfwEE/er9V8Tj0eVwfsSl9L6CndGz5Ob+Mywmh0YaSQhBlrLglBTon
	 SICLJVzRD+bae3ZkhXjLdoapcjUTxu5onGzype0PLLUhVZ3ngquDkYw/WZddIByFgx
	 mv1fOZsFECtoS1hl367VwBKCz3RdthdDW3J/QycQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfCLSN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbfCLRLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:24 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7609C21734;
        Tue, 12 Mar 2019 17:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410683;
        bh=FipTVCBHndGvnon2xyD2/dLzZY90Gik19ywchGNhqHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D0mAfRO6inqd68TpDBywk9NZsarQ96njklBSLBo1Hy32Xv8YstJ7qcYfN7Ve8i8Gr
         wqN515lJlRgFoqrbn/4PRAzsIFJgqQpqioqiDEYwCEP/tRM0N1TlA84IlxbS/CWnWJ
         J/4WIhpp0Dh9DJc7jcWn6dDCdOwEfdycdYjkHy3E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Koenig <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Michel Daenzer <michel.daenzer@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Carsten Haitzler <Carsten.Haitzler@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 13/25] drm: disable uncached DMA optimization for ARM and arm64
Date:   Tue, 12 Mar 2019 10:08:51 -0700
Message-Id: <20190312170404.531087175@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170403.643852550@linuxfoundation.org>
References: <20190312170403.643852550@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e02f5c1bb2283cfcee68f2f0feddcc06150f13aa ]

The DRM driver stack is designed to work with cache coherent devices
only, but permits an optimization to be enabled in some cases, where
for some buffers, both the CPU and the GPU use uncached mappings,
removing the need for DMA snooping and allocation in the CPU caches.

The use of uncached GPU mappings relies on the correct implementation
of the PCIe NoSnoop TLP attribute by the platform, otherwise the GPU
will use cached mappings nonetheless. On x86 platforms, this does not
seem to matter, as uncached CPU mappings will snoop the caches in any
case. However, on ARM and arm64, enabling this optimization on a
platform where NoSnoop is ignored results in loss of coherency, which
breaks correct operation of the device. Since we have no way of
detecting whether NoSnoop works or not, just disable this
optimization entirely for ARM and arm64.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: David Zhou <David1.Zhou@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Junwei Zhang <Jerry.Zhang@amd.com>
Cc: Michel Daenzer <michel.daenzer@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://patchwork.kernel.org/patch/10778815/
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/drm_cache.h |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/include/drm/drm_cache.h
+++ b/include/drm/drm_cache.h
@@ -47,6 +47,24 @@ static inline bool drm_arch_can_wc_memor
 	return false;
 #elif defined(CONFIG_MIPS) && defined(CONFIG_CPU_LOONGSON3)
 	return false;
+#elif defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+	/*
+	 * The DRM driver stack is designed to work with cache coherent devices
+	 * only, but permits an optimization to be enabled in some cases, where
+	 * for some buffers, both the CPU and the GPU use uncached mappings,
+	 * removing the need for DMA snooping and allocation in the CPU caches.
+	 *
+	 * The use of uncached GPU mappings relies on the correct implementation
+	 * of the PCIe NoSnoop TLP attribute by the platform, otherwise the GPU
+	 * will use cached mappings nonetheless. On x86 platforms, this does not
+	 * seem to matter, as uncached CPU mappings will snoop the caches in any
+	 * case. However, on ARM and arm64, enabling this optimization on a
+	 * platform where NoSnoop is ignored results in loss of coherency, which
+	 * breaks correct operation of the device. Since we have no way of
+	 * detecting whether NoSnoop works or not, just disable this
+	 * optimization entirely for ARM and arm64.
+	 */
+	return false;
 #else
 	return true;
 #endif


