Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2688C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A832177E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413583;
	bh=244Fua93XWB1optCXZhSQPIfmvwcYhUXzkcDy8Cw8Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZL2KMSpHbK/dnUiuAMueGkNFmH65L4uICeEMCazsjsOeAYUEo1zVFl8xiIjfyNXLq
	 0XOwPnwCAya4nHblsjcJDOBgi935lJzlffUsJ3DUvuu82qcL1Zn01/rWJtQSixDZOe
	 BdPaUeqOxmyMNjr45snVVFqkXD4aMTUydlg0BpSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfCLR7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbfCLRNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:30 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EF1F21741;
        Tue, 12 Mar 2019 17:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410809;
        bh=244Fua93XWB1optCXZhSQPIfmvwcYhUXzkcDy8Cw8Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vIZUOlZQCIJUHTMp2v/SgQo5CHr7ZMiOF+nDQ+HmYW+1Hdjn8XXObABq21fco9X53
         TyFUfEBOpgkndcKB8g+A+XXRgYPAMB0Xh909GXSft1MQ6Uf0cumoMgVwlM2TxIdENU
         TgB0tYoRS98v8CP6tYZYUmrm+XPMe5Z/RlwOwAjw=
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
Subject: [PATCH 4.20 160/171] drm: disable uncached DMA optimization for ARM and arm64
Date:   Tue, 12 Mar 2019 10:09:00 -0700
Message-Id: <20190312170401.202933174@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
 include/drm/drm_cache.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/drm/drm_cache.h b/include/drm/drm_cache.h
index bfe1639df02d..97fc498dc767 100644
--- a/include/drm/drm_cache.h
+++ b/include/drm/drm_cache.h
@@ -47,6 +47,24 @@ static inline bool drm_arch_can_wc_memory(void)
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
-- 
2.19.1



