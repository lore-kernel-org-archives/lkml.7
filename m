Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69187C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4080B216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888979;
	bh=VEu8WnpjUEJUhUtqHxsXk5QyAkF33WFyk3yonqlED3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rwf/ILHXA/caULRHYFoMacM1aoRR1chjqpNltSz9NE4VpglwPA/Ytb9UcbAER/1Wr
	 dSTPxokgC87qf1LmLG6Mmv6avtxEEd/K5EbT7cgZU48uG0xZI0CfRajSmoyCP7YiMl
	 yPkhyZUVhSR0nP/4XOuESke7o608SWjnTU0MCkXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732907AbfK0VJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:09:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732898AbfK0VJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:09:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C12D21555;
        Wed, 27 Nov 2019 21:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888972;
        bh=VEu8WnpjUEJUhUtqHxsXk5QyAkF33WFyk3yonqlED3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vun0rXSnOMjgwRwIXqZHAUlJBnSVrd37tXQwyvwbqvhNbjK+CoBKhKW7CWu58LM/N
         CURYDGUcu7v/t7MIwBLuoq4GGS3tet8zZ2S1xh3WkesN3Q9kmHBque3neh/V+mgGyC
         FOUA1FBVElKHaX9HcX3fBH/YKHoTI9dgIPS3Z3x4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 5.3 33/95] drm/i915: Dont oops in dumb_create ioctl if we have no crtcs
Date:   Wed, 27 Nov 2019 21:31:50 +0100
Message-Id: <20191127202858.331851337@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 8ac495f624a42809000255955be406f6a8a74b55 upstream.

Make sure we have a crtc before probing its primary plane's
max stride. Initially I thought we can't get this far without
crtcs, but looks like we can via the dumb_create ioctl.

Not sure if we shouldn't disable dumb buffer support entirely
when we have no crtcs, but that would require some amount of work
as the only thing currently being checked is dev->driver->dumb_create
which we'd have to convert to some device specific dynamic thing.

Cc: stable@vger.kernel.org
Reported-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Fixes: aa5ca8b7421c ("drm/i915: Align dumb buffer stride to 4k to allow for gtt remapping")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20191106172349.11987-1-ville.syrjala@linux.intel.com
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
(cherry picked from commit baea9ffe64200033499a4955f431e315bb807899)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
(cherry picked from commit aeec766133f99d45aad60d650de50fb382104d95)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/display/intel_display.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -2519,6 +2519,9 @@ u32 intel_plane_fb_max_stride(struct drm
 	 * the highest stride limits of them all.
 	 */
 	crtc = intel_get_crtc_for_pipe(dev_priv, PIPE_A);
+	if (!crtc)
+		return 0;
+
 	plane = to_intel_plane(crtc->base.primary);
 
 	return plane->max_stride(plane, pixel_format, modifier,


