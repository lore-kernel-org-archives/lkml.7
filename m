Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8506C2BCA1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9129B204EC
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099314;
	bh=nCnfGX5yZs5PaQHkOfdYyZZA8GG57QB1c5RcTkz5vrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1va3H2PMi2JHqKmM4UVayMm3YFNmRrgaZwTiqpMN//JLI00LYCfbTmIJ10Eqq3efD
	 joY876XP7OlcoNeHCYTh/gaoUzgLW2adhclRzSYkwT4ILlsQv2VB6T42ytOeMQ0Dnx
	 Lprh4W+LEPf0IkVDO6hkJ0KVptGKwSSGzfd2YIcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbfFIQzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732726AbfFIQy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:54:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E47C0206BB;
        Sun,  9 Jun 2019 16:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099298;
        bh=nCnfGX5yZs5PaQHkOfdYyZZA8GG57QB1c5RcTkz5vrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZaaMv/OnjmofPP2IIKIinAWzDsydQr6Ps3JFUcLXI4/m+mnxqRxo0BrGuPqlsGwjl
         cVRjSygTQJXQ6uo4V86QrWvUb+XOB+1xb8icV3edjoGt0BzC2uUcsBXOiHkb650HOC
         bFT6iHXV5BZE2nOW14m8hnnskehEhlOZ9/M0EqCo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH 4.9 80/83] drm/i915: Fix I915_EXEC_RING_MASK
Date:   Sun,  9 Jun 2019 18:42:50 +0200
Message-Id: <20190609164134.763326048@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.843327870@linuxfoundation.org>
References: <20190609164127.843327870@linuxfoundation.org>
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
@@ -756,7 +756,7 @@ struct drm_i915_gem_execbuffer2 {
 	__u32 num_cliprects;
 	/** This is a struct drm_clip_rect *cliprects */
 	__u64 cliprects_ptr;
-#define I915_EXEC_RING_MASK              (7<<0)
+#define I915_EXEC_RING_MASK              (0x3f)
 #define I915_EXEC_DEFAULT                (0<<0)
 #define I915_EXEC_RENDER                 (1<<0)
 #define I915_EXEC_BSD                    (2<<0)


