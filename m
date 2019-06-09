Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FD0C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E4F20833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098969;
	bh=PjM8XhUNVxe75X+ylHHcOfoz1DpJBfdQF8bioJZenW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=obAIzxHU0ivCWfUKEbxz6Mez7r+RVAf5VSxBfltpbVo4TOuC0S5aJXcN4mNeOVliO
	 qknjkjL4hHr84l79YvarXHIYk5Y4Ivp7OorBfUnbC6x2ysX/0upOPUgKawZlGZOgOw
	 M5DdD9Hffy9rURlkWJ9NfIjQXieHozI0Pnc94N9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbfFIQt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731458AbfFIQtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:49:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB11208E4;
        Sun,  9 Jun 2019 16:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098962;
        bh=PjM8XhUNVxe75X+ylHHcOfoz1DpJBfdQF8bioJZenW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQPm38OjxrRMNdc0+807x/zskML5v5ivLpXpFUxkEO0jSdoqQTIJ805uZ+G7BhEU6
         atXDrbA3DsgaCOQzXSw6Z2TN5ufrcdRkuWYts/2W58wdFi2AmiMCdRpsdHChtz/DHh
         rfX28688dALuXzpi463myI0JkIu24PZutAsdkFB8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH 4.19 38/51] drm/msm: fix fb references in async update
Date:   Sun,  9 Jun 2019 18:42:19 +0200
Message-Id: <20190609164129.687643766@linuxfoundation.org>
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

From: Helen Koike <helen.koike@collabora.com>

commit 474d952b4870cfbdc55d3498f4d498775fe77e81 upstream.

Async update callbacks are expected to set the old_fb in the new_state
so prepare/cleanup framebuffers are balanced.

Cc: <stable@vger.kernel.org> # v4.14+
Fixes: 224a4c970987 ("drm/msm: update cursors asynchronously through atomic")
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
Acked-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190603165610.24614-4-helen.koike@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
@@ -503,6 +503,8 @@ static int mdp5_plane_atomic_async_check
 static void mdp5_plane_atomic_async_update(struct drm_plane *plane,
 					   struct drm_plane_state *new_state)
 {
+	struct drm_framebuffer *old_fb = plane->state->fb;
+
 	plane->state->src_x = new_state->src_x;
 	plane->state->src_y = new_state->src_y;
 	plane->state->crtc_x = new_state->crtc_x;
@@ -525,6 +527,8 @@ static void mdp5_plane_atomic_async_upda
 
 	*to_mdp5_plane_state(plane->state) =
 		*to_mdp5_plane_state(new_state);
+
+	new_state->fb = old_fb;
 }
 
 static const struct drm_plane_helper_funcs mdp5_plane_helper_funcs = {


