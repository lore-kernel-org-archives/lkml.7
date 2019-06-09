Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50892C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269F920833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098782;
	bh=xZk6V8W47holid3x8sEAl6DZJWT45f42r7gly3AseKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q/OvXpgs5n8p6okNOsRNmu0OKzVi4g/a7aFE2Luz2BEdN/Ojt094ZlC/KtAYCtO9s
	 zC7eJW3j4lsaEeSeO08tNGouybo+SGPMik8w8h2lA3vpn+azU55eJB6b3B36b+yyMC
	 jDPOul3Q58cvQJt5XrQ6rqpyUQaIi1qfxgO7quD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfFIQqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:46:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730337AbfFIQqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:46:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 730C32081C;
        Sun,  9 Jun 2019 16:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098774;
        bh=xZk6V8W47holid3x8sEAl6DZJWT45f42r7gly3AseKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQ18AyBjCnfSORN4gXbYQ8iRohdH0bv+pvNM7o/1asCIyMPNCW0xCFLZDtLkWgfpl
         Q9xUVTJeG3EVrDW1JKBvttIqS4/EG0xqdFDExH9hrYDc1vX4hYFEuhLiIGv8ieMEFI
         OJgpqdaahKBsFbgCxZ/bmFU8jrjSxMwUtxkJbgpE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.1 56/70] drm: Fix timestamp docs for variable refresh properties.
Date:   Sun,  9 Jun 2019 18:42:07 +0200
Message-Id: <20190609164132.173948370@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.541128197@linuxfoundation.org>
References: <20190609164127.541128197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Kleiner <mario.kleiner.de@gmail.com>

commit 0cbd0adc4429930567083d18cc8c0fbc5f635d96 upstream.

As discussed with Nicholas and Daniel Vetter (patchwork
link to discussion below), the VRR timestamping behaviour
produced utterly useless and bogus vblank/pageflip
timestamps. We have found a way to fix this and provide
sane behaviour.

As of Linux 5.2, the amdgpu driver will be able to
provide exactly the same vblank / pageflip timestamp
semantic in variable refresh rate mode as in standard
fixed refresh rate mode. This is achieved by deferring
core vblank handling (drm_crtc_handle_vblank()) until
the end of front porch, and also defer the sending of
pageflip completion events until end of front porch,
when we can safely compute correct pageflip/vblank
timestamps.

The same approach will be possible for other VRR
capable kms drivers, so we can actually have sane
and useful timestamps in VRR mode.

This patch removes the section of the docs that
describes the broken timestamp behaviour present
in Linux 5.0/5.1.

Fixes: ab7a664f7a2d ("drm: Document variable refresh properties")
Link: https://patchwork.freedesktop.org/patch/285333/
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190418060157.18968-1-mario.kleiner.de@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_connector.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1385,12 +1385,6 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mo
  *
  *	The driver may place further restrictions within these minimum
  *	and maximum bounds.
- *
- *	The semantics for the vertical blank timestamp differ when
- *	variable refresh rate is active. The vertical blank timestamp
- *	is defined to be an estimate using the current mode's fixed
- *	refresh rate timings. The semantics for the page-flip event
- *	timestamp remain the same.
  */
 
 /**


