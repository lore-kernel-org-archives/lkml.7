Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A5CC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C4F2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098985;
	bh=K//TcAw+Y0Cgdhgw467+MLrfiQNDboVwqHwDPfPLT8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xzbeNkOsDOQ9FPzb62s3G33vDBYsA3WyWTw1yYt4PtimLqFhGF5A9+MHlaQnnW4pC
	 nqnAUp5otXbZdlVJpABOolH3Cv0bO/zlaApJv8Ffl7Q+5ISnwPYnrmjJNFGynJ0gxZ
	 BV9KfHww+i3c0K6d6WKm6qL3BZfUig+Uu7hiLFeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbfFIQtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729533AbfFIQtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:49:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CBA207E0;
        Sun,  9 Jun 2019 16:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098982;
        bh=K//TcAw+Y0Cgdhgw467+MLrfiQNDboVwqHwDPfPLT8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0cVCSRUdB0QJ9+7tKwa7f8+/OAETTvgieEdVcrRCXO4CmolQH9RguvADWs+3jS3cP
         n+EaKaEjQcmv0dSxO5fPf0GTQkhSKZwX2mUcQ51olVpLj5iH9AKC7++HHq/Ct+NClZ
         QsghT5lFaDvIKRdoP5hXvbRCK+HV6Rd9NloZ3lfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH 4.19 45/51] drm/i915: Fix I915_EXEC_RING_MASK
Date:   Sun,  9 Jun 2019 18:42:26 +0200
Message-Id: <20190609164130.400825244@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.123076536@linuxfoundation.org>
References: <20190609164127.123076536@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

commit d90c06d57027203f73021bb7ddb30b800d65c636 upstream.

This was supposed to be a mask of all known rings, but it is being used
by execbuffer to filter out invalid rings, and so is instead mapping high
unused values onto valid rings. Instead of a mask of all known rings,
we need it to be the mask of all possible rings.

Fixes: 549f7365820a ("drm/i915: Enable SandyBridge blitter ring")
Fixes: de1add360522 ("drm/i915: Decouple execbuf uAPI from internal implementation")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: <stable@vger.kernel.org> # v4.6+
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190301140404.26690-21-chris@chris-wilson.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/drm/i915_drm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/uapi/drm/i915_drm.h
+++ b/include/uapi/drm/i915_drm.h
@@ -942,7 +942,7 @@ struct drm_i915_gem_execbuffer2 {
 	 * struct drm_i915_gem_exec_fence *fences.
 	 */
 	__u64 cliprects_ptr;
-#define I915_EXEC_RING_MASK              (7<<0)
+#define I915_EXEC_RING_MASK              (0x3f)
 #define I915_EXEC_DEFAULT                (0<<0)
 #define I915_EXEC_RENDER                 (1<<0)
 #define I915_EXEC_BSD                    (2<<0)


