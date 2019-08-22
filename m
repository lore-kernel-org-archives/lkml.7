Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D45C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F8723401
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393251AbfHVUcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:32:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391797AbfHVUcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:32:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8738FA381A5;
        Thu, 22 Aug 2019 20:32:14 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 038216CE6B;
        Thu, 22 Aug 2019 20:32:11 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/i915: Enable CONFIG_DMA_API_DEBUG_SG for intel-ci
Date:   Thu, 22 Aug 2019 16:31:27 -0400
Message-Id: <20190822203127.24648-2-lyude@redhat.com>
In-Reply-To: <20190822203127.24648-1-lyude@redhat.com>
References: <20190822203127.24648-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Thu, 22 Aug 2019 20:32:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we've fixed i915 so that it sets a max SG segment length and
gotten rid of the relevant warnings, let's enable
CONFIG_DMA_API_DEBUG_SG for intel-ci so that we can catch issues like
this in the future as well.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
---
 drivers/gpu/drm/i915/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
index 00786a142ff0..ad8d3cd63c9f 100644
--- a/drivers/gpu/drm/i915/Kconfig.debug
+++ b/drivers/gpu/drm/i915/Kconfig.debug
@@ -32,6 +32,7 @@ config DRM_I915_DEBUG
 	select DRM_DEBUG_SELFTEST
 	select DMABUF_SELFTESTS
 	select SW_SYNC # signaling validation framework (igt/syncobj*)
+        select DMA_API_DEBUG_SG
 	select DRM_I915_SW_FENCE_DEBUG_OBJECTS
 	select DRM_I915_SELFTEST
 	select DRM_I915_DEBUG_RUNTIME_PM
-- 
2.21.0

